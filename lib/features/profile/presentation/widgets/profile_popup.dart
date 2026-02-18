import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/core/session/session_provider.dart';
import 'package:optopus/features/auth/presentation/controller/auth_controller.dart';
import 'package:optopus/core/widgets/navigation_tile_widget.dart';

class ProfilePopup extends ConsumerWidget {
  const ProfilePopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final sessionAsync = ref.watch(sessionProvider);

    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      color: theme.scaffoldBackgroundColor,
      child: sessionAsync.when(
        data: (account) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center align for top section
          children: [
            // Avatar
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(
                account?.avatarUrl ?? 'https://via.placeholder.com/80',
              ),
            ),
            const SizedBox(height: 10),
            // Name
            Text(
              account?.displayName ?? "Guest User",
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            // Email
            Text(
              account?.username ?? "",
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 15),
            // View Profile Button
            NavigationTileWidget(
              alignment: Alignment.center,
              text: "View Profile",
              hoverBackgroundColor: theme.colorScheme.surfaceBright,
              onPressed: () {},
            ),
            const SizedBox(height: 15),

            // Menu Items
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NavigationTileWidget(
                    text: "Settings",
                    borderColor: Colors.transparent,
                    hoverBackgroundColor: theme.colorScheme.surfaceBright,
                    onPressed: () {},
                  ),
                  NavigationTileWidget(
                    text: "Sign Out",
                    borderColor: Colors.transparent,
                    hoverBackgroundColor: theme.colorScheme.surfaceBright,
                    onPressed: () =>
                        ref.read(authControllerProvider.notifier).signOut(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            Divider(height: 1, thickness: 0.2, color: theme.dividerColor),
            const SizedBox(height: 10),

            // Switch Accounts
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Switch Accounts",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildAddAccountItem(context),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => const Text("Error"),
      ),
    );
  }

  Widget _buildAddAccountItem(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {},
      hoverColor: theme.hoverColor,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        child: Row(
          children: [
            Icon(
              Icons.add,
              size: 16,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            const SizedBox(width: 8),
            Text(
              "Add Account",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
