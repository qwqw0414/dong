package com.pro.dong.board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.pro.dong.board.model.service.BoardService;
import com.pro.dong.board.model.vo.Attachment;
import com.pro.dong.board.model.vo.Board;
import com.pro.dong.board.model.vo.BoardCategory;
import com.pro.dong.common.util.Utils;
import com.pro.dong.member.model.vo.Member;

import sun.java2d.pipe.SpanShapeRenderer.Simple;


@RequestMapping("/board")
@Controller
public class BoardController {
	
	static Logger log = LoggerFactory.getLogger(BoardController.class);
	@Autowired
	BoardService bs;
	
	
	// 민호 시작 ==========================
	@RequestMapping("/boardList.do")
	public ModelAndView boardList(ModelAndView mav) {
		
		List<BoardCategory> boardCategoryList = bs.selectBoardCategory();
		List<Board> boardList = bs.selectBoardList();//인기글 조회
		log.debug("listBoard야야@@@@@@@@@@@@@@@@@@@@={}",boardList);
		mav.addObject("boardCategoryList",boardCategoryList);
		mav.addObject("boardList",boardList);
		mav.setViewName("/board/boardList");
		return mav;
		
	}
	
	@RequestMapping("/loadBoardList")
	@ResponseBody
	public Map<String, Object> loadBoardList(@RequestParam(value="searchType", defaultValue="")String searchType, @RequestParam(value="searchKeyword",defaultValue="") String searchKeyword, @RequestParam(value="boardCategory",defaultValue="") String boardCategory,@RequestParam(value="cPage",defaultValue="1") int cPage, @RequestParam("memberId") String memberId){
		log.debug("boardCategory={}",boardCategory);
		final int numPerPage = 10;
		Map<String, Object> result = new HashMap<>();
		// 주소 조회
		Member member = bs.getMemberByMemberId(memberId);
//		Address addr = bs.getAddrByMemberId(memberId);
		// 게시판 카테고리 조회
		List<BoardCategory> boardCategoryList = bs.selectBoardCategory();
		// 공지글 조회
		List<Board> noticeList = bs.selectBoardNotice();
		// 파라미터 생성
		Map<String, String> param = new HashMap<>();
		String sido = member.getSido();
		String sigungu = member.getSigungu();
		String dong = member.getDong();
		param.put("sido", sido);
		param.put("sigungu", sigungu);
		param.put("dong", dong);
		param.put("boardCategory", boardCategory);
		param.put("searchType", searchType);
		param.put("searchKeyword", searchKeyword);
		// 페이징바 작업
		int totalContents = bs.selectBoardTotalContents(param);
		// 게시글 조회
		List<Board> list = bs.loadBoardList(cPage, numPerPage, param);
		// 넘겨줄map에 담기
		result.put("sido", sido);
		result.put("sigungu", sigungu);
		result.put("dong", dong);
		result.put("list", list);
		result.put("boardCategoryList", boardCategoryList);
		result.put("noticeList", noticeList);
		result.put("cPage", cPage);
		result.put("numPerPage", numPerPage);
		result.put("totalContents", totalContents);
		String function = "loadBoardList('"+searchType+"','"+searchKeyword+"','"+boardCategory+"',";
		String pageBar = Utils.getAjaxPageBar(totalContents, cPage, numPerPage, function);
		result.put("pageBar", pageBar);
		return result;
	}
	//==========================민호 끝
		
	// 하진 시작 ==========================
		
	//========================== 하진 끝
		
	// 근호 시작 ==========================
	@RequestMapping("/writeBoard.do")
	public ModelAndView writeBoard(ModelAndView mav) {
		List<BoardCategory> boardCategoryList = bs.selectBoardCategory();
		mav.addObject("boardCategoryList",boardCategoryList);
		mav.setViewName("/board/writeBoard");
		return mav;
	}
	
	@RequestMapping("/writeBoardEnd.do")
	public ModelAndView writeBoardEnd(ModelAndView mav, Board board, @RequestParam(value="boardCategory") String boardCategory,
									  @RequestParam(value="upFile", required=false) MultipartFile[] upFile,
									  HttpServletRequest request) {
		
		String saveDirectory = request.getServletContext().getRealPath("/resources/upload/board");
		List<Attachment> attachList = new ArrayList<>();
		
		log.debug("board={}", board);
		board.setCategoryId(boardCategory);
		//동적으로 directory 생성
		File dir = new File(saveDirectory);
		if(dir.exists() == false)
			dir.mkdir();
		
		//MultipartFile객체 파일업로드 처리
		for(MultipartFile f : upFile) {
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
				
				Attachment attach = new Attachment();
				attach.setOriginalFileName(originalFileName);
				attach.setRenamedFileName(renamedFileName);
				attachList.add(attach);
				
			}
		}
		log.debug("attachList={}", attachList);
		//업로드 처리 끝
		
		//2.업무로직
		int result = bs.insertBoard(board, attachList);
		
		//3.view
		mav.addObject("msg", result>0?"등록성공!":"등록실패!");
		mav.addObject("loc", "/board/boardList.do");
		mav.setViewName("common/msg");
		
		return mav;
	}
	/*public String writeBoardEnd(Model model, Board board) {
		
		int result = bs.insertBoard(board);
		log.debug("board={}", board);
		model.addAttribute("msg", result>0?"등록성공!":"등록실패!");
		model.addAttribute("loc", "/board/boardList.do");
		
		log.debug("result={}",result);
		
		return "common/msg";
	}*/
	//========================== 근호 끝
		
	// 지은 시작 ==========================
	@RequestMapping("/boardView")
	public String boardView(Model model, @RequestParam("boardNo") int boardNo) {
		
		Board board = bs.selectOneBoard(boardNo);
		log.debug("boardNo="+boardNo);
		List<Attachment> attachmentList = bs.selectAttachmentList(boardNo);
		int readCount = bs.boardInCount(boardNo);
		log.debug("readCount="+readCount);
		
		model.addAttribute("board", board);
		model.addAttribute("attachmentList", attachmentList);
		
		return "board/boardView";
		
	}
	
	@RequestMapping("/boardUpdateView.do")
	public ModelAndView boardUpdate(ModelAndView mav, Board board) {
		
		
		
		return mav;
	}
	
	@RequestMapping("/boardDelete.do")
	public String boardDelete(ModelAndView mav, int boardNo) {
		int result = bs.deleteBoard(boardNo);
		log.debug("boardDelete@boardNo="+boardNo);
		
		String msg = "";
		if(result>0) {
			log.debug("board삭제 성공!!!!!");
			msg="게시물 삭제에 성공하였습니다!";
			
		}else {
			log.debug("board삭제 실패!!!");
			msg="게시물 삭제에 실패하였습니다!";
		}
		
		
		return "board/boardList";
	}
	
	

	
	

	//========================== 지은 끝
		
	// 예찬 시작 ==========================
		
	//========================== 예찬 끝
		
	// 주영 시작 ==========================
		
	//========================== 주영 끝
		
	// 현규 시작 ==========================

	//========================== 현규 끝


}
