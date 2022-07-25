package kr.co.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.domain.AnswerVO;
import kr.co.domain.Criteria;
import kr.co.domain.RequestVO;

public interface AnswerMapper {
	public List<AnswerVO> getList();
	
	public void insert(AnswerVO answer);
	// bno 는 시퀀스 자동 생성으로 나머지 값만 입력
	
	public void insertSelectKey(AnswerVO answer);
	// 생성되는 시퀀스 값을 확인하고 나머지 값 입력
	
	public AnswerVO read(Long abno);
	
	public int delete(Long abno);
	
	public int update(AnswerVO answer);
	
	public List<AnswerVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	
	public void updateReplyCnt(@Param("rbno") Long rbno
			, @Param("amount") int amount);
	
	public void updateSitter(RequestVO request);
}
