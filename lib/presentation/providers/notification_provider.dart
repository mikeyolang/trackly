import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trackly/core/constants/enums.dart';
import 'package:trackly/data/models/app_models.dart';

part 'notification_provider.g.dart';


@riverpod
class NotificationNotifier extends _$NotificationNotifier {
  @override
  NotificationModel? build() => null;

  void showSuccess(String message) {
    state = NotificationModel(
      message: message,
      type: NotificationType.success,
      timestamp: DateTime.now(),
    );
  }

  void showError(String message) {
    state = NotificationModel(
      message: message,
      type: NotificationType.error,
      timestamp: DateTime.now(),
    );
  }

  void showInfo(String message) {
    state = NotificationModel(
      message: message,
      type: NotificationType.info,
      timestamp: DateTime.now(),
    );
  }

  void clearNotification() {
    state = null;
  }
}
