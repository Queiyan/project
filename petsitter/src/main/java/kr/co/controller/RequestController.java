package kr.co.controller;

import java.io.File;
import java.security.Principal;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.domain.Criteria;
import kr.co.domain.PageDTO;
import kr.co.domain.RequestVO;
import kr.co.service.MemberService;
import kr.co.service.RequestService;
import kr.co.utils.UploadFileUtils;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/request/*")
@AllArgsConstructor
@Controller
public class RequestController {
	private RequestService service;
	private MemberService memberService;

	@Resource(name = "uploadPath")
	private String uploadPath;

	@GetMapping("/list")
	public void list(Model model, Criteria cri) {
		log.info("list");
		cri.setAmount(12); // 9개씩 보이게 수정
		int total = service.getTotalCount(cri);
		log.info("total : " + total);

		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register(Principal principal, Model model) {
		String userId = principal.getName();
		model.addAttribute("info", memberService.userInfo(userId));
	}
	

	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(RequestVO request, MultipartFile file, RedirectAttributes rttr) throws Exception {
		

		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;

		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);

		} else {
			fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		request.setImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		request.setThumImg(
				File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		log.info("register : " + request);
		service.register(request);

		rttr.addFlashAttribute("result", request.getRbno());
		return "redirect:/request/list";
	}


	@GetMapping("/get")
	public void get(@RequestParam("rbno") Long rbno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("/get");
		model.addAttribute("request", service.get(rbno));



	}	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/modify" )
	public void get(Principal principal, @RequestParam("rbno") Long rbno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("/get");
		model.addAttribute("request", service.get(rbno));
		String userId = principal.getName();
		model.addAttribute("info", memberService.userInfo(userId));
	}


	@PostMapping("/modify")
	@PreAuthorize("principal.username==#request.writer")
	public String modify(RequestVO request, Criteria cri,MultipartFile file, HttpServletRequest req, RedirectAttributes rttr) throws Exception{
		log.info("modify:" + request);
		
		 // 새로운 파일이 등록되었는지 확인
		 if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
		  // 기존 파일을 삭제
		  new File(uploadPath + req.getParameter("img")).delete();
		  new File(uploadPath + req.getParameter("thumImg")).delete();
		  
		  // 새로 첨부한 파일을 등록
		  String imgUploadPath = uploadPath + File.separator + "imgUpload";
		  String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		  String fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		  
		  request.setImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		  request.setThumImg(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		  
		 } else {  // 새로운 파일이 등록되지 않았다면
		  // 기존 이미지를 그대로 사용
			 request.setImg(req.getParameter("img"));
			 request.setThumImg(req.getParameter("thumImg"));
		  
		 }
		
		if (service.modify(request)) {
			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/request/list";
	}

	@PostMapping("/remove")
	@PreAuthorize("principal.username==#writer")
	public String remove(@RequestParam("rbno") Long rbno, Criteria cri, RedirectAttributes rttr,  String writer) {
		log.info("remove..." + rbno);
		if (service.remove(rbno)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/request/list";
	}

	@PreAuthorize("principal.username==#request.writer")
	@PostMapping("/matching")
	public String matching(RequestVO request, RedirectAttributes rttr) {
		service.updateSitter(request);
	

		return "redirect:/matching/requester";
	}
	
	@PostMapping("/completed")
	public String matching(Long rbno) {
		log.info(rbno);
		service.iscompleted(rbno);
		
		return "redirect:/matching/requester";
	}
	
	@GetMapping(value = "/get/{rbno}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<RequestVO> get(@PathVariable("rbno") Long rbno) {
		log.info("get: " + rbno);
		return new ResponseEntity<>(service.get(rbno), HttpStatus.OK);
	}

}