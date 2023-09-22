import 'package:collections_api/collections_api.dart';

/// {@template collections_api}
/// The interface and models for an API providing access to collections.
/// {@endtemplate}
abstract class CollectionsApi {
  /// {@macro collections_api}
  const CollectionsApi();

  /// Provides a [Stream] of all collections.
  Stream<List<Collection>> getCollections();

  /// Creates a [collection].
  Future<void> saveCollection(Collection collection);

  /// Deletes the `collection` with the given id.
  /// 
  /// If no `collection` with the given id exists, a [CollectionNotFoundException] error is
  /// thrown.
  Future<void> deleteCollection(String id);
}

class CollectionNotFoundException implements Exception {}
