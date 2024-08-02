package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.ReservationVO;
import kr.or.ddit.vo.ReviewVO;

public interface IReservationService {
	
	public List<ReservationVO> myResRoomBefore(String userId);
	
	public List<ReservationVO> myResRoomAfter(String userId);
	
	public List<ReservationVO> myResCarBefore(String userId);
	
	public List<ReservationVO> myResCarAfter(String userId);
	
	public List<ReservationVO> afterRoomReview(int resNo);
	
	public int delResBeforeRoom(ReservationVO resVo);
	
	public int delResBeforeCar(ReservationVO resVo);
	
	
}
