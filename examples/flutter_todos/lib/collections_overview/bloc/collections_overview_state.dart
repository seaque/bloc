part of 'collections_overview_bloc.dart';

enum CollectionsOverviewStatus { initial, loading, success, failure }

final class CollectionsOverviewState extends Equatable {
  const CollectionsOverviewState({
    this.status = CollectionsOverviewStatus.initial,
    this.collections = const [],
    this.lastDeletedCollection,
  });

  final CollectionsOverviewStatus status;
  final List<Collection> collections;
  final Collection? lastDeletedCollection;

  CollectionsOverviewState copyWith({
    CollectionsOverviewStatus Function()? status,
    List<Collection> Function()? collections,
    Collection? Function()? lastDeletedCollection,
  }) {
    return CollectionsOverviewState(
      status: status != null ? status() : this.status,
      collections: collections != null ? collections() : this.collections,
      lastDeletedCollection:
          lastDeletedCollection != null ? lastDeletedCollection() : this.lastDeletedCollection,
    );
  }

  @override
  List<Object?> get props => [
        status,
        collections,
        lastDeletedCollection,
      ];
}