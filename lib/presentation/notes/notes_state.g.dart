// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NotesState _$$_NotesStateFromJson(Map<String, dynamic> json) =>
    _$_NotesState(
      notes: (json['notes'] as List<dynamic>?)
              ?.map((e) => Note.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$$_NotesStateToJson(_$_NotesState instance) =>
    <String, dynamic>{
      'notes': instance.notes,
    };
