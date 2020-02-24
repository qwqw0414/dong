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
import org.w3c.dom.ls.LSInput;

import com.google.gson.Gson;
import com.pro.dong.common.util.Utils;
import com.pro.dong.member.model.vo.Member;
import com.pro.dong.product.model.vo.Product;
import com.pro.dong.shop.model.service.ShopService;
import com.pro.dong.shop.model.vo.Shop;
import com.pro.dong.shop.model.vo.ShopInquriy;

@Controller
@RequestMapping("/shop")
public class ShopController {

	static Logger log = LoggerFactory.getLogger(ShopController.class);
	static Gson gson = new Gson();
	@Autowired
	ShopService ss;
	
	
	// 민호 시작 ==========================
	@RequestMapping("/shopFollow")
	@ResponseBody
	public String shopFollow(@RequestParam("follow")String follow, @RequestParam("follower")String follower, @RequestParam("isFollowing")int isFollowing) {
		log.debug("follow={}",follow);
		
		Map<String, String> param = new HashMap<>();
		Map<String, Object> resultMap = new HashMap<>();
		
		param.put("follow",follow);
		param.put("follower",follower);

		int result = 0;
		if(isFollowing>0) {
			result = ss.shopUnfollow(param);
		} else {
			result = ss.shopFollow(param);
		}
		resultMap.put("result", result);
		
		return gson.toJson(resultMap);
	}
	
	@RequestMapping("/isFollowing")
	@ResponseBody
	public Map<String,Object> isFollowing(@RequestParam("follow")String follow, @RequestParam("follower")String followerMemberId) {
		
		Map<String, String> param = new HashMap<>();
		Map<String, String> followerShop = new HashMap<>();
		Map<String, Object> resultMap = new HashMap<>();
		followerShop = ss.selectOneShop(followerMemberId);
		log.debug("map={}",followerShop);
		log.debug("followerShop.get('SHOP_NO')={}",followerShop.get("SHOP_NO"));
		
		String follower = String.valueOf(followerShop.get("SHOP_NO"));
		log.debug("follower={}",follower);
		param.put("follow",follow);
		param.put("follower",follower);
		int isFollowing = ss.isFollowing(param);
		resultMap.put("isFollowing", isFollowing);
		resultMap.put("follower", follower);
		return resultMap;
	}
	@RequestMapping("/viewFollow")
	@ResponseBody
	public Map<String, Object> viewFollow(@RequestParam("follow")String follow,@RequestParam(value="cPage",defaultValue="1")int cPage){
		int numPerPage = 10;
		
		Map<String, String> param = new HashMap<>();
		Map<String, Object> result = new HashMap<>();
		param.put("follow", follow);
		int totalContents = ss.selectFollowListCount(follow);
		List<Map<String,String>> followList = ss.selectFollowList(follow,cPage,numPerPage);
		String followPageBar = new Utils().getOneClickPageBar(totalContents, cPage, numPerPage);
		result.put("followList", followList);
		result.put("followPageBar", followPageBar);
		return result;
	}
	@RequestMapping("/viewFollower")
	@ResponseBody
	public Map<String, Object> viewFollower(@RequestParam("follower")String follower, @RequestParam(value="cPage",defaultValue="1")int cPage){
		int numPerPage = 10;
		
		Map<String, String> param = new HashMap<>();
		Map<String, Object> result = new HashMap<>();
		param.put("follower", follower);
		int totalContents = ss.selectFollowerListCount(follower);
		List<Map<String,String>> followerList = ss.selectFollowerList(follower,cPage,numPerPage);
		String followPageBar = new Utils().getOneClickPageBar(totalContents, cPage, numPerPage);
		result.put("followerList", followerList);
		result.put("followPageBar", followPageBar);
		return result;
	}
	@RequestMapping("/loadReviewGrade")
	@ResponseBody
	public Map<String, Object> loadReviewGrade(){
		Map<String, Object> result = new HashMap<>();
		List<Map<String, String>> reviewGradeList = ss.loadReviewGrade();
		result.put("reviewGradeList", reviewGradeList);
		return result;
	}
	@RequestMapping("/insertReview")
	@ResponseBody
	public Map<String, Object> insertReview(HttpSession session, 
			@RequestParam("shopName")String shopName, @RequestParam("reviewGrade")String reviewGrade, @RequestParam("reviewContent")String reviewContent,@RequestParam("productNo")String productNo){
		Member memberLoggedIn = (Member) session.getAttribute("memberLoggedIn");
		String memberId = memberLoggedIn.getMemberId();
		Shop shop = ss.selectOneShopByShopName(shopName);
		int shopNo = shop.getShopNo();
		
		Map<String, String> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("shopNo", shopNo+"");
		param.put("reviewGrade", reviewGrade);
		param.put("reviewContent", reviewContent);
		param.put("productNo", productNo);
		Map<String, Object> resultMap = new HashMap<>();
		int result = ss.insertReview(param);
		resultMap.put("result", result);
		return resultMap;
		
	}
	@RequestMapping("/loadShopReview")
	@ResponseBody
	public Map<String, Object> loadShopReview(@RequestParam(value="cPage",defaultValue="1")int cPage, @RequestParam("shopNo")int shopNo){
		log.debug("shopNo={}",shopNo);
		int numPerPage = 10;
		
		Map<String, String> param = new HashMap<>();
		Map<String, Object> result = new HashMap<>();
		param.put("shopNo", shopNo+"");
		int totalContents = ss.selectShopReviewListCount(param);
		List<Map<String,String>> shopReviewList = ss.loadShopReview(param, cPage, numPerPage);
		String pageBar = new Utils().getOneClickPageBar(totalContents, cPage, numPerPage);
		result.put("shopReviewList", shopReviewList);
		result.put("pageBar", pageBar);
		return result;
	}
	//========================== 민호 끝
	
	
	// 하진 시작 ==========================
	@RequestMapping(value="/loadMyProduct" , produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String loadMyProductList(String memberId, int cPage){
		
		int numPerPage = 10;
		
		List<Map<String, String>> list = null;
			
		list = ss.loadMyProductList(memberId,cPage,numPerPage);
		int totalContents = ss.totalCountMyProduct(memberId);
			
		String pageBar = new Utils().getOneClickPageBar(totalContents, cPage, numPerPage);
			
		Map<String,Object> result = new HashMap<>();
			
		result.put("product", list);
		result.put("pageBar", pageBar);
		
		return gson.toJson(result);
	}
	@RequestMapping(value="/loadMyProductManage" , produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String loadMyProductManage(String searchKeyword,
			String saleCategory, 
			int cPage,
			String memberId){
		
		int numPerPage = 10;
		
		Map<String, String> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("saleCategory", saleCategory);
		param.put("searchKeyword", searchKeyword);
	
		int totalContents = ss.totalProductContents(param);

		List<Map<String, String>> list = ss.loadMyProductManage(cPage,numPerPage,param);
		log.debug("@@@@@@@@@@@@@={}",list);
		String pageBar = new Utils().getOneClickPageBar(totalContents, cPage, numPerPage);	

		Map<String,Object> result = new HashMap<>();
		
		result.put("product", list);
		result.put("pageBar", pageBar);
		
		return gson.toJson(result);
	}
	@RequestMapping("/myPoductManage.do")
	public ModelAndView myPoductManage(ModelAndView mav) {
		mav.setViewName("/shop/myProductManage");
		return mav;
	}

	@RequestMapping("/productUpdate")
	@ResponseBody
	public String productUpdate(@RequestParam("productNo") String productNo) {
		Map<String, String> param = new HashMap<>();
		param.put("productNo",productNo);
		
		int result = ss.productUpdate(productNo);
		
		return ""+result;
	}
	@RequestMapping("/productDelete")
	@ResponseBody
	public String productDelete(@RequestParam("productNo") String productNo) {
		Map<String, String> param = new HashMap<>();
		param.put("productNo",productNo);
		int result = ss.productDelete(productNo);
		return ""+result;
	}
	@RequestMapping("/saleSelect")
	@ResponseBody
	public String saleStatus(@RequestParam("productNo") String productNo, @RequestParam("select") String select) {
		
		Map<String, String> param = new HashMap<>();
		param.put("productNo", productNo);
		param.put("select", select);
		int result = ss.saleStatus(param);
		
		return ""+result;
	}
	//========================== 하진 끝
	
	
	// 근호 시작 ==========================
	
	
	
	//========================== 근호 끝
	
	
	// 지은 시작 ==========================
	/*@RequestMapping("/shopView.do")
	public String readCount(@RequestParam("shopNo") int shopNo) {
		int readCount = ss.shopInCount(shopNo);
		
		return readCount+"";
	}*/
	
	
	//========================== 지은 끝
	
	
	// 예찬 시작 ==========================
	@RequestMapping(value="/shopList.do", produces="text/plain;charset=UTF-8")
	public ModelAndView shopList(ModelAndView mav, @RequestParam("keyword") String keyword) {
//		Map<String, String> map = new HashMap<>();
//		map.put("keyword", keyword);
//		
//		List<Shop> list = ss.searchShop(map);
		
		mav.addObject("keyword", keyword);
		
		return mav;
	}
	
	@RequestMapping(value="/searchShop", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String searchShop(String keyword) {
		Map<String, String> map = new HashMap<>();
		map.put("keyword", keyword);
		
		List<Shop> list = ss.searchShop(map);
		
		return gson.toJson(list);
	}
	
	@RequestMapping("/shopView1.do")
	public ModelAndView shopView1(int shopNo) {
		
		ModelAndView mav = new ModelAndView();
		
		Shop shop = ss.selectOneShopByShopNo(shopNo);
		
		mav.addObject("shop", shop);
		
		return mav;
	}
	
	//========================== 예찬 끝
	
	
	// 주영 시작 ==========================
	@RequestMapping("/shopView.do")
	public ModelAndView myshopView(ModelAndView mav,
								   @RequestParam(value="memberId", defaultValue = "") String memberId, 
								   @RequestParam(value="shopNo", defaultValue = "0") int shopNo ) {
		Map<String, String> map = new HashMap<>();
		//int visitDate = ss.selectOpenDate(memberId);
		//map = ss.selectOpenDate(memberId);
		
		if(memberId.equals("")) {
			int readCount = ss.shopInCount(shopNo);
			map = ss.selectShopByShopNo(shopNo);
			mav.addObject("shopNo", shopNo);
		}
		else if(Integer.toString(shopNo).equals("0")) {
			map = ss.selectOneShop(memberId);
			mav.addObject("memberId", memberId);
		}
		
		mav.addObject("map", map);
		//mav.addObject("readCount",readCount);
		return mav;
	}
	
	@RequestMapping("/updateShopInfo")
	@ResponseBody
	public Map<String, Object> shopInfoUpdate(@RequestParam("memberId") String memberId,
							     @RequestParam("updateInfo") String shopInfo) {
		Map<String, String> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("shopInfo", shopInfo);
		
		
		int result = ss.updateShopInfo(param);

		Map<String, String> resultShop = ss.selectOneShop(memberId);
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("resultShop", resultShop);
		
		return resultMap;
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
	public Map<String, Object> shopNameUpdate(@RequestParam("memberId") String memberId,
							     			  @RequestParam("shopName") String shopName) {
		Map<String, String> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("shopName", shopName);
		
		int result = ss.updateShopName(param);
		Map<String, String> resultShop = new HashMap<>();
		
		resultShop = ss.selectOneShop(memberId);
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("resultShop", resultShop);
		
		Gson gson = new Gson();
		
		return resultMap;
	}
	
	
	@RequestMapping("/shopImageUpload.do")
	@ResponseBody
	public ModelAndView shopImageUpload(ModelAndView mav,
								@RequestParam(value = "upFile", required = false) MultipartFile upFile,
								@RequestParam(value = "memberId", required = false) String memberId,
								HttpServletRequest request) {
		
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
				
				mav.setViewName("redirect:/shop/shopView.do?memberId="+memberId);
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
		
		//XSS공격대비 &문자변환
		inquiryContent = inquiryContent.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\\n", "<br/>");
		
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
	public Map<String, Integer> deleteShopInquriy(@RequestParam("deleteCommentBtn") int deleteCommentBtn,
												  @RequestParam("inquiryLevel") int inquiryLevel){
		Map<String, Integer> map = new HashMap<>();
		int result = 0;
		
		if(inquiryLevel == 1) {
			result = ss.deleteShopInquriy(deleteCommentBtn);
			map.put("result", result);
		}
		else if(inquiryLevel == 2){
			result = ss.deleteShopInquriyComment(deleteCommentBtn);
			map.put("result", result);
		}
		
		return map;
	}
	
	@RequestMapping("/insertInquiryComment")
	@ResponseBody
	public Map<String, Object> insertInquiryComment(@RequestParam("inquiryRefNo") int inquiryRefNo,
												 	@RequestParam("shopInquiryCommentText") String shopInquiryCommentText,
												 	@RequestParam("shopInquiryCommentWriter") String shopInquiryCommentWriter,
												 	@RequestParam("shopInquiryCommentShopNo") int shopInquiryCommentShopNo){
		
		//XSS공격대비 &문자변환
		shopInquiryCommentText = shopInquiryCommentText.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\\n", "<br/>");
		
		ShopInquriy s = new ShopInquriy();
		s.setInquiryRef(inquiryRefNo);
		s.setInquiryContent(shopInquiryCommentText);
		s.setMemberId(shopInquiryCommentWriter);
		s.setShopNo(shopInquiryCommentShopNo);
		
		
		Map<String, String> param = new HashMap<>();
		param.put("inquiryRefNo", Integer.toString(inquiryRefNo));
		param.put("shopInquiryCommentText", shopInquiryCommentText);
		param.put("shopInquiryCommentWriter", shopInquiryCommentWriter);
		param.put("shopInquiryCommentShopNo", Integer.toString(shopInquiryCommentShopNo));
		
		Map<String, Object> map = new HashMap<>();
		int result = ss.insertInquiryComment(param);
		log.info("resultInsert={}", result);
		
		map.put("s", s);
		
		return map;
	}
	
	@RequestMapping("/selectMyWishList")
	@ResponseBody
	public Map<String, Object> selectMyWishList(@RequestParam("memberId") String memberId,
													  @RequestParam(value="cPage",defaultValue="1") int cPage){
		final int numPerPage = 10;
		List<Map<String, Object>> list = new ArrayList<>();
		
		//페이징바 작업
		int totalContents = ss.selectMyWishListTotalContents(memberId);
		
		//게시글 조회
		list = ss.selectMyWishList(memberId, cPage, numPerPage);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		/*map.put("cPage", cPage);
		map.put("numPerPage", numPerPage);*/
		map.put("totalContents", totalContents);
		String pageBar = new Utils().getOneClickPageBar(totalContents, cPage, numPerPage);
		map.put("pageBar", pageBar);
		
		return map;
	}
	
	@RequestMapping("/deleteWishProduct")
	@ResponseBody
	public Map<String, Integer> deleteWishProduct(@RequestParam("wishProductNo") int wishProductNo,
												  @RequestParam("memberId") String memberId){
		Map<String, String> param = new HashMap<>();
		param.put("wishProductNo", Integer.toString(wishProductNo));
		param.put("memberId", memberId);
		
		int result = ss.deleteWishProduct(param);
		Map<String, Integer> map = new HashMap<>();
		map.put("result", result);
		return map;
	}
	

	//========================== 주영 끝
	
	
	// 현규 시작 ==========================
	
	
	
	//========================== 현규 끝
	
	
}
