import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trackly/presentation/providers/repository_provider.dart';
import '../../domain/entities/activity.dart';
import '../../domain/repositories/visits_repository.dart';

part 'activities_provider.g.dart';

@riverpod
class ActivitiesNotifier extends _$ActivitiesNotifier {
  @override
  FutureOr<List<Activity>> build() async {
    final repository = ref.read(visitsRepositoryProvider);
    return repository.getActivities();
  }

  Future<void> refreshActivities() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(visitsRepositoryProvider);
      final activities = await repository.getActivities();
      state = AsyncValue.data(activities);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

@riverpod
List<Activity> activitiesByIds(
  ActivitiesByIdsRef ref,
  List<String> activityIds,
) {
  final activities = ref.watch(activitiesNotifierProvider);
  return activities.when(
    data:
        (activitiesList) =>
            activitiesList
                .where(
                  (activity) => activityIds.contains(activity.id.toString()),
                )
                .toList(),
    loading: () => [],
    error: (_, __) => [],
  );
}
