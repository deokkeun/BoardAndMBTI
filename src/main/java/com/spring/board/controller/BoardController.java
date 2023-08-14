package com.spring.board.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserVo;
import com.spring.common.CommonUtil;

@Controller
@SessionAttributes({"loginMember"})
public class BoardController {
	
	@Autowired 
	boardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,PageVo pageVo) throws Exception{
		
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		List<BoardVo> boardTypeList = new ArrayList<>();
		
		int page = 1;
		int totalCnt = 0;
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}
		
		boardList = boardService.SelectBoardList(pageVo);
		totalCnt = boardService.selectBoardCnt(pageVo);
		boardTypeList = boardService.selectBoardType();
		
		model.addAttribute("boardTypeList", boardTypeList);
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);
		
		return "board/boardList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.POST)
	public Map<String, Object> boardList(Locale locale, Model model,PageVo pageVo
			,@RequestParam(value="checkStr", required=false) String checkStr) throws Exception{
		
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		List<BoardVo> boardTypeList = new ArrayList<>();
		
		int page = 1;
		int totalCnt = 0;
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}
		
		String[] checkArr = null;
		if(checkStr != null) {
			checkArr = checkStr.split(",");
			if(checkArr[0].equals("a00")) {
				System.out.println("checkArr[0]::"+checkArr[0]);
			} else {
				pageVo.setCheckArr(checkArr);
				System.out.println("pageVo.getCheckArr()::"+pageVo.getCheckArr()[0]);
			}
		}
		
		Map<String, Object> map = new HashMap<>();
		
		boardList = boardService.SelectBoardList(pageVo);
		totalCnt = boardService.selectBoardCnt(pageVo);
		
		System.out.println("totalCnt::"+totalCnt);
		
		boardTypeList = boardService.selectBoardType();
		map.put("boardTypeList", boardTypeList);
		map.put("boardList", boardList);
		map.put("totalCnt", totalCnt);
		map.put("pageNo", page);
		
		model.addAttribute("boardTypeList", boardTypeList);
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);
		
		return map;
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		boardVo = boardService.selectBoard(boardType,boardNum);

		List<BoardVo> boardTypeList = new ArrayList<>();
		boardTypeList = boardService.selectBoardType();
		
		model.addAttribute("boardTypeList", boardTypeList);
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model
			,@RequestParam(value="boardType", required=false) String boardType
			,@RequestParam(value="boardNum", required=false) Integer boardNum) throws Exception{
		
		List<BoardVo> boardTypeList = new ArrayList<>();
		boardTypeList = boardService.selectBoardType();
		model.addAttribute("boardTypeList", boardTypeList);
		
		String type = "write";
		if(boardType != null) { // update
			BoardVo boardVo = new BoardVo();
			boardVo = boardService.selectBoard(boardType,boardNum);
			type = "update";
			model.addAttribute("board", boardVo);
			model.addAttribute("type", type);
			model.addAttribute("boardType", boardType);
			model.addAttribute("boardNum", boardNum);
			
		} else { // insert
			model.addAttribute("type", type);
		}
		
		return "board/boardWrite";
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	public String boardWriteAction(Locale locale, BoardVo boardVo, HttpServletRequest request) throws Exception{
		
		System.out.println("boardVo::"+boardVo);
		System.out.println("boardVo::"+boardVo.getBoardVoList().get(0).getBoardTitle());
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		for(BoardVo board : boardVo.getBoardVoList()) {
			if(board.getType() != null) {// (write, update)
				if(board.getType().equals("update")) { // update
					int resultCnt = boardService.boardUpdate(board);
					result.put("update", (resultCnt > 0)?"Y":"N");
				} else { // insert
					if(board.getCreator().equals("")) {
						board.setCreator("SYSTEM");
					}
					int resultCnt = boardService.boardInsert(board);
					result.put("success", (resultCnt > 0)?"Y":"N");
				}
			}
		}
	
		String callbackMsg = CommonUtil.getJsonCallBackString(" ",result);
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardDelete.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model, BoardVo boardVo
			,@RequestParam(value="type", required=false) String type
			,RedirectAttributes ra) throws Exception {
		
		if(type.equals("delete")) {
			int result = boardService.boardDelete(boardVo);
			System.out.println("result::"+result);
		}
		
		return "redirect:/board/boardList.do";
	}
	
	
//	---------------------------- MBTI ---------------------------- 
	
	@RequestMapping(value = "/board/mbtiStart.do", method = RequestMethod.GET)
	public String mbtiTest(Model model
			,@RequestParam Map<String, Object> paramMap
			,@RequestParam(value="boardType0", required=false) String boardType0
			,@RequestParam(value="mbtiType", required=false) String mbtiType) throws Exception {
		
		String[] boardTypeArr = new String[2];
		boardTypeArr = boardType0.split("");
		int fast = Math.min((int)boardTypeArr[0].charAt(0), (int)boardTypeArr[1].charAt(0)); // 69
		int low = Math.max((int)boardTypeArr[0].charAt(0), (int)boardTypeArr[1].charAt(0)); // 73
		String fastWord = String.valueOf((char)fast); // E, N, F, J 빠른 알파벳
		String slowWord = String.valueOf((char)low); // I, S, T, P 느린 알파벳
		String startWord = fastWord+slowWord; // EI, NS, FT, JP 유형
		String endWord = slowWord+fastWord; // IE, SN, TF, PJ 유형
		
		System.out.println("mbtiType::"+mbtiType);
		System.out.println("boardType0::"+boardType0);
		
		List<BoardVo> boardList = new ArrayList<>();
		BoardVo boardVo = new BoardVo();
		String[] mbtiArr = new String[2];

		if(boardType0.equals(startWord) || boardType0.equals(endWord)) {
			if(boardType0.equals("EI") || boardType0.equals("IE")) {
				mbtiArr = new String[] {"NS", "SN"};
			} else if(boardType0.equals("NS") || boardType0.equals("SN")) {
				mbtiArr = new String[] {"FT", "TF"};
			} else if(boardType0.equals("FT") || boardType0.equals("TF") || boardType0.equals("JP") || boardType0.equals("PJ")) {
				mbtiArr = new String[] {"JP", "PJ"};
			}
			mbtiValidate(mbtiArr, boardType0, mbtiType, startWord, endWord, fastWord, slowWord, model, boardVo, boardList, paramMap);
		
		} else {
			if(boardType0.equals("start")) {
				// boardList 시작 데이터 가져오기
				mbtiArr = new String[] {"EI", "IE"};
				boardVo.setMbtiArr(mbtiArr);
				boardList = boardService.selectMbtiBoardList(boardVo);
				model.addAttribute("boardList", boardList);		
			} 
		}
		return "board/mbtiStart";
	}
	
	
//	------------------------- MBTI TYPE 누적 -------------------------
	public void mbtiValidate(String[] mbtiArr, String boardType0, String mbtiType, String startWord, String endWord
							,String fastWord, String slowWord, Model model, BoardVo boardVo
							,List<BoardVo> boardList
							,Map<String, Object> paramMap) throws Exception {

		boardVo.setMbtiArr(mbtiArr);
		boardList = boardService.selectMbtiBoardList(boardVo);
		model.addAttribute("boardList", boardList);
		
		System.out.println("startWord::"+startWord);
		System.out.println("endWord::"+endWord);
		
		int startTypeSum = 0; // E, N, F, J 빠른 알파벳 타입 총점
		int endTypeSum = 0; // I, S, T, P 느린 알파벳 타입 총점
		
		for(int i = 0; i < boardList.size(); i++) {
			boardType0 = String.valueOf(paramMap.get("boardType"+Integer.toString(i))); // 질문사항 게시판 타입( EX) EI, IE, EI, IE, IE )
			int selectNumber = Integer.parseInt((paramMap.get(Integer.toString(i))).toString()) - 4; // 점수 초기화(-3, -2, -1, 0, 1, 2, 3)
			
				if(boardType0.equals(startWord)) { // EI, NS, FT, JP 유형
					System.out.println("boardType0::"+boardType0);
					System.out.println("selectNumber::"+selectNumber);
					if(selectNumber >= 0) { // E, N, F, J 빠른 알파벳 < I, S, T, P 느린 알파벳(느린 알파벳쪽 점수 추가)
						System.out.println("selectNumberABS[type=" + startWord + "(" + slowWord + ")]::"+Math.abs(selectNumber));
						endTypeSum += Math.abs(selectNumber);
					} else { // E, N, F, J 빠른 알파벳 > I, S, T, P 느린 알파벳(빠른 알파벳쪽 점수 추가)
						System.out.println("selectNumberABS[type=" + startWord + "(" + fastWord + ")]::"+Math.abs(selectNumber));
						startTypeSum += Math.abs(selectNumber);
					}
				} else if(boardType0.equals(endWord)) { // IE, SN, TF, PJ 반대 유형
					System.out.println("boardType0::"+boardType0);
					System.out.println("selectNumber::"+selectNumber);
					if(selectNumber >= 0) { // I, S, T, P 느린 알파벳 < E, N, F, J 빠른 알파벳 (빠른 알파벳쪽 점수 추가)
						System.out.println("selectNumberABS[type=" + endWord + "(" + fastWord + ")]::"+Math.abs(selectNumber));
						startTypeSum += Math.abs(selectNumber);
					} else { // I, S, T, P 느린 알파벳 > E, N, F, J 빠른 알파벳 (느린 알파벳쪽 점수 추가)
						System.out.println("selectNumberABS[type=" + endWord + "(" + slowWord + ")]::"+Math.abs(selectNumber));
						endTypeSum += Math.abs(selectNumber);
					}
				}
			} 
		
		// 알파벳 타입별 총점으로 MBTI type 결정
		if(startTypeSum >= endTypeSum) { // E, N, F, J 빠른 알파벳 총점 >= I, S, T, P 느린 알파벳 총점
			mbtiType += fastWord; // mbtiTYpe += 알파벳 빠른순
		
		} else if(startTypeSum < endTypeSum) { // E, N, F, J 빠른 알파벳 총점 < I, S, T, P 느린 알파벳 총점
			mbtiType += slowWord; // mbtiTYpe += 알파벳 느린순
		}
		model.addAttribute("mbtiType", mbtiType);
		
		System.out.println("--------mbtiTypeResult--------::"+mbtiType);
		System.out.println("startTypeSum::"+startTypeSum);
		System.out.println("endTypeSum::"+endTypeSum);
		
		// MBTI 완성 되면 결과 화면으로 가도록 boardList 비어있는 값 전달
		if(mbtiType.length() == 4) { 
			List<BoardVo> emptyBoardList = new ArrayList<>();
			model.addAttribute("boardList", emptyBoardList);	
		}
	}

	
//	------------------------- login -------------------------
	@RequestMapping(value = "/board/login.do", method = RequestMethod.GET)
	public String login() throws Exception{
		return "board/login";
	}
	
	@RequestMapping(value = "/board/login.do", method = RequestMethod.POST)
	public String loginConfirm(Model model, UserVo loginMember, RedirectAttributes ra) throws Exception{
		
		loginMember = boardService.login(loginMember);
		String message = null;
		
		if(loginMember != null) {
			message = loginMember.getUserName()+"님 로그인을 환영합니다.";
			ra.addFlashAttribute("message", message);
			ra.addFlashAttribute("loginMember", loginMember);
			return "redirect:/board/boardList.do";
		}
		message = "아이디와 비밀번호를 다시 확인해주세요.";			
		ra.addFlashAttribute("message", message);
		return "redirect:/board/login.do";
	}
		
//	------------------------- join -------------------------
	@RequestMapping(value = "/board/join.do", method = RequestMethod.GET)
	public String join(Model model) throws Exception{
		
		List<UserVo> phoneList = new ArrayList<>();
		phoneList = boardService.phoneList();
		model.addAttribute("phoneList", phoneList);
		System.out.println("phoneList::"+phoneList);
		
		return "board/join";
	}
		
	@RequestMapping(value = "/board/join.do", method = RequestMethod.POST)
	public String joinConfirm(Model model, UserVo inputMember, RedirectAttributes ra) throws Exception{
		
		
		String userName = uni2ksc(inputMember.getUserName());
		inputMember.setUserName(userName);
		System.out.println("userName::"+userName);
		
		int result = boardService.join(inputMember);
		System.out.println("result::"+result);
		
		String message = null;
		
		if(result > 0) {
			message = inputMember.getUserName()+"님 회원가입을 축하합니다.";
		} else {
			message = "회원 가입중 오류 발생: 관리자에게 문의해주세요.";
		}
		ra.addFlashAttribute("message", message);
		
		return "redirect:/board/boardList.do";
	}
	
//	------------------------- logout -------------------------
	@RequestMapping(value = "/board/logout.do", method = RequestMethod.GET)
	public String logout(SessionStatus status, RedirectAttributes ra) throws Exception{
		ra.addFlashAttribute("message", "로그아웃 되었습니다.");
		status.setComplete();
		return "redirect:/board/boardList.do";
	}
	
//	------------------------- userIdDupCheck -------------------------
	@ResponseBody
	@RequestMapping(value = "/board/userIdDupCheck.do", method = RequestMethod.POST)
	public int userIdDupCheck(@RequestParam(value="userId", required=false) String userId) throws Exception{
		return boardService.userIdDupCheck(userId);
	}

	
	
	// 유니코드를 한글코드로 변환
	protected String uni2ksc (String Unicodestr) throws UnsupportedEncodingException {
	return new String (Unicodestr.getBytes("8859_1"),"KSC5601");
	}
	
	// 한글코드를 유니코드로 변환
	protected String ksc2uni(String str) throws UnsupportedEncodingException {
	return new String( str.getBytes("KSC5601"), "8859_1");
	}
	
	
}
