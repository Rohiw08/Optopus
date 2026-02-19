import 'package:optopus/features/studio/application/studio_service.dart';
import 'package:optopus/features/collections/providers.dart';
import 'package:optopus/features/flows/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'studio_providers.g.dart';

@riverpod
StudioService studioService(Ref ref) {
  return StudioService(
    ref.watch(collectionServiceProvider),
    ref.watch(flowServiceProvider),
  );
}
