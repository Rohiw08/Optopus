import 'package:optopus/features/home/application/home_service.dart';
import 'package:optopus/features/collections/providers.dart';
import 'package:optopus/features/flows/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_providers.g.dart';

@riverpod
HomeService homeService(Ref ref) {
  return HomeService(
    ref.watch(collectionServiceProvider),
    ref.watch(flowServiceProvider),
  );
}
