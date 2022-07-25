package kr.co.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class SitterReviewDTO {
	private double totalAvg;
	private int count;

}
