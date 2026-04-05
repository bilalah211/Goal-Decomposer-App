// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalCardModelAdapter extends TypeAdapter<GoalCardModel> {
  @override
  final int typeId = 0;

  @override
  GoalCardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoalCardModel(
      id: fields[0] as String?,
      title: fields[1] as String,
      description: fields[2] as String,
      deadline: fields[3] as DateTime,
      priority: fields[4] as String,
      colorValue: fields[5] as int?,
      tasks: (fields[6] as List?)?.cast<TaskModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, GoalCardModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.deadline)
      ..writeByte(4)
      ..write(obj.priority)
      ..writeByte(5)
      ..write(obj.colorValue)
      ..writeByte(6)
      ..write(obj.tasks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalCardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
