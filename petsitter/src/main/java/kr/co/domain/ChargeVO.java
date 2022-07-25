package kr.co.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ChargeVO {
	private String userid;
	private String chargeId;
	private Date chargeDate;
	private int point;
	
}
