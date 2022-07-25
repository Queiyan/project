package kr.co.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.domain.Criteria;
import kr.co.domain.RequestVO;
import kr.co.mapper.RequestMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class RequestServiceImp implements RequestService {

	@Setter(onMethod_ = @Autowired)
	private RequestMapper mapper;

	@Override
	public void register(RequestVO request) {
		log.info("register......" + request);
		mapper.insertSelectKey(request);
	}

	@Override
	public RequestVO get(Long rbno) {
		log.info("get......" + rbno);
		return mapper.read(rbno);
	}

	@Override
	public boolean modify(RequestVO request) {
		log.info("modify......" + request);
		return mapper.update(request) == 1;
	}

	@Override
	public boolean remove(Long rbno) {
		log.info("remove......" + rbno);
		return (mapper.delete(rbno)) == 1;
	}

	@Override
	public List<RequestVO> getList(Criteria cri) {
		log.info("getList......");
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	@Override
	public void updateSitter(RequestVO request) {
		mapper.updateSitter(request);
	}

	@Override
	public List<RequestVO> getMatchingList() {
		log.info("getMatchingLIst..");
		return mapper.getMatchingList();
	}

	@Override
	public boolean iscompleted(Long rbno) {
		log.info("iscompleted..");

		return mapper.iscompleted(rbno)==1;
	}
	 // 완료된 게시물
   @Override
   public List<RequestVO> completedList(String loginUser) {
      log.info("completedList..");
      return mapper.completedList(loginUser);
   }

@Override
public List<RequestVO> managedList(String loginUser) {
	return  mapper.managedList(loginUser);
}
	
	
	
	
}
