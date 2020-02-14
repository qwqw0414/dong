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
import com.pro.dong.board.model.vo.BoardComment;
import com.pro.dong.common.util.Utils;
import com.pro.dong.member.model.vo.Member;
import com.pro.dong.product.model.service.ProductService;
import com.pro.dong.product.model.vo.Category;
import com.pro.dong.product.model.vo.Like;
import com.pro.dong.product.model.vo.OrderList;
import com.pro.dong.product.model.vo.Product;
import com.pro.dong.product.model.vo.ProductAttachment;
import com.pro.dong.product.model.vo.ProductComment;
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
	@RequestMapping("/submitPurchase")
	@ResponseBody
	public String submitPurchase(OrderList orderList, Member buyer){
		log.debug("orderList={}",orderList);
		int result = ps.submitPurchase(orderList);
		int pointResult = 0;
		if(result>0) {
			pointResult = ps.updateMemberPoint(orderList);
		}
		
		return pointResult+"";
	}
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
			log.info("member={}",member);
			Like like = new Like();
			like.setMemberId(member.getMemberId());
			like.setProductNo(productNo);
			
			int likeCnt = ps.countLike(like);
			
			map.put("likeCnt", likeCnt+"");
			map.put("memberLoggedIn", member);
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
	@RequestMapping(value="/loadProductReportCategory", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String loadProductReportCategory() {
		List<Map<String, String>> list = null;
		list = ps.loadProductReportCategory();
		Map<String, Object> result = new HashMap<>();
		result.put("list", list);
		return gson.toJson(result);
	}
		
	@RequestMapping("/insertProductReport")
	@ResponseBody
	public String insertProductReport(
			@RequestParam(value = "files", required = false) MultipartFile upFile,
			@RequestParam(value = "reportComment", required = false) String reportComment,
			@RequestParam(value = "categoryId", required = false) String categoryId,
			@RequestParam(value = "memberId", required = false) String memberId,
			@RequestParam(value = "productNo", required = false) int productNo,
			HttpServletRequest request) {
		
		int result = 0;

		if(upFile != null) {
			
			String saveDirectory = request.getServletContext().getRealPath("/resources/upload/productReportImage");
			
			//동적으로 directory 생성
			File dir = new File(saveDirectory);
			if (dir.exists() == false)
				dir.mkdir();
			
			//MultipartFile객체 파일업로드 처리
			MultipartFile f = upFile;
			if (!f.isEmpty()) {
				//파일명 재생성
				String originalFileName = f.getOriginalFilename();
				String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
				int rndNum = (int) (Math.random() * 1000);
				String renamedFileName = sdf.format(new Date()) + "_" + rndNum + ext;
				
				//서버컴퓨터에 파일저장
				try {
					f.transferTo(new File(saveDirectory + "/" + renamedFileName));
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				Map<String, String> param = new HashMap<>();
				param.put("fileName", renamedFileName);
				param.put("reportComment", reportComment);
				param.put("categoryId", categoryId);
				param.put("memberId", memberId);
				param.put("productNo", Integer.toString(productNo));
				
				result = ps.insertProductReport(param);
			}
		} //end if
		else {
				
				Map<String, String> param = new HashMap<>();
				param.put("reportComment", reportComment);
				param.put("categoryId", categoryId);
				param.put("memberId", memberId);
				param.put("productNo", Integer.toString(productNo));
				
				result = ps.insertProductReport(param);
		}
		return ""+result;
	}
	
	//========================== 주영 끝
		
	//현규 시작 ==========================
		//댓글 등록
		@RequestMapping(value="/insertComments", produces="text/plain;charset=UTF-8")
		@ResponseBody
		public String insertComments(HttpSession session, ProductComment pc, @RequestParam("productNo") int productNo) {
			
			int result = ps.insertProductComment(pc);
			System.out.println(result);
			
			
			
			return gson.toJson(result)+"";
		}
		
		
		//댓글 불러들이기
		@ResponseBody
		@RequestMapping(value="/selectProductComment", produces="text/plain;charset=UTF-8")
		public String selectProductCommentList(@RequestParam("productNo") int productNo, @RequestParam("cPage") int cPage) {
			int numPerPage=10;
			log.info("파라미터로받아온 productNo{}",productNo);
			List<Map<String,String>>list = null;
			
			list = ps.selectProductCommentList(productNo,cPage,numPerPage);
			log.debug("DB에서 가져온 리스트={}",list);
			
			
			
			int totalContents = ps.countComment(productNo);
			String pageBar = new Utils().getOneClickPageBar(totalContents, cPage, numPerPage);
			
			Map<String,Object> result = new HashMap<>();
			result.put("list", list);
			result.put("pageBar", pageBar);
			
			
			
			return gson.toJson(result)+"";
		}
		
		
		
		
		//댓글 지우기
		@ResponseBody
		@RequestMapping("/deleteLevel1")
		public String deleteLevel1(@RequestParam("commentNo") int commentNo,@RequestParam("productNo")int productNo) {
			log.info("삭제할 코멘트넘버={}",commentNo);
			
			ProductComment pc = new ProductComment();
			pc.setCommentNo(commentNo);
			
			int result= ps.deleteLevel1(commentNo);
			
			
//			List<Map<String,String>>list = null;
//			if (result>0) {
//				list = bs.selectBoardCommentList(productNo);
//			}
			
			
			return gson.toJson(result)+"";
		}
		
		//대댓글 쓰기
		@ResponseBody
		@RequestMapping(value="/insertLevel2", produces="text/plain;charset=UTF-8")
		public String insertLevel2(ProductComment pc,@RequestParam("productNo")int productNo) {
			log.debug("dddddd={}",pc);
			
			int result = ps.insertProductComment(pc);
			
			
			
			log.info("result={}",result);
			
			return gson.toJson(result)+"";
			

		}
		
		//대댓글 삭제
		@ResponseBody
		@RequestMapping(value="/deleteLevel2", produces="text/plain;charset=UTF-8")
		public String deleteLevel2(@RequestParam("commentNo") int commentNo) {
			log.debug("삭제할 대댓번호={}",commentNo);
			
			int result = ps.deleteLevel2(commentNo);
			
			return gson.toJson(result)+"";
		}
//========================== 현규 끝
}
