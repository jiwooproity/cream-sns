import 'package:flutter_riverpod/flutter_riverpod.dart';

// Models
import 'package:cream_sns/features/profile/model/profile.dart';

// Service
import 'package:cream_sns/features/profile/data/profile_service.dart';


final profileProvider = FutureProvider.family<Profile, String>((ref, id) async {
  return ref.read(profileClientProvider).info(id);
});