package kr.co.service;

import java.util.List;

import kr.co.domain.SitterInfoVO;

public interface SitterInfoService {

	public int getCount(String sitter);
	
	public int reviewCount(String sitter);


	public double getAvg(String sitter);

	public List<SitterInfoVO> getReview(String sitter);

	public int insertReview(SitterInfoVO svo);
}
