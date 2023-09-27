import 'package:flutter/widgets.dart';
import 'package:flutter_todos/bootstrap.dart';
import 'package:local_storage_collections_api/local_storage_collections_api.dart';
import 'package:local_storage_todos_api/local_storage_todos_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final todosApi = LocalStorageTodosApi(
    plugin: await SharedPreferences.getInstance(),
  );

  final collectionsApi = LocalStorageCollectionsApi(
    plugin: await SharedPreferences.getInstance(),
  );

  bootstrap(todosApi: todosApi, collectionsApi: collectionsApi);
}
