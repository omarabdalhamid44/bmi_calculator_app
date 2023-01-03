class DataBaseModel{
late int id ;
late String name;
late int age;
late String gender;
late int height;
late int weight;
late String type;
late String category;
late double result;
DataBaseModel();
  DataBaseModel.fromMap(Map<String,dynamic> map){
    id = map['id'];
    name = map['name'];
    age = map['age'];
    gender = map['gender'];
    height = map['height'];
    weight = map['weight'];
    type = map['type'];
    category = map['category'];
    result = map['result'];
  }
  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = {};
    map['name'] =  name;
    map['age'] =  age;
    map['gender'] =  gender;
    map['height'] =  height;
    map['weight'] =  weight;
    map['type'] =  type;
    map['category'] = category;
    map['result'] = result;
    return map;
  }
}