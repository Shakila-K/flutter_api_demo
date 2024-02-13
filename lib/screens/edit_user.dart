import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio/internet_services/paths.dart';
import 'package:flutter_dio/model/user.dart';

class EditUser extends StatefulWidget {
  final User user;
  const EditUser({super.key, required this.user});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {

  late User user;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    user = widget.user;
    _nameController.text = user.name.toString();
    _ageController.text = user.age.toString();
  }

  void updatreUser() async {
    try{
      var response = await Dio().put('$baseUrl/update', data: user.toJson());
      if(response.statusCode == 200){
        print('User updated');
        closePage();
      }
      else{
        throw response.statusMessage.toString();
      }
    }catch(e){
      print(e);
    }
  }

  void deleteUser() async {
    try{
      var response = await Dio().delete('$baseUrl/remove/${user.id}');
      if(response.statusCode == 200){
        print('User deleted');
        closePage();
      }
      else{
        throw response.statusMessage.toString();
      }
    }catch (e){
      print(e);
    }
  }

  void closePage(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
      ),
      body: Center(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('ID: ${user.id}')
                ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        setState(() {
                          user.name = _nameController.text;
                          user.age = int.parse(_ageController.text);
                        });
                        updatreUser();
                      },
                      child: const Text('Save'),
                    ),
                    const SizedBox(width: 20,),
                    ElevatedButton(
                      onPressed: (){
                        deleteUser();
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
        ),
      ),
    );
  }
}