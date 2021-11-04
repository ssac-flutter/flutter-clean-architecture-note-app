// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Note _$$_NoteFromJson(Map<String, dynamic> json) => _$_Note(
      title: json['title'] as String,
      content: json['content'] as String,
      color: json['color'] as int,
      timestamp: json['timestamp'] as int,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$$_NoteToJson(_$_Note instance) => <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'color': instance.color,
      'timestamp': instance.timestamp,
      'id': instance.id,
    };
