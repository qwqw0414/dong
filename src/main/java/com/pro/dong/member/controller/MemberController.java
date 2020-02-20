package com.pro.dong.member.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.pro.dong.common.email.EmailHandler;
import com.pro.dong.common.email.TempKey;
import com.pro.dong.common.util.Utils;
import com.pro.dong.member.model.exception.MemberException;
import com.pro.dong.member.model.service.MemberService;
import com.pro.dong.member.model.vo.Member;
import com.pro.dong.product.model.vo.OrderList;
import com.pro.dong.shop.model.vo.Shop;

@SessionAttributes(value= {"memberLoggedIn"})
@Controller
@RequestMapping("/member")
public class MemberController {
	static Map<String,String> loginstatus = new HashMap<>();
	static Logger log = LoggerFactory.getLogger(MemberController.class);
	static Gson gson = new Gson();
	
	@Autowired
	MemberService ms;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Inject
	private JavaMailSender mailSender;
	
// 민호 시작 ==========================
	@RequestMapping("/updatePoint")
	@ResponseBody
	public Map<String, String> updatePoint(ModelAndView mav, @RequestParam("pointAmount") int pointAmount, @RequestParam("memberId") String memberId, HttpServletRequest request) {
		log.debug("pointAmount={}",pointAmount);
		log.debug("memberId={}",memberId);
		Map<String, String> map = new HashMap<>();
		map.put("pointAmount", pointAmount+"");
		map.put("memberId", memberId);
		int result = ms.updatePoint(map);
		log.debug("result",result);
		Map<String, String> memberInfo = null;
		if(result>0) {
			Member memberLoggedIn = (Member)request.getSession().getAttribute("memberLoggedIn");
			memberInfo = ms.selectMemberPoints(memberLoggedIn);
		} 
		log.debug("memberInfo={}",memberInfo);
		return memberInfo;
	}
	@RequestMapping("/orderListView.do")
	public void orderListView() {
		
	}
	@RequestMapping("/loadOrderList")
	@ResponseBody
	public Map<String, Object> loadOrderList(HttpSession session, @RequestParam(value="cPage", defaultValue="") int cPage){
		Member memberLoggedIn = (Member) session.getAttribute("memberLoggedIn");
		String memberId = memberLoggedIn.getMemberId();
		Map<String, String> param = new HashMap<>();
		Map<String, Object> result = new HashMap<>();
		param.put("memberId", memberId);
		int numPerPage = 10;
		
		int totalContents = ms.orderListTotalContents(param);
		
		List<OrderList> orderList = ms.loadOrderList(param,cPage,numPerPage);
		String pageBar = new Utils().getOneClickPageBar(totalContents, cPage, numPerPage);
		result.put("orderList", orderList);
		result.put("pageBar", pageBar);
		return result;
	}
	@RequestMapping("/loadSaleList")
	@ResponseBody
	public Map<String, Object> loadSaleList(HttpSession session, @RequestParam(value="cPage", defaultValue="") int cPage){
		Member memberLoggedIn = (Member) session.getAttribute("memberLoggedIn");
		String memberId = memberLoggedIn.getMemberId();
		Shop shop = ms.getShopName(memberId);
		String shopName = shop.getShopName();
		Map<String, String> param = new HashMap<>();
		Map<String, Object> result = new HashMap<>();
		param.put("memberId", memberId);
		param.put("shopName", shopName);
		
		int numPerPage = 10;
		int totalContents = ms.saleListTotalContents(param);
		List<OrderList> saleList = ms.loadSaleList(param,cPage,numPerPage);
		String pageBar = new Utils().getOneClickPageBar(totalContents, cPage, numPerPage);
		result.put("saleList", saleList);
		result.put("pageBar", pageBar);
		return result;
	}
	
	@RequestMapping("/updateReceive")
	@ResponseBody
	public Map<String, Object> updateReceive(@RequestParam("orderNo")int orderNo, @RequestParam("productNo")int productNo,
			@RequestParam("price")int price, @RequestParam("shopName")String shopName){
		
		Map<String, String> param = new HashMap<>();
		param.put("shopName", shopName);
		List<Map<String, String>> list = ms.selectMemberIdByShopName(param);
		log.debug("list={}",list);
		String memberId = list.get(0).get("MEMBER_ID");
		
		log.debug("memberId={}",memberId);
		Map<String, Object> resultMap = new HashMap<>();
		int result = ms.updateReceive(orderNo);
		int checkOrderStatus = ms.checkOrderStatus(orderNo);
		int updateProductStatus = 0;
		int chargePoint = 0;
		if(checkOrderStatus>0) {
			updateProductStatus = ms.updateProductStatus(productNo);
			if(updateProductStatus>0) {
				param.put("pointAmount", price+"");
				param.put("memberId", memberId);
				chargePoint = ms.updatePoint(param);
			}
		}
		resultMap.put("result", result);
		resultMap.put("checkOrderStatus", checkOrderStatus);
		resultMap.put("updateProductStatus", updateProductStatus);
		resultMap.put("chargePoint", chargePoint);
		
		return resultMap;
		
	}
	@RequestMapping("/updateSend")
	@ResponseBody
	public Map<String, Object> updateSend(@RequestParam("orderNo")int orderNo, @RequestParam("productNo")int productNo,
			@RequestParam("price")int price, HttpSession session){
		Member memberLoggedIn = (Member) session.getAttribute("memberLoggedIn");
		String memberId = memberLoggedIn.getMemberId();
		
		Map<String, Object> resultMap = new HashMap<>();
		Map<String, String> param = new HashMap<>();
		param.put("pointAmount", price+"");
		param.put("memeberId", memberId);
		int result = ms.updateSend(orderNo);
		int checkOrderStatus = ms.checkOrderStatus(orderNo);
		int updateProductStatus = 0;
		int chargePoint = 0;
		if(checkOrderStatus>0) {
			updateProductStatus = ms.updateProductStatus(productNo);
			if(updateProductStatus>0) {
				chargePoint = ms.updatePoint(param);
			}
		}
		resultMap.put("result", result);
		resultMap.put("checkOrderStatus", checkOrderStatus);
		resultMap.put("updateProductStatus", updateProductStatus);
		resultMap.put("chargePoint", chargePoint);
		return resultMap;
	}
//==========================민호 끝
	
// 하진 시작 ==========================
	
	@RequestMapping("/memberBye.do")
	public ModelAndView memberBye(ModelAndView mav,SessionStatus sessionStatus) {
		mav.setViewName("/member/memberBye");
		return mav;
	}
	
	@RequestMapping("/memberByeForm.do")
	public ModelAndView memberBye(@RequestParam("memberId") String memberId,
									@RequestParam("password") String password,
									ModelAndView mav,
									SessionStatus sessionStatus) {
	
		String msg = "";
		String loc = "/";
	
		Member m = ms.selectDeleteOne(memberId);

		if(m != null) {
			
			//비밀번호에 따른 분기			사용자가 입력	db에 있는 비번
			if(passwordEncoder.matches(password, m.getPassword())) {
				int result = ms.byeMember(memberId);{
					msg="회원 탈퇴 성공";
					if(!sessionStatus.isComplete()) {
						sessionStatus.setComplete();
					}
				}
			}
			else {
				msg="비밀번호가 틀렸습니다.";
				loc="/member/memberBye.do";
			}
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("common/msg");
		}
		
		return mav;
	}
	
	
	
	
//========================== 하진 끝
	
// 근호 시작 ==========================
	
	@RequestMapping("/memberLogin.do")
	public void memberLogin() {
		
	}
	@RequestMapping("/memberLoginId.do")
	public ModelAndView memberLoginId(@RequestParam(value="loginMemberId") String memberId, @RequestParam(value="loginPassword") String password,
			ModelAndView mav, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
	Member m = ms.selectLoginMember(memberId);
	log.debug("m={}", m);
	
	String msg = "";
	String loc = "/";
	if(m == null) {
		msg = "존재하지 않는 아이디입니다.";
		loc = "/";
	}
	else {
		
		/*String enp = passwordEncoder.encode(m.getPassword());
		m.setPassword(enp);
		log.debug("enp={}",enp);*/
		
		if(passwordEncoder.matches(password, m.getPassword())) {
			msg = "로그인 성공";
			mav.addObject("memberLoggedIn", m);
			
			
			
			loginstatus.put(session.getId(), m.getMemberId());
			
			System.out.println("===================================="+loginstatus+"==========================================");
			
			
			
			

			//아이디저장
			String saveId = request.getParameter("saveId");
			log.debug("saveId={}",saveId);
			//체크한경우
			if(saveId != null) {
				Cookie c = new Cookie("saveId", memberId);
				c.setMaxAge(7*24*60*60);//7일후 소멸함
				c.setPath("/");
//				request.setAttribute("c", c);
				response.addCookie(c);
				log.debug("ccccccc={}", c);
				
			}
			//체크하지 않은 경우
			else {
				Cookie c = new Cookie("saveId", memberId);
				c.setMaxAge(0);
				c.setPath("/");
				response.addCookie(c);
				log.debug("ccccccc={}", c);
			}
			
		}
		else {
			msg = "비밀번호가 틀렸습니다.";
			loc = "/";
		}
	}
	log.debug("password={}",password);
	//2.view모델처리
	mav.addObject("msg", msg);
	mav.addObject("loc", loc);
	
	mav.setViewName("common/msg");
	
	return mav;
	}
	@RequestMapping("/memberLogOut.do")
	public String memberLogOut(SessionStatus sessionStatus) {
		if(!sessionStatus.isComplete()) {
			sessionStatus.setComplete();
		}
		return "redirect:/";
	}
	
	@RequestMapping("/emailAuth.do")
	@ResponseBody
	public String emailAuth(Model model, 
							HttpServletRequest request,
							@RequestParam(value="email") String email) throws MessagingException, UnsupportedEncodingException {
		
		Random r = new Random();
		int dice = r.nextInt(4589362)+49311; //인증번호 랜덤 생성
		HttpSession session = request.getSession(true);
//		Member m = ms.emailAuth(email);
		String authCode = String.valueOf(dice);
		session.setAttribute("authCode", authCode);
		
		log.debug("email121212={}",email);

		//메일 보내기
		EmailHandler sendMail = new EmailHandler(mailSender);
		sendMail.setSubject("[홈페이지 이메일 인증]");
		sendMail.setText(new StringBuffer().append("<h1>[이메일 인증]</h1>")
				.append("이메일 인증 번호: ["+authCode+"] 입니다.")
				.toString());
		/*sendMail.setText("<h1>메일인증</h1>" +
						 "<a href='http://localhost:9090/dong/verify.do?email=" +email +
						 "authKey="+authKey+
						 "' target='_blank'>이메일 인증 확인</a>");*/
		sendMail.setFrom("dhrmsghss@gmail.com", "관리자");
		sendMail.setTo(email);
		sendMail.send();
		
		if(email == null) {
			email = "null";
		}
		
		return email;
	}
	
	//인증 번호 입력
	@RequestMapping(value="/verify.do")
	@ResponseBody
	public String signSuccess(
							  @RequestParam(value="authKey")String authKey,
							  HttpSession session,
							  @RequestParam(value="email") String email,
							  HttpServletRequest request, Model model) {
		
		String originalKey = (String)session.getAttribute("authCode");
		log.debug("emaillllllllllll={}",email);
		log.debug("authKeyyyyyyyy={}", authKey);
		String msg = "";
		if(originalKey.equals(authKey)) {
			msg ="true";
		}
		else {
			msg = "false";
		}
		
		return msg;
	}
	//이메일 중복검사
	@RequestMapping("/emailDuplicate")
	@ResponseBody
	public String emailDuplicate(@RequestParam(value="email") String email) {
		log.debug("email={}",email);
		int result = ms.emailDuplicate(email);
		log.debug("result={}",result);
		return result+"";
		
	}
	
	//인증 번호 입력/이메일 수정
	@RequestMapping(value="/emailUpdate")
	@ResponseBody
	public Map<String, String> emailUpdate(
							  @RequestParam(value="authKey")String authKey,
							  HttpSession session,
							  @RequestParam(value="email") String email,
							  HttpServletRequest request, Model model) {
		String originalKey = (String)session.getAttribute("authCode");
		log.debug("emaillllllllllll={}",email);
		log.debug("authKeyyyyyyyy={}", authKey);
		
		Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");

		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, String> param = new HashMap<>();
		param.put("memberId", memberLoggedIn.getMemberId());
		param.put("email", email);
		
		
		log.debug("parammmmmmm+{}"+param);
		log.debug("originalKey={}"+originalKey);
		Map<String, String> m = new HashMap<>();
		
		int result = 0;
		if(originalKey.equals(authKey)) {
			result = ms.updateMemberEmail(param);
			if(result > 0) {
				map=ms.selectOneMember(memberLoggedIn.getMemberId());
				log.debug("resulttttttttt="+result);
			}
		}
		else {
		}
		log.debug("map={}",map);
		String newEmail = (String) map.get("EMAIL");
		m.put("email", newEmail);
		m.put("result", result+"");

		
		log.debug("newEmail+{}",newEmail);	
		
		return m;
	}
	//주소수정
		@RequestMapping("/updateAddress")
		@ResponseBody
		public Map<String, Object> updateAddress(@RequestParam(value="sido") String sido,
												 @RequestParam(value="sigungu") String sigungu,
												 @RequestParam(value="dong") String dong,
												 HttpSession session){
			
			Member memberLoggedIn = (Member) session.getAttribute("memberLoggedIn");
			
			Map<String, Object> map = new HashMap<String, Object>();
			Map<String,String> param = new HashMap<String, String>();
			param.put("memberId", memberLoggedIn.getMemberId());
			param.put("sido", sido);
			param.put("sigungu", sigungu);
			param.put("dong", dong);
			
			log.debug("param={}",param);
			int result = ms.updateAddress(param);
			log.debug("resultttt={}",result);

			if(result > 0) {
				map = ms.selectOneMember(memberLoggedIn.getMemberId());
			}
			log.debug("mappppp={}",map);
			
			return map;
		}
//========================== 근호 끝
	
// 지은 시작 ==========================
	@RequestMapping("/findPassword.do")
	public void findPassword() {}
	
	@RequestMapping("/findPasswordEnd")
	@ResponseBody
	public int findPasswordEnd(@RequestParam String memberId, @RequestParam String email ) {
		
		log.debug(memberId + "," + email);
		
		Member m = new Member();
		m.setMemberId(memberId);
		m.setEmail(email);
		
		int count = ms.selectMember(m);
		log.debug("memberId",memberId);
		log.debug("email",email);
		
		return count;
	}
	
	@RequestMapping("/passwordUpdate")
	@ResponseBody
	public String passwordUpdate(Member member) {
		
		//비밀번호 암호화
		log.debug(member.toString());
		
		member.setPassword(passwordEncoder.encode(member.getPassword()));
		
		int result = ms.passwordUpdate(member);
		
		return result+"";
	}
//========================== 지은 끝
	
// 예찬 시작 ==========================
	@RequestMapping("/memberEnroll.do")
	public void memberEnroll() {}
	
	//아이디 중복검사
	@RequestMapping("/idDuplicate")
	@ResponseBody
	public String idDuplicate(String memberId) {
		
		log.debug("memberId="+memberId);
		
		int result = ms.idDuplicate(memberId);
		
		return result+""; 
	}
	
//	주소 가져오기
	@RequestMapping(value="/selectAddress", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String selectAddress(String memberId) {
		
		Member member= ms.selectAddress(memberId);
		Gson gson = new Gson();
		
		return gson.toJson(member);
	}
	
	//회원 가입
	@RequestMapping("/memberEnrollEnd")
	@ResponseBody
	public String memberEnrollEnd(Member member) throws MessagingException, UnsupportedEncodingException {
		int result = 0;
		try {
//		    비밀번호 암호화
			member.setPassword(passwordEncoder.encode(member.getPassword()));
			log.debug(member.toString());
			
			result = ms.insertMember(member);
			
			if(result > 0) {
				result = ms.insertShop(member.getMemberId());
			}else {
				throw new MemberException("회원가입 오류");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return result+"";
	}
	
//========================== 예찬 끝
	
// 주영 시작 ==========================
	@RequestMapping("/findId.do")
	public void findId() {
		
	}
	
	@RequestMapping(value="/findIdEnd", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String findIdEnd(Member member) {
		
		log.debug(member.toString());
		
		Member m = ms.selectMemberByName(member);
		log.debug("m={}",m);
		Gson gson = new Gson();
		return gson.toJson(m);
	}
	
//========================== 주영 끝
	
// 현규 시작 ==========================
	@RequestMapping("/memberView.do")
	public ModelAndView memberView(HttpSession session, ModelAndView mav) {
		Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
		mav = new ModelAndView();
		Map<String, Object> map = ms.selectOneMember(memberLoggedIn.getMemberId());
		mav.addObject("member", map);
		log.debug("mav={}",mav);
		mav.setViewName("member/memberView");
		return mav;
	}
	
	@RequestMapping("/updateMemberName")
	@ResponseBody
	public Map<String, Object> updateMemberName(HttpSession session, @RequestParam("afterName") String afterName) {
		Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
		
		log.info("세션 memberId={}",memberLoggedIn.getMemberId());
		log.info("바꿀 membername={}",afterName);

		
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String,String> param = new HashMap<String, String>();
		param.put("memberId", memberLoggedIn.getMemberId());
		param.put("afterName", afterName);
		
		log.info("map={}",map);
		
		int result = ms.updateMemberName(param);
		log.info("result={}",result);
		
		
		if (result>0) {
			map=ms.selectOneMember(memberLoggedIn.getMemberId());
		}
				
		log.info("바뀐멤버객체={}",map);
		
		
		return map;
	}
	@RequestMapping("/updateMemberPhone")
	@ResponseBody
	public Map<String, Object> updateMemberPhone(HttpSession session, @RequestParam("afterPhone") String afterPhone) {
		Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
		
		log.info("세션 memberId={}",memberLoggedIn.getMemberId());
		log.info("바꿀 afterPhone={}",afterPhone);
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String,String> param = new HashMap<String, String>();
		param.put("memberId", memberLoggedIn.getMemberId());
		param.put("afterPhone", afterPhone);
		
		log.info("map={}",map);
		
		int result = ms.updateMemberPhone(param);
		log.info("result={}",result);
		
		
		if (result>0) {
			map=ms.selectOneMember(memberLoggedIn.getMemberId());
		}
		
		log.info("바뀐멤버객체={}",map);
		
		
		return map;
	}
	
	
	
	@RequestMapping("/memberChargingDetails.do")
	public void memberChargingDetails() {}
	
	
	
	@ResponseBody
	@RequestMapping(value="/selectAllDetails", produces="text/plain;charset=UTF-8")
	public String memberChargingDetails(HttpSession session, @RequestParam("cPage") int cPage) {
		Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
		List<Map<String,String>>list = null;
		int numPerPage=10;
		
		list = ms.selectAllDetails(memberLoggedIn.getMemberId(),cPage,numPerPage);
		
		int totalContents = ms.countDetails(memberLoggedIn.getMemberId());
		String pageBar = new Utils().getOneClickPageBar(totalContents, cPage, numPerPage);
		
		Map<String,Object> result = new HashMap<>();
		result.put("list", list);
		result.put("pageBar", pageBar);
		
		
		return gson.toJson(result)+"";
	}
	
	@ResponseBody
	@RequestMapping(value="/selectByOption", produces="text/plain;charset=UTF-8")
	public String selectByOption(HttpSession session, @RequestParam("start") String start, @RequestParam("end") String end,
					@RequestParam("option") String option, @RequestParam("cPage") int cPage) {
		log.info("시작날짜={}",start);
		log.info("종료날짜={}",end);
		log.info("옵션={}",option);
		
		Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
		
		Map<String, String> param = new HashMap<>();
		param.put("memberId",memberLoggedIn.getMemberId());
		param.put("start", start);
		param.put("end", end+"235959");
//		param.put("end", end);
		param.put("option", option);
		
		List<Map<String,String>>list = null;
		int numPerPage=10;
		
		
		list = ms.selectDetailsByOption(param,cPage,numPerPage);
		
		
		
		
		
		int totalContents = ms.countDetailsByOption(param);
		String pageBar = new Utils().getOneClickPageBar(totalContents, cPage, numPerPage);
		
		log.debug("리스트으응으으응={}",list);
		
		
		
		Map<String,Object> result = new HashMap<>();
		result.put("list", list);
		result.put("pageBar", pageBar);
		
		
		return gson.toJson(result)+"";
	}
	
	
	
	
	
	
	
	
//========================== 현규 끝

	
}
