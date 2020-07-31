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
import org.springframework.util.FileCopyUtils;
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
	@Resource(name="companyUploadPath")
	private String companypath;
	@Autowired
	UserMapper mapper;

	@Autowired
	private UserMailSendService mailSender;
	
	//��ü ���� ����
	@RequestMapping(value="/user/mypage/updateUserCompany",method=RequestMethod.POST)
	public String updateCompany(CompanyVO vo,MultipartHttpServletRequest multi)throws Exception {
		
		
		return "redirect:/";
	}
	//��ü ���� �ҷ�����
	@RequestMapping("/user/mypage/readCompany")
	@ResponseBody
	public HashMap<String, Object> readCompany(String c_id) {
		HashMap<String, Object> map=new HashMap<String, Object>();
		CompanyVO vo=mapper.readCompany(c_id);
		map.put("read", vo);
		return map;
	}
	
	
	//���� ���� ����
	@RequestMapping(value="/user/mypage/updateUser",method=RequestMethod.POST)
	public String update(UserVO vo,MultipartHttpServletRequest multi)throws Exception {

		System.out.println(vo.toString());
		MultipartFile file=multi.getFile("file");
		if(!file.isEmpty()) {
			UserVO vo1=mapper.read(vo.getU_id());
			//���� ��ǥ�̹��� ����
			if(!vo1.getU_image().equals("")) {
				new File(path+File.separator+vo1.getU_image()).delete();
			}
			String image=System.currentTimeMillis()+file.getOriginalFilename();
			file.transferTo(new File(path + File.separator + image));
			vo.setU_image(image);
			mapper.updateUser(vo);
		}else {
			mapper.updateUser2(vo);
		}
		
		
		return "redirect:/";
	}
	
	
	@RequestMapping("/user/mypage/read")
	@ResponseBody
	public HashMap<String, Object> read(String u_id) {
		HashMap<String, Object> map=new HashMap<String, Object>();
		UserVO vo=mapper.read(u_id);
		map.put("read", vo);
		return map;
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
		int result=0;
		if(i>1) {
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
	public String idCheckPass(String u_id) {
		String i=mapper.readid(u_id);
		return i;
	}
	//PASSã�� ���̵�/�̸�/����,�̸��� üũ
	@RequestMapping("/user/nameCheckPass")
	@ResponseBody
	public int nameCheckPass(String id,String name,String birthday,String email) {
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

	
	
	
	
	//�Ϲ�,��ü ȸ������ ���� ������
	@RequestMapping("/user/signupselect")
	public void signUpchk() {
		
	}
	//�Ϲ� ȸ�� ���� ������
	@RequestMapping("/user/signup")
	public void signUp() {
		
	}
	//��ü ȸ�� ���� ������
	@RequestMapping("/user/signupcompany")
	public void signUpCompany() {
		
	}
	
	//�α׾ƿ� ������
	@RequestMapping("/user/logout")
	public String logout(HttpSession session, HttpServletRequest request) {
		session.invalidate();
		session=request.getSession(true);
		return "redirect:/user/login";
	}
	
	//���� ���̵� �ߺ� üũ
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
	public int loginCheckCompany(String c_id,String c_pass,String c_number,HttpSession session) {
		CompanyVO readVO=mapper.readCompany(c_id);
		int chkNum=0;
		
		if(readVO!=null) {
			if(readVO.getC_pass().equals(c_pass)) {
				if(readVO.getC_number().equals(c_number)) {
					if(readVO.getC_key().equals("Y")) {
						//����
						chkNum=2;
						session.setAttribute("c_id", readVO.getC_id());
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
	public void login() {
		
	}
	
	//�Ϲ� ȸ�� ���� + �̸��� ������ȣ Send + ���� ���ε�
	@RequestMapping(value="/user/insert",method=RequestMethod.POST)
	public String insert(UserVO vo,MultipartHttpServletRequest multi,HttpServletRequest request) throws Exception {
		String id=mapper.readid(vo.getU_id());
		UserVO read=mapper.read(vo.getU_id());
		
		if(id.equals("1")) {//���̵� ���翩�� Ȯ��
			if(read.getU_key().equals("Y")) {//���̵������ϸ� Ű���� �� key���� Y�� �ƴϸ� ����
				System.out.println("�̹� ȸ�����̵� �����մϴ�.");
			}else {
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
			mailSender.mailSendWithUserKey(vo.getU_email(), vo.getU_id(), request);
		}
		return "redirect:/";
	}
	
	//��ü ȸ�� ����
	@RequestMapping(value="/user/insertCompany",method=RequestMethod.POST)
	public String insertComapny(CompanyVO vo,MultipartHttpServletRequest multi,HttpServletRequest request) throws Exception {
		String id=mapper.readcompanyid(vo.getC_id());
		CompanyVO read=mapper.readCompany(vo.getC_id());
		System.out.println(vo.getC_address());
		
		if(id.equals("1")) {//���̵� ���翩�� Ȯ��
			if(read.getC_key().equals("Y")) {//���̵������ϸ� Ű���� �� key���� Y�� �ƴϸ� ����
				System.out.println("�̹� ȸ�����̵� �����մϴ�.");
			}else {
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

}
