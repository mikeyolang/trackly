import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trackly/core/constants/enums.dart';
import '../../domain/entities/visit.dart';

part 'app_models.freezed.dart';

@freezed
class VisitFilterModel with _$VisitFilterModel {
  const factory VisitFilterModel({
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    int? customerId,
  }) = _VisitFilterModel;
}

@freezed
class VisitStatsModel with _$VisitStatsModel {
  const factory VisitStatsModel({
    @Default(0) int totalVisits,
    @Default(0) int completedVisits,
    @Default(0) int pendingVisits,
    @Default(0) int cancelledVisits,
    @Default(0.0) double completionRate,
    @Default(0) int thisWeekVisits,
    @Default(0) int thisMonthVisits,
  }) = _VisitStatsModel;

  factory VisitStatsModel.fromVisits(List<Visit> visits) {
    final total = visits.length;
    final completed = visits.where((v) => v.status == 'Completed').length;
    final pending = visits.where((v) => v.status == 'Pending').length;
    final cancelled = visits.where((v) => v.status == 'Cancelled').length;

    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfMonth = DateTime(now.year, now.month, 1);

    final thisWeek =
        visits.where((v) => v.visitDate.isAfter(startOfWeek)).length;
    final thisMonth =
        visits.where((v) => v.visitDate.isAfter(startOfMonth)).length;

    final completionRate = total > 0 ? (completed / total) * 100 : 0.0;

    return VisitStatsModel(
      totalVisits: total,
      completedVisits: completed,
      pendingVisits: pending,
      cancelledVisits: cancelled,
      completionRate: completionRate,
      thisWeekVisits: thisWeek,
      thisMonthVisits: thisMonth,
    );
  }
}

@freezed
class AppStateModel with _$AppStateModel {
  const factory AppStateModel({@Default(false) bool isLoading, String? error}) =
      _AppStateModel;
}

@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String message,
    required NotificationType type,
    required DateTime timestamp,
  }) = _NotificationModel;
}



@freezed
class VisitFormState with _$VisitFormState {
  const factory VisitFormState({
    int? customerId,
    DateTime? visitDate,
    @Default('') String location,
    @Default('') String notes,
    @Default([]) List<String> selectedActivities,
    @Default('Pending') String status,
    @Default(false) bool isValid,
  }) = _VisitFormState;
}
