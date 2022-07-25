package kr.co.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private int startPage; // 페이징 시작
	private int endPage; // 페이징 끝
	private boolean prev, next;
	private int total; // 총 게시물수
	private Criteria cri; // 현재페이지와 페이지당 게시물수

	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
// 1페이지라고 가정하면 endPage는 10
		this.startPage = this.endPage - 9;// 1
		int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
// 총게시물이 20개라고 가정하면 realEnd=2
// 페이지당 보여줄 게시물 수는 10개로 가정.
		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}
}