package kr.co.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class SitRequestVO {
	private Long sbno;
	private String title;
	private String content;
	private String writer;
	private String pet;
	private String img;
	private String thumImg;
	private String requester;
	private Date regdate;
	private Date updateDate;
	private String address;
	private String detailAddress;
	private String extraAddress;
	private boolean completed;
	
	private int replyCnt;

}
