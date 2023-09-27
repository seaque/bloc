// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      title: json['title'] as String,
      id: json['id'] as String?,
      description: json['description'] as String? ?? '',
      collection: json['collectionId'] == null
          ? null
          : Collection.fromJson(json['collectionId'] as Map<String, dynamic>),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'collectionId': instance.collection,
      'isCompleted': instance.isCompleted,
    };
