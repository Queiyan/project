package kr.co.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.domain.Criteria;
import kr.co.domain.SitRequestReplyVO;

public interface SitRequestReplyMapper {
	public int insert(SitRequestReplyVO srvo);
	
	public SitRequestReplyVO read(Long rsbno);
	
	public int delete(Long rsbno);
	
	public int update(SitRequestReplyVO reply);
	
	public List<SitRequestReplyVO> getListWithPaging(
	@Param("cri") Criteria cri,
	@Param("sbno") Long sbno);
	
	public int getCountBySbno(Long sbno);
	

	public int updateSitter(SitRequestReplyVO reply);
	
	public List<SitRequestReplyVO> matchingReply();

	
	public int iscompleted(Long rsbno);

}
