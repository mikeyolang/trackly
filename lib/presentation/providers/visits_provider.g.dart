// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visits_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$visitsNotifierHash() => r'e6d2c09f514855bdd73142e8ec5942ccd187e5ea';

/// See also [VisitsNotifier].
@ProviderFor(VisitsNotifier)
final visitsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<VisitsNotifier, List<Visit>>.internal(
      VisitsNotifier.new,
      name: r'visitsNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$visitsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$VisitsNotifier = AutoDisposeAsyncNotifier<List<Visit>>;
String _$filteredVisitsNotifierHash() =>
    r'd57eaef1e389b8280f75a7886e9853beedda57fa';

/// See also [FilteredVisitsNotifier].
@ProviderFor(FilteredVisitsNotifier)
final filteredVisitsNotifierProvider = AutoDisposeAsyncNotifierProvider<
  FilteredVisitsNotifier,
  List<Visit>
>.internal(
  FilteredVisitsNotifier.new,
  name: r'filteredVisitsNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$filteredVisitsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FilteredVisitsNotifier = AutoDisposeAsyncNotifier<List<Visit>>;
String _$visitFilterHash() => r'dbf00854b7826821efc87b8fec3c7fb9335899f4';

/// See also [VisitFilter].
@ProviderFor(VisitFilter)
final visitFilterProvider =
    AutoDisposeNotifierProvider<VisitFilter, VisitFilterModel>.internal(
      VisitFilter.new,
      name: r'visitFilterProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$visitFilterHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$VisitFilter = AutoDisposeNotifier<VisitFilterModel>;
String _$searchQueryHash() => r'5cfb8bc058f64b12d9a61421526a8ea7b414d4fa';

/// See also [SearchQuery].
@ProviderFor(SearchQuery)
final searchQueryProvider =
    AutoDisposeNotifierProvider<SearchQuery, String>.internal(
      SearchQuery.new,
      name: r'searchQueryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$searchQueryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SearchQuery = AutoDisposeNotifier<String>;
String _$visitStatsHash() => r'f6544245240a6a7da6c083460bc2515bf3338cc6';

/// See also [VisitStats].
@ProviderFor(VisitStats)
final visitStatsProvider =
    AutoDisposeAsyncNotifierProvider<VisitStats, VisitStatsModel>.internal(
      VisitStats.new,
      name: r'visitStatsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$visitStatsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$VisitStats = AutoDisposeAsyncNotifier<VisitStatsModel>;
String _$visitDetailHash() => r'b53faf8b78318c509682f919c006f3c8b760cacb';

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

abstract class _$VisitDetail extends BuildlessAutoDisposeAsyncNotifier<Visit?> {
  late final int visitId;

  FutureOr<Visit?> build(int visitId);
}

/// See also [VisitDetail].
@ProviderFor(VisitDetail)
const visitDetailProvider = VisitDetailFamily();

/// See also [VisitDetail].
class VisitDetailFamily extends Family<AsyncValue<Visit?>> {
  /// See also [VisitDetail].
  const VisitDetailFamily();

  /// See also [VisitDetail].
  VisitDetailProvider call(int visitId) {
    return VisitDetailProvider(visitId);
  }

  @override
  VisitDetailProvider getProviderOverride(
    covariant VisitDetailProvider provider,
  ) {
    return call(provider.visitId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'visitDetailProvider';
}

/// See also [VisitDetail].
class VisitDetailProvider
    extends AutoDisposeAsyncNotifierProviderImpl<VisitDetail, Visit?> {
  /// See also [VisitDetail].
  VisitDetailProvider(int visitId)
    : this._internal(
        () => VisitDetail()..visitId = visitId,
        from: visitDetailProvider,
        name: r'visitDetailProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$visitDetailHash,
        dependencies: VisitDetailFamily._dependencies,
        allTransitiveDependencies: VisitDetailFamily._allTransitiveDependencies,
        visitId: visitId,
      );

  VisitDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.visitId,
  }) : super.internal();

  final int visitId;

  @override
  FutureOr<Visit?> runNotifierBuild(covariant VisitDetail notifier) {
    return notifier.build(visitId);
  }

  @override
  Override overrideWith(VisitDetail Function() create) {
    return ProviderOverride(
      origin: this,
      override: VisitDetailProvider._internal(
        () => create()..visitId = visitId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        visitId: visitId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<VisitDetail, Visit?> createElement() {
    return _VisitDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VisitDetailProvider && other.visitId == visitId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, visitId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin VisitDetailRef on AutoDisposeAsyncNotifierProviderRef<Visit?> {
  /// The parameter `visitId` of this provider.
  int get visitId;
}

class _VisitDetailProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<VisitDetail, Visit?>
    with VisitDetailRef {
  _VisitDetailProviderElement(super.provider);

  @override
  int get visitId => (origin as VisitDetailProvider).visitId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
