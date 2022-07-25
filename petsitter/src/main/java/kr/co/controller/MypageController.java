package kr.co.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.domain.MemberVO;
import kr.co.domain.RequestVO;
import kr.co.service.MemberService;
import kr.co.service.RequestService;
import lombok.AllArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@Controller
public class MypageController {
	private MemberService memberservice;
	
	private RequestService requestservice;

	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;

	@PreAuthorize("isAuthenticated()")
	@GetMapping("/mypage")
	public void mypageInfo(Principal principal, Model model) {

		String userId = principal.getName();
		model.addAttribute("info", memberservice.userInfo(userId));

	}

	// 유저 정보 수정
	@PostMapping("/mypagemod")
	@PreAuthorize("isAuthenticated()")
	public String modify(MemberVO membervo, RedirectAttributes rttr) throws Exception {
		if (memberservice.modify(membervo)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/mypage";
	}

	@GetMapping("/modifyPw")
	@PreAuthorize("isAuthenticated()")
	public void modifyPw() {

	}

	@PostMapping("/modifyPw")
	@PreAuthorize("isAuthenticated()")
	public String modifyPw(Principal principal, String rawPassword, String newPassword, RedirectAttributes rttr)
			throws Exception {
		String userId = principal.getName();
		String userPw = memberservice.pwCheck(userId);

		MemberVO modPw = new MemberVO();
		modPw.setUserid(userId);

		if (pwencoder.matches(rawPassword, userPw)) {

			modPw.setUserpw(pwencoder.encode(newPassword));
			if (memberservice.pwModify(modPw)) {
				rttr.addFlashAttribute("result", "success");
			}
			return "redirect:/mypage";

		} else {
			rttr.addFlashAttribute("result", "fail");
			return "redirect:/modifyPw";

		}
	}
	
	 @GetMapping("/completed")
     @PreAuthorize("isAuthenticated()")
     public void completedList(Principal principal, Model model) {
     String loginUser = principal.getName();
     model.addAttribute("completed", requestservice.completedList(loginUser));
     
     }
	 
	 @GetMapping("/managed")
     @PreAuthorize("isAuthenticated()")
     public void managedList(Principal principal, Model model) {
     String loginUser = principal.getName();
     model.addAttribute("managed", requestservice.managedList(loginUser));
     
     }
}
