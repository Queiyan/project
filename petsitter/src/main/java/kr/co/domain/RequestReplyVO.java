package kr.co.domain;

import java.util.Date;

import lombok.Data;

@Data
public class RequestReplyVO {
	private Long rrno;
	private Long rbno;
	private String reply;
	private String replyer;
	private Date replyDate;
	private Date updateDate;
}
