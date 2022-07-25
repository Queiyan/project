package kr.co.domain;

import java.util.Date;

import lombok.Data;

@Data
public class SitterInfoVO {
	private int sno; 
	private String sitter; 
	private String requester;
	private String review; 
	private double average; 
	private Date enddate;
	
//	private double totalAvg;
//	private int count;
	

}
