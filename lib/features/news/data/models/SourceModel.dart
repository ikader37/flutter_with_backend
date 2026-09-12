import 'package:app_test_with_backend/features/news/domain/entities/SourceEntity.dart';
class SourceModel{
  final String id;
  final String name;
const SourceModel({
    required  this.id,
  required  this.name
});

  Map<String,dynamic> toJson()=>{
    "id": id,
    "name":name
  };
  SourceEntity toEntity()=>SourceEntity(id: id, name: name);

  factory SourceModel.fromJson(Map<String,dynamic> json){
    return SourceModel(id:json['id']?? '', name: json['name']?? '');
  }

  @override
  String toString() {
    return 'SourceModel{id: $id, name: $name}';
  }
}