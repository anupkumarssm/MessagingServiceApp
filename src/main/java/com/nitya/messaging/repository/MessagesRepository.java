package com.nitya.messaging.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.nitya.messaging.entiry.Messages;

public interface MessagesRepository extends JpaRepository<Messages, Integer>{

	Messages findByToUsername(String toMobile);

	List<Messages> findByUsername(String username);

	Messages findFirstByUsername(String username);

	Messages findByToMobile(String username);

	Messages findFirstByToUsername(String username);

}
