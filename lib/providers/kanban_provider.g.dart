// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanban_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(persistenceService)
final persistenceServiceProvider = PersistenceServiceProvider._();

final class PersistenceServiceProvider
    extends
        $FunctionalProvider<
          PersistenceService,
          PersistenceService,
          PersistenceService
        >
    with $Provider<PersistenceService> {
  PersistenceServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'persistenceServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$persistenceServiceHash();

  @$internal
  @override
  $ProviderElement<PersistenceService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PersistenceService create(Ref ref) {
    return persistenceService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PersistenceService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PersistenceService>(value),
    );
  }
}

String _$persistenceServiceHash() =>
    r'304c67cdc8f4ed22b34f0eabeb381797b6d94c6d';

@ProviderFor(KanbanNotifier)
final kanbanProvider = KanbanNotifierProvider._();

final class KanbanNotifierProvider
    extends $NotifierProvider<KanbanNotifier, KanbanState> {
  KanbanNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kanbanProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kanbanNotifierHash();

  @$internal
  @override
  KanbanNotifier create() => KanbanNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KanbanState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KanbanState>(value),
    );
  }
}

String _$kanbanNotifierHash() => r'a41684a1592ba6d060675530993f0e5caee704ca';

abstract class _$KanbanNotifier extends $Notifier<KanbanState> {
  KanbanState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<KanbanState, KanbanState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<KanbanState, KanbanState>,
              KanbanState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
