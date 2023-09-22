import 'package:collections_api/collections_api.dart';

/// {@template collections_repository}
/// A repository that handles collection related requests.
/// {@endtemplate}
class CollectionsRepository {
  /// {@macro collections_repository}
  const CollectionsRepository({
    required CollectionsApi collectionsApi,
  }) : _collectionsApi = collectionsApi;

  final CollectionsApi _collectionsApi;

  /// Provides a [Stream] of all collections.
  Stream<List<Collection>> getCollections() => _collectionsApi.getCollections();

  /// Saves a [collection].
  ///
  Future<void> saveCollection(Collection collection) =>
      _collectionsApi.saveCollection(collection);

  /// Deletes a [collection] by its [id].
  /// 
  /// Returns [true] if the collection was deleted successfully.
  Future<void> deleteCollection(String id) =>
      _collectionsApi.deleteCollection(id);
}
