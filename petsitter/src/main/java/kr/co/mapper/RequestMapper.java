package kr.co.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.domain.Criteria;
import kr.co.domain.RequestVO;

public interface RequestMapper {

	// @Select("select * from tbl_request where rbno > 0")
	public List<RequestVO> getMatchingList();

	public void insert(RequestVO request);

	// bno 는 시퀀스 자동 생성으로 나머지 값만 입력.
	public void insertSelectKey(RequestVO request);

	// 생성되는 시퀀스 값을 확인하고 나머지 값 입력.
	public RequestVO read(Long rbno);

	public int delete(Long rbno);

	public int update(RequestVO request);
	
	public List<RequestVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	
	
	public void updateReplyCnt(@Param("rbno") Long rbno
			, @Param("amount") int amount);
	
	public void updateSitter(RequestVO request);
	
	public int iscompleted(Long rbno);

	// 완료된 요청
	public List<RequestVO> completedList(String loginUser);
	
	public List<RequestVO> managedList(String loginUser);

	
}
