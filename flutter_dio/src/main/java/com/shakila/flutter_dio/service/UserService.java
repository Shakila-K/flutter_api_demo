package com.shakila.flutter_dio.service;

import com.shakila.flutter_dio.dto.UserDto;
import com.shakila.flutter_dio.model.UserModel;
import com.shakila.flutter_dio.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {

    @Autowired
    private final UserRepository userRepository;

    public ResponseEntity<UserModel> getUser(Integer userId) {
        if(this.userRepository.existsById(userId)){
            return new ResponseEntity<>(this.userRepository.findById(userId).orElseThrow(), HttpStatus.OK);
        }
        else{
            return ResponseEntity.notFound().build();
        }
    }

    public ResponseEntity<List<UserModel>> getAll(){
        return new ResponseEntity<>(this.userRepository.findAll(), HttpStatus.OK);
    }

    public ResponseEntity<UserModel> newUser(UserDto user){
        UserModel newUser = new UserModel( user.getName(), user.getAge());
        return new ResponseEntity<>(this.userRepository.save(newUser), HttpStatus.CREATED);
    }

    public ResponseEntity<UserModel> updateUser(UserModel user){
        if (this.userRepository.existsById(user.getUserId())){
            return new ResponseEntity<>(this.userRepository.save(user), HttpStatus.OK);
        }
        else
            return ResponseEntity.notFound().build();
    }

    public ResponseEntity<Void> deleteUser(Integer userId){
        if (this.userRepository.existsById(userId)){
            this.userRepository.delete(this.userRepository.findById(userId).orElseThrow());
            return ResponseEntity.ok().build();
        }
        else
            return ResponseEntity.notFound().build();
    }
}
