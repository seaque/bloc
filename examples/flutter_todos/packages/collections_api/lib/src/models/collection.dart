import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:todos_api/todos_api.dart';
import 'package:uuid/uuid.dart';

part 'collection.g.dart';

/// {@template collection}
/// A single `collection`.
///
/// Contains a [title] and list of [todo]s and [id].
///
/// If no [todo]s are provided, the `collection` is considered empty.
///
/// [Collection]s are immutable and can be copied using [copyWith], in
/// addition to being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}

@immutable
@JsonSerializable()
class Collection extends Equatable {
  /// {@macro collection}
  Collection({
    required this.title,
    String? id,
    this.todos,
  }) : assert(
          id == null || id.isNotEmpty,
          'id must either be null or not empty',
        ),
        id = id ?? const Uuid().v4();

  /// The unique identifier of the `collection`.
  /// 
  /// Cannot be empty.
  final String id;

  /// The title of the `todo`.
  final String title;

  /// The list of `todo`s.
  final List<Todo>? todos;

  /// Returns a copy of this `collection` with the given values updated.
  ///
  /// {@macro collection}
  Collection copyWith({
    String? id,
    String? title,
    List<Todo>? todos,
  }) {
    return Collection(
      id: id ?? this.id,
      title: title ?? this.title,
      todos: todos ?? todos,
    );
  }

  /// Deserializes a [Collection] from [json].
  static Collection fromJson(JsonMap json) => _$CollectionFromJson(json);

  /// Converts this [Collection] to a [JsonMap].
  JsonMap toJson() => _$CollectionToJson(this);

  @override
  List<dynamic> get props => [title, todos];
}
