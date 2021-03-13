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
			e.printStackTrace();
		}
		return null;
	}

	public List<Map<String, Object>> getNewDirectMessages(String username, String toMobile) {
		try {
			String query = "SELECT * FROM direct_messages dm where  dm.from_username=? and dm.to_username=? or dm.from_username=? and dm.to_username=?";
			return jdbcTemplate.queryForList(query, username, toMobile, toMobile, username);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public Map<String, Object> getConatDetails(String toMobile,String username) {
		try {
			String query = "select * FROM messages m where m.to_username=?";
			return jdbcTemplate.queryForMap(query, toMobile);
		} catch (Exception e) {
			String query = "select c.fullname as to_fullname,c.mobile as to_mobile,c.timestamp FROM contacts c where c.mobile=? and c.username=?";
			return jdbcTemplate.queryForMap(query, toMobile,username);
		}
	}

	public void updateTime(String username, String time) {
		try {
			String query = "update messages m set m.timestamp=? where m.to_username=?";
			jdbcTemplate.update(query, time, username);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<Map<String, Object>> getGroupList(String username) {
		try {
			String query = "SELECT g.group_name,g.id FROM groups_tb g,group_users gu where g.id=gu.group_id and gu.mobile=?";
			return jdbcTemplate.queryForList(query, username);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<Map<String, Object>> getGroupMessageData(String groupId) {
		try {
			String query = "SELECT * FROM messagingserviceapp.group_messages where group_id=?";
			return jdbcTemplate.queryForList(query, groupId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<Map<String, Object>> getLatestGroupMessage(String groupId, String flag,String username) {
		try {
				String query = "SELECT * FROM group_messages where group_id=? and flag=? and from_username !=?";
				List<Map<String, Object>> resultList = jdbcTemplate.queryForList(query, groupId, flag,username);
				 for(int i=0;i<resultList.size();i++) {
					String updateQuery = "update group_messages set flag=0 where id=? and flag=1";
					jdbcTemplate.update(updateQuery, resultList.get(i).get("id").toString());
				}
				return resultList;
		} catch (Exception e) {
		}
		return null;
	}

	public Map<String, Object> getTop1Group(String username) {
		try {
			String query = "SELECT g.group_name,g.id FROM groups_tb g,group_users gu where g.id=gu.group_id and gu.mobile=? limit 1";
			return jdbcTemplate.queryForMap(query,username);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<Map<String, Object>> getLatestDirectMessage(String username, String tousername) {
		try {
			String query = "SELECT * FROM direct_messages dm where 	dm.from_username=? AND dm.to_username=? and flag=1";
			List<Map<String, Object>> resultList = jdbcTemplate.queryForList(query, tousername,username);
			System.out.println("resultList=="+resultList);
			 for(int i=0;i<resultList.size();i++) {
				String updateQuery = "update direct_messages set flag=0 where id=? and flag=1";
				jdbcTemplate.update(updateQuery, resultList.get(i).get("id").toString());
			}
			return resultList;
	} catch (Exception e) {
	}
	return null;
	}

	public void updateMessageCount(String id,String fromUsername,String toUsername) {
		try {
			String query = "update messages m set m.message_count=(m.message_count+1) where m.username=? and m.to_username=?";
			jdbcTemplate.update(query, fromUsername,toUsername);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
