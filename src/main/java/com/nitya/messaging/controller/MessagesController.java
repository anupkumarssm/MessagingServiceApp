package com.nitya.messaging.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nitya.messaging.dao.MessagingDao;
import com.nitya.messaging.entiry.Contacts;
import com.nitya.messaging.entiry.DirectMessages;
import com.nitya.messaging.entiry.GroupMessages;
import com.nitya.messaging.entiry.GroupUsers;
import com.nitya.messaging.entiry.Groups;
import com.nitya.messaging.entiry.Messages;
import com.nitya.messaging.repository.ContactsRepository;
import com.nitya.messaging.repository.DirectMessagesRepository;
import com.nitya.messaging.repository.GroupMessagesRepository;
import com.nitya.messaging.repository.GroupUsersRepository;
import com.nitya.messaging.repository.GroupsRepository;
import com.nitya.messaging.repository.MessagesRepository;
import com.nitya.messaging.repository.UserProfileRepository;

@Controller
public class MessagesController {

	@Autowired
	ContactsRepository contactsRepository;

	@Autowired
	MessagesRepository messagesRepository;
	@Autowired
	DirectMessagesRepository directMessagesRepository;

	@Autowired
	MessagingDao messagingDao;

	private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	@Autowired
	GroupsRepository groupsRepository;

	@Autowired
	GroupMessagesRepository groupMessagesRepository;

	@Autowired
	GroupUsersRepository groupUsersRepository;

	@Autowired
	UserProfileRepository userProfileRepository;

	@RequestMapping(value = "/contacts")
	public String contacts(HttpServletRequest req, Model model) {
		if (req.getUserPrincipal() == null)
			return "redirect:login";
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		String username = req.getUserPrincipal().getName();
		model.addAttribute("getAllContacts", contactsRepository.findByUsername(username));
		messagingDao.updateTime(username, sdf.format(timestamp));
		req.getSession().setAttribute("userDetials", userProfileRepository.findByUsername(username));
		return "contacts";
	}

	@RequestMapping(value = "/addContacts")
	public String addContacts(HttpServletRequest req, Contacts contacts) {
		String username = req.getUserPrincipal().getName();
		Contacts c = contactsRepository.findByMobileAndUsername(contacts.getMobile().trim(),username);
		if (c == null) {
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			String currentTime = sdf.format(timestamp);
			contacts.setTimestamp(currentTime);
			contacts.setUsername(username);
			contactsRepository.save(contacts);
		}
		return "redirect:contacts";
	}

	@RequestMapping(value = "/direct-messages")
	public String messages(HttpServletRequest req, Model model) {
		if (req.getUserPrincipal() == null)
			return "redirect:login";
		String username = req.getUserPrincipal().getName();
		model.addAttribute("getAllMessages", messagesRepository.findByUsername(username));
		model.addAttribute("getAllContacts", listmapToJsonString(contactsRepository.findByUsername(username)));
		messagingDao.updateTime(username, "Online");
		req.getSession().setAttribute("userDetials", userProfileRepository.findByUsername(username));
		return "directMessages";
	}

	@RequestMapping(value = "/get-direct-messages")
	public String getMessages(HttpServletRequest req, Model model) {
		if (req.getUserPrincipal() == null)
			return "redirect:login";
		String username = req.getUserPrincipal().getName();
		String toMobile = req.getParameter("toMobile");
		messagingDao.updateTime(username,"Online");
		model.addAttribute("contactDetails", messagingDao.getConatDetails(toMobile.trim(), username));
		model.addAttribute("username",username);
		req.getSession().setAttribute("userDetials", userProfileRepository.findByUsername(username));
		return "getDirectMessages";
	}

	@ResponseBody
	@RequestMapping(value = "/getDirectMessagesData")
	public List<Map<String, Object>> getDirectMessagesData(HttpServletRequest req, Model model) {
		String username = req.getUserPrincipal().getName();
		String tousername = req.getParameter("tousername");
		List<Map<String, Object>> directMessageList = messagingDao.getDirectMessages(username, tousername.trim());
		return directMessageList;
	}

	@ResponseBody
	@RequestMapping(value = "/directMessageListener")
	public List<Map<String, Object>> directMessageListener(HttpServletRequest req, Model model) {
		String username = req.getUserPrincipal().getName();
		String tousername = req.getParameter("tousername");
		List<Map<String, Object>> getLatestDirectMessageList = messagingDao.getLatestDirectMessage(username.trim(), tousername.trim());
		model.addAttribute(username, username);
		return getLatestDirectMessageList;
	}

	@ResponseBody
	@RequestMapping(value = "/addDirectMessage")
	public int addMessage(HttpServletRequest req, Messages messages, DirectMessages dirMessages, Model model) {
		String username = req.getUserPrincipal().getName();
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		String currentTime = sdf.format(timestamp);
		DirectMessages directMessages = new DirectMessages();
		Messages msg = messagesRepository.findByToUsername(messages.getToMobile().trim());
		if (msg == null) {
			messages.setUsername(username);
			messages.setStatus("1");
			messages.setMessageCount("0");
			messages.setTimestamp(currentTime);
			messages = messagesRepository.save(messages);
			directMessages.setMessagesId(String.valueOf(messages.getId()));
		} else {
			directMessages.setMessagesId(String.valueOf(msg.getId()));
		}
		messagingDao.updateMessageCount(directMessages.getMessagesId(),username,messages.getToUsername().trim());
		directMessages.setFromUsername(username);
		directMessages.setToUsername(messages.getToUsername().trim());
		directMessages.setTextMessage(dirMessages.getTextMessage());
		directMessages.setTimestamp(currentTime);
		directMessages.setFlag("1");
		directMessagesRepository.save(directMessages);
		int status=0;
		String toMobile = messages.getToMobile().trim();
		if(toMobile.equals(username))
			status = 0;
		else
			status = 1;
		return status;
	}

	@RequestMapping(value = "/getUpdatedMessage")
	public String getUpdatedMessage(HttpServletRequest req, Model model) {
		String username = req.getUserPrincipal().getName();
		String tousername = req.getParameter("tousername");
		model.addAttribute("directMessages", messagingDao.getDirectMessages(username, tousername));
		model.addAttribute("username", username);
		return "directMessage";
	}

	@ResponseBody
	@RequestMapping(value = "/checkUserOnlineOrOffLine")
	public List<Messages> checkUserOnlineOrOffLine(HttpServletRequest req, Model model) {
		String username = req.getUserPrincipal().getName();
		return messagesRepository.findByUsername(username);
	}

	private String listmapToJsonString(List<Contacts> contactList) {
		JSONArray json_arr = new JSONArray();
		Map<String, Object> map = new HashMap<>();
		for (Contacts field : contactList) {
			map.put("label", field.getFullname());
			map.put("value", field.getMobile());
			JSONObject json_obj = new JSONObject();
			for (Map.Entry<String, Object> entry : map.entrySet()) {
				String key = entry.getKey();
				Object value = entry.getValue();
				try {
					json_obj.put(key, value);
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			json_arr.put(json_obj);
		}
		return json_arr.toString();
	}

	@RequestMapping(value = "/group-messages")
	public String groupMessages(HttpServletRequest req, Model model) {
		if (req.getUserPrincipal() == null)
			return "redirect:login";
		String username = req.getUserPrincipal().getName();
		model.addAttribute("username", username);
		model.addAttribute("getAllContacts", contactsRepository.findByUsername(username));
		model.addAttribute("getGroupList", messagingDao.getGroupList(username));
		model.addAttribute("top1Group", messagingDao.getTop1Group(username));
		req.getSession().setAttribute("userDetials", userProfileRepository.findByUsername(username));
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		messagingDao.updateTime(username, sdf.format(timestamp));
		return "groupMessage";
	}

	@RequestMapping(value = "/createGroup")
	public String createGroup(HttpServletRequest req, Model model, Groups groups) {
		String username = req.getUserPrincipal().getName();
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		String currentTime = sdf.format(timestamp);
		groups.setCreatedBy(username);
		groups.setTimestamp(currentTime);
		groups = groupsRepository.save(groups);
		String mobile[] = req.getParameterValues("mobile");
		for (int i = 0; i < mobile.length; i++) {
			System.out.println("mobile===" + mobile[i]);
			GroupUsers groupUsers = new GroupUsers();
			groupUsers.setGroupId(groups.getId());
			groupUsers.setMobile(mobile[i]);
			groupUsersRepository.save(groupUsers);
		}
		model.addAttribute("getAllContacts", contactsRepository.findByUsername(username));
		return "redirect:group-messages";
	}

	@RequestMapping(value = "/getGroupMessage")
	public String getDirectMessage(HttpServletRequest req, Model model) {
		String username = req.getUserPrincipal().getName();
		model.addAttribute("username", username);
		String groupId = req.getParameter("groupId");
		model.addAttribute("groupMessageData", messagingDao.getGroupMessageData(groupId,"1", username));
		model.addAttribute("top1Group", messagingDao.getTop1Group(username));
		return "getGroupMessage";
	}

	@ResponseBody
	@RequestMapping(value = "/addGroupMessage")
	public int addGroupMessage(HttpServletRequest req, Model model, GroupMessages groupMessages) {
		String username = req.getUserPrincipal().getName();
		System.out.println("user==" + username);
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		String currentTime = sdf.format(timestamp);
		groupMessages.setTimestamp(currentTime);
		groupMessages.setFromUsername(username);
		groupMessages.setFlag("1");
		groupMessagesRepository.save(groupMessages);
		return 1;
	}

	@ResponseBody
	@RequestMapping(value = "/getGroupMessageData")
	public List<Map<String, Object>> getGroupMessageData(HttpServletRequest req, Model model) {
		String username = req.getUserPrincipal().getName();
		String groupId = req.getParameter("groupId");
		return messagingDao.getGroupMessageData(groupId,"1", username);
	}

	@ResponseBody
	@RequestMapping(value = "/groupMessageListener")
	public List<Map<String, Object>> groupMessageListener(HttpServletRequest req, Model model) {
		String username = req.getUserPrincipal().getName();
		String groupId = req.getParameter("groupId");
		List<Map<String, Object>> getLatestGroupMessage = messagingDao.getLatestGroupMessage(groupId, "1", username);
		return getLatestGroupMessage;
	}
	
	@ResponseBody
	@RequestMapping(value = "/countUnreadGroupMsg")
	public List<Map<String, Object>> countUnreadGroupMsg(HttpServletRequest req, Model model) {
		String username = req.getUserPrincipal().getName();
		return messagingDao.countUnreadGroupMsg(username);
	}


}
