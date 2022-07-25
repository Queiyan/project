package kr.co.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.domain.Criteria;
import kr.co.domain.RequestReplyPageDTO;
import kr.co.domain.RequestReplyVO;
import kr.co.mapper.RequestMapper;
import kr.co.mapper.RequestReplyMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class RequestReplyServiceImp implements RequestReplyService {

	@Setter(onMethod_ = @Autowired)
	private RequestReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private RequestMapper requestMapper;
	
	
	
	
	@Transactional
	@Override
	public int register(RequestReplyVO rvo) {
		log.info("register......" + rvo);
		requestMapper.updateReplyCnt(rvo.getRbno(), 1);
		return mapper.insert(rvo);
	}

	@Override
	public RequestReplyVO get(Long rrno) {
		log.info("get......" + rrno);
		return mapper.read(rrno);
	}

	@Transactional
	@Override
	public int remove(Long rrno) {
		log.info("remove......" + rrno);
		RequestReplyVO rvo = mapper.read(rrno);
		requestMapper.updateReplyCnt(rvo.getRbno(), -1);
		return mapper.delete(rrno);
	}

	@Override
	public int modify(RequestReplyVO reply) {
		log.info("modify......" + reply);
		return mapper.update(reply);
	}

	@Override
	public List<RequestReplyVO> getList(Criteria cri, Long rbno) {
		log.info("get Reply list " + rbno);
		return mapper.getListWithPaging(cri, rbno);
	}

	@Override
	public RequestReplyPageDTO getListPage(Criteria cri, Long rbno) {
		return new RequestReplyPageDTO(mapper.getCountByRbno(rbno), mapper.getListWithPaging(cri, rbno));

	}
}
