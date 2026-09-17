import 'package:app_test_with_backend/features/news/data/models/SourceLocalModel.dart';
import 'package:hive_ce/hive.dart';

class SourcelocalModelAdapter extends  TypeAdapter<SourceLocalModel> {
  @override
  SourceLocalModel read(BinaryReader reader) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  // TODO: implement typeId
  int get typeId => throw UnimplementedError();

  @override
  void write(BinaryWriter writer, SourceLocalModel obj) {
    // TODO: implement write
  }
}