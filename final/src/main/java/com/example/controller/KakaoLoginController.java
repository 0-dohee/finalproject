package com.example.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.UserVO;
import com.fasterxml.jackson.databind.JsonNode;

@Controller

public class KakaoLoginController {

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
	        String token = node.get("access_token").toString();
	        //���ǿ� ����ش�.
	        session.setAttribute("token", token);
	        
	        return "/user/logininfo";
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
