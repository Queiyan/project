package kr.co.service;

import java.util.List;

import kr.co.domain.MemberVO;

public interface MemberService {
	public void member(MemberVO membervo, String userid) throws Exception;

	public int useridcheck(String userid) throws Exception;

	public MemberVO userInfo(String userid); // 마이페이지 정보

	public boolean modify(MemberVO membervo);

	public List<MemberVO> matchingInfo();

	public int emCheck(MemberVO vo); // 이메일 체크

	public boolean pwModify(MemberVO membervo); // 비밀번호 수정

	public String pwCheck(String userid); // 비밀번호 체크
	
	public int chargePoint(MemberVO membervo);
	
	public int getPoint(String userid);
	
	public List<MemberVO> adminInfo(); //관리자
	
	public boolean remove(String userid); // 삭제
	
	public List<String> adminId(); 
}
