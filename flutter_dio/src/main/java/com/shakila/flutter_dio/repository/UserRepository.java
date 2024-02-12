package com.shakila.flutter_dio.repository;

import com.shakila.flutter_dio.model.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository <UserModel, Integer> {

}
