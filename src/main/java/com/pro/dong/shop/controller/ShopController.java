package com.pro.dong.shop.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.pro.dong.member.model.vo.Member;
import com.pro.dong.shop.model.service.ShopService;
import com.pro.dong.shop.model.vo.Shop;
import com.pro.dong.shop.model.vo.ShopInquriy;

@Controller
@RequestMapping("/shop")
public class ShopController {

	static Logger log = LoggerFactory.getLogger(ShopController.class);
	
	@Autowired
	ShopService ss;
	
	
	// 민호 시작 ==========================
	
	
	
	//========================== 민호 끝
	
	
	// 하진 시작 ==========================
	
	
	//========================== 하진 끝
	
	
	// 근호 시작 ==========================
	
	
	
	//========================== 근호 끝
	
	
	// 지은 시작 ==========================
	
	
	
	//========================== 지은 끝
	
	
	// 예찬 시작 ==========================
	
	
	
	//========================== 예찬 끝
	
	
	// 주영 시작 ==========================
	@RequestMapping("/shopView.do")
	public ModelAndView myshopView(HttpServletRequest request) {
		Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
		String memberId = memberLoggedIn.getMemberId();
		
		ModelAndView mav = new ModelAndView();
		
		Map<String, String> map = ss.selectOneShop(memberId);
		
		mav.addObject("map", map);
		
		return mav;
	}
	
	@RequestMapping("/updateShopInfo")
	@ResponseBody
	public Map<String, String> shopInfoUpdate(@RequestParam("memberId") String memberId,
							     @RequestParam("updateInfo") String shopInfo) {
		Map<String, String> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("shopInfo", shopInfo);
		
		
		int result = ss.updateShopInfo(param);

		Map<String, String> resultShop = ss.selectOneShop(memberId);
		
		return resultShop;
	}
	
	@RequestMapping("/shopNameCheck")
	@ResponseBody
	public Map<String, String> shopNameCheck(@RequestParam("memberId") String memberId,
							     			  @RequestParam("shopName") String shopName) {
		Map<String, String> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("shopName", shopName);
		
		Map<String, String> shopNameCheck = new HashMap<>();
		
		int checkResult= ss.selectShopNameCheck(param);
		
		//중복이 아니니까 사용가능하다.
		if(checkResult == 0) {
			checkResult = 1;
		} 
		//중복이니까 사용 불가다.
		else {
			checkResult = 9;
		}
		
		shopNameCheck.put("checkResult", Integer.toString(checkResult));
		
		return shopNameCheck;
	}
	
	@RequestMapping("/updateShopName")
	@ResponseBody
	public Map<String, String> shopNameUpdate(@RequestParam("memberId") String memberId,
							     			  @RequestParam("shopName") String shopName) {
		Map<String, String> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("shopName", shopName);
		
		int result = ss.updateShopName(param);
		Map<String, String> resultShop = new HashMap<>();
		
		resultShop = ss.selectOneShop(memberId);	
		
		return resultShop;
	}
	
	
	@RequestMapping("/shopImageUpload.do")
	@ResponseBody
	public ModelAndView shopImageUpload(ModelAndView mav,
								@RequestParam(value = "upFile", required = false) MultipartFile upFile,
								@RequestParam(value = "memberId", required = false) String memberId, HttpServletRequest request) {
		
		String saveDirectory = request.getServletContext().getRealPath("/resources/upload/shopImage");
		
		//동적으로 directory 생성
		File dir = new File(saveDirectory);
		if(dir.exists() == false)
			dir.mkdir();
		
		//MultipartFile객체 파일업로드 처리
		MultipartFile f = upFile; 
			if(!f.isEmpty()) {
				//파일명 재생성
				String originalFileName = f.getOriginalFilename();
				String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
				int rndNum = (int)(Math.random()*1000);
				String renamedFileName = sdf.format(new Date())+"_"+rndNum+ext;
				
				//서버컴퓨터에 파일저장
				try {
					f.transferTo(new File(saveDirectory+"/"+renamedFileName));
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				Shop s = new Shop();
				s.setImage(renamedFileName);
				s.setMemberId(memberId);
				
				int result = ss.updateShopImg(s);
				
				mav.setViewName("redirect:/shop/shopView.do");
			}
		
		return mav;
	}
	
	@RequestMapping("/selectShopInquriy")
	@ResponseBody
	public Map<String, Object> selectShopInquriy(@RequestParam("shopNo") int shopNo){
		List<ShopInquriy> list = new ArrayList<>();
		list = ss.selectShopInquiry(shopNo);
		
		int totalInquiry = ss.selectTotalInpuiry(shopNo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("totalInquiry", totalInquiry);
		
		return map;
	}
	
	@RequestMapping("/insertShopInquriy")
	@ResponseBody
	public Map<String, Object> insertShopInquriy(@RequestParam("memberId") String memberId,
												 @RequestParam("inquiryContent") String inquiryContent,
												 @RequestParam("shopNo") int shopNo){
		
		//inquiryContent.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\\n", "<br/>");
		
		ShopInquriy s = new ShopInquriy();
		s.setInquiryLevel(1);
		s.setInquiryContent(inquiryContent);
		s.setShopNo(shopNo);
		
		Map<String, String> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("inquiryContent", inquiryContent);
		param.put("shopNo",  Integer.toString(shopNo));
		
		Map<String, Object> map = new HashMap<>();
		int result = ss.insertShopInquriy(param);
		map.put("s", s);
		
		return map;
	}
	
	@RequestMapping("/deleteShopInquriy")
	@ResponseBody
	public Map<String, Integer> deleteShopInquriy(@RequestParam("deleteCommentBtn") int deleteCommentBtn){
		log.info("들어왔나요?");
		
		int result = ss.deleteShopInquriy(deleteCommentBtn);
		log.info("result={}", result);
		Map<String, Integer> map = new HashMap<>();
		map.put("result", result);
		return map;
	}

	//========================== 주영 끝
	
	
	// 현규 시작 ==========================
	
	
	
	//========================== 현규 끝
	
	
}
