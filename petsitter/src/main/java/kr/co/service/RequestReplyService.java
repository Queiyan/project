package kr.co.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.domain.Criteria;
import kr.co.domain.RequestReplyPageDTO;
import kr.co.domain.RequestReplyVO;

public interface RequestReplyService {
	public int register(RequestReplyVO rvo);

	public RequestReplyVO get(Long rrno);

	public int remove(Long rrno);

	public int modify(RequestReplyVO reply);

	public List<RequestReplyVO> getList(@Param("cri") Criteria cri, @Param("rbno") Long rbno);

	public RequestReplyPageDTO getListPage(Criteria cri, Long rbno);
	
	
}
