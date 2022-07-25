package kr.co.controller;

import java.security.Principal;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.domain.ChargeVO;
import kr.co.domain.MemberVO;
import kr.co.service.ChargeService;
import kr.co.service.MemberService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/charge/*")
@AllArgsConstructor
@Controller
@Log4j
public class ChargeController {
	private ChargeService chargeService;
	private MemberService memberService;

	
	
	@PostMapping(value = "/point", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> point(@RequestBody ChargeVO cvo) {
		log.info("cvo: " + cvo);
		int insertCount = chargeService.charge(cvo);
		log.info("charge insert count: " + insertCount);
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	

	@GetMapping("/user/point")
	public String chargePoint(int amount, Principal principal ){
		log.info(amount);
		String userid = principal.getName();

		int rawPoint = memberService.getPoint(userid);
		int userpoint = rawPoint + amount;
		
		
		MemberVO mvo = new MemberVO();
		mvo.setUserid(userid);
		mvo.setUserPoint(userpoint);
		memberService.chargePoint(mvo);


		return "redirect:/charge/myPoint";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/myPoint")
	public void myPoint(Principal principal, Model model) {
		
		
		String userId = principal.getName();
		model.addAttribute("info", memberService.userInfo(userId));

	}
	
	@GetMapping("/completed/point")
	public String completedPoint(int amount, String userid ){
		log.info(amount);

		int rawPoint = memberService.getPoint(userid);
		int userpoint = rawPoint + amount;
		
		
		MemberVO mvo = new MemberVO();
		mvo.setUserid(userid);
		mvo.setUserPoint(userpoint);
		memberService.chargePoint(mvo);


		return "redirect:/charge/myPoint";
	}
	
	
	




}
