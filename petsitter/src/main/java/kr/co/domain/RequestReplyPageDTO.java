package kr.co.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class RequestReplyPageDTO {

	private int replyTotalCnt;// 덧글의 갯수 replyTotalCnt 가 더 어울림.
	private List<RequestReplyVO> list;// 덧글의 목록

}
