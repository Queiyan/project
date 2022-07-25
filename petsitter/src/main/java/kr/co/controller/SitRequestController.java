package kr.co.controller;

import java.io.File;
import java.security.Principal;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.domain.Criteria;
import kr.co.domain.PageDTO;
import kr.co.domain.SitRequestReplyVO;
import kr.co.domain.SitRequestVO;
import kr.co.service.MemberService;
import kr.co.service.SitRequestReplyService;
import kr.co.service.SitRequestService;
import kr.co.utils.UploadFileUtils;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/sitrequest/*")
@AllArgsConstructor
public class SitRequestController {

	private SitRequestService service;
	private SitRequestReplyService replyService;
	private MemberService memberService;


	@Resource(name = "uploadPath")
	private String uploadPath;

	@GetMapping("/list")
	public void list(Model model, Criteria cri) {
		log.info("list");
		cri.setAmount(12);
		int total = service.getTotalCount(cri);
		log.info("total : " + total);

		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register() {

	}

	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(SitRequestVO sitrequest, MultipartFile file, RedirectAttributes rttr) throws Exception {

		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;

		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);

		} else {
			fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		sitrequest.setImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		sitrequest.setThumImg(
				File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		log.info("register : " + sitrequest);
		service.register(sitrequest);

		rttr.addFlashAttribute("result", sitrequest.getSbno());

		return "redirect:/sitrequest/list";
	}

	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("sbno") Long sbno, @ModelAttribute("cri") Criteria cri, Model model) {
//		Principal principal = null;
//		if(principal.getName() != null && principal.getName() != "") {
//			String userid = principal.getName();
//			model.addAttribute("info", memberService.userInfo(userid));
//		}
		
		
		log.info("/get");
		model.addAttribute("sitrequest", service.get(sbno));
	}

	@PostMapping("/modify")
	@PreAuthorize("principal.username==#sitrequest.writer")
	   public String modify(SitRequestVO sitrequest,Criteria cri,MultipartFile file, HttpServletRequest req, RedirectAttributes rttr) throws Exception {
	      log.info("modify:" + sitrequest);
	      
	   // 새로운 파일이 등록되었는지 확인
			 if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			  // 기존 파일을 삭제
			  new File(uploadPath + req.getParameter("img")).delete();
			  new File(uploadPath + req.getParameter("thumImg")).delete();
			  
			  // 새로 첨부한 파일을 등록
			  String imgUploadPath = uploadPath + File.separator + "imgUpload";
			  String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
			  String fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			  
			  sitrequest.setImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
			  sitrequest.setThumImg(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
			  
			 } else {  // 새로운 파일이 등록되지 않았다면
			  // 기존 이미지를 그대로 사용
				 sitrequest.setImg(req.getParameter("img"));
				 sitrequest.setThumImg(req.getParameter("thumImg"));
			  
			 }
	      
	      
	      
	      if (service.modify(sitrequest)) {
	         rttr.addFlashAttribute("result", "success");
	      }
	      rttr.addAttribute("pageNum", cri.getPageNum());
	      rttr.addAttribute("amount", cri.getAmount());
	      rttr.addAttribute("type", cri.getType());
	      rttr.addAttribute("keyword", cri.getKeyword());

	      return "redirect:/sitrequest/list";
	   }
	
	 @PreAuthorize("principal.username==#writer")
	 @PostMapping("/remove")
	   public String remove(@RequestParam("sbno") Long sbno,Criteria cri, RedirectAttributes rttr, String writer) {
	      log.info("remove..." + sbno);
	      if (service.remove(sbno)) {
	         rttr.addFlashAttribute("result", "success");
	      }
	      
	      rttr.addAttribute("pageNum", cri.getPageNum());
	      rttr.addAttribute("amount", cri.getAmount());
	      rttr.addAttribute("type", cri.getType());
	      rttr.addAttribute("keyword", cri.getKeyword());

	      return "redirect:/sitrequest/list";
	   }
	
	@PreAuthorize("principal.username==#sitrequest.writer")
	@PostMapping("/matching")
	public String matching(SitRequestVO sitrequest, Long rsbno, RedirectAttributes rttr) {
		
		//service.updateRequester(sitrequest);
		String sitter = sitrequest.getWriter();
		
		SitRequestReplyVO rvo = new SitRequestReplyVO();
		rvo.setRsbno(rsbno);
		rvo.setSitter(sitter);
		replyService.updateSitter(rvo);

		return "redirect:/matching/sitter";
	}
	
//	@PostMapping("/completed")
//	public String matching(Long sbno) {
//		log.info(sbno);
//		service.iscompleted(sbno);
//		
//
//		return "redirect:/matching/requester";
//	}

}
