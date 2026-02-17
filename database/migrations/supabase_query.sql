-- ============================================================================
-- Optopus Consolidated Migration
-- Order: Functions -> Tables -> RLS Policies -> Helper Functions -> Views
-- ============================================================================

-- 1. GLOBAL HELPER FUNCTIONS
-- Required for automatic 'updated_at' timestamps across all tables
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 2. ENUMS
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'workspace_role') THEN
        CREATE TYPE public.workspace_role AS ENUM ('admin', 'editor', 'viewer');
    END IF;
END $$;

-- 3. TABLES DEFINITION (No RLS Policies yet to avoid circular dependencies)

-- Table: profiles (Merged from accounts/profiles logic)
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    full_name TEXT,
    avatar_url TEXT,
    role TEXT DEFAULT 'user',
    preferences JSONB DEFAULT '{}'::jsonb,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Table: workspaces
CREATE TABLE IF NOT EXISTS public.workspaces (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL CHECK (char_length(name) > 0 AND char_length(name) <= 255),
    description TEXT,
    owner_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Table: workspace_members
CREATE TABLE IF NOT EXISTS public.workspace_members (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    workspace_id UUID NOT NULL REFERENCES public.workspaces(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    role public.workspace_role NOT NULL DEFAULT 'viewer',
    joined_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE(workspace_id, user_id)
);

-- Table: collections
CREATE TABLE IF NOT EXISTS public.collections (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    workspace_id UUID NOT NULL REFERENCES public.workspaces(id) ON DELETE CASCADE,
    name TEXT NOT NULL CHECK (char_length(name) > 0 AND char_length(name) <= 255),
    description TEXT,
    parent_id UUID REFERENCES public.collections(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    CHECK (parent_id IS NULL OR parent_id != id)
);

-- Table: flows
CREATE TABLE IF NOT EXISTS public.flows (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    collection_id UUID NOT NULL REFERENCES public.collections(id) ON DELETE CASCADE,
    name TEXT NOT NULL CHECK (char_length(name) > 0 AND char_length(name) <= 255),
    data JSONB NOT NULL DEFAULT '{}'::jsonb,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 4. INDEXES
CREATE INDEX IF NOT EXISTS idx_workspaces_owner_id ON public.workspaces(owner_id);
CREATE INDEX IF NOT EXISTS idx_workspace_members_workspace_id ON public.workspace_members(workspace_id);
CREATE INDEX IF NOT EXISTS idx_flows_collection_id ON public.flows(collection_id);
CREATE INDEX IF NOT EXISTS idx_flows_data_gin ON public.flows USING gin(data);

-- 5. ROW LEVEL SECURITY (RLS) POLICIES
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.workspaces ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.workspace_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.collections ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.flows ENABLE ROW LEVEL SECURITY;

-- Profile Policies
CREATE POLICY "Users can view all profiles" ON public.profiles FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "Users can update own profile" ON public.profiles FOR UPDATE USING (id = auth.uid());

-- Workspace Policies (The fix for the circular dependency error)
CREATE POLICY "Users can view their workspaces" ON public.workspaces
    FOR SELECT USING (
        owner_id = auth.uid() OR 
        EXISTS (SELECT 1 FROM public.workspace_members WHERE workspace_id = workspaces.id AND user_id = auth.uid())
    );

CREATE POLICY "Owners can manage workspaces" ON public.workspaces
    FOR ALL USING (owner_id = auth.uid());

-- Workspace Member Policies
CREATE POLICY "Members can view fellow members" ON public.workspace_members
    FOR SELECT USING (
        EXISTS (SELECT 1 FROM public.workspaces WHERE id = workspace_id AND owner_id = auth.uid()) OR
        EXISTS (SELECT 1 FROM public.workspace_members wm WHERE wm.workspace_id = workspace_id AND wm.user_id = auth.uid())
    );

-- Collection Policies
CREATE POLICY "Users can view collections" ON public.collections
    FOR SELECT USING (
        EXISTS (SELECT 1 FROM public.workspaces w WHERE w.id = workspace_id AND 
        (w.owner_id = auth.uid() OR EXISTS (SELECT 1 FROM public.workspace_members wm WHERE wm.workspace_id = w.id AND wm.user_id = auth.uid())))
    );

-- Flow Policies
CREATE POLICY "Users can view flows" ON public.flows
    FOR SELECT USING (
        EXISTS (SELECT 1 FROM public.collections c WHERE c.id = collection_id)
    );

-- 6. TRIGGERS
-- Automatic Profile Creation on Signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.profiles (id, full_name, avatar_url)
    VALUES (
        NEW.id,
        COALESCE(NEW.raw_user_meta_data->>'full_name', split_part(NEW.email, '@', 1)),
        COALESCE(NEW.raw_user_meta_data->>'avatar_url', 'https://ui-avatars.com/api/?name=' || NEW.id)
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Updated_at Timestamps
CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_workspaces_updated_at BEFORE UPDATE ON public.workspaces FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_collections_updated_at BEFORE UPDATE ON public.collections FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_flows_updated_at BEFORE UPDATE ON public.flows FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- 7. VIEWS & HELPER FUNCTIONS
CREATE OR REPLACE VIEW public.workspaces_with_stats AS
SELECT 
    w.*,
    (SELECT COUNT(*) FROM public.workspace_members WHERE workspace_id = w.id) as member_count,
    (SELECT COUNT(*) FROM public.collections WHERE workspace_id = w.id) as collection_count
FROM public.workspaces w;

CREATE OR REPLACE FUNCTION public.get_user_workspaces(user_uuid UUID)
RETURNS TABLE (id UUID, name TEXT, role TEXT) AS $$
BEGIN
    RETURN QUERY
    SELECT w.id, w.name, 
    CASE WHEN w.owner_id = user_uuid THEN 'owner' ELSE wm.role::TEXT END
    FROM public.workspaces w
    LEFT JOIN public.workspace_members wm ON wm.workspace_id = w.id AND wm.user_id = user_uuid
    WHERE w.owner_id = user_uuid OR wm.user_id = user_uuid;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;