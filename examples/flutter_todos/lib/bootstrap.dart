import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todos/app/app.dart';
import 'package:flutter_todos/app/app_bloc_observer.dart';
import 'package:todos_api/todos_api.dart';
import 'package:todos_repository/todos_repository.dart';
import 'package:collections_api/collections_api.dart';
import 'package:collections_repository/collections_repository.dart';

void bootstrap({required TodosApi todosApi, required CollectionsApi collectionsApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final todosRepository = TodosRepository(todosApi: todosApi);
  final collectionsRepository = CollectionsRepository(collectionsApi: collectionsApi);

  runZonedGuarded(
    () => runApp(App(todosRepository: todosRepository, collectionsRepository: collectionsRepository,)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
