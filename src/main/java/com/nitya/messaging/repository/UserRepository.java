package com.nitya.messaging.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.nitya.messaging.entiry.Users;


public interface UserRepository extends JpaRepository<Users,Integer>{

	Users findByUsername(String username);

}
