package kr.co.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.domain.Criteria;
import kr.co.domain.SitRequestVO;

public interface SitRequestMapper {
	
	public List<SitRequestVO> getMatchingList();

	public void insert(SitRequestVO sitrequest);

	// bno 는 시퀀스 자동 생성으로 나머지 값만 입력.
	public void insertSelectKey(SitRequestVO sitrequest);

	// 생성되는 시퀀스 값을 확인하고 나머지 값 입력.
	public SitRequestVO read(Long sbno);

	public int delete(Long sbno);

	public int update(SitRequestVO sitrequest);
	
	public List<SitRequestVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public void updateReplyCnt(@Param("sbno") Long sbno
			, @Param("amount") int amount);
	
	public void updateRequester(SitRequestVO sitrequest);
	
	public int iscompleted(Long sbno);

}
