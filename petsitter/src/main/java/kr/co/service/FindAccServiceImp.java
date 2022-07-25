package kr.co.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.domain.MemberVO;
import kr.co.mapper.MemberMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class FindAccServiceImp implements FindAccService {

   @Setter(onMethod_ = @Autowired)
   private MemberMapper membermapper;
   
   // 아이디 찾기
      @Override
      public String searchId(String email) {
         log.info("search id......" + email);
         return membermapper.findId(email);
      }

   // 비밀번호 찾기
   @Override
   public int searchPw(String userid, String email) {
      log.info("search pw......" + userid);
      return membermapper.findPw(userid, email);
   }

   // 임시 비밀번호로 변경
   @Override
   public int pwMailSend(MemberVO member) {
      log.info("change pw......" + member);
      return membermapper.pwMailSend(member);
   }

}