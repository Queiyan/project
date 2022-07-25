package kr.co.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.domain.Criteria;

import kr.co.domain.SitRequestReplyPageDTO;
import kr.co.domain.SitRequestReplyVO;
import kr.co.mapper.MemberMapper;
import kr.co.mapper.SitRequestMapper;
import kr.co.mapper.SitRequestReplyMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class SitRequestReplyServiceImp implements SitRequestReplyService {

	@Setter(onMethod_ = @Autowired)
	private SitRequestReplyMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private SitRequestMapper SitRequestMapper;
	


	@Transactional
	@Override
	public int register(SitRequestReplyVO srvo) {
		log.info("register......" + srvo);
		SitRequestMapper.updateReplyCnt(srvo.getSbno(), 1);
		return mapper.insert(srvo);
	}

	@Override
	public SitRequestReplyVO get(Long rsbno) {
		log.info("get......" + rsbno);
		return mapper.read(rsbno);
	}

	@Transactional
	@Override
	public int remove(Long rsbno) {
		log.info("remove......" + rsbno);
		SitRequestReplyVO srvo = mapper.read(rsbno);
		SitRequestMapper.updateReplyCnt(srvo.getSbno(), -1);
		return mapper.delete(rsbno);
	}

	@Override
	public int modify(SitRequestReplyVO reply) {
		log.info("modify......" + reply);
		return mapper.update(reply);
	}

	@Override
	public List<SitRequestReplyVO> getList(Criteria cri, Long sbno) {
		log.info("get Reply list " + sbno);
		return mapper.getListWithPaging(cri, sbno);
	}

	@Override
	public SitRequestReplyPageDTO getListPage(Criteria cri, Long sbno) {
		return new SitRequestReplyPageDTO(mapper.getCountBySbno(sbno), mapper.getListWithPaging(cri, sbno));

	}

	@Override
	public int updateSitter(SitRequestReplyVO reply) {
		return mapper.updateSitter(reply);
	}

	@Override
	public List<SitRequestReplyVO> getMatchingReply() {
		return mapper.matchingReply();
	}

	@Override
	public boolean iscompleted(Long rsbno) {
		return mapper.iscompleted(rsbno)==1;
	}

}
