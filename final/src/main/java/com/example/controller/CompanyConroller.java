package com.example.controller;

import java.io.File;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.domain.CompanyVO;
import com.example.domain.Criteria;
import com.example.domain.PageMaker;
import com.example.domain.RoomVO;
import com.example.mapper.CompanyMapper;
import com.example.service.CompanyService;

@Controller
@Repository
public class CompanyConroller {
	@Resource(name="companyUploadPath")
	private String companypath;

	@Autowired
	CompanyMapper mapper;
	
	@Autowired
	CompanyService service;
		
   @RequestMapping("/sidebar")
   @ResponseBody
   public int cart(HttpSession session,CompanyVO vo) {
	   int cnt=0;
	   ArrayList<CompanyVO> listCart=(ArrayList<CompanyVO>)session.getAttribute("listCart");
		if(listCart==null) {
			listCart=new ArrayList<CompanyVO>();
			listCart.add(vo);
		}else {
			
			boolean find=false;
			for(CompanyVO nvo:listCart) {
				if(nvo.getR_id().equals(vo.getR_id()) && nvo.getR_roomnum().equals(vo.getR_roomnum())) {
					find=true;
					cnt=1;
				}
			}
			if(find==false) {
				listCart.add(vo);
			}
		}
		session.setAttribute("listCart", listCart);
		return cnt;
   }
   
   @RequestMapping("/cartcancel")
   @ResponseBody
   public void cartcancel(HttpSession session,CompanyVO vo) {
	   System.out.println(vo.toString());
	   ArrayList<CompanyVO> listCart=(ArrayList<CompanyVO>)session.getAttribute("listCart");
		for(CompanyVO nvo:listCart) {
			if(nvo.getR_id().equals(vo.getR_id()) && nvo.getR_roomnum().equals(vo.getR_roomnum())) {
				session.removeAttribute("listCart");
				listCart.remove(nvo);
				session.setAttribute("listCart", listCart);
			}
		}
   }
   
   
	
	@RequestMapping("/company/getroomread")
	@ResponseBody
	public HashMap<String, Object> getroomread(String r_i_id, String r_i_roomnum){
		HashMap<String, Object> map= new HashMap<String, Object>();
		map.put("option", mapper.readRoomoption(r_i_id, r_i_roomnum));
		map.put("image", mapper.imagesread(r_i_id, r_i_roomnum));
		map.put("read", mapper.read(r_i_id,r_i_roomnum));
		return map;
	}
	
	@RequestMapping("/company/readroom")
	@ResponseBody
	public int readroom(String r_id, String r_roomnum) {
		int rvo=mapper.roomreadCount(r_id, r_roomnum);
		
		return rvo;
	}
	@RequestMapping("/company/roominsert")
	public String insertroom(Model model,String c_id, Criteria cri) {
		cri.setR_id(c_id);
		cri.setPerPageNum(5);
		PageMaker pm=new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(mapper.totalCount(c_id));
		
		model.addAttribute("cri",cri);
		model.addAttribute("pm",pm);
		model.addAttribute("list",mapper.roomlist(cri));
		return "/company/roominsert";
	}
	
	
	//룸등록
		@RequestMapping(value="/company/insertroom",method=RequestMethod.POST)
		public String insertComapny(RoomVO vo,MultipartHttpServletRequest multi,HttpServletRequest request) throws Exception {
			String[] arrayParam = request.getParameterValues("r_o_option");
			
				
				//대표이미지 업로드
				MultipartFile file=multi.getFile("file");
				if(!file.isEmpty()) {
					String image=System.currentTimeMillis()+file.getOriginalFilename();
					file.transferTo(new File(companypath + File.separator + image));
					vo.setR_image(image);
				}
				//추가 이미지 업로드
				List<MultipartFile> files=multi.getFiles("files");
				List<String> images=new ArrayList<String>();
				for(MultipartFile attfile:files) {
					if(!attfile.isEmpty()) {
						String image=System.currentTimeMillis()+attfile.getOriginalFilename();
						attfile.transferTo(new File(companypath + File.separator + image));
						images.add(image);
					}
				}
				
				vo.setImages(images);
				
				service.insert(vo);		
				
				for (int i = 0; i < arrayParam.length; i++) { 
					mapper.insertRoomoption(vo.getR_id(),vo.getR_roomnum(),arrayParam[i]);
					}
			return "redirect:/company/roominsert?page=1&&c_id="+vo.getR_id();
		}
		@RequestMapping("/displayRoom")
		@ResponseBody
		public ResponseEntity<byte[]> display(String fileName) throws Exception {
			ResponseEntity<byte[]> result = null;
			// display fileName이 있는 경우
			if (!fileName.equals("")) {
				File file = new File(companypath + File.separator + fileName);
				HttpHeaders header = new HttpHeaders();
				header.add("Content-Type", Files.probeContentType(file.toPath()));
				result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			}
			return result;
		}
		
		@RequestMapping("/stay/search")
		   public String companylist(Model model,Criteria cri) {
		       cri.setPerPageNum(10);
		       PageMaker pm=new PageMaker();
		       pm.setCri(cri);
		       pm.setTotalCount(mapper.countpage());
		       model.addAttribute("cri",cri);
		       model.addAttribute("pm",pm);
		       model.addAttribute("list",mapper.hotellist(cri));
		       return "/stay/search";
		   }
		@RequestMapping(value="/stay/read",method=RequestMethod.POST)
		@ResponseBody
		public List<HashMap<String,Object>> hotelread(String c_id) {
			List<HashMap<String,Object>> read=mapper.hotelread(c_id);
			return read;	
		}
		
		@RequestMapping("/stay/read")
		public void hotelread(Model model,String c_id) {
			model.addAttribute("c_id",c_id);
		}
		
	   @RequestMapping("/company/companyread")
	   public void companyread(Model model,String c_id) {
	      model.addAttribute("vo",mapper.companyread(c_id));
	   }
		   
	   @RequestMapping("/company/roomlist")
	   @ResponseBody
	   public List<RoomVO> roomlist(String c_id) {
	      List<RoomVO> roomlist=mapper.companyroomlist(c_id);
	      return roomlist;
	   }
	   
	   
	   // 이미지파일 브라우저에 출력
      @RequestMapping("/company/hoteldisplay")
      @ResponseBody
      public ResponseEntity<byte[]> displays(String fileName) throws Exception {
         ResponseEntity<byte[]> result = null;
         // display fileName이 있는 경우
         if (!fileName.equals("")) {
            File file = new File(companypath + File.separator + fileName);
            HttpHeaders header = new HttpHeaders();
            header.add("Content-Type", Files.probeContentType(file.toPath()));
            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
         }
         return result;
      }
	
		
}
