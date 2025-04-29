import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/presentation/state/profile_provider.dart';
import 'package:app/presentation/utils/show_error_snackbar.dart';

class RoomManagementButtons extends ConsumerWidget {
  const RoomManagementButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileNotifierProvider);
    
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 90),
      child: profileAsync.when(
        data: (profile) {
          final isNameEmpty = (profile.name?.length ?? 0) == 0;
          
          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: isNameEmpty
                      ? null
                      : () {
                          ref.read(profileNotifierProvider.notifier).joinRoom();
                        },
                  child: const Text('Create Game'),
                ),
                if (profile.roomId != null) ...[
                  const SizedBox(height: 10),
                  Text('Current Room: ${profile.roomId}'),
                ],
              ],
            ),
          );
        },
        loading: () => const Center(child: SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(),
        )),
        error: (error, stackTrace) {
          showErrorSnackbar(context, error.toString());
          return const SizedBox(
            height: 40,
            child: Center(child: Text('Error loading profile')),
          );
        },
      ),
    );
  }
}