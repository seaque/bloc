import 'package:bloc/bloc.dart';
import 'package:collections_repository/collections_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_api/todos_api.dart';

part 'edit_collection_event.dart';
part 'edit_collection_state.dart';

class EditCollectionBloc extends 
Bloc<EditCollectionEvent, EditCollectionState> {
  EditCollectionBloc({
    required CollectionsRepository collectionsRepository,
    required Collection? initialCollection,
  })  : _collectionsRepository = collectionsRepository,
        super(
          EditCollectionState(
            initialCollection: initialCollection,
            title: initialCollection?.title ?? '',
            todos: initialCollection?.todos ?? [],
          ),
        ) {
    on<EditCollectionTitleChanged>(_onTitleChanged);
    on<EditCollectionTodoAdded>(_onContentChanged);
    on<EditCollectionSubmitted>(_onSubmitted);
  }

  final CollectionsRepository _collectionsRepository;

  void _onTitleChanged(
    EditCollectionTitleChanged event,
    Emitter<EditCollectionState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onContentChanged(
    EditCollectionTodoAdded event,
    Emitter<EditCollectionState> emit,
  ) {
    emit(state.copyWith(todos: event.todos));
  }

  Future<void> _onSubmitted(
    EditCollectionSubmitted event,
    Emitter<EditCollectionState> emit,
  ) async {
    emit(state.copyWith(status: EditCollectionStatus.loading));
    final collection = (
      state.initialCollection ?? Collection(title: '')
    ).copyWith(
      title: state.title,
      todos: state.todos,
    );

    try {
      await _collectionsRepository.saveCollection(collection);
      emit(state.copyWith(status: EditCollectionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditCollectionStatus.failure));
    }
  }
}
