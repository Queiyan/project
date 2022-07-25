package kr.co.service;

import java.util.List;

import kr.co.domain.AnswerVO;
import kr.co.domain.Criteria;

public interface AnswerService {
	
	public void register(AnswerVO answer);// 등록.	
	public AnswerVO get(Long abno);// 읽기	
	public boolean modify(AnswerVO answer);// 수정	
	public boolean remove(Long abno);// 삭제	
	public List<AnswerVO> getList(Criteria cri);// 목록
	int getTotalCount(Criteria cri);
}
