import 'package:cream_sns/features/home/provider/feed_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Models
import 'package:cream_sns/features/profile/model/profile.dart';

// Service
import 'package:cream_sns/features/profile/data/profile_service.dart';
import 'package:flutter_riverpod/legacy.dart';

final profileProvider = FutureProvider.family<Profile, String>((ref, id) async {
  return ref.read(profileClientProvider).info(id);
});

final profileActionProvider =
    StateNotifierProvider<ProfileActionNotifier, ProfileActionState>((ref) {
      return ProfileActionNotifier(ref);
    });

class ProfileActionNotifier extends StateNotifier<ProfileActionState> {
  ProfileActionNotifier(this.ref) : super(ProfileActionState(isLoading: false));

  final Ref ref;

  Future<void> following(bool isFollowed, String myId, String targetId) async {
    state = state.copyWith(isLoading: true);

    try {
      if (isFollowed) {
        await ref.read(profileClientProvider).unFollow(targetId);
      } else {
        await ref.read(profileClientProvider).following(targetId);
      }

      ref.invalidate(profileProvider(targetId));
      ref.invalidate(profileProvider(myId));
      ref.invalidate(feedListProvider);
    } on DioException catch (e) {
      return;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

class ProfileActionState {
  ProfileActionState({this.isLoading = false});

  final bool isLoading;

  ProfileActionState copyWith({bool? isLoading}) {
    return ProfileActionState(isLoading: isLoading ?? this.isLoading);
  }
}
