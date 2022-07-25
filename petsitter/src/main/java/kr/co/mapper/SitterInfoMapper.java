package kr.co.mapper;

import java.util.List;

import kr.co.domain.SitterInfoVO;

public interface SitterInfoMapper {
//	public SitterInfoVO select(String sitter);
	
	public int getCount(String sitter);
	
	public double getAvg(String sitter);
	
	public int reviewCount(String sitter);


	public List<SitterInfoVO> getReview(String sitter);
	
	public int insertReview(SitterInfoVO svo);
	
	//public boolean isExistUser
}
