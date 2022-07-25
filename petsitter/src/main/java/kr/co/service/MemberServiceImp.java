package kr.co.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.domain.MemberVO;
import kr.co.mapper.MemberMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImp implements MemberService {
	@Setter(onMethod_ = @Autowired)
	private MemberMapper membermapper;

	// 회원가입
	public void member(MemberVO membervo, String userid) throws Exception {
		membermapper.member(membervo);
		membermapper.memberAuth(userid);
	}

	// 아이디 중복 체크
	@Override
	public int useridcheck(String userid) throws Exception {
		return membermapper.useridcheck(userid);
	}

	// 마이페이지 정보
	@Override
	public MemberVO userInfo(String userid) {
		return membermapper.mypageInfo(userid);
	}

	@Override
	public boolean modify(MemberVO membervo) {
		return membermapper.memberUpdate(membervo) == 1;
	}

	@Override
	public List<MemberVO> matchingInfo() {
		return membermapper.matchingInfo();
	}

	@Override
	public int emCheck(MemberVO vo) {
		int result = membermapper.emCheck(vo);

		return result;
	}

	@Override
	public boolean pwModify(MemberVO membervo) {
		return membermapper.pwUpdate(membervo) == 1;
	}

	@Override
	public String pwCheck(String userid) {
		return membermapper.pwCheck(userid);
	}

	@Override
	public int chargePoint(MemberVO membervo) {
		return membermapper.chargePoint(membervo);
	}

	@Override
	public int getPoint(String userid) {
		return membermapper.getPoint(userid);
	}

	@Override
	public List<MemberVO> adminInfo() {
		return membermapper.admin();
	}

	@Override
	public boolean remove(String userid) {
		log.info("remove......" + userid);
		return (membermapper.delete(userid)) == 1;
	}
	
	@Override
	public List<String> adminId() {
		return membermapper.adminId();
	}
}
