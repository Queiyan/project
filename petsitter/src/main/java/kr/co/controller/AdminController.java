package kr.co.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.service.MemberService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class AdminController {

	@Setter(onMethod_ = @Autowired)
	private MemberService memberservice;

	@GetMapping("/admin/page")
	public void list(Model model) {
		model.addAttribute("list", memberservice.adminInfo());
	}

	@PostMapping("/remove")
	public String remove(@RequestParam("userid") String userid, 
			RedirectAttributes rttr) {
		log.info("remove..." + userid);
		if (memberservice.remove(userid)) {
			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:/admin/page";
	}
	//@GetMapping("/get/auth")
	//@RequestMapping(value="/get/auth", method=RequestMethod.GET)
	@RequestMapping("/get/auth")
	@ResponseBody
	public String getAuth(@RequestParam("userid") String userid, Model model) {
		log.info("getAuth..." + userid);

		List<String> adminUsers = memberservice.adminId();
        boolean isAdmin = adminUsers.contains(userid);
        if(isAdmin) {
        	return "admin";
        } else {
        	return "user";
        }
	}


	
}