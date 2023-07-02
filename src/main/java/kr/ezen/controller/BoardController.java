package kr.ezen.controller;

import java.util.List;

import kr.ezen.bbs.domain.ProductDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.ezen.bbs.domain.BoardDTO;
import kr.ezen.bbs.domain.PageDTO;
import kr.ezen.service.BoardService;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private BoardService service;
	
//	@GetMapping("/list.do")
//	public String list(Model model) {
//		List<BoardDTO> list = service.getList();
//		model.addAttribute("list", list);
//
//		return "board/boardList";
//	}

	@RequestMapping("/list.do")
	public String list(PageDTO pDto, Model model) {
		List<BoardDTO> list = service.getList(pDto);
		System.out.println(pDto.getSearchType());
		System.out.println(pDto.getKeyWord());

		model.addAttribute("list", list);
		model.addAttribute("pDto", pDto);

		return "board/boardList";
	}
	
	
	@GetMapping("/register.do")
	public String register(@ModelAttribute("pDto") PageDTO pDto) {

		return "board/register";
	}
	
	@PostMapping("/register.do")
		public String register(BoardDTO dto, @ModelAttribute("pDto") PageDTO pDto
				,RedirectAttributes rttr) {

		service.register(dto);
		rttr.addAttribute("cntPerPage", pDto.getCntPerPage());
		return "redirect:/board/list.do";
	}
	/*model은 수정을하고 화면에 보여줄때는 model로 request 할때 써줌*/
	@GetMapping("/view.do")
	public String view(int bid, @ModelAttribute("pDto") PageDTO pDto, Model m) {
		BoardDTO dto = service.view(bid, "v");
		m.addAttribute("dto", dto);
		
		return "board/view";
	}
	
	// 게시글 수정 폼페이지
	@RequestMapping(value="/modify.do", method=RequestMethod.GET)
	public String modifyForm(PageDTO pDto, int bid, Model m) {
		BoardDTO dto = service.view(bid, "m");
		m.addAttribute("dto", dto);
		m.addAttribute("pDto", pDto);
		
		return "board/modify";
	}
	// 게시글 수정
	@RequestMapping(value="/modify.do", method=RequestMethod.POST)
//	public String modify(@ModelAttribute("pDto") PageDTO pDto, BoardDTO dto,
	public String modify(@ModelAttribute("pDto") PageDTO pDto, BoardDTO dto,
						 RedirectAttributes rttr) {
		service.modify(dto);
		System.out.println("viewPage : " + pDto.getViewPage());
//		m.addAttribute("viewPage", pDto.getViewPage());
		rttr.addAttribute("viewPage", pDto.getViewPage());
		rttr.addAttribute("cntPerPage", pDto.getCntPerPage());
		rttr.addAttribute("searchType", pDto.getSearchType());
		rttr.addAttribute("keyWord", pDto.getKeyWord());

		return "redirect:list.do";
	}
	
	//게시글 삭제
	@GetMapping("/remove.do")
	public String remove(@ModelAttribute("pDto") PageDTO pDto, int bid,
						 RedirectAttributes rttr) {
		service.remove(bid);
		System.out.println("~~~~~cntPerPage : " + pDto.getCntPerPage());
		rttr.addAttribute("viewPage", pDto.getViewPage());
		rttr.addAttribute("cntPerPage", pDto.getCntPerPage());

		return "redirect:/board/list.do";
	}


}
