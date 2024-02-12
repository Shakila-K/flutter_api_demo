class NewUser {
  
  String? name;
  int? age;

  NewUser({this.name, this.age});

  NewUser.fromJson(Map<String, dynamic> json){
    name = json['name'];
    age = json['age'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['age'] = age;
    return data;
  }
}