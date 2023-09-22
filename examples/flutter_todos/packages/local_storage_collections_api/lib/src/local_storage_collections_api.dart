import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collections_api/collections_api.dart';

/// {@template local_storage_collections_api}
/// A Flutter implementation of the CollectionsApi that uses local storage.
/// {@endtemplate}
class LocalStorageCollectionsApi extends CollectionsApi {
  /// {@macro local_storage_collections_api}
  LocalStorageCollectionsApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _collectionStreamController = BehaviorSubject<List<Collection>>.seeded(const []);

  /// The key used for storing the collections locally.
  /// 
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kCollectionsCollectionKey = '__collections_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final collectionsJson = _getValue(kCollectionsCollectionKey);
    if (collectionsJson != null) {
      final collections = List<Map<dynamic, dynamic>>.from(
        json.decode(collectionsJson) as List,
      )
          .map((jsonMap) => Collection.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _collectionStreamController.add(collections);
    } else {
      _collectionStreamController.add(const []);
    }
  }

  @override 
  Stream<List<Collection>> getCollections() => _collectionStreamController.asBroadcastStream();

  @override
  Future<void> saveCollection(Collection collection) {
    final collections = [..._collectionStreamController.value];
    final collectionIndex = collections.indexWhere((c) => c.id == collection.id);
    if (collectionIndex >= 0) {
      collections[collectionIndex] = collection;
    } else {
      collections.add(collection);
    }
    return _setValue(
      kCollectionsCollectionKey,
      json.encode(collections));
  }

  @override
  Future<void> deleteCollection(String id) async {
    final collections = [..._collectionStreamController.value];
    final collectionIndex = collections.indexWhere((c) => c.id == id);
    if (collectionIndex == -1) {
      throw CollectionNotFoundException();
    }
    else {
      collections.removeAt(collectionIndex);
      _collectionStreamController.add(collections);
      return _setValue(
        kCollectionsCollectionKey,
        json.encode(collections));
    }
  }
}
