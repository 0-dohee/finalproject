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
	        System.out.println("로그인 할때 임시 코드값");
	        //카카오 홈페이지에서 받은 결과 코드
	        System.out.println(code);
	        System.out.println("로그인 후 결과값");
	        
	        //카카오 rest api 객체 선언
	        kakao_restapi kr = new kakao_restapi();
	        //결과값을 node에 담아줌
	        JsonNode node = kr.getAccessToken(code);
	        //결과값 출력
	        System.out.println(node);
	        //노드 안에 있는 access_token값을 꺼내 문자열로 변환
	        JsonNode token = node.get("access_token");
	        //세션에 담아준다.
	        session.setAttribute("token", token);
	        
	        
	        // access_token을 통해 사용자 정보 요청
	        JsonNode userInfo = kakao_restapi.getKakaoUserInfo(token);
	        /*
			@SuppressWarnings("deprecation")
			JsonParser parser=new JsonParser();
	        JsonElement element= parser.parse(userInfo);
	        
	        JsonObject properties1 = element.getAsJsonObject().get("properties").getAsJsonObject();
	        JsonObject kakao_account1 = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
	        String nickname1 = properties1.getAsJsonObject().get("nickname").getAsString();
	        String email1 = kakao_account1.getAsJsonObject().get("email").getAsString();
	        System.out.println(nickname1+"//"+email1);
	        */

	        // Get id
	        String id = userInfo.path("id").asText();
	        
	        // 유저정보 카카오에서 가져오기 Get properties
	        JsonNode properties = userInfo.path("properties");
	        JsonNode kakao_account = userInfo.path("kakao_account");
	        
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
	        vo.setU_status("0");
	        String vo1=mapper.readkakao(id,"0");
	        System.out.println(vo1);
	        if(vo1!="1") {
	        	mapper.insertKakao(vo);
	        	session.setAttribute("kakaoinfo", "0");
	        }
	        session.setAttribute("u_id", "0");
	        session.setAttribute("u_k_id", id);
	        return "/index";
	    }

	 private String userInfo() {
		// TODO Auto-generated method stub
		return null;
	}

	@RequestMapping(value = "/user/logout", produces = "application/json")
	    public String Logout(HttpSession session) {
	        //kakao restapi 객체 선언
	        kakao_restapi kr = new kakao_restapi();
	        
	        //노드에 로그아웃한 결과값음 담아줌 매개변수는 세션에 잇는 token을 가져와 문자열로 변환
	        System.out.println("토큰출력:"+session.getAttribute("token").toString());
	        JsonNode node = kr.Logout(session.getAttribute("token").toString());
	        //결과 값 출력
	        System.out.println("로그인 후 반환되는 아이디 : " + node.get("id"));
	        System.out.println(node.get("id"));
	        return "redirect:/user/login";
	    }    


}
