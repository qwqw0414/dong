package com.pro.dong.product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pro.dong.board.model.vo.BoardCategory;
import com.pro.dong.product.model.service.ProductService;
import com.pro.dong.product.model.vo.Category;

@Controller
@RequestMapping("/product")
public class ProductController {

	static Logger log = LoggerFactory.getLogger(ProductController.class);

	@Autowired
	ProductService ps;
	
	
	//민호 시작 ==========================
	
	//==========================민호 끝
		
	//하진 시작 ==========================
	@RequestMapping("/categoryView")
	@ResponseBody
	public  Map<String, Object> categoryView(){
		
		Map<String, Object> result = new HashMap<>();
		
		List<Category> cateboryList = ps.selectCategory();
		log.debug("list@@@@@@@@@@@@@@@@@@@@@@@@={}",cateboryList);
		result.put("cateboryList", cateboryList);
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//========================== 하진 끝
		
	//근호 시작 ==========================

	//========================== 근호 끝
		
	//지은 시작 ==========================

	//========================== 지은 끝
		
	//예찬 시작 ==========================
		@RequestMapping("/productReg.do")
		public void productReg() {
			
		}
	//========================== 예찬 끝
		
	//주영 시작 ==========================
		
	//========================== 주영 끝
		
	//현규 시작 ==========================

	//========================== 현규 끝
}
