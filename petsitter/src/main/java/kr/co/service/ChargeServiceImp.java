package kr.co.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.domain.ChargeVO;
import kr.co.mapper.ChargeMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ChargeServiceImp implements ChargeService {


	   @Setter(onMethod_ = @Autowired)
	   private ChargeMapper mapper;
	   
	@Override
	public int charge(ChargeVO cvo) {
		log.info("cvo..." + cvo);
		return mapper.insert(cvo);
	}

}
