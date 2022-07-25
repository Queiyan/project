package kr.co.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.service.MemberService;
import kr.co.service.RequestService;
import kr.co.service.SitRequestReplyService;
import kr.co.service.SitRequestService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/matching/*")
@AllArgsConstructor
@Controller
@Log4j
public class MatchingController {
	private RequestService requestService;
	private SitRequestService sitrequestService;
	private SitRequestReplyService sitrequestReplyService;
	private MemberService memberService;


	@PreAuthorize("isAuthenticated()")
	@GetMapping("/requester")
	public void requester(Model model) {
		
		model.addAttribute("list", requestService.getMatchingList());
		//model.addAttribute("sitList", sitrequestService.getMatchingList());
		model.addAttribute("replyList", sitrequestReplyService.getMatchingReply());
		model.addAttribute("member", memberService.matchingInfo());


		
		
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/sitter")
	public void sitter(Model model) {
		
		model.addAttribute("list", requestService.getMatchingList());
		//model.addAttribute("sitList", sitrequestService.getMatchingList());
		model.addAttribute("replyList", sitrequestReplyService.getMatchingReply());
		model.addAttribute("member", memberService.matchingInfo());


	}
}
