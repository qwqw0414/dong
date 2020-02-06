package com.pro.dong.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.pro.dong.member.model.exception.MemberException;
import com.pro.dong.member.model.service.MemberService;
import com.pro.dong.member.model.vo.Member;

@SessionAttributes(value= {"memberLoggedIn"})
@Controller
@RequestMapping("/member")
public class MemberController {
	
	static Logger log = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	MemberService ms;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
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
	
//==========================민호 끝
	
// 하진 시작 ==========================
	
	@RequestMapping("/memberBye.do")
	public ModelAndView memberBye(ModelAndView mav) {
		mav.setViewName("/member/memberBye");
		return mav;
	}
	
	@RequestMapping("/memberByeForm.do")
	public ModelAndView memberBye(@RequestParam("memberId") String memberId,
									@RequestParam("password") String password,
									ModelAndView mav) {
	
		String msg = "";
		String loc = "/";
	
		Member m = ms.selectDeleteOne(memberId);

		if(m != null) {
			
			//비밀번호에 따른 분기			사용자가 입력	db에 있는 비번
			if(passwordEncoder.matches(password, m.getPassword())) {
				int result = ms.byeMember(memberId);{
					msg="회원 탈퇴 성공";
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
		
		Address address = ms.selectAddress(memberId);
		Gson gson = new Gson();
		
		return gson.toJson(address);
	}
	
	//회원 가입
	@RequestMapping("/memberEnrollEnd")
	@ResponseBody
	public String memberEnrollEnd(Member member, Address address) {
		int result = 0;
		try {
//		    비밀번호 암호화
			member.setPassword(passwordEncoder.encode(member.getPassword()));
			log.debug(member.toString());
			result = ms.insertMember(member);
			
			if(result > 0) {
				result = ms.insertAddress(address);
			}else {
				throw new MemberException("회원가입 오류");
			}
			
			if(result > 0) {
				result = ms.insertShop(member.getMemberId());
			}else {
				throw new MemberException("회원가입 오류");
			}
			
			if(result > 0) {
				result = ms.insertPoint(member.getMemberId());
			}else {
				throw new MemberException("회원가입 오류");
			}
			
			if(result > 0) {
				result = ms.insertValid(member.getMemberId());
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
	
	@RequestMapping("/updateMemberEmail")
	@ResponseBody
	public Map<String, Object> updateMemberEmail(HttpSession session, @RequestParam("afterEmail") String afterEmail) {
		Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
		
		log.info("세션 memberId={}",memberLoggedIn.getMemberId());
		log.info("바꿀 afterEmail={}",afterEmail);
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String,String> param = new HashMap<String, String>();
		param.put("memberId", memberLoggedIn.getMemberId());
		param.put("afterEmail", afterEmail);
		
		log.info("map={}",map);
		
		int result = ms.updateMemberEmail(param);
		log.info("result={}",result);
		
		
		if (result>0) {
			map=ms.selectOneMember(memberLoggedIn.getMemberId());
		}
		
		log.info("바뀐멤버객체={}",map);
		
		
		return map;
	}
	
//========================== 현규 끝

	
}
