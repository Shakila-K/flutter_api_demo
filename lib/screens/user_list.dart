import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio/internet_services/paths.dart';
import 'package:flutter_dio/model/user.dart';
import 'package:flutter_dio/screens/add_user.dart';
import 'package:flutter_dio/screens/edit_user.dart';

class UserList extends StatefulWidget {
  
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  List<User> users = [];
  bool haveData = false;


  void getUsers() async {
    print('getting data from server');
    try{
      var response = await Dio().get('$baseUrl/get');
      if(response.statusCode == 200){
        List<dynamic> data = response.data;
        List<User> users = data.map((e) => User.fromJson(e)).toList();
        setState(() {
          this.users = users;
          haveData = true;
        });
        print('got data from server');
      }
      else{
        throw response.statusMessage.toString();
      }
    }
    catch(e){
      print(e);
    }
  }

  void goToAddUser() async{
    print('going to add user');
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddUser()),
    );
    print('back from add user');
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('User List'),
              const Spacer(),
              IconButton(
                onPressed: (){
                  goToAddUser();
                  getUsers();
                },
                icon: const Icon(Icons.person_add_alt),
              ),
              IconButton(onPressed: getUsers, icon: Icon(Icons.refresh))
            ],
          ),
        ),
      ),
      body: haveData ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index){
            return Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 1),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Id : ${users[index].id}",),
                    Text("Name : ${users[index].name}",),
                    Text("Age : ${users[index].age}",),
                    IconButton(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditUser(user: users[index])),
                      );
                    }, icon: const Icon(Icons.edit)),
                  ],
                ),
              ),
            );
          },
        ),
      ) : const Center(child: CircularProgressIndicator(),),
    );
  }
}
