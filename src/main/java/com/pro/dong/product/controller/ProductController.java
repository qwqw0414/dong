package com.pro.dong.product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.pro.dong.board.model.vo.BoardCategory;
import com.pro.dong.product.model.service.ProductService;
import com.pro.dong.product.model.vo.Category;
import com.pro.dong.product.model.vo.Product;
import com.pro.dong.shop.model.vo.Shop;

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
		
		@ResponseBody
		@RequestMapping(value="/categoryList", produces="text/plain;charset=UTF-8")
		public String categoryList(Category category) {
			
			List<Category> list = ps.selectCategory(category);
			log.debug(list.toString());
			
			Gson gson = new Gson();
			
			return gson.toJson(list);
					
		}
		
		@ResponseBody
		@RequestMapping(value="/productReg", produces="text/plain;charset=UTF-8")
		public String productReg(Product product, String memberId) {
			
			if(product.getShipping().equals("true"))
				product.setShipping("Y");
			else
				product.setShipping("N");
			
			if(product.getHaggle().equals("true"))
				product.setHaggle("Y");
			else
				product.setHaggle("N");
			
			Shop shop = ps.selectOneShop(memberId);
			
			product.setShopNo(shop.getShopNo());
			
			log.debug(product.toString());
			
			int result = ps.insertProduct(product);
			
			return ""+result;
		}
		
	//========================== 예찬 끝
		
	//주영 시작 ==========================
		
	//========================== 주영 끝
		
	//현규 시작 ==========================

	//========================== 현규 끝
}
