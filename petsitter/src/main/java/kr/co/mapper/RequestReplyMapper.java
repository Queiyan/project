package kr.co.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.domain.Criteria;
import kr.co.domain.RequestReplyVO;

public interface RequestReplyMapper {
	public int insert(RequestReplyVO rvo);
	
	public RequestReplyVO read(Long rrno);
	
	public int delete(Long rrno);
	
	public int update(RequestReplyVO reply);
	
	public List<RequestReplyVO> getListWithPaging(
	@Param("cri") Criteria cri,
	@Param("rbno") Long rbno);
	
	public int getCountByRbno(Long rbno);
}
