package com.ehr.web.attend;

public class Paging {
	private int totalCnt; // 게시물의 총 개수
	private int pageSize; // 각 페이지에 표시할 항목 개수
	private int naviSize = 10; // 페이지 네비게이션의 크기 (페이지 링크 수)
	private int totalPage; // totalCnt와 pageSize를 기반으로 계산된 전체 페이지 수.
	private int page; // 현재 페이지 번호.
	private int startPage; // 네비게이션에서 표시될 첫 번째 페이지 번호
	private int endPage; // 네비게이션에서 표시될 마지막 페이지 번호
	private boolean showPrev; // 이전 페이지로 이동하는 링크 표시할지 여부
	private boolean showNext; // 다음 페이지로 이동하는 링크 표시할지 여부

	// 항목의 총 개수와 현재 페이지 번호를 인자로 받음(pageSize 를 10으로 설정)
	public Paging(int totalCnt, int page) {
		this(totalCnt, page, 10);
	}

	// 항목의 총 개수, 현재 페이지 번호 및 페이지 크기를 지정
	public Paging(int totalCnt, int page, int pageSize) {
		this.totalCnt = totalCnt; // 전체 항목 수로 초기화
		this.page = page; // 현재 페이지 번호로 초기화
		this.pageSize = pageSize; // 페이지당 항목 수로 초기화

		// 전체 항목 수를 페이지당 항목 수로 나누고 소수점 올림
		totalPage = (int) Math.ceil(totalCnt / (double) pageSize);

		// 페이지 번호는 1부터 시작
		// (page-1) / naviSize * naviSize + 1 공식 사용
		startPage = (page - 1) / naviSize * naviSize + 1;

		// 마지막 페이지 번호를 계산
		// 최대 페이지 수인 totalPage를 초과하지 않도록 Math.min() 함수를 사용
		endPage = Math.min(startPage + naviSize - 1, totalPage);

		// startPage가 1이 아닐 때
		showPrev = startPage != 1;

		// endPage가 totalPage와 같지 않을 때
		showNext = endPage != totalPage;
	}

	// 현재 페이지 번호, "이전" 및 "다음" 링크, 페이지 번호 범위를 포함한 정보를 출력
	// showPrev와 showNext를 사용하여 "이전"과 "다음" 링크를 표시 여부를 결정.
	void print() {
		// 현재 페이지 번호를 표시
		System.out.println("page = " + page);

		// showPrev가 true일 경우 PREV를 출력
		System.out.print(showPrev ? "[PREV]" : "");

		// startPage ! endPage까지 반복하면서
		// 각 페이지 번호와 공백을 출력
		for (int i = startPage; i <= endPage; i++) {
			System.out.println(i + " ");
		}
		// showNext가 true일 경우 NEXT 출력
		System.out.println(showNext ? "[NEXT]" : "");
	}

	public int getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getNaviSize() {
		return naviSize;
	}

	public void setNaviSize(int naviSize) {
		this.naviSize = naviSize;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isShowPrev() {
		return showPrev;
	}

	public void setShowPrev(boolean showPrev) {
		this.showPrev = showPrev;
	}

	public boolean isShowNext() {
		return showNext;
	}

	public void setShowNext(boolean showNext) {
		this.showNext = showNext;
	}

}