part of 'edit_collection_bloc.dart';

enum EditCollectionStatus { initial, loading, success, failure }

extension EditCollectionStatusX on EditCollectionStatus {
  bool get isLoadingOrSuccess => [
        EditCollectionStatus.loading,
        EditCollectionStatus.success,
      ].contains(this);
}

final class EditCollectionState extends Equatable {
  const EditCollectionState({
    this.status = EditCollectionStatus.initial,
    this.initialCollection,
    this.title = '',
    this.todos = const [],
  });

  final EditCollectionStatus status;
  final Collection? initialCollection;
  final List<Todo>? todos;
  final String title;

  bool get isNewCollection => initialCollection == null;

  EditCollectionState copyWith({
    EditCollectionStatus? status,
    List<Todo>? todos,
    String? title,
  }) {
    return EditCollectionState(
      status: status ?? this.status,
      initialCollection: initialCollection ?? initialCollection,
      todos: todos ?? this.todos,
      title: title ?? this.title,
    );
  }

  @override
  List<Object?> get props => [status, initialCollection, title, todos];
}
