package com.nitya.messaging.repository;

import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.nitya.messaging.entiry.DirectMessages;

public interface DirectMessagesRepository extends JpaRepository<DirectMessages, Integer>{

	
	//@Query("SELECT * FROM direct_messages dm where  dm.from_username=:username and dm.to_username=:toMobile")
	//List<Map<String,Object>> getDirectMessages(@Param("username") String username,  @Param("toMobile") String toMobile);

}
