package kr.co.controller;

import java.io.File;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import kr.co.domain.Criteria;
import kr.co.domain.SitRequestReplyPageDTO;
import kr.co.domain.SitRequestReplyVO;
import kr.co.service.SitRequestReplyService;
import kr.co.utils.UploadFileUtils;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/sitreplies/")
@RestController
@Log4j
@AllArgsConstructor
public class SitRequestReplyController {
	private SitRequestReplyService service;

	@Resource(name = "uploadPath")
	private String uploadPath;

	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new")
	public ResponseEntity<String> create(SitRequestReplyVO srvo, MultipartFile file) throws Exception {
		log.info("SitRequestReplyVO: " + srvo);

		log.info("file : " + file);

		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;

		// 새로운 파일이 등록되었는지 확인
		if (file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);

		} else {
			fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		srvo.setImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		srvo.setThumbImg(
				File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);

		int insertCount = service.register(srvo);
		log.info("SitRequestReply insert count: " + insertCount);

		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// 게시물별 댓글 목록 확인
	@GetMapping(value = "/pages/{sbno}/{page}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<SitRequestReplyPageDTO> getList(@PathVariable("page") int page,
			@PathVariable("sbno") Long sbno) {
		log.info("getList......");
		Criteria cri = new Criteria(page, 10);
		log.info(cri);
		return new ResponseEntity<>(service.getListPage(cri, sbno), HttpStatus.OK);
	}

	// 댓글 1개 읽기
	@GetMapping(value = "/{rsbno}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<SitRequestReplyVO> get(@PathVariable("rsbno") Long rsbno) {
		log.info("get: " + rsbno);
		return new ResponseEntity<>(service.get(rsbno), HttpStatus.OK);
	}

	// 댓글 삭제
	@PreAuthorize("principal.username == #srvo.replyer")
	@DeleteMapping(value = "/{rsbno}", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> remove(@PathVariable("rsbno") Long rsbno, @RequestBody SitRequestReplyVO srvo) {
		log.info("remove: " + rsbno);
		return service.remove(rsbno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// 댓글 수정
//   @PreAuthorize("principal.username == #srvo.replyer")
	@PostMapping(value = "/{rsbno}")
	public ResponseEntity<String> modify(SitRequestReplyVO srvo, @PathVariable("rsbno") Long rsbno, MultipartFile file,
			HttpServletRequest req) throws Exception {
		srvo.setRsbno(rsbno);
		log.info("rsbno: " + rsbno);
		log.info("rsbno: " + srvo);
		log.info("rsbno: " + file);

		if (srvo.getImg() == null && srvo.getImg().equals("")) {
			// 새로운 파일이 등록되었는지 확인
			if (file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
				// 기존 파일을 삭제
				new File(uploadPath + req.getParameter("img")).delete();
				new File(uploadPath + req.getParameter("thumbImg")).delete();

				// 새로 첨부한 파일을 등록
				String imgUploadPath = uploadPath + File.separator + "imgUpload";
				String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
				String fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(),
						ymdPath);

				srvo.setImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
				srvo.setThumbImg(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_"
						+ fileName);

			} else { // 새로운 파일이 등록되지 않았다면
				// 기존 이미지를 그대로 사용
				srvo.setImg(req.getParameter("img"));
				srvo.setThumbImg(req.getParameter("thumbImg"));

			}
		}

		return service.modify(srvo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping("/completed")
	public ResponseEntity<String> matching(Long rsbno) {
		log.info(rsbno);
		service.iscompleted(rsbno);
		

		return service.iscompleted(rsbno) ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);	}

}