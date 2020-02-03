package com.pro.dong.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.pro.dong.member.model.exception.MemberException;
import com.pro.dong.member.model.service.MemberService;
import com.pro.dong.member.model.vo.Address;
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
	@RequestMapping("/chargePoint.do")
	public void chargePoint() {
		
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
		
		
		int result = ms.byeMember(memberId);
		 
		log.debug("memberId={}",memberId);
		String msg = "";
		String loc = "/";
	
		if(result < 0) {
			msg = "회원 탈퇴 실패";
		}
		else {
			Member m = ms.selectDeleteOne(memberId);
			log.debug("member객체야@@@@@@@@@@@@@@={}",m);
			
			//비밀번호에 따른 분기				사용자가 입력	db에 있는 비번
			if(passwordEncoder.matches(password, m.getPassword())) {
				msg="회원 탈퇴 성공";
			}
			else {
				msg="비밀번호가 틀렸습니다.";
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
	public ModelAndView memberLoginId(@RequestParam String memberId, @RequestParam String password,
			ModelAndView mav, HttpSession session) {

	Member m = ms.selectLoginMember(memberId);
	log.debug("m={}", m);
	
	String msg = "";
	String loc = "/";
	if(m == null) {
		msg = "존재하지 않는 아이디입니다.";
		loc = "/member/memberLogin.do";
	}
	else {
		
		/*String enp = passwordEncoder.encode(m.getPassword());
		m.setPassword(enp);
		log.debug("enp={}",enp);*/
		
		if(passwordEncoder.matches(password, m.getPassword())) {
			msg = "로그인 성공";
			mav.addObject("memberLoggedIn", m);
		}
		else {
			msg = "비밀번호가 틀렸습니다.";
			loc = "/member/memberLogin.do";
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
	public void findPassword() {
		
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
	
	//회원 가입
	@RequestMapping("/memberEnrollEnd")
	@ResponseBody
	public String memberEnrollEnd(Member member, Address address) {
		int result = 0;
		try {
//		    비밀번호 암호화
			member.setPassword(passwordEncoder.encode(member.getPassword()));
			
			result = ms.insertMember(member);
			
			if(result > 0) {
				result = ms.insertAddress(address);
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
	public String findId() {
		log.debug("jsp 연결 성공");
		
		return "member/findId";
	}
	
	
	@RequestMapping("/findIdEnd")
	@ResponseBody
	public String findIdEnd(@RequestParam("memberName") String name, @RequestParam("memberEmail") String email) {
		
		Map<String, String> map = new HashMap<>();
		map.put("name", name);
		map.put("email", email);
		
		//Member m = ms.selectMemberByName(map);
		
		return ""+ms.selectMemberByName(map);
	}
	
//========================== 주영 끝
	
// 현규 시작 ==========================
	@RequestMapping("/memberView.do")
	public void memberView() {
		
	}
	
//========================== 현규 끝

	
}
