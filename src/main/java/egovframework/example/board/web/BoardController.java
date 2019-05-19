package egovframework.example.board.web;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.example.board.service.BoardService;
import egovframework.example.board.service.BoardVO;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class BoardController {

	/** BoardService */
	@Resource(name = "boardService")
	private BoardService boardService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@RequestMapping(value = "/list.do")
	public String list(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model) throws Exception {
	
		/** EgovPropertyService.sample */
		boardVO.setPageUnit(propertiesService.getInt("pageUnit"));
		boardVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());

		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> list = boardService.selectBoardList(boardVO);
		model.addAttribute("resultList", list);

		int totCnt = boardService.selectBoardListTotCnt(boardVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "board/list";
	}
	@RequestMapping(value = "/mgmt.do", method = RequestMethod.GET)
	public String mgmt(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model, HttpServletRequest request ) throws Exception {    //등록화면 로딩
	
		SimpleDateFormat sdf = new SimpleDateFormat();
		Calendar c1 = Calendar.getInstance();
		String strToday = sdf.format(c1.getTime());
		System.out.println("Today="+ strToday);
		
		boardVO = boardService.selectBoard(boardVO);
		
		boardVO.setIndate(strToday);
		boardVO.setWriter(request.getSession().getAttribute("userId").toString() );
		boardVO.setWriterNm(request.getSession().getAttribute("userName").toString() );

		model.addAttribute("boardVO", boardVO);
		
		return "board/mgmt";
	}
	@RequestMapping(value = "/mgmt.do", method = RequestMethod.POST)
	public String mgmt2(@ModelAttribute("boardVO") BoardVO boardVO, @RequestParam("mode") String mode, ModelMap model) throws Exception {   //저장버튼 클릭 후
		
		if ("add".equals(mode)) { 
			boardService.insertBoard(boardVO);
		} else if("mod".equals(mode)) {
			boardService.updateBoard(boardVO);
		} else if("del".equals(mode)){
			boardService.deleteBoard(boardVO);
		}
		
		System.out.println("insert Finished");
		return "redirect:/list.do";
	}
	@RequestMapping(value = "/view.do")
	public String view(@ModelAttribute("boardVO") BoardVO boardVO,ModelMap model, HttpServletRequest request) throws Exception {

		boardService.updateBoardCount(boardVO);
		boardVO = boardService.selectBoard(boardVO);
		model.addAttribute("boardVO", boardVO);
		
		List<?> list = boardService.selectReplyList(boardVO);
		model.addAttribute("resultList", list);
		
		return "board/view";
	}
	
	@RequestMapping(value = "/reply.do")
	public String reply(@ModelAttribute("boardVO") BoardVO boardVO,ModelMap model, HttpServletRequest request) throws Exception {
		
		
		boardService.insertReply(boardVO);
		model.addAttribute("boardVO", boardVO);
		
		return "redirect:/view.do?idx="+boardVO.getIdx() ;
	}
	
	@RequestMapping(value = "/login.do")
	public String login(@RequestParam("user_id") String user_id, @RequestParam("password") String password, ModelMap model, HttpServletRequest request ) throws Exception {
		
		System.out.println("user_id: " + user_id);
		System.out.println("password: " + password);
		
/*		String aa = request.getParameter("user_id");
		String bb = request.getParameter("password");
		System.out.println("user_id / passwd is " + aa + " / " + bb);*/
		
		BoardVO boardVO = new BoardVO();
		boardVO.setUser_id(user_id);
		boardVO.setPassword(password);
		String user_name = boardService.selectLoginCheck(boardVO);
		
		if (user_name != null && user_name != "" ) {
			System.out.println(user_name);
			request.getSession().setAttribute("userId", user_id);
			request.getSession().setAttribute("userName", user_name);
		}
		else {
			request.getSession().setAttribute("userId", "");
			request.getSession().setAttribute("userName", "");
			model.addAttribute("msg", "사용자 정보가 일치하지 않습니다.");
			System.out.println("사용자 정보가 일치하지 않습니다.");
		}
//		return "board/list";
		return "redirect:/list.do";
	}

	@RequestMapping(value = "/logout.do")
	public String logout(ModelMap model, HttpServletRequest request ) throws Exception {
		
		request.getSession().invalidate();
//		return "board/list";
		return "redirect:/list.do";
	}
}
