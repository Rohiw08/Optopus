import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optopus/core/session/session_provider.dart';

class HomeProfileWidget extends ConsumerWidget {
  const HomeProfileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final session = ref.watch(sessionProvider);

    print(
      session.when(
        data: (data) => data,
        error: (err, stack) => err,
        loading: () => "loading",
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        child: session.when(
          data: (account) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.3),
                    width: 0.1,
                  ),
                ),
                child: Center(
                  child: SizedBox(
                    width: 65,
                    height: 65,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        account?.avatarUrl ?? 'https://via.placeholder.com/80',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                account?.displayName ?? "Guest User",
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                account?.username ?? "",
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w100,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          loading: () => const CircularProgressIndicator(),
          error: (err, _) => const Icon(Icons.error_outline),
        ),
      ),
    );
  }
}
