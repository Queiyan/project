package kr.co.service;

import java.util.List;

import kr.co.domain.Criteria;
import kr.co.domain.RequestVO;

public interface RequestService {

	public void register(RequestVO request);// 등록.
	public RequestVO get(Long rbno);// 읽기
	public boolean modify(RequestVO request);// 수정
	public boolean remove(Long rbno);// 삭제
	public List<RequestVO> getList(Criteria cri);// 목록
	int getTotalCount(Criteria cri);
	
	public void updateSitter(RequestVO request);
	
	public List<RequestVO> getMatchingList();
	
	public boolean iscompleted(Long rbno);
	
	// 완료된 게시물
	public List<RequestVO> completedList(String loginUser);
	
	public List<RequestVO> managedList(String loginUser);

}
