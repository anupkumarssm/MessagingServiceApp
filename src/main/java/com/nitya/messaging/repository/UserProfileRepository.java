package com.nitya.messaging.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.nitya.messaging.entiry.UserProfile;

public interface UserProfileRepository extends JpaRepository<UserProfile, Integer>{

	UserProfile findByUsername(String username);

}
