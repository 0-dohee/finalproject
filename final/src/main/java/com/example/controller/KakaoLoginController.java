package com.example.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.domain.UserVO;
import com.example.mapper.UserMapper;
import com.fasterxml.jackson.databind.JsonNode;


@Controller

public class KakaoLoginController {
	
	@Autowired
	UserMapper mapper;
	
	 @RequestMapping(value = "/oauth", produces = "application/json")
	    public String kakaoLogin(@RequestParam("code") String code, Model model, HttpSession session) {
	        System.out.println("�α��� �Ҷ� �ӽ� �ڵ尪");
	        //īī�� Ȩ���������� ���� ��� �ڵ�
	        System.out.println(code);
	        System.out.println("�α��� �� �����");
	        
	        //īī�� rest api ��ü ����
	        kakao_restapi kr = new kakao_restapi();
	        //������� node�� �����
	        JsonNode node = kr.getAccessToken(code);
	        //����� ���
	        System.out.println(node);
	        //��� �ȿ� �ִ� access_token���� ���� ���ڿ��� ��ȯ
	        JsonNode token = node.get("access_token");
	        //���ǿ� ����ش�.
	        session.setAttribute("token", token);
	        
	        // access_token�� ���� ����� ���� ��û
	        JsonNode userInfo = kakao_restapi.getKakaoUserInfo(token);

	        // Get id
	        String id = userInfo.path("id").asText();
	        // �������� īī������ �������� Get properties
	        JsonNode properties = userInfo.path("properties");
	        JsonNode kakao_account = userInfo.path("kakao_account");
	        System.out.println(userInfo.path("properties").asText());
	        
	       String name = properties.path("nickname").asText();
	       String email = kakao_account.path("email").asText();
	       String thumbnailImage = properties.path("thumbnail_image").asText();
	       String profileImage=properties.path("profile_image").asText();
	       
	        System.out.println("id : " + id);
	        System.out.println("name : " + name);
	        System.out.println("email : " + email);
	        System.out.println("thumbnail_image : "+thumbnailImage);
	        System.out.println("profileimage : "+profileImage);
	        UserVO vo= new UserVO();
	        vo.setU_k_id(id);
	        vo.setU_pass("");
	        vo.setU_name("");
	        vo.setU_email("");
	        vo.setU_tel("");
	        vo.setU_address("");
	        vo.setU_key("Y");
	        String vo1=mapper.readkakao(id);
	        System.out.println(vo1+"..");
	        if(vo1==null) {
	        	mapper.insertKakao(vo);
	        }
	        session.setAttribute("u_id", "0");
	        session.setAttribute("u_k_id", id);
	        return "/index";
	    }

	 @RequestMapping(value = "/user/logout", produces = "application/json")
	    public String Logout(HttpSession session) {
	        //kakao restapi ��ü ����
	        kakao_restapi kr = new kakao_restapi();
	        
	        //��忡 �α׾ƿ��� ������� ����� �Ű������� ���ǿ� �մ� token�� ������ ���ڿ��� ��ȯ
	        System.out.println("��ū���:"+session.getAttribute("token").toString());
	        JsonNode node = kr.Logout(session.getAttribute("token").toString());
	        //��� �� ���
	        System.out.println("�α��� �� ��ȯ�Ǵ� ���̵� : " + node.get("id"));
	        System.out.println(node.get("id"));
	        return "redirect:/user/login";
	    }    


}
