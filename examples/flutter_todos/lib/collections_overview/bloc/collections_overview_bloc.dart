import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:collections_repository/collections_repository.dart';

part 'collections_overview_event.dart';
part 'collections_overview_state.dart';

class CollectionsOverviewBloc extends Bloc<CollectionsOverviewEvent, CollectionsOverviewState> {
  CollectionsOverviewBloc({
    required CollectionsRepository collectionsRepository,
  })  : _collectionsRepository = collectionsRepository,
        super(const CollectionsOverviewState()) {
    on<CollectionsOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<CollectionsOverviewCollectionDeleted>(_onCollectionDeleted);
  }

  final CollectionsRepository _collectionsRepository;

  Future<void> _onSubscriptionRequested(
    CollectionsOverviewSubscriptionRequested event,
    Emitter<CollectionsOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => CollectionsOverviewStatus.loading));

    await emit.forEach<List<Collection>>(
      _collectionsRepository.getCollections(),
      onData: (collections) => state.copyWith(
        status: () => CollectionsOverviewStatus.success,
        collections: () => collections,
      ),
      onError: (_, __) => state.copyWith(
        status: () => CollectionsOverviewStatus.failure,
      ),
    );
  }

  Future<void> _onCollectionDeleted(
    CollectionsOverviewCollectionDeleted event,
    Emitter<CollectionsOverviewState> emit,
  ) async {
    emit(state.copyWith(lastDeletedCollection: () => event.collection));
    await _collectionsRepository.deleteCollection(event.collection.id);
  }
}