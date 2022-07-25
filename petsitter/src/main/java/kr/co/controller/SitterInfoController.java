package kr.co.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.domain.SitterInfoVO;
import kr.co.domain.SitterReviewDTO;
import kr.co.service.SitterInfoService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/sitterInfo/")
@AllArgsConstructor
@Controller
public class SitterInfoController {
	private SitterInfoService service;

	// 게시물별 댓글 목록 확인
	@GetMapping(value = "/list/{sitter}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<List<SitterInfoVO>> getList(@PathVariable("sitter") String sitter) {
		log.info("getList......");
		
		return new ResponseEntity<>(service.getReview(sitter), HttpStatus.OK);
	}

	// 댓글 1개 읽기
	@GetMapping(value = "/{sitter}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<SitterReviewDTO> get(@PathVariable("sitter") String sitter) {
		log.info("get: " + sitter);
		
		int cnt = service.reviewCount(sitter);
		if (cnt == 0) {
			SitterReviewDTO sitterReview = new SitterReviewDTO(0,service.getCount(sitter));
			return new ResponseEntity<>(sitterReview, HttpStatus.OK);


		} else {
			SitterReviewDTO sitterReview = new SitterReviewDTO(service.getAvg(sitter),service.getCount(sitter));
			return new ResponseEntity<>(sitterReview, HttpStatus.OK);
		}
		

	}
	
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> create(@RequestBody SitterInfoVO svo) {
		log.info("SitterInfoVO: " + svo);
		int insertCount = service.insertReview(svo);
		log.info("SitterInfo insert count: " + insertCount);
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
