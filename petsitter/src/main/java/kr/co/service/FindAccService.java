package kr.co.service;

import org.apache.ibatis.annotations.Param;

import kr.co.domain.MemberVO;

public interface FindAccService {
	public String searchId(String userMail); // 아이디 찾기

   public int searchPw(@Param("userid") String userid
         , @Param("email") String email); // 비밀번호 찾기

   public int pwMailSend(MemberVO member);   // 비밀번호 변경
}
