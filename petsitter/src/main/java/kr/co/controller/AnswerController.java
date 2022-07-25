package kr.co.controller;

import java.io.File;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.domain.AnswerVO;
import kr.co.domain.Criteria;
import kr.co.domain.PageDTO;

import kr.co.service.AnswerService;
import kr.co.utils.UploadFileUtils;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
@RequestMapping("/answer/*")
public class AnswerController {
	
	private AnswerService service;
	
	@Resource(name = "uploadPath")
	private String uploadPath;

	@GetMapping("/list")
	public void list() {
	}
	
	@GetMapping("/register")
	public void register() {

	}
	@PostMapping("/register")
	public String register(AnswerVO answer, MultipartFile file, RedirectAttributes rttr) throws Exception {

		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;

		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);

		} else {
			fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		answer.setImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		answer.setThumImg(
				File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		log.info("register : " + answer);
		service.register(answer);

		rttr.addFlashAttribute("result", answer.getAbno());

		return "redirect:/answer/list";
	}

	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("abno") Long abno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("/get");
		model.addAttribute("answer", service.get(abno));
	}

	@PostMapping("/modify")
	public String modify(AnswerVO answer, Criteria cri, RedirectAttributes rttr) {
		log.info("modify:" + answer);
		if (service.modify(answer)) {
			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/answer/list";
	}

	@PostMapping("/remove")
	public String remove(@RequestParam("abno") Long abno, Criteria cri, RedirectAttributes rttr) {
		log.info("remove..." + abno);
		if (service.remove(abno)) {
			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/answer/list";
	}
	
	

}
