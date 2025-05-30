// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activities_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activitiesByIdsHash() => r'80d7c61019cd0f81840678d5e3dbae0686af1c96';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [activitiesByIds].
@ProviderFor(activitiesByIds)
const activitiesByIdsProvider = ActivitiesByIdsFamily();

/// See also [activitiesByIds].
class ActivitiesByIdsFamily extends Family<List<Activity>> {
  /// See also [activitiesByIds].
  const ActivitiesByIdsFamily();

  /// See also [activitiesByIds].
  ActivitiesByIdsProvider call(List<String> activityIds) {
    return ActivitiesByIdsProvider(activityIds);
  }

  @override
  ActivitiesByIdsProvider getProviderOverride(
    covariant ActivitiesByIdsProvider provider,
  ) {
    return call(provider.activityIds);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'activitiesByIdsProvider';
}

/// See also [activitiesByIds].
class ActivitiesByIdsProvider extends AutoDisposeProvider<List<Activity>> {
  /// See also [activitiesByIds].
  ActivitiesByIdsProvider(List<String> activityIds)
    : this._internal(
        (ref) => activitiesByIds(ref as ActivitiesByIdsRef, activityIds),
        from: activitiesByIdsProvider,
        name: r'activitiesByIdsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$activitiesByIdsHash,
        dependencies: ActivitiesByIdsFamily._dependencies,
        allTransitiveDependencies:
            ActivitiesByIdsFamily._allTransitiveDependencies,
        activityIds: activityIds,
      );

  ActivitiesByIdsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.activityIds,
  }) : super.internal();

  final List<String> activityIds;

  @override
  Override overrideWith(
    List<Activity> Function(ActivitiesByIdsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ActivitiesByIdsProvider._internal(
        (ref) => create(ref as ActivitiesByIdsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        activityIds: activityIds,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<Activity>> createElement() {
    return _ActivitiesByIdsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ActivitiesByIdsProvider && other.activityIds == activityIds;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, activityIds.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ActivitiesByIdsRef on AutoDisposeProviderRef<List<Activity>> {
  /// The parameter `activityIds` of this provider.
  List<String> get activityIds;
}

class _ActivitiesByIdsProviderElement
    extends AutoDisposeProviderElement<List<Activity>>
    with ActivitiesByIdsRef {
  _ActivitiesByIdsProviderElement(super.provider);

  @override
  List<String> get activityIds =>
      (origin as ActivitiesByIdsProvider).activityIds;
}

String _$activitiesNotifierHash() =>
    r'545d3a8e46a23dc1261df44bb4e472c2c0791689';

/// See also [ActivitiesNotifier].
@ProviderFor(ActivitiesNotifier)
final activitiesNotifierProvider = AutoDisposeAsyncNotifierProvider<
  ActivitiesNotifier,
  List<Activity>
>.internal(
  ActivitiesNotifier.new,
  name: r'activitiesNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$activitiesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ActivitiesNotifier = AutoDisposeAsyncNotifier<List<Activity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
