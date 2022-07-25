package kr.co.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class RequestVO {
	private Long rbno;
	private String title;
	private String content;
	private String writer;
	private String pet;
	private String img;
	private String thumImg;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date startDateTime;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date endDateTime;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	@DateTimeFormat(pattern = "HH:mm")
	private Date startTime;
	@DateTimeFormat(pattern = "HH:mm")
	private Date endTime;
	private String sitter;
	private Date regdate;
	private Date updateDate;
	private String address;
	private String detailAddress;
	private String extraAddress;
	private boolean completed;
	
	private int replyCnt;
	
	private int payment;
}
