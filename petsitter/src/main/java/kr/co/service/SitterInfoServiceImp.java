package kr.co.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.domain.SitterInfoVO;
import kr.co.mapper.SitterInfoMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class SitterInfoServiceImp implements SitterInfoService {
	@Setter(onMethod_ = @Autowired)
	private SitterInfoMapper mapper;

	@Override
	public int getCount(String sitter) {
		log.info("count..." + sitter);
		return mapper.getCount(sitter);
	}

	@Override
	public double getAvg(String sitter) {
		log.info("avg..." + sitter);
		return mapper.getAvg(sitter);
	}

	@Override
	public List<SitterInfoVO> getReview(String sitter) {
		log.info("getReview..." + sitter);
		return mapper.getReview(sitter);
	}


	@Override
	public int insertReview(SitterInfoVO svo) {
		log.info("insertReview..." + svo);
		return mapper.insertReview(svo);
	}

	@Override
	public int reviewCount(String sitter) {
		log.info("count..." + sitter);
		return mapper.reviewCount(sitter);
	}

}
