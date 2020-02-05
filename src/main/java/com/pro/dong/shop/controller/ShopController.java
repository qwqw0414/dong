package com.pro.dong.shop.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pro.dong.member.controller.MemberController;
import com.pro.dong.member.model.vo.Member;
import com.pro.dong.shop.model.service.ShopService;
import com.pro.dong.shop.model.vo.Shop;

@Controller
@RequestMapping("/shop")
public class ShopController {

	static Logger log = LoggerFactory.getLogger(MemberController.class);
	
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
		log.debug("memberShop={}", map);
		
		mav.addObject("map", map);
		
		return mav;
	}
	
	@RequestMapping("/updateShopInfo")
	@ResponseBody
	public Map<String, String> shopInfoUpdate(@RequestParam("memberId") String memberId,
							           	      @RequestParam("updateInfo") String shopInfo) {
		log.info("넘어왔다!!!!!!!!!!!!!!!!!!!!!!!");
		Shop shop = new Shop();
		shop.setMemberId(memberId);
		shop.setShopInfo(shopInfo);
		
		log.debug("가져온 shop={}", shop);
		
		int result = ss.updateShopInfo(shop);

		log.debug("result={}", result);
		
		Map<String, String> map = ss.selectOneShop(memberId);
		
		return map;
	}
	
	//========================== 주영 끝
	
	
	// 현규 시작 ==========================
	
	
	
	//========================== 현규 끝
	
	
}
