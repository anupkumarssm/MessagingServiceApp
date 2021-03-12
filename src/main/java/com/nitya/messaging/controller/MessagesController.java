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
import com.nitya.messaging.entiry.Messages; 
import com.nitya.messaging.repository.ContactsRepository;
import com.nitya.messaging.repository.DirectMessagesRepository;
import com.nitya.messaging.repository.MessagesRepository;

@Controller
public class MessagesController {

	@Autowired
	ContactsRepository contactsRepository;
	
	@Autowired
	MessagesRepository messagesRepository;
	@Autowired
	DirectMessagesRepository  directMessagesRepository;
	
	@Autowired
	MessagingDao messagingDao;
	
	private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	

	@RequestMapping(value = "/messages")
	public String messages(HttpServletRequest req,Model model) {
		if(req.getUserPrincipal() == null)
			return "redirect:login";
		String username=req.getUserPrincipal().getName();
		model.addAttribute("getAllMessages",messagesRepository.findByUsername(username));
		model.addAttribute("getAllContacts",listmapToJsonString(contactsRepository.findByUsername(username)));
		messagingDao.updateTime(username,"Online");
		return "messages";
	}

	@RequestMapping(value = "/getMessages")
	public String getMessages(HttpServletRequest req,Model model) {
		String username=req.getUserPrincipal().getName();
		String toMobile = req.getParameter("toMobile");
		System.out.println("toMobile===" + toMobile);
		model.addAttribute("contactDetails",messagingDao.getConatDetails(toMobile.trim()));
		//model.addAttribute("directMessages",messagingDao.getDirectMessages(username.trim(),toMobile.trim()));
		return "getMessages";
	}

	@RequestMapping(value = "/contacts")
	public String contacts(HttpServletRequest req,Model model) {
		if(req.getUserPrincipal() == null)
			return "redirect:login";
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		String username=req.getUserPrincipal().getName();
		model.addAttribute("getAllContacts",contactsRepository.findByUsername(username));
		messagingDao.updateTime(username,sdf.format(timestamp));
		return "contacts";
	}

	@RequestMapping(value = "/addContacts")
	public String addContacts(HttpServletRequest req, Contacts contacts) {
		
		Contacts c = contactsRepository.findByMobile(contacts.getMobile().trim());
		if(c == null) {
			String username=req.getUserPrincipal().getName();
			 Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			String currentTime=sdf.format(timestamp);
			contacts.setTimestamp(currentTime);
			contacts.setUsername(username);
			contactsRepository.save(contacts);
		}
		return "redirect:contacts";
	}

	@RequestMapping(value = "/addMessage")
	public String addMessage(HttpServletRequest req, Messages messages,DirectMessages dirMessages,Model model) {
		String username=req.getUserPrincipal().getName();
		System.out.println("Username : "+username);
		 Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		 String currentTime=sdf.format(timestamp);
	        System.out.println("currentTime==="+currentTime);
	        DirectMessages directMessages = new DirectMessages();
	        Messages  msg = messagesRepository.findByToUsername(messages.getToMobile().trim());
	        if(msg == null) {
	        	messages.setUsername(username);
	    		messages.setStatus("1");
	    		messages.setChatCount("1");
	    		messages.setTimestamp(currentTime);
	    		messages = messagesRepository.save(messages);
	    		directMessages.setMessagesId(String.valueOf(messages.getId()));
	        } else {
	        	directMessages.setMessagesId(String.valueOf(msg.getId()));
	        }
		directMessages.setFromUsername(username);
		directMessages.setToUsername(messages.getToUsername());
		directMessages.setTextMessage(dirMessages.getTextMessage());
		directMessages.setTimestamp(currentTime);
		directMessagesRepository.save(directMessages);
		model.addAttribute("directMessages",messagingDao.getNewDirectMessages(username,messages.getToUsername()));
		 model.addAttribute("username",username);
		model.addAttribute("contactDetails",messagingDao.getConatDetails(messages.getToUsername().trim()));
		return "directMessage";
	}

	
	@RequestMapping(value = "/getUpdatedMessage")
	public String getUpdatedMessage(HttpServletRequest req, Model model) {
		String username = req.getUserPrincipal().getName();
		String tousername = req.getParameter("tousername");
		System.out.println("getUpdatedMessage");
		model.addAttribute("directMessages", messagingDao.getDirectMessages(username, tousername));
		model.addAttribute("username", username);
		return "directMessage";
	}
	 
	@ResponseBody
	@RequestMapping(value = "/checkUserOnlineOrOffLine")
	public List<Messages> checkUserOnlineOrOffLine(HttpServletRequest req,Model model) {
		String username=req.getUserPrincipal().getName(); 
		return messagesRepository.findByUsername(username);
	}
	
	
	private String listmapToJsonString(List<Contacts> contactList) {
		    JSONArray json_arr=new JSONArray();
		    Map<String, Object> map = new HashMap<>();
			for (Contacts field : contactList) {
			    map.put("label",field.getFullname());
			    map.put("value",field.getMobile());
		        JSONObject json_obj=new JSONObject();
		        for (Map.Entry<String, Object> entry : map.entrySet()) {
		            String key = entry.getKey();
		            Object value = entry.getValue();
		            try {
		                json_obj.put(key,value);
		            } catch (JSONException e) {
		                // TODO Auto-generated catch block
		                e.printStackTrace();
		            }                           
		        }
		        json_arr.put(json_obj);
		    }
		    return json_arr.toString();
	}
	
	
	
	
	@RequestMapping(value = "/getNewMessages")
	public String getNewMessages(HttpServletRequest req,Model model) {
		String username=req.getUserPrincipal().getName();
		String toMobile = req.getParameter("tousername");
		model.addAttribute("contactDetails",messagingDao.getConatDetails(toMobile.trim()));
		 model.addAttribute("directMessages",messagingDao.getDirectMessages(username.trim(),toMobile.trim()));
		 model.addAttribute("username",username);
		 return "directMessage";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getNewMessagesTexts")
	public List<Map<String, Object>> getNewMessagesTexts(HttpServletRequest req,Model model) {
		String username=req.getUserPrincipal().getName();
		String toMobile = req.getParameter("tousername");
		 model.addAttribute("directMessages",messagingDao.getDirectMessages(username.trim(),toMobile.trim()));
		 System.out.println("+"+messagingDao.getDirectMessages(username.trim(),toMobile.trim()));
		 return messagingDao.getDirectMessages(username.trim(),toMobile.trim());
	}
	
	
	
	@RequestMapping(value = "/group-messages")
	public String groupMessages(HttpServletRequest req, Model model) {
		if(req.getUserPrincipal() == null)
			return "redirect:login";
		String username = req.getUserPrincipal().getName();
		model.addAttribute("username", username);
		return "groupMessages";
	}
	
}
