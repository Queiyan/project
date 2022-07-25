package kr.co.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.domain.AnswerVO;
import kr.co.domain.Criteria;

import kr.co.mapper.AnswerMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class AnswerServiceImp implements AnswerService {

	@Setter(onMethod_ = @Autowired)
	private AnswerMapper mapper;
	
	@Override
	public void register(AnswerVO answer) {
		log.info("register......" + answer);
		mapper.insertSelectKey(answer);

	}

	@Override
	public AnswerVO get(Long abno) {
		log.info("get......" + abno);
		return mapper.read(abno);
	}

	@Override
	public boolean modify(AnswerVO answer) {
		log.info("modify......" + answer);
		return mapper.update(answer)==1;
	}

	@Override
	public boolean remove(Long abno) {
		log.info("remove......" + abno);
		return (mapper.delete(abno)) == 1;
	}

	@Override
	public List<AnswerVO> getList(Criteria cri) {
		log.info("getList......");
		return mapper.getListWithPaging(cri);
	}
	@Override
	public int getTotalCount(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

}
