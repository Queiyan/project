package kr.co.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.domain.MemberVO;

public interface MemberMapper {
	public MemberVO read(String userid);

	public void member(MemberVO membervo); // 회원가입

	public void memberAuth(String userid); // 회원가입(권한)
	
	public MemberVO mypageInfo(String userid); // 마이페이지 정보

	public int useridcheck(String userid);

	public int memberUpdate(MemberVO membervo); // 회원정보수정

	public String findId(String userMail); // 아이디 찾기

	public int findPw(@Param("userid") String userid, @Param("email") String email); // 비밀번호 찾기

	public int pwMailSend(MemberVO member); // 임시 비밀번호발급

	public List<MemberVO> matchingInfo();

	public int emCheck(MemberVO vo); // 이메일 체크

	public int pwUpdate(MemberVO membervo); // 비밀번호수정

	public String pwCheck(String userid);
	
	public int chargePoint(MemberVO membervo);
	
	public int getPoint(String userid);

	public List<MemberVO> admin();
	
	public int delete(String userid);
	
	public List<String> adminId();
	
}
