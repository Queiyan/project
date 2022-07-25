package kr.co.domain;

import java.util.Date;

import lombok.Data;

@Data
public class AnswerVO {
	
	private Long abno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updateDate;
	private String img;
	private String thumImg;
}
