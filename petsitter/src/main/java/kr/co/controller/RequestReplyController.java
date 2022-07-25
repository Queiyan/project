package kr.co.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import kr.co.domain.Criteria;
import kr.co.domain.RequestReplyPageDTO;
import kr.co.domain.RequestReplyVO;
import kr.co.service.RequestReplyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
@AllArgsConstructor
public class RequestReplyController {
	private RequestReplyService service;

	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> create(@RequestBody RequestReplyVO rvo) {
		log.info("RequestReplyVO: " + rvo);
		int insertCount = service.register(rvo);
		log.info("RequestReply insert count: " + insertCount);
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// 게시물별 댓글 목록 확인
	@GetMapping(value = "/pages/{rbno}/{page}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<RequestReplyPageDTO> getList(@PathVariable("page") int page, @PathVariable("rbno") Long rbno) {
		log.info("getList......");
		Criteria cri = new Criteria(page, 10);
		log.info(cri);
		return new ResponseEntity<>(service.getListPage(cri, rbno), HttpStatus.OK);
	}

	// 댓글 1개 읽기
	@GetMapping(value = "/{rrno}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<RequestReplyVO> get(@PathVariable("rrno") Long rrno) {
		log.info("get: " + rrno);
		return new ResponseEntity<>(service.get(rrno), HttpStatus.OK);
	}

	// 댓글 삭제
	@PreAuthorize("principal.username == #rvo.replyer")
	@DeleteMapping(value = "/{rrno}", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> remove(@PathVariable("rrno") Long rrno, @RequestBody RequestReplyVO rvo) {
		log.info("remove: " + rrno);
		return service.remove(rrno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// 댓글 수정
	@PreAuthorize("principal.username == #rvo.replyer")
	@RequestMapping(method = { RequestMethod.PUT,
			RequestMethod.PATCH }, value = "/{rrno}", consumes = "application/json", produces = {
					MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> modify(@RequestBody RequestReplyVO rvo, @PathVariable("rrno") Long rrno) {
		rvo.setRrno(rrno);
		log.info("rrno: " + rrno);
 		return service.modify(rvo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

}
