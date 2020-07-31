package com.example.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.domain.CompanyVO;
import com.example.domain.UserVO;
import com.example.mapper.UserMapper;
import com.example.service.UserMailSendService;



@Controller
@Repository
public class UserController {
	@Resource(name="userUploadPath")
	private String path;
	
	@Autowired
	UserMapper mapper;

	@Autowired
	private UserMailSendService mailSender;

	@RequestMapping("/user/find(id)")
	public void findid() {
		
	}
	
	@RequestMapping("/user/find(pass)")
	public void findpass() {
		
	}
	//실명인증
	@RequestMapping("/user/nameCheck")
	@ResponseBody
	public int nameCheck(String name, String birthday) {
		int i=mapper.checkName(birthday, name);
		int result=0;
		if(i>1) {
			result=1;
		}
		return result;
	}
	//ID찾기 이메일 인증
	@RequestMapping("/user/emailCheck")
	@ResponseBody
	public HashMap<String, Object> emailCheck(String email, String name, String birthday, HttpServletRequest request) {
		HashMap<String, Object> map= new HashMap<String, Object>();
		String key=mailSender.mailSendFindIdKey(email, name, birthday, request);
		map.put("list",mapper.checkID(birthday, name));
		map.put("email",key);
		return map;
	}
	//PASS 재설정
	@RequestMapping(value="/user/resetPass",method=RequestMethod.POST)
	public String updatePass(String id, String pass) {
		mapper.updatePass(id, pass);
		
		return "redirect:/user/login";
	}
	
	//PASS찾기 이메일 인증
	@RequestMapping("/user/emailCheckPass")
	@ResponseBody
	public String emailCheckPass(String email, String name, String birthday, HttpServletRequest request) {
		String key=mailSender.mailSendFindIdKey(email, name, birthday, request);
		return key;
	}
	//PASS찾기 아이디 인증
	@RequestMapping("/user/idCheckPass")
	@ResponseBody
	public String idCheckPass(String u_id) {
		String i=mapper.readid(u_id);
		return i;
	}
	
	//PASS찾기 아이디/이름/성명,이메일 체크
	@RequestMapping("/user/nameCheckPass")
	@ResponseBody
	public int idCheckPass(String id,String name,String birthday,String email) {
		UserVO vo=mapper.read(id);
		int chkNum=0;
		if(vo.getU_name().equals(name)) {
			if(vo.getU_birthday().equals(birthday)) {
				if(vo.getU_email().equals(email)) {
					chkNum=1;
				}else {
					chkNum=0;
				}
			}else {
				chkNum=0;
			}
		}else {
			chkNum=0;
		}
		return chkNum;
	}
	
	//일반,업체 회원가입 선택 페이지
	@RequestMapping("/user/signupselect")
	public void signUpchk() {
		
	}
	//일반 회원 가입 페이지
	@RequestMapping("/user/signup")
	public void signUp() {
		
	}
	//업체 회원 가입 페이지
	@RequestMapping("/user/signupcompany")
	public void signUpCompany() {
		
	}
	
	//로그아웃 페이지
	@RequestMapping("/user/logout")
	public void logout() {
		
	}
	
	//유저 아이디 중복 체크
	@RequestMapping("/user/idCheck")
	@ResponseBody
	public int idCheck(String u_id) {
		int result=0;	
		String readid=mapper.readid(u_id);
		
		if(readid.equals("1")) {
			UserVO vo=mapper.read(u_id);
			if(vo.getU_key().equals("Y")) {
				result=1;
			}else {
				result=0;
			}
		}else {
			result=0;
		}
		return result;
	}
	
	//업체 아이디 중복 체크
		@RequestMapping("/user/companyidCheck")
		@ResponseBody
		public int companyidCheck(String c_id) {
			int result=0;	

			String readid=mapper.readcompanyid(c_id);
			System.out.println(readid);
			if(readid.equals("1")) {
				CompanyVO vo=mapper.readCompany(c_id);
				System.out.println(vo.getC_key());
				if(vo.getC_key().equals("Y")) {
					result=1;
				}else {
					result=0;
				}
			}else {
				result=0;
			}
			return result;
		}
	//업체 사업자번호 중복 체크
		@RequestMapping("/user/companyNumberCheck")
		@ResponseBody
		public int companyNumberCheck(String c_number) {
			System.out.println(c_number);
			int result=0;	
			String readNumber=mapper.readcompanyNumber(c_number);
			System.out.println(readNumber);
			if(readNumber!=null) {
				result=1;
			}
			return result;
		}
	
	//로그인
	@RequestMapping(value="/user/loginCheck",method=RequestMethod.POST)
	@ResponseBody
	public int loginCheck(String u_id, String u_pass, HttpSession session, String chkLogin, HttpServletResponse response) {
		UserVO readVO=mapper.read(u_id);
		int chkNum=0;
		if(readVO!=null) {
			if(readVO.getU_pass().equals(u_pass)) {
				if(readVO.getU_key().equals("Y")) {
					chkNum=2;
					session.setAttribute("u_id", readVO.getU_id());
					if(chkLogin.equals("1")) {
						Cookie cookie=new Cookie("u_id",readVO.getU_id());
						cookie.setPath("/");
						cookie.setMaxAge(60*60);
						response.addCookie(cookie);
					}
				}else {
					//이메일 인증이 완료되지 않은 상태;
					chkNum=3;
				}
			}else{
				chkNum=1;
			}
		}
		return chkNum;
	}
	//업체로그인
	@RequestMapping(value="/user/loginCheckCompany",method=RequestMethod.POST)
	@ResponseBody
	public int loginCheckCompany(String c_id,String c_pass,String c_number,HttpSession session) {
		CompanyVO readVO=mapper.readCompany(c_id);
		int chkNum=0;
		
		if(readVO!=null) {
			if(readVO.getC_pass().equals(c_pass)) {
				if(readVO.getC_number().equals(c_number)) {
					if(readVO.getC_key().equals("Y")) {
						//성공
						chkNum=2;
						session.setAttribute("c_id", readVO.getC_id());
					}else {
						//이메일 인증이 완료되지 않은 상태;
						chkNum=3;
					}
				}else {
					//사업자번호가 다를 경우
					chkNum=4;
				}
			}else{
				//패스워드가 다를 경우
				chkNum=1;
			}
		}
		return chkNum;
	}
	//로그인 페이지
	@RequestMapping("/user/login")
	public void login() {
		
	}
	
	//일반 회원 가입 + 이메일 인증번호 Send + 파일 업로드
	@RequestMapping(value="/user/insert",method=RequestMethod.POST)
	public String insert(UserVO vo,MultipartHttpServletRequest multi,HttpServletRequest request) throws Exception {
		String id=mapper.readid(vo.getU_id());
		UserVO read=mapper.read(vo.getU_id());
		
		if(id.equals("1")) {//아이디 존재여부 확인
			if(read.getU_key().equals("Y")) {//아이디존재하면 키값을 비교 key값이 Y가 아니면 실행
				System.out.println("이미 회원아이디가 존재합니다.");
			}else {
				mapper.delete(read.getU_id());
				//프로필 이미지 업로드
				MultipartFile file=multi.getFile("file");
				if(!file.isEmpty()) {
					String image=System.currentTimeMillis()+file.getOriginalFilename();
					file.transferTo(new File(path+File.separator+image));
					vo.setU_image(image);
				}
				
				vo.setU_key("N");
				mapper.insert(vo);
				mailSender.mailSendWithUserKey(vo.getU_email(), vo.getU_id(), request);
			}
		}else {

			//프로필 이미지 업로드
			MultipartFile file=multi.getFile("file");
			if(!file.isEmpty()) {
				String image=System.currentTimeMillis()+file.getOriginalFilename();
				file.transferTo(new File(path+File.separator+image));
				vo.setU_image(image);
			}
			
			System.out.println("프로필 사진 : "+vo.toString());
			vo.setU_key("N");
			mapper.insert(vo);
			mailSender.mailSendWithUserKey(vo.getU_email(), vo.getU_id(), request);
		}
		return "redirect:/";
	}
	
	//업체 회원 가입
	@RequestMapping(value="/user/insertCompany",method=RequestMethod.POST)
	public String insertComapny(CompanyVO vo,MultipartHttpServletRequest multi,HttpServletRequest request) throws Exception {
		String id=mapper.readcompanyid(vo.getC_id());
		CompanyVO read=mapper.readCompany(vo.getC_id());
		System.out.println(id+";;");
		
		if(id.equals("1")) {//아이디 존재여부 확인
			if(read.getC_key().equals("Y")) {//아이디존재하면 키값을 비교 key값이 Y가 아니면 실행
				System.out.println("이미 회원아이디가 존재합니다.");
			}else {
				mapper.deleteCompany(read.getC_id());
				//프로필 이미지 업로드
						MultipartFile file=multi.getFile("file1");
						if(!file.isEmpty()) {
							String image=System.currentTimeMillis()+file.getOriginalFilename();
							file.transferTo(new File(path+File.separator+image));
							vo.setC_image(image);
						}
				vo.setC_key("N");
				mapper.insertCompany(vo);
				mailSender.mailSendWithCompanyKey(vo.getC_email(), vo.getC_id(), request);
				}	
			}else {
				//프로필 이미지 업로드
				MultipartFile file=multi.getFile("file1");
				if(!file.isEmpty()) {
					String image=System.currentTimeMillis()+file.getOriginalFilename();
					file.transferTo(new File(path+File.separator+image));
					vo.setC_image(image);
				}
				vo.setC_key("N");
				mapper.insertCompany(vo);
				mailSender.mailSendWithCompanyKey(vo.getC_email(), vo.getC_id(), request);
			}
		return "redirect:/user/login";
	}


	//이메일 인증번호 Key 값 인증하기
	@RequestMapping(value = "/user/key_alter", method = RequestMethod.GET)
	public String key_alterConfirm(@RequestParam("user_id") String user_id, @RequestParam("user_key") String key) {
		mailSender.alter_userKey_service(user_id, key); // mailsender의 경우 @Autowired

		return "/user/success(id)";
	}
	
	//이메일 인증번호 Key 값 인증하기
	@RequestMapping(value = "/user/key_alterCompany", method = RequestMethod.GET)
	public String key_alterConfirmCompany(@RequestParam("user_id") String user_id, @RequestParam("user_key") String key) {
		mailSender.alter_CompanyKey_service(user_id, key); // mailsender의 경우 @Autowired

		return "/user/success(id)";
	}

}
