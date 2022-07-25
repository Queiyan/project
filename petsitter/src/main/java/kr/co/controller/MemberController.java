package kr.co.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.domain.MemberVO;
import kr.co.service.FindAccService;
import kr.co.service.MemberService;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Controller
public class MemberController {
	
	
	
	@Setter(onMethod_ = @Autowired)
	private MemberService memberService;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	@Setter(onMethod_ = @Autowired)
	private FindAccService findservice;
	
	@Autowired
	private JavaMailSender mailSender; // 메일 전송모듈


	// 회원가입폼
	@RequestMapping(value="/signup", method=RequestMethod.GET)
	public void joinGet() {
	}
	
	// 회원가입 처리
	@RequestMapping(value="/signup", method=RequestMethod.POST)
	public String joinPost(MemberVO membervo) throws Exception {
		log.info("signup");
		membervo.setUserpw(pwencoder.encode(membervo.getUserpw()));
		String userid = membervo.getUserid();
		memberService.member(membervo, userid);
		
		return "redirect:/";
	}
	
	// 회원가입시 아이디 존재 유무 확인
	@RequestMapping(value="/useridcheck", method=RequestMethod.POST)
	@ResponseBody
	public String useridcheck(String userid) throws Exception {
		int result = memberService.useridcheck(userid);
		
		if(result != 0) {
			return "exist";
		} else {
			return "avail";
		}
	}

	// 회원가입시 입력한 이메일로 인증번호 전송 처리
		@ResponseBody
		@PostMapping("/emailAuth")
		public Map<String, Object> SendMail(String mail, HttpSession session, MemberVO vo) {
			Map<String, Object> map = new HashMap<>();
			String email = vo.getEmail();
			
			String authNum = RandomStringUtils.randomAlphanumeric(10);

			// 세팅된 임시비번을 메일로 보내기.
			String setfrom = "kategora4321@gmail.com";
			String tomail = email; // 받는 사람 이메일
			String title = " 회원가입 인증번호"; // 제목
			String content = "회원가입 인증번호는 " + authNum + " 입니다."; // 내용
			try {
				// 메일 보내기
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

				messageHelper.setFrom(setfrom); // 보내는사람 생략하거나 하면 정상작동을 안함
				messageHelper.setTo(tomail); // 받는사람 이메일
				messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
				messageHelper.setText(content); // 메일 내용

				mailSender.send(message);
				map.put("key", authNum);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			//System.out.println("authNum : "+ authNum);
			return map;
		}
		// 아이디 중복 검사
				@RequestMapping(value = "/useridCk", method = RequestMethod.POST)
				@ResponseBody
				public String useridCK(String userid) throws Exception {
					log.info("useridck");

					int result = memberService.useridcheck(userid);

					log.info("result: " + result);

					if (result != 0) {
						return "exist";
					} else {
						return "avale";
					}
				}

				// 아이디/비밀번호 찾기 폼
				@GetMapping("/findAccount")
				public void selectAccount() {
				}
				
				@RequestMapping(value="/findAccount/id" , method=RequestMethod.POST)
				@ResponseBody
				public String selectId(String email) throws Exception {
					log.info("find id");
					String result = findservice.searchId(email);
					
					if (result != null) {
						return result;
					} else {
						return "not found";
					}
				}
				
				// 비밀번호 찾기
				@RequestMapping(value="/findAccount/pw", method=RequestMethod.POST)
				@ResponseBody
				public String selectPw(String userid, String userMailPw) throws Exception {
					log.info("findAccount");
					int result = findservice.searchPw(userid, userMailPw);

					if (result == 1) {
						return "found";
					} else {
						return "not found";
					}
				}

				// 임시 비밀번호 발급
				@RequestMapping(value="/findAccount/pwMail", method=RequestMethod.POST)
				@ResponseBody
				public String pwMailSend(String userid, String userMailPw) throws Exception {
					log.info("pwMailSend");

					// 임시 비밀번호 생성
					String uuid = UUID.randomUUID().toString().replaceAll("-", "");
					uuid = uuid.substring(0, 10);
					log.info(uuid);

					// 이메일 보낼 준비
					log.info("send pwMail");
					String setFrom = "kategora4321@gmail.com";
					String toMail = userMailPw;
					String title = "[반려동물] " + userid + " 님, 임시 비밀번호입니다.";
					String content = "안녕하세요, 회원님." + "<br><br>"
							+ "회원님의 임시 비밀번호는 "
							+ "<b>" + uuid + "</b>" + "입니다." + "<br>"
							+ "회원님의 개인 정보 보호를 위해 로그인 후 꼭 비밀번호를 변경해 주시길 바랍니다." + "<br><br><br>"
							+ "감사합니다.<br>반려동물 돌봄 서비스.";

					// 유저 비밀번호 변경
					MemberVO member = new MemberVO();
					member.setUserid(userid);
					member.setEmail(userMailPw);
					member.setUserpw(uuid);
					member.setUserpw(pwencoder.encode(member.getUserpw()));
					int result = findservice.pwMailSend(member);

					// 비밀번호를 변경한 결과가 있다면 메일 전송, 없다면 실패
					if (result == 1) {
						try {
							MimeMessage message = mailSender.createMimeMessage();
							MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
							helper.setFrom(setFrom);
							helper.setTo(toMail);
							helper.setSubject(title);
							helper.setText(content, true);
							mailSender.send(message);

							return "success";

						} catch(Exception e) {
							e.printStackTrace();
							return "fail";
						}
					} else {
						return "not found";
					}
				}
			// 회원가입 이메일 유효성 체크
            @ResponseBody
            @PostMapping("/emCheck")
            public int emCheck(MemberVO vo) throws Exception {
               int result = memberService.emCheck(vo);
               return result;
            }
            
            

        	@GetMapping(value = "/getInfo/{userid}", produces = { MediaType.APPLICATION_JSON_VALUE })
        	public ResponseEntity<MemberVO> get(@PathVariable("userid") String userid) {
        		return new ResponseEntity<>(memberService.userInfo(userid), HttpStatus.OK);
        	}

}
