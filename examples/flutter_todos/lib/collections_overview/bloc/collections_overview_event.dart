part of 'collections_overview_bloc.dart';

sealed class CollectionsOverviewEvent extends Equatable {
  const CollectionsOverviewEvent();

  @override
  List<Object> get props => [];
}

final class CollectionsOverviewSubscriptionRequested extends CollectionsOverviewEvent {
  const CollectionsOverviewSubscriptionRequested();
}

final class CollectionsOverviewCollectionDeleted extends CollectionsOverviewEvent {
  const CollectionsOverviewCollectionDeleted(this.collection);

  final Collection collection;

  @override
  List<Object> get props => [collection];
}
