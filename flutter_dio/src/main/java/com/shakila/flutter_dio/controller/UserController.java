package com.shakila.flutter_dio.controller;

import com.shakila.flutter_dio.dto.UserDto;
import com.shakila.flutter_dio.model.UserModel;
import com.shakila.flutter_dio.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/user")
@CrossOrigin(allowedHeaders = "*",origins = "*")
@RequiredArgsConstructor
public class UserController {

    @Autowired
    private final UserService userService;

    @GetMapping("/get/{userId}")
    public ResponseEntity<UserModel> getUser(@PathVariable Integer userId){
        return this.userService.getUser(userId);
    }

    @GetMapping("/get")
    public ResponseEntity<List<UserModel>> getAll(){
        return this.userService.getAll();
    }

    @PostMapping("/new")
    public ResponseEntity<UserModel> newUser(@RequestBody UserDto user){
        return this.userService.newUser(user);
    }

    @PutMapping("/update")
    public ResponseEntity<UserModel> updateUser(@RequestBody UserModel user) {
        return this.userService.updateUser(user);
    }

    @DeleteMapping("/remove/{userId}")
    public ResponseEntity<Void> deleteUser(@PathVariable Integer userId){
        return this.userService.deleteUser(userId);
    }
}
