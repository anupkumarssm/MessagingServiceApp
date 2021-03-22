package com.nitya.messaging.repository;
 
import org.springframework.data.jpa.repository.JpaRepository; 

import com.nitya.messaging.entiry.DirectMessages;

public interface DirectMessagesRepository extends JpaRepository<DirectMessages, Integer>{
}
