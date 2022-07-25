package kr.co.security;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.co.domain.MemberVO;
import kr.co.mapper.MemberMapper;
import kr.co.security.domain.CustomUser;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Log4j
public class CustomUserDetailsService implements UserDetailsService {
	@Setter(onMethod_ = { @Autowired })
	private MemberMapper memberMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.warn("load user by userName : " + username);
		MemberVO vo = memberMapper.read(username);
		return vo == null ? null : new CustomUser(vo);
	}
}
