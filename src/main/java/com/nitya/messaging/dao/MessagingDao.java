package com.nitya.messaging.dao;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

@Component
public class MessagingDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	public List<Map<String, Object>> getDirectMessages(String username, String toMobile) {
		try {
			String query = "SELECT * FROM direct_messages dm where  dm.from_username=? and dm.to_username=? or dm.from_username=? and dm.to_username=?";
			return jdbcTemplate.queryForList(query, username, toMobile, toMobile, username);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}

	public List<Map<String, Object>> getNewDirectMessages(String username, String toMobile) {
		try {
			String query = "SELECT * FROM direct_messages dm where  dm.from_username=? and dm.to_username=? or dm.from_username=? and dm.to_username=?";
			return jdbcTemplate.queryForList(query, username, toMobile, toMobile, username);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}

	public Map<String, Object> getConatDetails(String toMobile) {
		try {
			String query = "select * FROM messages m where m.to_username=?";
			return jdbcTemplate.queryForMap(query, toMobile);
		} catch (Exception e) {
			String query = "select c.fullname as to_fullname,c.mobile as to_mobile,c.timestamp FROM contacts c where c.mobile=?";
			return jdbcTemplate.queryForMap(query, toMobile);
		} 
	}

	public void updateTime(String username, String time) {
		try {
			String query = "update messages m set m.timestamp=? where m.to_username=?";
			jdbcTemplate.update(query, time, username);
		} catch (Exception e) {
			// TODO: handle exception
		} 
	}

}
