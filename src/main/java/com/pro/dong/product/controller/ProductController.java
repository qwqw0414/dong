package com.pro.dong.product.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import com.pro.dong.board.model.vo.Attachment;
import com.pro.dong.board.model.vo.BoardCategory;
import com.pro.dong.common.util.Utils;
import com.pro.dong.member.model.vo.Member;
import com.pro.dong.product.model.service.ProductService;
import com.pro.dong.product.model.vo.Category;
import com.pro.dong.product.model.vo.Like;
import com.pro.dong.product.model.vo.Product;
import com.pro.dong.product.model.vo.ProductAttachment;
import com.pro.dong.shop.model.vo.Shop;

import lombok.Builder.Default;

@Controller
@RequestMapping("/product")
public class ProductController {

	static Logger log = LoggerFactory.getLogger(ProductController.class);
	static Gson gson = new Gson();
	@Autowired
	ProductService ps;
	
	
	//민호 시작 ==========================
	
	//==========================민호 끝
		
	//하진 시작 ==========================
	
	
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
			return gson.toJson(list);
		}
		
		@ResponseBody
		@RequestMapping(value="/productReg", produces="text/plain;charset=UTF-8")
		public String productReg(Product product, String memberId, MultipartFile[] files, HttpServletRequest request) {
			
			int result = 0;
			
			try {
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
				
				product.setTitle(product.getTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
				product.setInfo(product.getInfo().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\\n", "<br/>"));
			
				String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/product");
				List<ProductAttachment> attachList = new ArrayList<>();
				
				File dir = new File(saveDirectory);
				if(dir.exists() == false) dir.mkdir();
				
				for(MultipartFile f : files) {
					if(!f.isEmpty()) {
						String originalFileName = f.getOriginalFilename();
						String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
						SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
						int rndNum = (int)(Math.random()*1000);
						String renamedFileName = sdf.format(new Date())+"_"+rndNum+ext;
						
						try {
							f.transferTo(new File(saveDirectory+"/"+renamedFileName));
						} catch (IllegalStateException e) {
							e.printStackTrace();
						} catch (IOException e) {
							e.printStackTrace();
						}
						
						ProductAttachment attach = new ProductAttachment();
						attach.setPhoto(renamedFileName);
						attachList.add(attach);
					}
				}
				
				result = ps.insertProduct(product, attachList);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			
			return ""+result;
		}
		
		@ResponseBody
		@RequestMapping(value="/selectProductListTop10", produces="text/plain;charset=UTF-8")
		public String selectProductListTop10(String categoryId) {
			
			List<Map<String, String>> list = null;
			
			try {
				list = ps.selectProductListTop10(categoryId);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			return gson.toJson(list);
		}
		
		@RequestMapping("/productList.do")
		public ModelAndView productList(ModelAndView mav, String categoryId, String keyword) {
			
			mav.addObject("categoryId", categoryId);
			mav.addObject("keyword", keyword);
			return mav;
		}
		
		@ResponseBody
		@RequestMapping(value="/searchProduct", produces="text/plain;charset=UTF-8")
		public String searchProduct(int cPage, Product product, String keyword) {
			
			
			int numPerPage = 40;
			Map<String, String> param = new HashMap<>();
			param.put("categoryId", product.getCategoryId());
			param.put("keyword", keyword);
			param.put("sido", product.getSido());
			param.put("sigungu", product.getSigungu());
			param.put("dong", product.getDong());
			
			List<Map<String, String>> list = ps.selectProduct(cPage,numPerPage,param);
			
			int totalContents = ps.countProduct(param);
			String pageBar = new Utils().getOneClickPageBar(totalContents, cPage, numPerPage);
			
			Map<String,Object> result = new HashMap<>();
			result.put("product", list);
			result.put("pageBar", pageBar);
			
			log.debug(pageBar);
			
			return gson.toJson(result);
		}
		
		@RequestMapping("/productView.do")
		public ModelAndView productView(ModelAndView mav, int productNo, HttpServletRequest request) {
			
			Map<String, Object> map = ps.selectOneProduct(productNo);
			
			HttpSession session = request.getSession();
			Member member = (Member) session.getAttribute("memberLoggedIn");
			
			Like like = new Like();
			like.setMemberId(member.getMemberId());
			like.setProductNo(productNo);
			
			int likeCnt = ps.countLike(like);

			map.put("likeCnt", likeCnt+"");
			mav.addObject("map",map);
			
			return mav;
		}
		
		
		@RequestMapping(value="/productLike", produces="text/plain;charset=UTF-8")
		@ResponseBody
		public String productLike(Like like) {
			
			Map<String, String> map = new HashMap<>();
			int likeCnt = ps.countLike(like);
			int result;
			
			if(likeCnt == 0) {
				result = ps.insertLike(like);
				map.put("type", "I");
			}
			else {
				result = ps.deleteLike(like);
				map.put("type", "O");
			}
			
			map.put("result", result+"");
			
			return gson.toJson(map);
		}
	//========================== 예찬 끝
		
	//주영 시작 ==========================
		
	//========================== 주영 끝
		
	//현규 시작 ==========================

	//========================== 현규 끝
}
