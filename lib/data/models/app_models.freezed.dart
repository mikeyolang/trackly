// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$VisitFilterModel {
  String? get status => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  int? get customerId => throw _privateConstructorUsedError;

  /// Create a copy of VisitFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VisitFilterModelCopyWith<VisitFilterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitFilterModelCopyWith<$Res> {
  factory $VisitFilterModelCopyWith(
    VisitFilterModel value,
    $Res Function(VisitFilterModel) then,
  ) = _$VisitFilterModelCopyWithImpl<$Res, VisitFilterModel>;
  @useResult
  $Res call({
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    int? customerId,
  });
}

/// @nodoc
class _$VisitFilterModelCopyWithImpl<$Res, $Val extends VisitFilterModel>
    implements $VisitFilterModelCopyWith<$Res> {
  _$VisitFilterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VisitFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? customerId = freezed,
  }) {
    return _then(
      _value.copyWith(
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String?,
            startDate:
                freezed == startDate
                    ? _value.startDate
                    : startDate // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            endDate:
                freezed == endDate
                    ? _value.endDate
                    : endDate // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            customerId:
                freezed == customerId
                    ? _value.customerId
                    : customerId // ignore: cast_nullable_to_non_nullable
                        as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VisitFilterModelImplCopyWith<$Res>
    implements $VisitFilterModelCopyWith<$Res> {
  factory _$$VisitFilterModelImplCopyWith(
    _$VisitFilterModelImpl value,
    $Res Function(_$VisitFilterModelImpl) then,
  ) = __$$VisitFilterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    int? customerId,
  });
}

/// @nodoc
class __$$VisitFilterModelImplCopyWithImpl<$Res>
    extends _$VisitFilterModelCopyWithImpl<$Res, _$VisitFilterModelImpl>
    implements _$$VisitFilterModelImplCopyWith<$Res> {
  __$$VisitFilterModelImplCopyWithImpl(
    _$VisitFilterModelImpl _value,
    $Res Function(_$VisitFilterModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VisitFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? customerId = freezed,
  }) {
    return _then(
      _$VisitFilterModelImpl(
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String?,
        startDate:
            freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        endDate:
            freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        customerId:
            freezed == customerId
                ? _value.customerId
                : customerId // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc

class _$VisitFilterModelImpl implements _VisitFilterModel {
  const _$VisitFilterModelImpl({
    this.status,
    this.startDate,
    this.endDate,
    this.customerId,
  });

  @override
  final String? status;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final int? customerId;

  @override
  String toString() {
    return 'VisitFilterModel(status: $status, startDate: $startDate, endDate: $endDate, customerId: $customerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisitFilterModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, startDate, endDate, customerId);

  /// Create a copy of VisitFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VisitFilterModelImplCopyWith<_$VisitFilterModelImpl> get copyWith =>
      __$$VisitFilterModelImplCopyWithImpl<_$VisitFilterModelImpl>(
        this,
        _$identity,
      );
}

abstract class _VisitFilterModel implements VisitFilterModel {
  const factory _VisitFilterModel({
    final String? status,
    final DateTime? startDate,
    final DateTime? endDate,
    final int? customerId,
  }) = _$VisitFilterModelImpl;

  @override
  String? get status;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  int? get customerId;

  /// Create a copy of VisitFilterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VisitFilterModelImplCopyWith<_$VisitFilterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$VisitStatsModel {
  int get totalVisits => throw _privateConstructorUsedError;
  int get completedVisits => throw _privateConstructorUsedError;
  int get pendingVisits => throw _privateConstructorUsedError;
  int get cancelledVisits => throw _privateConstructorUsedError;
  double get completionRate => throw _privateConstructorUsedError;
  int get thisWeekVisits => throw _privateConstructorUsedError;
  int get thisMonthVisits => throw _privateConstructorUsedError;

  /// Create a copy of VisitStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VisitStatsModelCopyWith<VisitStatsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitStatsModelCopyWith<$Res> {
  factory $VisitStatsModelCopyWith(
    VisitStatsModel value,
    $Res Function(VisitStatsModel) then,
  ) = _$VisitStatsModelCopyWithImpl<$Res, VisitStatsModel>;
  @useResult
  $Res call({
    int totalVisits,
    int completedVisits,
    int pendingVisits,
    int cancelledVisits,
    double completionRate,
    int thisWeekVisits,
    int thisMonthVisits,
  });
}

/// @nodoc
class _$VisitStatsModelCopyWithImpl<$Res, $Val extends VisitStatsModel>
    implements $VisitStatsModelCopyWith<$Res> {
  _$VisitStatsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VisitStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalVisits = null,
    Object? completedVisits = null,
    Object? pendingVisits = null,
    Object? cancelledVisits = null,
    Object? completionRate = null,
    Object? thisWeekVisits = null,
    Object? thisMonthVisits = null,
  }) {
    return _then(
      _value.copyWith(
            totalVisits:
                null == totalVisits
                    ? _value.totalVisits
                    : totalVisits // ignore: cast_nullable_to_non_nullable
                        as int,
            completedVisits:
                null == completedVisits
                    ? _value.completedVisits
                    : completedVisits // ignore: cast_nullable_to_non_nullable
                        as int,
            pendingVisits:
                null == pendingVisits
                    ? _value.pendingVisits
                    : pendingVisits // ignore: cast_nullable_to_non_nullable
                        as int,
            cancelledVisits:
                null == cancelledVisits
                    ? _value.cancelledVisits
                    : cancelledVisits // ignore: cast_nullable_to_non_nullable
                        as int,
            completionRate:
                null == completionRate
                    ? _value.completionRate
                    : completionRate // ignore: cast_nullable_to_non_nullable
                        as double,
            thisWeekVisits:
                null == thisWeekVisits
                    ? _value.thisWeekVisits
                    : thisWeekVisits // ignore: cast_nullable_to_non_nullable
                        as int,
            thisMonthVisits:
                null == thisMonthVisits
                    ? _value.thisMonthVisits
                    : thisMonthVisits // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VisitStatsModelImplCopyWith<$Res>
    implements $VisitStatsModelCopyWith<$Res> {
  factory _$$VisitStatsModelImplCopyWith(
    _$VisitStatsModelImpl value,
    $Res Function(_$VisitStatsModelImpl) then,
  ) = __$$VisitStatsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalVisits,
    int completedVisits,
    int pendingVisits,
    int cancelledVisits,
    double completionRate,
    int thisWeekVisits,
    int thisMonthVisits,
  });
}

/// @nodoc
class __$$VisitStatsModelImplCopyWithImpl<$Res>
    extends _$VisitStatsModelCopyWithImpl<$Res, _$VisitStatsModelImpl>
    implements _$$VisitStatsModelImplCopyWith<$Res> {
  __$$VisitStatsModelImplCopyWithImpl(
    _$VisitStatsModelImpl _value,
    $Res Function(_$VisitStatsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VisitStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalVisits = null,
    Object? completedVisits = null,
    Object? pendingVisits = null,
    Object? cancelledVisits = null,
    Object? completionRate = null,
    Object? thisWeekVisits = null,
    Object? thisMonthVisits = null,
  }) {
    return _then(
      _$VisitStatsModelImpl(
        totalVisits:
            null == totalVisits
                ? _value.totalVisits
                : totalVisits // ignore: cast_nullable_to_non_nullable
                    as int,
        completedVisits:
            null == completedVisits
                ? _value.completedVisits
                : completedVisits // ignore: cast_nullable_to_non_nullable
                    as int,
        pendingVisits:
            null == pendingVisits
                ? _value.pendingVisits
                : pendingVisits // ignore: cast_nullable_to_non_nullable
                    as int,
        cancelledVisits:
            null == cancelledVisits
                ? _value.cancelledVisits
                : cancelledVisits // ignore: cast_nullable_to_non_nullable
                    as int,
        completionRate:
            null == completionRate
                ? _value.completionRate
                : completionRate // ignore: cast_nullable_to_non_nullable
                    as double,
        thisWeekVisits:
            null == thisWeekVisits
                ? _value.thisWeekVisits
                : thisWeekVisits // ignore: cast_nullable_to_non_nullable
                    as int,
        thisMonthVisits:
            null == thisMonthVisits
                ? _value.thisMonthVisits
                : thisMonthVisits // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$VisitStatsModelImpl implements _VisitStatsModel {
  const _$VisitStatsModelImpl({
    this.totalVisits = 0,
    this.completedVisits = 0,
    this.pendingVisits = 0,
    this.cancelledVisits = 0,
    this.completionRate = 0.0,
    this.thisWeekVisits = 0,
    this.thisMonthVisits = 0,
  });

  @override
  @JsonKey()
  final int totalVisits;
  @override
  @JsonKey()
  final int completedVisits;
  @override
  @JsonKey()
  final int pendingVisits;
  @override
  @JsonKey()
  final int cancelledVisits;
  @override
  @JsonKey()
  final double completionRate;
  @override
  @JsonKey()
  final int thisWeekVisits;
  @override
  @JsonKey()
  final int thisMonthVisits;

  @override
  String toString() {
    return 'VisitStatsModel(totalVisits: $totalVisits, completedVisits: $completedVisits, pendingVisits: $pendingVisits, cancelledVisits: $cancelledVisits, completionRate: $completionRate, thisWeekVisits: $thisWeekVisits, thisMonthVisits: $thisMonthVisits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisitStatsModelImpl &&
            (identical(other.totalVisits, totalVisits) ||
                other.totalVisits == totalVisits) &&
            (identical(other.completedVisits, completedVisits) ||
                other.completedVisits == completedVisits) &&
            (identical(other.pendingVisits, pendingVisits) ||
                other.pendingVisits == pendingVisits) &&
            (identical(other.cancelledVisits, cancelledVisits) ||
                other.cancelledVisits == cancelledVisits) &&
            (identical(other.completionRate, completionRate) ||
                other.completionRate == completionRate) &&
            (identical(other.thisWeekVisits, thisWeekVisits) ||
                other.thisWeekVisits == thisWeekVisits) &&
            (identical(other.thisMonthVisits, thisMonthVisits) ||
                other.thisMonthVisits == thisMonthVisits));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalVisits,
    completedVisits,
    pendingVisits,
    cancelledVisits,
    completionRate,
    thisWeekVisits,
    thisMonthVisits,
  );

  /// Create a copy of VisitStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VisitStatsModelImplCopyWith<_$VisitStatsModelImpl> get copyWith =>
      __$$VisitStatsModelImplCopyWithImpl<_$VisitStatsModelImpl>(
        this,
        _$identity,
      );
}

abstract class _VisitStatsModel implements VisitStatsModel {
  const factory _VisitStatsModel({
    final int totalVisits,
    final int completedVisits,
    final int pendingVisits,
    final int cancelledVisits,
    final double completionRate,
    final int thisWeekVisits,
    final int thisMonthVisits,
  }) = _$VisitStatsModelImpl;

  @override
  int get totalVisits;
  @override
  int get completedVisits;
  @override
  int get pendingVisits;
  @override
  int get cancelledVisits;
  @override
  double get completionRate;
  @override
  int get thisWeekVisits;
  @override
  int get thisMonthVisits;

  /// Create a copy of VisitStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VisitStatsModelImplCopyWith<_$VisitStatsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AppStateModel {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of AppStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppStateModelCopyWith<AppStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateModelCopyWith<$Res> {
  factory $AppStateModelCopyWith(
    AppStateModel value,
    $Res Function(AppStateModel) then,
  ) = _$AppStateModelCopyWithImpl<$Res, AppStateModel>;
  @useResult
  $Res call({bool isLoading, String? error});
}

/// @nodoc
class _$AppStateModelCopyWithImpl<$Res, $Val extends AppStateModel>
    implements $AppStateModelCopyWith<$Res> {
  _$AppStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isLoading = null, Object? error = freezed}) {
    return _then(
      _value.copyWith(
            isLoading:
                null == isLoading
                    ? _value.isLoading
                    : isLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            error:
                freezed == error
                    ? _value.error
                    : error // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppStateModelImplCopyWith<$Res>
    implements $AppStateModelCopyWith<$Res> {
  factory _$$AppStateModelImplCopyWith(
    _$AppStateModelImpl value,
    $Res Function(_$AppStateModelImpl) then,
  ) = __$$AppStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, String? error});
}

/// @nodoc
class __$$AppStateModelImplCopyWithImpl<$Res>
    extends _$AppStateModelCopyWithImpl<$Res, _$AppStateModelImpl>
    implements _$$AppStateModelImplCopyWith<$Res> {
  __$$AppStateModelImplCopyWithImpl(
    _$AppStateModelImpl _value,
    $Res Function(_$AppStateModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isLoading = null, Object? error = freezed}) {
    return _then(
      _$AppStateModelImpl(
        isLoading:
            null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        error:
            freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$AppStateModelImpl implements _AppStateModel {
  const _$AppStateModelImpl({this.isLoading = false, this.error});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'AppStateModel(isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppStateModelImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, error);

  /// Create a copy of AppStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppStateModelImplCopyWith<_$AppStateModelImpl> get copyWith =>
      __$$AppStateModelImplCopyWithImpl<_$AppStateModelImpl>(this, _$identity);
}

abstract class _AppStateModel implements AppStateModel {
  const factory _AppStateModel({final bool isLoading, final String? error}) =
      _$AppStateModelImpl;

  @override
  bool get isLoading;
  @override
  String? get error;

  /// Create a copy of AppStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppStateModelImplCopyWith<_$AppStateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NotificationModel {
  String get message => throw _privateConstructorUsedError;
  NotificationType get type => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Create a copy of NotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationModelCopyWith<NotificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationModelCopyWith<$Res> {
  factory $NotificationModelCopyWith(
    NotificationModel value,
    $Res Function(NotificationModel) then,
  ) = _$NotificationModelCopyWithImpl<$Res, NotificationModel>;
  @useResult
  $Res call({String message, NotificationType type, DateTime timestamp});
}

/// @nodoc
class _$NotificationModelCopyWithImpl<$Res, $Val extends NotificationModel>
    implements $NotificationModelCopyWith<$Res> {
  _$NotificationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? type = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as NotificationType,
            timestamp:
                null == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationModelImplCopyWith<$Res>
    implements $NotificationModelCopyWith<$Res> {
  factory _$$NotificationModelImplCopyWith(
    _$NotificationModelImpl value,
    $Res Function(_$NotificationModelImpl) then,
  ) = __$$NotificationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, NotificationType type, DateTime timestamp});
}

/// @nodoc
class __$$NotificationModelImplCopyWithImpl<$Res>
    extends _$NotificationModelCopyWithImpl<$Res, _$NotificationModelImpl>
    implements _$$NotificationModelImplCopyWith<$Res> {
  __$$NotificationModelImplCopyWithImpl(
    _$NotificationModelImpl _value,
    $Res Function(_$NotificationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? type = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$NotificationModelImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as NotificationType,
        timestamp:
            null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$NotificationModelImpl implements _NotificationModel {
  const _$NotificationModelImpl({
    required this.message,
    required this.type,
    required this.timestamp,
  });

  @override
  final String message;
  @override
  final NotificationType type;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'NotificationModel(message: $message, type: $type, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationModelImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, type, timestamp);

  /// Create a copy of NotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationModelImplCopyWith<_$NotificationModelImpl> get copyWith =>
      __$$NotificationModelImplCopyWithImpl<_$NotificationModelImpl>(
        this,
        _$identity,
      );
}

abstract class _NotificationModel implements NotificationModel {
  const factory _NotificationModel({
    required final String message,
    required final NotificationType type,
    required final DateTime timestamp,
  }) = _$NotificationModelImpl;

  @override
  String get message;
  @override
  NotificationType get type;
  @override
  DateTime get timestamp;

  /// Create a copy of NotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationModelImplCopyWith<_$NotificationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$VisitFormState {
  int? get customerId => throw _privateConstructorUsedError;
  DateTime? get visitDate => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  List<String> get selectedActivities => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;

  /// Create a copy of VisitFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VisitFormStateCopyWith<VisitFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitFormStateCopyWith<$Res> {
  factory $VisitFormStateCopyWith(
    VisitFormState value,
    $Res Function(VisitFormState) then,
  ) = _$VisitFormStateCopyWithImpl<$Res, VisitFormState>;
  @useResult
  $Res call({
    int? customerId,
    DateTime? visitDate,
    String location,
    String notes,
    List<String> selectedActivities,
    String status,
    bool isValid,
  });
}

/// @nodoc
class _$VisitFormStateCopyWithImpl<$Res, $Val extends VisitFormState>
    implements $VisitFormStateCopyWith<$Res> {
  _$VisitFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VisitFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerId = freezed,
    Object? visitDate = freezed,
    Object? location = null,
    Object? notes = null,
    Object? selectedActivities = null,
    Object? status = null,
    Object? isValid = null,
  }) {
    return _then(
      _value.copyWith(
            customerId:
                freezed == customerId
                    ? _value.customerId
                    : customerId // ignore: cast_nullable_to_non_nullable
                        as int?,
            visitDate:
                freezed == visitDate
                    ? _value.visitDate
                    : visitDate // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            location:
                null == location
                    ? _value.location
                    : location // ignore: cast_nullable_to_non_nullable
                        as String,
            notes:
                null == notes
                    ? _value.notes
                    : notes // ignore: cast_nullable_to_non_nullable
                        as String,
            selectedActivities:
                null == selectedActivities
                    ? _value.selectedActivities
                    : selectedActivities // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            isValid:
                null == isValid
                    ? _value.isValid
                    : isValid // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VisitFormStateImplCopyWith<$Res>
    implements $VisitFormStateCopyWith<$Res> {
  factory _$$VisitFormStateImplCopyWith(
    _$VisitFormStateImpl value,
    $Res Function(_$VisitFormStateImpl) then,
  ) = __$$VisitFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? customerId,
    DateTime? visitDate,
    String location,
    String notes,
    List<String> selectedActivities,
    String status,
    bool isValid,
  });
}

/// @nodoc
class __$$VisitFormStateImplCopyWithImpl<$Res>
    extends _$VisitFormStateCopyWithImpl<$Res, _$VisitFormStateImpl>
    implements _$$VisitFormStateImplCopyWith<$Res> {
  __$$VisitFormStateImplCopyWithImpl(
    _$VisitFormStateImpl _value,
    $Res Function(_$VisitFormStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VisitFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerId = freezed,
    Object? visitDate = freezed,
    Object? location = null,
    Object? notes = null,
    Object? selectedActivities = null,
    Object? status = null,
    Object? isValid = null,
  }) {
    return _then(
      _$VisitFormStateImpl(
        customerId:
            freezed == customerId
                ? _value.customerId
                : customerId // ignore: cast_nullable_to_non_nullable
                    as int?,
        visitDate:
            freezed == visitDate
                ? _value.visitDate
                : visitDate // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        location:
            null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                    as String,
        notes:
            null == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                    as String,
        selectedActivities:
            null == selectedActivities
                ? _value._selectedActivities
                : selectedActivities // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        isValid:
            null == isValid
                ? _value.isValid
                : isValid // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$VisitFormStateImpl implements _VisitFormState {
  const _$VisitFormStateImpl({
    this.customerId,
    this.visitDate,
    this.location = '',
    this.notes = '',
    final List<String> selectedActivities = const [],
    this.status = 'Pending',
    this.isValid = false,
  }) : _selectedActivities = selectedActivities;

  @override
  final int? customerId;
  @override
  final DateTime? visitDate;
  @override
  @JsonKey()
  final String location;
  @override
  @JsonKey()
  final String notes;
  final List<String> _selectedActivities;
  @override
  @JsonKey()
  List<String> get selectedActivities {
    if (_selectedActivities is EqualUnmodifiableListView)
      return _selectedActivities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedActivities);
  }

  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final bool isValid;

  @override
  String toString() {
    return 'VisitFormState(customerId: $customerId, visitDate: $visitDate, location: $location, notes: $notes, selectedActivities: $selectedActivities, status: $status, isValid: $isValid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisitFormStateImpl &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.visitDate, visitDate) ||
                other.visitDate == visitDate) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(
              other._selectedActivities,
              _selectedActivities,
            ) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isValid, isValid) || other.isValid == isValid));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    customerId,
    visitDate,
    location,
    notes,
    const DeepCollectionEquality().hash(_selectedActivities),
    status,
    isValid,
  );

  /// Create a copy of VisitFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VisitFormStateImplCopyWith<_$VisitFormStateImpl> get copyWith =>
      __$$VisitFormStateImplCopyWithImpl<_$VisitFormStateImpl>(
        this,
        _$identity,
      );
}

abstract class _VisitFormState implements VisitFormState {
  const factory _VisitFormState({
    final int? customerId,
    final DateTime? visitDate,
    final String location,
    final String notes,
    final List<String> selectedActivities,
    final String status,
    final bool isValid,
  }) = _$VisitFormStateImpl;

  @override
  int? get customerId;
  @override
  DateTime? get visitDate;
  @override
  String get location;
  @override
  String get notes;
  @override
  List<String> get selectedActivities;
  @override
  String get status;
  @override
  bool get isValid;

  /// Create a copy of VisitFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VisitFormStateImplCopyWith<_$VisitFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
