package kr.co.service;

import java.util.List;

import kr.co.domain.Criteria;
import kr.co.domain.SitRequestVO;

public interface SitRequestService {

	public void register(SitRequestVO sitrequest);// 등록.
	
	public SitRequestVO get(Long sbno);// 읽기
	
	public boolean modify(SitRequestVO sitrequest);// 수정
	
	public boolean remove(Long sbno);// 삭제
	
	public List<SitRequestVO> getList(Criteria cri);// 목록
	
	int getTotalCount(Criteria cri);
	
	public void updateRequester(SitRequestVO sitrequest);

	public List<SitRequestVO> getMatchingList();

	
	public boolean iscompleted(Long sbno);


	
}
