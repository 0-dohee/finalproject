package com.example.controller;

import java.io.File;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.domain.BlackVO;
import com.example.domain.CompanyOptionVO;
import com.example.domain.CompanyVO;
import com.example.domain.PassengersVO;
import com.example.domain.UserTagVO;
import com.example.domain.UserVO;
import com.example.mapper.AirMapper;
import com.example.mapper.UserMapper;
import com.example.service.UserMailSendService;



@Controller
@Repository
public class UserController {
	@Resource(name="userUploadPath")
	private String path;
	@Resource(name="companyUploadPath")
	private String companypath;
	@Autowired
	UserMapper mapper;

	@RequestMapping(value="/user/userroombooking",method=RequestMethod.POST)
	   @ResponseBody
	   public List<HashMap<String,Object>> userroombooking(HttpSession session){
	      String u_id=(String)session.getAttribute("u_id");
	       String u_k_id=(String)session.getAttribute("u_k_id");
	       List<HashMap<String,Object>> map=mapper.userroombooking(u_id, u_k_id);
	       return map;
	      }
	
	@RequestMapping("/user/mypage/report")
	public void report() {
		
	}
	
	@RequestMapping("/user/mypage/reportread")
	@ResponseBody
	public int reportread(String u_id) {
		System.out.println(u_id);
		int count1=mapper.count(u_id, "0");
		int count2=mapper.count("0", u_id);	
		System.out.println(count1 +count2);
		int result=0;

		if(count1==1) {
			result=0;
		}else if(count2==1){
			result=1;
		}else {
			result=2;
		}

		return result;
	}
	
	@RequestMapping(value="/user/mypage/insertblack",method=RequestMethod.POST)
	public String insertblack(BlackVO vo) {
		System.out.println(vo.getU_from_id()+vo.getU_from_k_id()+vo.getU_to_id()+vo.getU_to_k_id()+vo.getB_content());
		System.out.println(vo.toString());
		mapper.insertblack(vo);
		
		return "/user/mypage/report";
	}
	
	
	@Autowired
	private UserMailSendService mailSender;
	@RequestMapping("/user/mypage/kakaolightbox")
	public void lightbox() {
		
	}
	
	
	@RequestMapping("/user/mypage/usercancel")
	public void usercancel() {
		
	}
	
	//���� Ż�� ��й�ȣ üũ
		@RequestMapping("/user/mypage/UserPass")
		@ResponseBody
		public int userpass(String u_id,String u_k_id,String u_pass) {
			UserVO vo=mapper.read(u_id,u_k_id);
			int result=0;
			if(vo.getU_pass().equals(u_pass)) {
				result=1;
			}else {
				result=0;
			}
			return result;
		}
	//��ü Ż�� ��й�ȣ üũ
	@RequestMapping("/user/mypage/CompanyPass")
	@ResponseBody
	public int companypass(String c_id,String c_pass) {
		CompanyVO vo=mapper.readCompany(c_id);
		int result=0;
		if(vo.getC_pass().equals(c_pass)) {
			result=1;
		}else {
			result=0;
		}
		return result;
	}
	
	//����ȸ�� Ż��
	@RequestMapping(value="/user/mypage/usercancel",method=RequestMethod.POST)
	public String usercancelPost(String u_id,String u_k_id,HttpSession session,HttpServletRequest request) {
		System.out.println(u_id);
		mapper.usercancel(u_id,u_k_id);
		session.invalidate();
		session=request.getSession(true);
		return "redirect:/";
	}
	//��üȸ�� Ż��
		@RequestMapping(value="/user/mypage/companycancel",method=RequestMethod.POST)
		public String companycancelPost(String c_id,HttpSession session,HttpServletRequest request) {
			System.out.println(c_id);
			mapper.deleteOption(c_id);
			mapper.deleteCompany(c_id);
			session.invalidate();
			session=request.getSession(true);
			return "redirect:/";
		}
	//��ü ���� ����
	@RequestMapping(value="/user/mypage/updateCompany",method=RequestMethod.POST)
	public String updateCompany(CompanyVO vo,MultipartHttpServletRequest multi,HttpServletRequest request)throws Exception {
		
		String[] arrayParam = request.getParameterValues("hoption");
		MultipartFile file=multi.getFile("file1");
		CompanyVO vo1=mapper.readCompany(vo.getC_id());
		if(!file.isEmpty()) {
			//���� ��ǥ�̹��� ����
			if(!vo1.getC_image().equals("")) {
				new File(companypath+File.separator+vo1.getC_image()).delete();
			}
			String image=System.currentTimeMillis()+file.getOriginalFilename();
			file.transferTo(new File(companypath + File.separator + image));
			vo.setC_image(image);
			
			if(vo.getC_pass().equals("")) {
				vo.setC_pass(vo1.getC_pass());
				mapper.updateCompany(vo);
			}else {
				mapper.updateCompany(vo);
			}
			mapper.deleteOption(vo.getC_id());
			for (int i = 0; i < arrayParam.length; i++) { 
				System.out.println(arrayParam[i]); 
				mapper.insertCompanyoption(vo.getC_id(), arrayParam[i]);
				}
		}else {
			if(vo.getC_pass().equals("")) {
				vo.setC_pass(vo1.getC_pass());
				mapper.updateCompany2(vo);
			}else {
				mapper.updateCompany2(vo);
			}

			mapper.deleteOption(vo.getC_id());
			for (int i = 0; i < arrayParam.length; i++) { 
				System.out.println(arrayParam[i]); 
				mapper.insertCompanyoption(vo.getC_id(), arrayParam[i]);
				}
		}
		return "redirect:/";
	}
	//��ü ���� �ҷ�����
	@RequestMapping("/user/mypage/readCompany")
	@ResponseBody
	public HashMap<String, Object> readCompany(String c_id) {
		System.out.println(c_id);
		HashMap<String, Object> map=new HashMap<String, Object>();
		CompanyVO vo=mapper.readCompany(c_id);
		List<CompanyOptionVO> ovo= mapper.readOption(c_id);
		map.put("readOption", ovo);
		map.put("read", vo);
		return map;
	}
	
	
	//���� ���� ����
	@RequestMapping(value="/user/mypage/updateUser",method=RequestMethod.POST)
	public String update(UserVO vo,MultipartHttpServletRequest multi,HttpServletRequest request)throws Exception {
		System.out.println("aaa");
		String[] arrayParam = request.getParameterValues("t_tag");
		System.out.println(vo.toString());
		MultipartFile file=multi.getFile("file");
		UserVO vo1=mapper.read(vo.getU_id(),vo.getU_k_id());
		if(!file.isEmpty()) {
			UserVO vo2=mapper.kakaoread(vo.getU_id(),vo.getU_k_id());
			//���� ��ǥ�̹��� ����
			if(!vo2.getU_image().equals("")) {
				new File(path+File.separator+vo2.getU_image()).delete();
			}
			String image=System.currentTimeMillis()+file.getOriginalFilename();
			file.transferTo(new File(path + File.separator + image));
			vo.setU_image(image);
			if(vo.getU_pass().equals("")) {
				vo.setU_pass(vo1.getU_pass());
				
				System.out.println(vo.getU_pass());
				mapper.updateUser(vo);
			}else {
				mapper.updateUser(vo);
			}
			mapper.deleteTag(vo.getU_id(),vo.getU_k_id());
			for (int i = 0; i < arrayParam.length; i++) { 
				System.out.println(arrayParam[i]); 
				mapper.insertUsertag(vo.getU_id(),"0",arrayParam[i]);
				}
		}else {
			if(vo.getU_pass().equals("")) {
				vo.setU_pass(vo1.getU_pass());
				System.out.println(vo.getU_pass());
				mapper.updateUser2(vo);
			}else {
				mapper.updateUser2(vo);
			}
			mapper.deleteTag(vo.getU_id(),vo.getU_k_id());
			for (int i = 0; i < arrayParam.length; i++) { 
				System.out.println(arrayParam[i]); 
				mapper.insertUsertag(vo.getU_id(),"0",arrayParam[i]);
				}
		}
		
		
		return "redirect:/";
	}
	
	//���� ���� �о����
	@RequestMapping("/user/mypage/read")
	@ResponseBody
	public HashMap<String, Object> read(String u_id, String u_k_id) {
		HashMap<String, Object> map=new HashMap<String, Object>();
		UserVO vo=mapper.kakaoread(u_id, u_k_id);
		String uvo=mapper.readid(u_id,u_k_id);
		List<UserTagVO> tvo=mapper.readtag(u_id);
		map.put("readtag", tvo);
		map.put("read", vo);
		map.put("readuser", uvo);
		return map;
	}
	
	//īī�� ������Ʈ 
	@RequestMapping("/updateKakao")
	public String updateKakao(UserVO vo, HttpServletRequest request) throws Exception {
			
			String[] arrayParam = request.getParameterValues("t_tag");
			vo.setU_id("0");
			mapper.updateKakao(vo);
			
			for (int i = 0; i < arrayParam.length; i++) { 
				System.out.println(arrayParam[i]); 
				mapper.insertUsertag("0",vo.getU_k_id(),arrayParam[i]);
				}
		return "redirect:/";
	}
	@RequestMapping("/user/mypage/infomation")
	public void information() {
		
	}
	
	@RequestMapping("/user/findCompany(id)")
	public void findidC() {
		
	}
	
	@RequestMapping("/user/findCompany(pass)")
	public void findpassC() {
		
	}
	
	
	
	//�Ǹ�����
	@RequestMapping("/user/checkNameCompany")
	@ResponseBody
	public int nameCheckC(String name, String number) {
			int i=mapper.checkNameCompany(number, name);
			System.out.println(i);
			int result=0;
			if(i==1) {
				result=1;
			}
			return result;
		}
	//IDã�� �̸��� ����
	@RequestMapping(value="/user/emailCheckCompany",method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> emailCheckCompany(String email, String name, String number, HttpServletRequest request) {
		HashMap<String, Object> map= new HashMap<String, Object>();
		String key=mailSender.mailSendFindIdCompanyKey(email, name, number, request);
		map.put("idCompany",mapper.checkIDCompany(number, name));
		map.put("email",key);
		return map;
	}
	//��üPASS �缳��
		@RequestMapping(value="/user/resetPassCompany",method=RequestMethod.POST)
		public String updatePassCompany(String id, String pass) {
			mapper.updatePassCompany(id, pass);
			return "redirect:/user/login";
		}
	//��üPASSã�� �̸��� ����
		@RequestMapping("/user/emailCheckPassCompany")
		@ResponseBody
		public String emailCheckPassCompany(String email, String name,String number, HttpServletRequest request) {
			String key=mailSender.mailSendFindIdCompanyKey(email, name, number, request);
			return key;
		}
	//��ü PASSã�� ���̵�/�̸�/����,�̸��� üũ
		@RequestMapping("/user/nameCheckPassCompany")
		@ResponseBody
		public int nameCheckPassCompany(String id,String name,String number,String email) {
			CompanyVO vo=mapper.readCompany(id);
			int chkNum=0;
			if(vo.getC_name().equals(name)) {
				if(vo.getC_number().equals(number)) {
					if(vo.getC_email().equals(email)) {
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
	//��ü PASSã�� ��ü ���̵� ����
	@RequestMapping("/user/idCheckPassCompany")
	@ResponseBody
	public String idCheckPassC(String c_id) {
		String i=mapper.readcompanyid(c_id);
		return i;
	}
	
	
	
	
	@RequestMapping("/user/find(id)")
	public void findid() {
		
	}
	
	@RequestMapping("/user/find(pass)")
	public void findpass() {
		
	}
	//�Ǹ�����
	@RequestMapping("/user/nameCheck")
	@ResponseBody
	public int nameCheck(String name, String birthday) {
		int i=mapper.checkName(birthday, name);
		System.out.println(i);
		int result=0;
		if(i==1) {
			result=1;
		}
		return result;
	}
	//IDã�� �̸��� ����
	@RequestMapping("/user/emailCheck")
	@ResponseBody
	public HashMap<String, Object> emailCheck(String email, String name, String birthday, HttpServletRequest request) {
		HashMap<String, Object> map= new HashMap<String, Object>();
		String key=mailSender.mailSendFindIdKey(email, name, birthday, request);
		map.put("list",mapper.checkID(birthday, name));
		map.put("email",key);
		return map;
	}
	//PASS �缳��
	@RequestMapping(value="/user/resetPass",method=RequestMethod.POST)
	public String updatePass(String id, String pass) {
		mapper.updatePass(id, pass);
		
		return "redirect:/user/login";
	}
	//PASSã�� �̸��� ����
	@RequestMapping("/user/emailCheckPass")
	@ResponseBody
	public String emailCheckPass(String email, String name, String birthday, HttpServletRequest request) {
		String key=mailSender.mailSendFindIdKey(email, name, birthday, request);
		return key;
	}
	//PASSã�� ���̵� ����
	@RequestMapping("/user/idCheckPass")
	@ResponseBody
	public String idCheckPass(String u_id,String u_k_id) {
		String i=mapper.readid(u_id,u_k_id);
		return i;
	}
	//PASSã�� ���̵�/�̸�/����,�̸��� üũ
	@RequestMapping("/user/nameCheckPass")
	@ResponseBody
	public int nameCheckPass(String u_id, String u_k_id, String name,String birthday,String email) {
		UserVO vo=mapper.read(u_id,u_k_id);
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

	
	
	
	
	//�Ϲ�,��ü ȸ������ ���� ������
	@RequestMapping("/user/signupselect")
	public void signUpchk() {
		
	}
	//�Ϲ� ȸ�� ���� ������
	@RequestMapping("/user/signup")
	public void signUp() {
		
	}
	//�Ϲ� ȸ�� ���� ������
		@RequestMapping("/user/signup2")
		public void signUp2() {
			
		}
	//��ü ȸ�� ���� ������
	@RequestMapping("/user/signupcompany")
	public void signUpCompany() {
		
	}
	
	//�α׾ƿ� ������
	@RequestMapping("/user/logout")
	public String logout(HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		session.invalidate();
		session=request.getSession(true);
		if(request.getCookies()!=null) {
			Cookie cookie=new Cookie("u_id",null);
			Cookie cookiec=new Cookie("c_id",null);
			cookie.setPath("/");
			cookie.setMaxAge(0);
			cookiec.setPath("/");
			cookiec.setMaxAge(0);
			response.addCookie(cookie);
		}
		return "redirect:/user/login";
	}
	
	//���� ���̵� �ߺ� üũ
	@RequestMapping("/user/idCheck")
	@ResponseBody
	public int idCheck(String u_id,String u_k_id) {
		int result=0;	
		System.out.println(u_id+"."+u_k_id);
		String readid=mapper.readid(u_id,u_k_id);
		
		if(readid.equals("1")) {
			UserVO vo=mapper.read(u_id,u_k_id);
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
	
	//��ü ���̵� �ߺ� üũ
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
	//��ü ����ڹ�ȣ �ߺ� üũ
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
	
	//�α���
	@RequestMapping(value="/user/loginCheck",method=RequestMethod.POST)
	@ResponseBody
	public int loginCheck(String u_id, String u_pass, HttpSession session, String chkLogin, HttpServletResponse response) {
		UserVO readVO=mapper.loginread(u_id);
		int chkNum=0;
		if(readVO!=null) {
			if(readVO.getU_pass().equals(u_pass)) {
				if(readVO.getU_key().equals("Y")) {
					chkNum=2;
					if(u_id.equals("admin")) {
						session.setAttribute("u_id", readVO.getU_id());
						session.setAttribute("u_k_id", readVO.getU_k_id());
						chkNum=4;
					}
					session.setAttribute("u_id", readVO.getU_id());
					session.setAttribute("u_k_id", readVO.getU_k_id());
					if(chkLogin.equals("1")) {
						Cookie cookie=new Cookie("u_id",readVO.getU_id());
						cookie.setPath("/");
						cookie.setMaxAge(60*60);
						response.addCookie(cookie);
					}
				}else {
					//�̸��� ������ �Ϸ���� ���� ����;
					chkNum=3;
				}
			}else{
				chkNum=1;
			}
		}
		return chkNum;
	}
	
	
	
	//��ü�α���
	@RequestMapping(value="/user/loginCheckCompany",method=RequestMethod.POST)
	@ResponseBody
	public int loginCheckCompany(String c_id,String c_pass,String c_number, String chkLogin,HttpSession session,HttpServletResponse response) {
		CompanyVO readVO=mapper.readCompany(c_id);
		int chkNum=0;
		
		if(readVO!=null) {
			if(readVO.getC_pass().equals(c_pass)) {
				if(readVO.getC_number().equals(c_number)) {
					if(readVO.getC_key().equals("Y")) {
						//����
						chkNum=2;
						session.setAttribute("c_id", readVO.getC_id());
						if(chkLogin.equals("1")) {
							Cookie cookie=new Cookie("c_id",readVO.getC_id());
							cookie.setPath("/");
							cookie.setMaxAge(60*60);
							response.addCookie(cookie);
						}
					}else {
						//�̸��� ������ �Ϸ���� ���� ����;
						chkNum=3;
					}
				}else {
					//����ڹ�ȣ�� �ٸ� ���
					chkNum=4;
				}
			}else{
				//�н����尡 �ٸ� ���
				chkNum=1;
			}
		}
		return chkNum;
	}
	//�α��� ������
	@RequestMapping("/user/login")
	public void login(HttpSession session) {
		if(session.getAttribute("u_k_id")!=null) {
			session.invalidate();
		}
	}
	
	//�Ϲ� ȸ�� ���� + �̸��� ������ȣ Send + ���� ���ε�
	@RequestMapping(value="/user/insert",method=RequestMethod.POST)
	public String insert(UserVO vo,MultipartHttpServletRequest multi,HttpServletRequest request) throws Exception {
		
		String[] arrayParam = request.getParameterValues("t_tag");
		
		String id=mapper.readid(vo.getU_id(),vo.getU_k_id());
		UserVO read=mapper.read(vo.getU_id(), vo.getU_k_id());
		
		if(id.equals("1")) {//���̵� ���翩�� Ȯ��
			if(read.getU_key().equals("Y")) {//���̵������ϸ� Ű���� �� key���� Y�� �ƴϸ� ����
				System.out.println("�̹� ȸ�����̵� �����մϴ�.");
			}else {
				mapper.deleteTag(read.getU_id(),read.getU_k_id());
				mapper.delete(read.getU_id());
				//������ �̹��� ���ε�
				MultipartFile file=multi.getFile("file");
				if(!file.isEmpty()) {
					String image=System.currentTimeMillis()+file.getOriginalFilename();
					file.transferTo(new File(path+File.separator+image));
					vo.setU_image(image);
				}
				
				vo.setU_key("N");
				mapper.insert(vo);
				for (int i = 0; i < arrayParam.length; i++) { 
					System.out.println(arrayParam[i]); 
					mapper.insertUsertag(vo.getU_id(),"0",arrayParam[i]);
					}
				mailSender.mailSendWithUserKey(vo.getU_email(), vo.getU_id(), request);
			}
		}else {

			//������ �̹��� ���ε�
			MultipartFile file=multi.getFile("file");
			if(!file.isEmpty()) {
				String image=System.currentTimeMillis()+file.getOriginalFilename();
				file.transferTo(new File(path+File.separator+image));
				vo.setU_image(image);
			}
			
			System.out.println("������ ���� : "+vo.toString());
			vo.setU_key("N");
			mapper.insert(vo);
			for (int i = 0; i < arrayParam.length; i++) { 
				System.out.println(arrayParam[i]); 
				mapper.insertUsertag(vo.getU_id(),"0",arrayParam[i]);
				}
			mailSender.mailSendWithUserKey(vo.getU_email(), vo.getU_id(), request);
		}
		return "redirect:/";
	}
	
	//��ü ȸ�� ����
	@RequestMapping(value="/user/insertCompany",method=RequestMethod.POST)
	public String insertComapny(CompanyVO vo,MultipartHttpServletRequest multi,HttpServletRequest request) throws Exception {
		
		String[] arrayParam = request.getParameterValues("hoption");
		String id=mapper.readcompanyid(vo.getC_id());
		CompanyVO read=mapper.readCompany(vo.getC_id());
		
		if(id.equals("1")) {//���̵� ���翩�� Ȯ��
			if(read.getC_key().equals("Y")) {//���̵������ϸ� Ű���� �� key���� Y�� �ƴϸ� ����
				System.out.println("�̹� ȸ�����̵� �����մϴ�.");
			}else {
				mapper.deleteOption(read.getC_id());
				mapper.deleteCompany(read.getC_id());
				//������ �̹��� ���ε�
						MultipartFile file=multi.getFile("file1");
						if(!file.isEmpty()) {
							String image=System.currentTimeMillis()+file.getOriginalFilename();
							file.transferTo(new File(companypath+File.separator+image));
							vo.setC_image(image);
						}
				vo.setC_key("N");
				mapper.insertCompany(vo);
				for (int i = 0; i < arrayParam.length; i++) { 
					System.out.println(arrayParam[i]); 
					mapper.insertCompanyoption(vo.getC_id(), arrayParam[i]);
					}
				mailSender.mailSendWithCompanyKey(vo.getC_email(), vo.getC_id(), request);
				}	
			}else {
				//������ �̹��� ���ε�
				MultipartFile file=multi.getFile("file1");
				if(!file.isEmpty()) {
					String image=System.currentTimeMillis()+file.getOriginalFilename();
					file.transferTo(new File(companypath+File.separator+image));
					vo.setC_image(image);
				}
				vo.setC_key("N");
				mapper.insertCompany(vo);
				for (int i = 0; i < arrayParam.length; i++) { 
					System.out.println(arrayParam[i]); 
					mapper.insertCompanyoption(vo.getC_id(), arrayParam[i]);
					}
				mailSender.mailSendWithCompanyKey(vo.getC_email(), vo.getC_id(), request);
			}
		return "redirect:/user/login";
	}


	//�̸��� ������ȣ Key �� �����ϱ�
	@RequestMapping(value = "/user/key_alter", method = RequestMethod.GET)
	public String key_alterConfirm(@RequestParam("user_id") String user_id, @RequestParam("user_key") String key) {
		mailSender.alter_userKey_service(user_id, key); // mailsender�� ��� @Autowired

		return "/user/success(id)";
	}
	
	//�̸��� ������ȣ Key �� �����ϱ�
	@RequestMapping(value = "/user/key_alterCompany", method = RequestMethod.GET)
	public String key_alterConfirmCompany(@RequestParam("user_id") String user_id, @RequestParam("user_key") String key) {
		mailSender.alter_CompanyKey_service(user_id, key); // mailsender�� ��� @Autowired

		return "/user/success(id)";
	}
	
	// �̹������� �������� ���
	@RequestMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> display(String fileName) throws Exception {
		ResponseEntity<byte[]> result = null;
		// display fileName�� �ִ� ���
		if (!fileName.equals("")) {
			File file = new File(path + File.separator + fileName);
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}
		return result;
	}
	// �̹������� �������� ���
		@RequestMapping("/displayCompany")
		@ResponseBody
		public ResponseEntity<byte[]> displayCompany(String fileName) throws Exception {
			ResponseEntity<byte[]> result = null;
			// display fileName�� �ִ� ���
			if (!fileName.equals("")) {
				File file = new File(companypath + File.separator + fileName);
				HttpHeaders header = new HttpHeaders();
				header.add("Content-Type", Files.probeContentType(file.toPath()));
				result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			}
			return result;
		}

}
