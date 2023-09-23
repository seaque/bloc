part of 'edit_collection_bloc.dart';

sealed class EditCollectionEvent extends Equatable {
  const EditCollectionEvent();

  @override
  List<Object> get props => [];
}

final class EditCollectionTitleChanged extends EditCollectionEvent {
  const EditCollectionTitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

final class EditCollectionTodoAdded extends EditCollectionEvent {
  const EditCollectionTodoAdded(this.todos);

  final List<Todo> todos;

  @override
  List<Object> get props => [todos];
}

final class EditCollectionSubmitted extends EditCollectionEvent {
  const EditCollectionSubmitted();
}
