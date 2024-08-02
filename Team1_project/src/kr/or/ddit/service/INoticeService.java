package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.NoticeVO;

public interface INoticeService {
	
	//공지사항 조회
	public List<NoticeVO> noticeList();
	
	//공지사항 상세내용 조회
	public NoticeVO noticeDetail(int noticeNo);
	
	//공지사항 등록
	public int noticeInsert(NoticeVO vo);
	
	//공지사항 삭제
	public int noticeDelete(int noticeNo);
	

}
