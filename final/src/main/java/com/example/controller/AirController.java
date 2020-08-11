package com.example.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.AirVO;
import com.example.domain.PassengersVO;
import com.example.mapper.AirMapper;
import com.example.service.AirPassengersService;

@RequestMapping("/air")
@Controller
public class AirController {
	@Autowired
	AirMapper mapper;
	@Autowired
	AirPassengersService service;
	
		@RequestMapping(value="/transaction",method=RequestMethod.POST)
		public void transaction(String a_p_residentRegistration,HttpSession session,Model model) {
			System.out.println(a_p_residentRegistration);
			session.setAttribute("id", "user1");
			String u_id=(String)session.getAttribute("id");
			//System.out.println(u_id);
			//service.passengersInsert(vo,u_id);
		}

		@RequestMapping("/end")
		public void end() {
			
		}
	
		@RequestMapping("/kakaoPay")
		public void kakaoPay(PassengersVO vo,Model model){
			model.addAttribute("vo",vo);
			//System.out.println(vo.toString());
		}
		
		@RequestMapping("/seatlist")
		@ResponseBody
		public List<String> seatlist(String a_number){
			List<String> seatlist=mapper.seatlist(a_number);
			return seatlist;
		}
		
		@RequestMapping("/bookingPeople")
		public void bookingPeople(String a_number,String a_number1,Model model,int sum,String startplace,String endplace,String a_startdate1) {
			//System.out.println(sum);
			//System.out.println(a_startdate1);
			model.addAttribute("go",mapper.bookingPeople(a_number));
			model.addAttribute("back",mapper.bookingPeople(a_number1));
			model.addAttribute("sum", sum);
			model.addAttribute("startplace", startplace);
			model.addAttribute("endplace", endplace);
			model.addAttribute("a_startdate1",  a_startdate1);
		}
		//왕복 편도 비행기 리스트
		@RequestMapping(value="/airList",method=RequestMethod.POST)
		@ResponseBody
		public HashMap<String, Object> airList(AirVO vo, String a_startdate1){
			//System.out.println(vo.toString());
			HashMap<String, Object> map=new HashMap<String, Object>();
			String back = vo.getA_startplace();
				//System.out.println(a_startdate1);
			if(a_startdate1!=""){
				//System.out.println("왕복"+a_startdate1);
				//System.out.println(vo.toString());
				List<AirVO> startList = mapper.airList(vo);
				vo.setA_startplace(vo.getA_endplace());
				vo.setA_endplace(back);
				vo.setA_startdate(a_startdate1);
				List<AirVO> backList = mapper.airList(vo);
				map.put("startList", startList);
				map.put("backList", backList);
				//System.out.println(vo.toString());
			}else if(a_startdate1=="") {
				//System.out.println("편도"+a_startdate1);
				List<AirVO> startList = mapper.airList(vo);
				map.put("startList", startList);
			}
			//System.out.println(map);
			return map;
		}
		
		@RequestMapping("/search")
		public void search(HttpSession session) {
			session.setAttribute("user1", "user1");
		      String user1=(String) session.getAttribute("user1");
		}
		
		@RequestMapping("/listRead")
		@ResponseBody
		public AirVO listRead(String a_number) {
			return mapper.listRead(a_number);
		}
	
	   //호텔스컴바인 항공권
	   @RequestMapping("/airport")
	   @ResponseBody
	   public HashMap<String, Object> airport() throws Exception {
	      HashMap<String, Object> map = new HashMap<String, Object>();
	      Document doc = Jsoup.connect("https://www.hotelscombined.co.kr/flights/SEL-CJU/2020-08-30?sort=bestflight_a").get();
	      Elements es = doc.select(".Base-Results-ResultsList");
	      ArrayList<HashMap<String, Object>> array = new ArrayList<HashMap<String, Object>>();
	      for (Element e : es.select(".Base-Results-HorizonResult")) {
	         HashMap<String, Object> m = new HashMap<String, Object>();
	         m.put("company", e.select(".times .bottom").text());//항공사
	         m.put("starttime", e.select(".depart-time").text());//출발시간
	         m.put("endtime", e.select(".arrival-time").text());//도착시간
	         m.put("runtime", e.select(".allow-multi-modal-icons .top").text());//운행시간
	         m.put("price", e.select(".booking .price-text").text());//가격
	         //m.put("startplace", e.select(".bottom div:nth-child(1) span").text());//출발지
	         //m.put("endplace", e.select(".bottom div:nth-child(3) span").text());//도착지
	         array.add(m);
	        /*ㄴ
	         String company = e.select(".times .bottom").text();//항공사
	         String starttime=e.select(".depart-time").text();//출발시간
	         String endtime= e.select(".arrival-time").text();//도착시간
	         String runtime= e.select(".allow-multi-modal-icons .top").text();//운행시간
	         String strprice= e.select(".booking .price-text").text();//가격
	         //String startplace= e.select(".bottom div:nth-child(1) span").text();//출발지
	         //String endplace= e.select(".bottom div:nth-child(3) span").text();//도착지
	         
	         AirVO vo=new AirVO();
	         String maxNumber = mapper.read().substring(1);
	         String number = "P" + (Integer.parseInt(maxNumber) + 1);
	         
	         String firstNo = strprice.substring(0, strprice.indexOf(","));
	         String lastNo = strprice.substring(strprice.indexOf(",")+1, strprice.length()-1);
	         //System.out.println("처음번호"+firstNo + "마지막번호"+lastNo);
	         int price = Integer.parseInt(firstNo+lastNo);//+Integer.parseInt(lastNo);
	         //System.out.println("가격"+price);
	         
	         vo.setA_number(number);
	         vo.setA_company(company);
	         vo.setA_startplace("김포");
	         vo.setA_endplace("제주");
	         vo.setA_starttime(starttime);
	         vo.setA_endtime(endtime);
	         vo.setA_runtime(runtime);
	         vo.setA_price(price);
	         vo.setA_startdate("2020년08월30일");
	         vo.setA_emptyseat(120);
	         mapper.insert(vo);
	         */
	      }
	      map.put("array", array);
	      return map;
	   }
}