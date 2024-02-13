
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio/internet_services/paths.dart';
import 'package:flutter_dio/model/new_user.dart';

class AddUser extends StatefulWidget {

  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  NewUser newUser = NewUser();

  void addUser() async {
    try{
      var response = await Dio().post('$baseUrl/new', data: newUser.toJson());
      if(response.statusCode == 201){
        print('User added');
        // goToUserList();
      }
      else{
        throw response.statusMessage.toString();
      }
    }catch(e){
      print(e);
    }

  }

  // void goToUserList(){
  //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => UserList()), (route) => false);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Age',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    newUser.name = _nameController.text;
                    newUser.age = int.parse(_ageController.text);
                    addUser();
                  });
                  Navigator.pop(context);
                },
                child: const Text('Add User'),
              ),
            ],
          ),
      ),
    )
    );
  }
}