package kr.co.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.domain.Criteria;
import kr.co.domain.SitRequestReplyPageDTO;
import kr.co.domain.SitRequestReplyVO;

public interface SitRequestReplyService {
	public int register(SitRequestReplyVO srvo);

	public SitRequestReplyVO get(Long rsbno);

	public int remove(Long rsbno);

	public int modify(SitRequestReplyVO reply);

	public List<SitRequestReplyVO> getList(@Param("cri") Criteria cri, @Param("sbno") Long sbno);

	public SitRequestReplyPageDTO getListPage(Criteria cri, Long sbno);
	
	public int updateSitter(SitRequestReplyVO reply);
	
	public List<SitRequestReplyVO> getMatchingReply();
	
	public boolean iscompleted(Long rsbno);



	
	
}
