package com.example.controller;

import java.io.File;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.openqa.selenium.remote.NewSessionPayload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.domain.Criteria;
import com.example.domain.HotplaceVO;
import com.example.domain.PageMaker;
import com.example.domain.UserVO;
import com.example.mapper.AdminMapper;
import com.example.mapper.UserMapper;
import com.example.service.AdminServiceInterface;

@Controller
@RequestMapping("/admin/")
public class AdminController {
	
	@Resource(name="hotplaceUploadPath") //servlet-context.xml���� ������ ���̵�
	private String path;
	
	@Autowired
	AdminMapper mapper;
	@Autowired
	UserMapper uMapper;
	@Autowired
	AdminServiceInterface service;
	
	// ������ index
	@RequestMapping("index")
	public String index(HttpSession session) {
		String u_id = (String)session.getAttribute("u_id");
		if(u_id.equals("admin")) {
			return "/admin/index";
		}else {
			return "redirect:/";
		}
	}	
	
	
	@RequestMapping("hotplace_list")
	public String list(Model model, HttpSession session) {
		String u_id = (String)session.getAttribute("u_id");
		if(u_id.equals("admin")) {
			model.addAttribute("list",mapper.list());
			return "/admin/hotplace_list";
		}else {
			return "redirect:/";
		}
	}
	
	@RequestMapping("hotplace_read")
	public String readimages(Model model,String h_x,String h_y, HttpSession session){
		String u_id = (String)session.getAttribute("u_id");
		if(u_id.equals("admin")) {
			model.addAttribute("vo", mapper.read(h_x,h_y));
			model.addAttribute("imagelist", mapper.imagelist(h_x,h_y));
			return "/admin/hotplace_read";
		}else {
			return "redirect:/";
		}
	}
	
	@RequestMapping("hotplace_insert")
	public String insert(HttpSession session) {
		String u_id = (String)session.getAttribute("u_id");
		if(u_id.equals("admin")) {
			return "/admin/hotplace_insert";
		}else {
			return "redirect:/";
		}
		
	}
	
	@RequestMapping(value="insertPost", method = RequestMethod.POST)
	public String insertPost(HotplaceVO vo, MultipartHttpServletRequest multi)throws Exception {
		//��ǥ�̹��� ���ε�
		MultipartFile file=multi.getFile("file");
		if(!file.isEmpty()) {
			String image=System.currentTimeMillis() + file.getOriginalFilename();
			file.transferTo(new File(path + File.separator + image));
			vo.setH_image(image);
		}
		List<MultipartFile> files=multi.getFiles("files");
		ArrayList<String> images=new ArrayList<String>();
		for(MultipartFile addFile:files) {
			String image=System.currentTimeMillis() + addFile.getOriginalFilename();
			addFile.transferTo(new File(path + File.separator + image));
			images.add(image);
		}
		vo.setH_i_images(images);
		mapper.insert(vo);
		
		for(String image:images) {
			mapper.insertimages(image, vo.getH_x(), vo.getH_y());
		}
		return "redirect:/admin/hotplace_list";
	}
	
	
	@RequestMapping(value="hotplace_delete", method=RequestMethod.POST)
	public String deletePost(HotplaceVO vo) {
		
		String oldImage=vo.getH_image();
		if(!oldImage.equals("")) {
			new File(path + File.separator + oldImage).delete();
		}
		List<String> oldImages=mapper.imagelist(vo.getH_x(),vo.getH_y());
		for(String image:oldImages) {
			if(!image.equals("")) {
				new File(path + File.separator + image).delete();
			}
		}
		
		service.delete(vo.getH_x(),vo.getH_y());
		return "redirect:hotplace_insert";
	}

	   @RequestMapping(value="hotplace_update", method=RequestMethod.POST)
	   public String updatePost(HotplaceVO vo, MultipartHttpServletRequest multi)throws Exception{
	      MultipartFile file=multi.getFile("file");
	      // ��ǥ�̹��� ���ε�
	      if(!file.isEmpty()){
	         // ���� ��ǥ�̹����� ������ ����
	         if(!vo.getH_image().equals("")){
	            new File(path + File.separator + vo.getH_image()).delete();
	         }
	         String image=System.currentTimeMillis() + file.getOriginalFilename();
	         file.transferTo(new File(path + File.separator + image));
	         vo.setH_image(image);
	      }
	      
	      // �߰��̹��� ���ε�
	      List<MultipartFile> files=multi.getFiles("files");
	      // ���� �߰��̹����� ������ ����
	      if(!files.get(0).isEmpty()){
	         List<String> oldImages=mapper.imagelist(vo.getH_x(), vo.getH_y());
	         for(String oldImage:oldImages){
	            new File(path + File.separator + oldImage).delete();
	         }
	      }
	      // ���ο� �߰��̹��� ���ε�
	      ArrayList<String> images=new ArrayList<String>();
	      for(MultipartFile attFile:files){
	         if(!attFile.isEmpty()){
	            String image=System.currentTimeMillis() + attFile.getOriginalFilename();
	            attFile.transferTo(new File(path + File.separator + image));
	            images.add(image);
	         }
	      }
	      vo.setH_i_images(images);
	      service.update(vo);
	      return "redirect:hotplace_list";
	   }


	
	@RequestMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> display(String fileName)throws Exception{
		ResponseEntity<byte[]> result=null;
		//display fileName�� �ִ� ���
		if(!fileName.equals("")) {
			File file=new File(path + File.separator + fileName);
			HttpHeaders header=new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result=new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}
		return result;
	}
	
	// ��������Ʈ
	@RequestMapping("userlist")
	public String userlist(HttpSession session) {
		String u_id = (String)session.getAttribute("u_id");
		if(u_id.equals("admin")) {
			return "/admin/userlist";
		}else {
			return "redirect:/";
		}
	}
	/*
	// ������Ʈ
	@RequestMapping("blacklistget")
	@ResponseBody
	public HashMap<String, Object> blacklistGet() {
		HashMap<String,Object> map= new HashMap<String,Object>();
		map.put("blacklist", mapper.blacklist());
		return map;
	}
	*/
	// ������Ʈ
	@RequestMapping("blacklist")
	public String blacklist(Model model ,Criteria cri,HttpSession  session) {
		String u_id = (String)session.getAttribute("u_id");
		if(u_id.equals("admin")) {
			if(cri.getKeyword()==null) {
				cri.setKeyword("");
			}
			cri.setPerPageNum(5);
			PageMaker pm= new PageMaker();
			pm.setCri(cri);
			pm.setTotalCount(mapper.totalcount(cri));
			model.addAttribute("cri",cri);
			model.addAttribute("pm",pm);
			model.addAttribute("keyword",cri.getKeyword());
			model.addAttribute("blacklist",mapper.blacklist(cri));
			return "/admin/blacklist";
		}else {
			return "redirect:/";
		}
	}
	
	
	@RequestMapping("black")
	public String black(Model model ,Criteria cri,HttpSession session) {
		String u_id = (String)session.getAttribute("u_id");
		if(u_id.equals("admin")) {
			if(cri.getKeyword()==null) {
				cri.setKeyword("");
			}
			cri.setPerPageNum(5);
			PageMaker pm= new PageMaker();
			pm.setCri(cri);
			pm.setTotalCount(mapper.totalcount1(cri));
			model.addAttribute("cri",cri);
			model.addAttribute("pm",pm);
			model.addAttribute("keyword",cri.getKeyword());
			model.addAttribute("black",mapper.black(cri));
			return "/admin/black";
		}else {
			
			return "redirect:/";
		}
	}
	
	@RequestMapping(value="read", produces="application/text; charset=utf8")
	@ResponseBody
	public String read(String u_id,String u_k_id,String date,HttpSession session) {
		String content= mapper.readcontent(u_id, u_k_id, date);
		return content;
	}
	@RequestMapping("lockStatus")
	public String lockStatus(String u_id,String u_k_id,HttpSession session) {
		String u_id1 = (String)session.getAttribute("u_id");
		mapper.updatestatus(u_id, u_k_id,"1");
		
		return "/admin/blacklist";
	}
	
	@RequestMapping("unlockStatus")
	public String unlockStatus(String u_id,String u_k_id,HttpSession session) {

			mapper.updatestatus(u_id, u_k_id,"0");
			mapper.blackdelete(u_id, u_k_id);
			return "/admin/blacklist";
		
	}
	
	@RequestMapping("unlock")
	public String unlock(String u_id,String u_k_id,HttpSession session) {
			mapper.blackdelete(u_id, u_k_id);
			return "/admin/blacklist";
	}
	// �Ű���
	@RequestMapping("userreport")
	public String userreport(HttpSession session) {
		String u_id = (String)session.getAttribute("u_id");
		if(u_id.equals("admin")) {
			return "/admin/userreport";
		}else {
			return "redirect:/";
		}
	}
	
	// �����ϱ�
	@RequestMapping("chat")
	public String chat(HttpSession session) {
		String u_id = (String)session.getAttribute("u_id");
		if(u_id.equals("admin")) {
			return "/admin/chat";
		}else {
			return "redirect:/";
		}
	}	
	
	// ��ü����Ʈ
	@RequestMapping("staylist")
	public String staylist(HttpSession session) {
		String u_id = (String)session.getAttribute("u_id");
		if(u_id.equals("admin")) {
			return "/admin/staylist";
		}else {
			return "redirect:/";
		}
	}
	
	// ��ü��û
	@RequestMapping("stayrequest")
	public String stayrequest(HttpSession session) {
		String u_id = (String)session.getAttribute("u_id");
		if(u_id.equals("admin")) {
			return "/admin/stayrequest";
		}else {
			return "redirect:/";
		}
	}
}
