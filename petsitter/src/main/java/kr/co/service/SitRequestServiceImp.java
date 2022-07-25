package kr.co.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.domain.Criteria;
import kr.co.domain.SitRequestVO;
import kr.co.mapper.SitRequestMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class SitRequestServiceImp implements SitRequestService {

	@Setter(onMethod_ = @Autowired)
	private SitRequestMapper mapper;

	@Override
	public void register(SitRequestVO sitrequest) {
		log.info("register......" + sitrequest);
		mapper.insertSelectKey(sitrequest);
	}

	@Override
	public SitRequestVO get(Long sbno) {
		log.info("get......" + sbno);
		return mapper.read(sbno);
	}

	@Override
	public boolean modify(SitRequestVO sitrequest) {
		log.info("modify......" + sitrequest);
		return mapper.update(sitrequest) == 1;
	}

	@Override
	public boolean remove(Long sbno) {
		log.info("remove......" + sbno);
		return (mapper.delete(sbno)) == 1;
	}

	@Override
	public List<SitRequestVO> getList(Criteria cri) {
		log.info("getList......");
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	@Override
	public void updateRequester(SitRequestVO sitrequest) {
		mapper.updateRequester(sitrequest);
		
	}

	@Override
	public List<SitRequestVO> getMatchingList() {
		log.info("getMatchingList..");
		return mapper.getMatchingList();
	}

	
	@Override
	public boolean iscompleted(Long sbno) {
		log.info("iscompleted..");

		return mapper.iscompleted(sbno)==1;
	}


}
