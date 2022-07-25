package kr.co.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int pageNum; 
	private int amount;
	private String type; // 검색 타입. 내용+제목+작성자
	private String keyword; // 검색어. 예) 새로

	public String[] getTypeArr() {
		// 검색 타입 배열 가져오기.
		return type == null ? new String[] {} : type.split("");
		// 삼항연사자는 (조건)?참:거짓;
		// 검색타입이 널이라면 비여있는 문자열 배열을 만들고,
		// 그렇지 않다면, 검색타입을 한글자씩 잘라서 문자열 배열로 만듦.
	}
	
	public Criteria() {
		this(1, 10); 
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
