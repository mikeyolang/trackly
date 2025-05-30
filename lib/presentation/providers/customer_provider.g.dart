// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$customerByIdHash() => r'a043729e5537343c120ae2a93f099f82ac4ae703';

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

/// See also [customerById].
@ProviderFor(customerById)
const customerByIdProvider = CustomerByIdFamily();

/// See also [customerById].
class CustomerByIdFamily extends Family<Customer?> {
  /// See also [customerById].
  const CustomerByIdFamily();

  /// See also [customerById].
  CustomerByIdProvider call(int customerId) {
    return CustomerByIdProvider(customerId);
  }

  @override
  CustomerByIdProvider getProviderOverride(
    covariant CustomerByIdProvider provider,
  ) {
    return call(provider.customerId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'customerByIdProvider';
}

/// See also [customerById].
class CustomerByIdProvider extends AutoDisposeProvider<Customer?> {
  /// See also [customerById].
  CustomerByIdProvider(int customerId)
    : this._internal(
        (ref) => customerById(ref as CustomerByIdRef, customerId),
        from: customerByIdProvider,
        name: r'customerByIdProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$customerByIdHash,
        dependencies: CustomerByIdFamily._dependencies,
        allTransitiveDependencies:
            CustomerByIdFamily._allTransitiveDependencies,
        customerId: customerId,
      );

  CustomerByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.customerId,
  }) : super.internal();

  final int customerId;

  @override
  Override overrideWith(Customer? Function(CustomerByIdRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: CustomerByIdProvider._internal(
        (ref) => create(ref as CustomerByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        customerId: customerId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Customer?> createElement() {
    return _CustomerByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomerByIdProvider && other.customerId == customerId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, customerId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CustomerByIdRef on AutoDisposeProviderRef<Customer?> {
  /// The parameter `customerId` of this provider.
  int get customerId;
}

class _CustomerByIdProviderElement extends AutoDisposeProviderElement<Customer?>
    with CustomerByIdRef {
  _CustomerByIdProviderElement(super.provider);

  @override
  int get customerId => (origin as CustomerByIdProvider).customerId;
}

String _$customersNotifierHash() => r'03d2cff01082e7000f3eb5e7caecf455e50f19be';

/// See also [CustomersNotifier].
@ProviderFor(CustomersNotifier)
final customersNotifierProvider = AutoDisposeAsyncNotifierProvider<
  CustomersNotifier,
  List<Customer>
>.internal(
  CustomersNotifier.new,
  name: r'customersNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$customersNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CustomersNotifier = AutoDisposeAsyncNotifier<List<Customer>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
