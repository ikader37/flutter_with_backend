import 'package:app_test_with_backend/features/news/data/models/SourceModel.dart';
import 'package:app_test_with_backend/features/news/domain/entities/SourceEntity.dart';
import 'package:hive_ce/hive.dart';

part 'SourceLocalModel.g.dart';

@HiveType(typeId: 1)
class SourceLocalModel extends HiveObject{
  @HiveField(0)
   final String  id="";
  @HiveField(1)
   final String name="";
  SourceLocalModel({required id,required name});

   // SourceLocalModel.name(this.id, this.name);

   Map<String,dynamic> toJson()=>{
    "id": id,
    "name":name
  };
  SourceEntity toEntity()=>SourceEntity(id: id.toString(), name: name);

  SourceModel toModel()=>SourceModel(id: id, name: name);
  factory SourceLocalModel.fromJson(Map<String,dynamic> json){
    return SourceLocalModel(id : json['id']?.toString() ?? '',
      name : json['name']?.toString() ?? '');
  }

  @override
  String toString() {
    return 'SourceModel{id: $id, name: $name}';
  }
}