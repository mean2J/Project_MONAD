package com.jeong.model;

import java.sql.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.jeong.util.JdbcUtil;


public class MemberDAO {
	/*
	 * DAO 클래스는 데이터를 분산 관리 할 필요가 없고 단순 DB 연동만 하기 때문에 불필요하게 여러개 생성할 수 없도록 객체를 1개로
	 * 제한시킵니다 (SINGLETON PATTERN)
	 * 
	 */

	// 싱글톤 패턴 클래스의 생성
	// 1. 스스로의 객체를 생성합니다.
	private static MemberDAO dao = new MemberDAO();

	private DataSource ds; // 데이터 소스 변수
	private Context ct;

	// 2. 외부에서 객체를 생성할 수 없도록 생성자를 막습니다. private으로
	private MemberDAO() {
		// 이와 같은 식으로 해두면 new로 부를 수가 없다.

		try {
			// 커넥션 풀에서 설정해놓은 것을 불러 쓸 코드를 작성

			ct = new InitialContext(); // 처음 톰캣에서 설정해놓은 정보를 가져올 수 있는 객체
			ds = (DataSource) ct.lookup("java:comp/env/jdbc/mysql"); // server.xml에 써있는 코드를 읽어옴 이니셜컨텐스트에서 이름으로 찾아와서 저장

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 3. 외부에서 객체 생성을 요구할 때 공개된 메서드를 통해 객체를 제공
	public static MemberDAO getInstance() {
		// 혹시라도 dao를 호출했을 때 없을 경우 객체를 생성
		if (dao == null) {
			dao = new MemberDAO();
		}
		return dao;
	}

	// members 테이블에 회원가입된 회원인지 확인하는 메서드
	public int userCheck(String id, String pw) {
		int result = 0;

		String sql = "select * from members where id = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) { // 해당 아이디가 존재
				String db_pw = rs.getString("pw");

				if (pw.equals(db_pw)) { // 해당 아이디가 존재함과 동시에 데베 pw와 입력한 pw가 같음
					System.out.println("로그인 성공");
					result = 1;
				} else { // 해당 아이디가 존재하지만 데베 pw와 입력한 pw가 다름
					System.out.println("비밀번호가 다름");
					result = 0;
				}
			} else {
				System.out.println("아이디가 존재하지 않음");
				result = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return result;
	}

	// reservation/findidProc.jsp
	// id와 name, phone3 모두 이용해보기
	// 매개변수 첫번째 아이디 폰번호 이름 구분 두번째꺼 obj
	// sort 자리에 id, name, phone3 가 오면 된다.
	// reservation 테이블에 회원가입된 회원인지 확인하는 메서드 (id부분에 obj를 넣고 sql문을 바꾸기가 되는지 해보기)
	public int userReservationCheck(String sort, String obj) {
		int result = 0;

		String sql = null;
		if (sort.equals("id")) {
			sql = "select * from reservation where customer_id = ?";
		} else {
			sql = "select * from reservation where arrivalTime = ?";
		}

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, obj);
			rs = pstmt.executeQuery();

			if (rs.next()) { // 해당 아이디가 존재
				System.out.println("reservation 테이블에 해당 검색내용이 존재함");
				result = 1;
			} else {
				System.out.println("reservation 테이블에 해당 검색내용이 존재하지 않음");
				result = 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return result;
	}

	// reservation/findidProc.jsp
	// reservation 테이블에 있는 유저정보를 가져오는 메소드
	// sort 자리
	public MemberVO getReservationInfo(String customer_id) { // 여러 개의 정보를 VO를 이용해서 한번에 다 가져옴
		MemberVO member = null;

		String sql = "select * from reservation where customer_id = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, customer_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				member = new MemberVO();

				member.setOid(rs.getInt("oid"));
				member.setCovers(rs.getString("covers"));
				member.setDate(rs.getString("date"));
				member.setTime(rs.getString("time"));
				member.setTable_id(rs.getString("table_id"));
				member.setCustomer_id(rs.getString("customer_id"));
				member.setArrivalTime(rs.getString("arrivalTime"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return member;
	}

	//유저정보
	public MemberVO getUpdateReservationInfo(String customer_id, String date) { // 여러 개의 정보를 VO를 이용해서 한번에 다 가져옴
		MemberVO member = null;

		String sql = "select * from reservation where customer_id = ? and date = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, customer_id);
			pstmt.setString(2, date);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				member = new MemberVO();

				member.setOid(rs.getInt("oid"));
				member.setCovers(rs.getString("covers"));
				member.setDate(rs.getString("date"));
				member.setTime(rs.getString("time"));
				member.setTable_id(rs.getString("table_id"));
				member.setCustomer_id(rs.getString("customer_id"));
				member.setArrivalTime(rs.getString("arrivalTime"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return member;
	}
	
	// members 테이블에 있는 유저정보를 가져오는 메소드
	public MemberVO getMemberInfo(String id) { // 여러 개의 정보를 VO를 이용해서 한번에 다 가져옴
		MemberVO member = null;

		String sql = "select * from members where id = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				member = new MemberVO();

				member.setName(rs.getString("name"));
				member.setId(rs.getString("id"));
				member.setPw(rs.getString("pw"));
				member.setCallCom(rs.getString("callCom"));
				member.setPhone1(rs.getString("phone1"));
				member.setPhone2(rs.getString("phone2"));
				member.setPhone3(rs.getString("phone3"));
				member.setBirth1(rs.getString("birth1"));
				member.setBirth2(rs.getString("birth2"));
				member.setEmail1(rs.getString("email1"));
				member.setEmail2(rs.getString("email2"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setAddress3(rs.getString("address3"));
				member.setJob(rs.getString("job"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return member;
	}

	// members 에 있는 기존 회원인지 확인하는 메소드
	public int userConfirm(String id) {
		int result = 0;

		String sql = "select * from members where id = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) { // 결과가 나오면 해당 아이디가 존재하는 것
				result = 1;
			} else { // 결과가 안 나오는 걸로 해당 아이디가 존재하지 않는 것
				result = 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return result;
	}

	// 회원가입을 위한 메소드
	public int insertUser(MemberVO vo) {
		int result = 0;

		String sql = "insert into members values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getId());
			pstmt.setString(3, vo.getPw());
			pstmt.setString(4, vo.getCallCom());
			pstmt.setString(5, vo.getPhone1());
			pstmt.setString(6, vo.getPhone2());
			pstmt.setString(7, vo.getPhone3());
			pstmt.setString(8, vo.getBirth1());
			pstmt.setString(9, vo.getBirth2());
			pstmt.setString(10, vo.getEmail1());
			pstmt.setString(11, vo.getEmail2());
			pstmt.setString(12, vo.getAddress1());
			pstmt.setString(13, vo.getAddress2());
			pstmt.setString(14, vo.getAddress3());
			pstmt.setString(15, vo.getJob());

			if (vo.getAddress1().length() == 0 || vo.getAddress2().length() == 0 || vo.getAddress3().length() == 0
					|| vo.getBirth1().length() == 0 || vo.getBirth2().length() == 0 || vo.getCallCom().length() == 0
					|| vo.getEmail1().length() == 0 || vo.getEmail2().length() == 0 || vo.getId().length() == 0
					|| vo.getName().length() == 0 || vo.getPhone1().length() == 0 || vo.getPhone2().length() == 0
					|| vo.getPhone2().length() == 0 || vo.getPhone3().length() == 0 || vo.getPw().length() == 0) { // 자동가입
																													// 방지
				result = -1;
				return result;
				// 하나라도 빠져있을 경우 자동가입 방지
			} else {

				int check = pstmt.executeUpdate();

				if (check == 1) { // 성공적으로 정보를 입력했을 경우
					System.out.println("회원가입 성공");
					result = 1;
				} else { // 정보입력 실패
					System.out.println("회원가입 실패");
					result = 0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return result;
	}

	// ID 찾기
	public String forgetId(MemberVO vo) { // 고유번호인 주민등록번호 뒷자리로 검색후 이름, 폰 번호 비교할 코드
		String result = "";

		String sql = "select * from members where birth2 =?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getBirth2());
			rs = pstmt.executeQuery();

			if (rs.next()) { // 주민번호 검색해서 나온 사람

				String db_name = rs.getString("name");
				String db_callCom = rs.getString("callCom");
				String db_phone1 = rs.getString("phone1");
				String db_phone2 = rs.getString("phone2");
				String db_phone3 = rs.getString("phone3");
				String db_birth1 = rs.getString("birth1");
				String db_birth2 = rs.getString("birth2");
				String db_email1 = rs.getString("email1");
				String db_email2 = rs.getString("email2"); // 그 사람의 데베에 저장되있는 정보를 가져옴
				String db_id = rs.getString("id"); // return 해줘야 할 id

				if (db_name.equals(vo.getName()) && db_callCom.equals(vo.getCallCom())
						&& db_phone1.equals(vo.getPhone1()) && db_phone2.equals(vo.getPhone2())
						&& db_phone3.equals(vo.getPhone3()) && db_birth1.equals(vo.getBirth1())
						&& db_birth2.equals(vo.getBirth2()) && db_email1.equals(vo.getEmail1())
						&& db_email2.equals(vo.getEmail2())) {

					// 입력한 정보랑 데이터베이스에서 가져온 정보랑 같을 경우
					System.out.println("아이디 찾기 완료");
					return result + db_id; // db_id가 전송됨
				} else { // 위에 정보가 일치하지 않을 경우
					System.out.println("아이디 찾기 실패하여 NotMember로 이름 설정");
					return result + "NotMember";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return result;
	}

	// 비밀번호 찾기
	public int forgetPw(MemberVO vo) { // 고유번호인 주민등록번호 뒷자리로 검색후 이름, 폰 번호 비교할 코드
		int result = 0;

		String sql = "select * from members where birth2 =?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getBirth2());
			rs = pstmt.executeQuery();

			if (rs.next()) { // 주민번호 검색해서 나온 사람

				String db_name = rs.getString("name");
				String db_id = rs.getString("id");
				String db_callCom = rs.getString("callCom");
				String db_phone1 = rs.getString("phone1");
				String db_phone2 = rs.getString("phone2");
				String db_phone3 = rs.getString("phone3");
				String db_birth1 = rs.getString("birth1");
				String db_birth2 = rs.getString("birth2");
				String db_email1 = rs.getString("email1");
				String db_email2 = rs.getString("email2");

				if (db_name.equals(vo.getName()) && db_id.equals(vo.getId()) && db_callCom.equals(vo.getCallCom())
						&& db_phone1.equals(vo.getPhone1()) && db_phone2.equals(vo.getPhone2())
						&& db_phone3.equals(vo.getPhone3()) && db_birth1.equals(vo.getBirth1())
						&& db_birth2.equals(vo.getBirth2()) && db_email1.equals(vo.getEmail1())
						&& db_email2.equals(vo.getEmail2())) {
					// 아이디와 나머지 정보가 일치할 경우
					sql = "update members set pw = ? where id = ?";

					Connection conn1 = null;
					PreparedStatement pstmt1 = null;

					try { // 비밀번호를 tempPw로 초기화 하는 내용
						conn1 = ds.getConnection();
						pstmt1 = conn.prepareStatement(sql);
						pstmt1.setString(1, vo.getTempPw());
						pstmt1.setString(2, vo.getId());

						int check = pstmt1.executeUpdate();

						if (check == 1) { // 비밀번호 1234 업데이트 완료 되었을 경우
							System.out.println("비밀번호를" + vo.getTempPw() + "로 수정 완료");
							result = 1;
						} else { // 비밀번호가 1234로 업데이트 안 되었을 경우
							System.out.println("비밀번호를" + vo.getTempPw() + "로 수정 실패");
							result = 0;
						}
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						try {
							JdbcUtil.close(conn);
							JdbcUtil.close(pstmt);
						} catch (Exception e2) {
							e2.printStackTrace();
						}
					}

				} else { // 아이디와 나머지 정보가 일치하지 않을 경우
					result = -1;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return result;
	}

	// members 에 있는 사람들 조회하기
	public MemberVO getUserInfo(String id) {
		MemberVO member = null;

		String sql = "select * from members where id = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				member = new MemberVO();

				/*
				 * private String name; private String id; private String pw; private String
				 * callCom; private String phone1; private String phone2; private String phone3;
				 * private String birth1; private String birth2; private String email1; private
				 * String email2; private String address1; private String address2; private
				 * String address3;
				 */

				member.setName(rs.getString("name"));
				member.setId(rs.getString("id"));
				member.setPw(rs.getString("pw"));
				member.setCallCom(rs.getString("callCom"));
				member.setPhone1(rs.getString("phone1"));
				member.setPhone2(rs.getString("phone2"));
				member.setPhone3(rs.getString("phone3"));
				member.setBirth1(rs.getString("birth1"));
				member.setBirth2(rs.getString("birth2"));
				member.setEmail1(rs.getString("email1"));
				member.setEmail2(rs.getString("email2"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setAddress3(rs.getString("address3"));
				member.setJob(rs.getString("job"));

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return member;
	}

	// 회원정보 수정을 위한 메소드
	public int updateUser(MemberVO vo) {
		int result = 0;

		String sql = "update members set pw = ?, callCom = ?, phone1 = ?, phone2 = ?, phone3 = ? "
				+ ", email1 = ?, email2 =?, address1 = ?, address2 =?, address3 =? where id = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			/*
			 * String id = (String)session.getAttribute("user_id");
			 * 
			 * String pw = request.getParameter("pw"); String callCom =
			 * request.getParameter("callCom"); String phone1 =
			 * request.getParameter("phone1"); String phone2 =
			 * request.getParameter("phone2"); String phone3 =
			 * request.getParameter("phone3"); String email1 =
			 * request.getParameter("email1"); String email2 =
			 * request.getParameter("email2"); String address1 =
			 * request.getParameter("address1"); String address2 =
			 * request.getParameter("address2"); String address3 =
			 * request.getParameter("address3");
			 */
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getPw());
			pstmt.setString(2, vo.getCallCom());
			pstmt.setString(3, vo.getPhone1());
			pstmt.setString(4, vo.getPhone2());
			pstmt.setString(5, vo.getPhone3());
			pstmt.setString(6, vo.getEmail1());
			pstmt.setString(7, vo.getEmail2());
			pstmt.setString(8, vo.getAddress1());
			pstmt.setString(9, vo.getAddress2());
			pstmt.setString(10, vo.getAddress3());
			pstmt.setString(11, vo.getId());

			int check = pstmt.executeUpdate();

			if (check == 1) { // 성공적으로 정보를 수정했을 때
				System.out.println("회원정보 수정 완료");
				result = 1;
			} else { // 회원정보를 바꾸지 못했을 경우
				System.out.println("회원정보 수정 실패");
				result = 0;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return result;
	}

	// reservation 선택한 자리에 테이블 예약이 되었는지 확인
	public int reservationCheckTable(String table_id, String time, String date) {
		int result = 0;

		String sql = "select * from reservation where table_id = ? and time = ? and date = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, table_id);
			pstmt.setString(2, time);
			pstmt.setString(3, date);

			rs = pstmt.executeQuery();

			if (rs.next()) { // 예약이 이미 되어있는 상태
				System.out.println("선택하신 날짜 시간에 이미 자리가 선택되어있음");
				result = 0;
			} else { // 예약이 안 되어 있음
				System.out.println("예약 가능");
				result = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return result;
	}

	// reservation 선택한 시간에 테이블 예약이 되었는지 확인
	public int reservationCheckTime(String time,String date, String customer_id) {
		int result = 0;

		String sql = "select * from reservation where time = ? and date = ? and customer_id = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, time);
			pstmt.setString(2, date);
			pstmt.setString(3, customer_id);
			rs = pstmt.executeQuery();

			if (rs.next()) { // 예약이 이미 되어있는 상태
				System.out.println("예약이 이미 되어 불가능");
				result = 0;
			} else { // 예약이 안 되어 있음
				System.out.println("예약 가능");
				result = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return result;
	}

	// reservation 선택한 시간에 테이블 예약이 되었는지 확인
	public int reservationCheckDate(String date, String customer_id) {
		int result = 0;

		String sql = "select * from reservation where date = ? and customer_id = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.setString(2, customer_id);
			rs = pstmt.executeQuery();

			if (rs.next()) { // 예약이 이미 되어있는 상태
				System.out.println("예약이 이미 되어 불가능");
				result = 0;
			} else { // 예약이 안 되어 있음
				System.out.println("예약 가능");
				result = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return result;
	}
	

	// reservation 테이블에 예약하기
	public int reservationConfirm(MemberVO vo) {
		int result = 0;

		String sql = "insert into reservation values(?,?,?,?,?,?,?)";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNextOid());
			pstmt.setString(2, vo.getCovers());
			pstmt.setString(3, vo.getDate());
			pstmt.setString(4, vo.getTime());
			pstmt.setString(5, vo.getTable_id());
			pstmt.setString(6, vo.getCustomer_id());
			pstmt.setString(7, vo.getArrivalTime());

			if (vo.getCovers().length() == 0 || vo.getDate().length() == 0 || vo.getTime().length() == 0
					|| vo.getTable_id().length() == 0) { // 자동가입 방지
				result = -1;
				return result;
				// 하나라도 빠져있을 경우 자동가입 방지
			} else {

				int check = pstmt.executeUpdate();

				if (check == 1) { // 성공적으로 정보를 입력했을 경우
					result = 1;
				} else { // 정보입력 실패
					System.out.println("예약 실패");
					result = 0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return result;
	}

	// customer 테이블에 회원등록을 위한 메소드
	public int insertCustomer(MemberVO vo) {
		int result = 0;

		String sql = "insert into customer values(?,?,?,?)";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getId());
			pstmt.setString(3, vo.getPhone3());
			pstmt.setString(4, vo.getoNum());

			int check = pstmt.executeUpdate();

			if (check == 1) { // 성공적으로 정보를 입력했을 경우
				System.out.println("customer 테이블에 정보넣기 성공");
				result = 1;
			} else { // 정보입력 실패
				System.out.println("customer 테이블에 정보넣기 실패");
				result = 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return result;
	}

	// customer 회원 정보 변경(oNum)을 위한 메소드
	public int updateCustomerUser(MemberVO vo) {
		int result = 0;

		String sql = "update customer set name = ?, id = ?, phone3 = ?, oNum = ?" + " where id = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			/*
			 * String id = (String)session.getAttribute("user_id");
			 * 
			 * String pw = request.getParameter("pw"); String callCom =
			 * request.getParameter("callCom"); String phone1 =
			 * request.getParameter("phone1"); String phone2 =
			 * request.getParameter("phone2"); String phone3 =
			 * request.getParameter("phone3"); String email1 =
			 * request.getParameter("email1"); String email2 =
			 * request.getParameter("email2"); String address1 =
			 * request.getParameter("address1"); String address2 =
			 * request.getParameter("address2"); String address3 =
			 * request.getParameter("address3");
			 */
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getId());
			pstmt.setString(3, vo.getPhone3());
			pstmt.setString(4, vo.getoNum());
			pstmt.setString(5, vo.getId());

			int check = pstmt.executeUpdate();

			if (check == 1) { // 성공적으로 정보를 수정했을 때
				System.out.println("customer 테이블 회원 정보 수정 완료");
				result = 1;
			} else { // 회원정보를 바꾸지 못했을 경우
				System.out.println("customer 테이블 회원정보 수정 실패");
				result = 0;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return result;
	}

	// customer 테이블에 있는 회원정보 찾기
	public MemberVO getCustomerInfo(String id) {
		MemberVO member = null;

		String sql = "select * from customer where id = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				member = new MemberVO();

				member.setName(rs.getString("name"));
				member.setId(rs.getString("id"));
				member.setPhone3(rs.getString("phone3"));
				member.setoNum(rs.getString("oNum"));

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return member;
	}

	// customer 에 있는 기존 회원인지 확인하는 메소드
	public int userCustomerConfirm(String id) {
		int result = 0;

		String sql = "select * from customer where id = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) { // 결과가 나오면 해당 아이디가 customer 테이블에 존재하는 것
				result = 1;
			} else { // 결과가 안 나오는 걸로 해당 아이디가 customer 테이블에 존재하지 않는 것
				result = 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return result;
	}

	// reservation 테이블에 있는 멤버 찾기
	public ArrayList<MemberVO> selectAllMember() {
		ArrayList<MemberVO> list = new ArrayList<MemberVO>();

		String sql = "select * from reservation order by customer_id asc";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				MemberVO vo = new MemberVO();
				vo.setOid(rs.getInt("oid"));
				vo.setCovers(rs.getString("covers"));
				vo.setDate(rs.getString("date"));
				vo.setTime(rs.getString("time"));
				vo.setTable_id(rs.getString("table_id"));
				vo.setCustomer_id(rs.getString("customer_id"));
				vo.setArrivalTime(rs.getString("arrivalTime"));

				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return list;
	}

	// reservation 테이블에 있는 멤버 찾기
	public ArrayList<MemberVO> selectReservationMember(String id) {
		ArrayList<MemberVO> list = new ArrayList<MemberVO>();

		String sql = "select * from reservation where customer_id = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				MemberVO vo = new MemberVO();
				vo.setOid(rs.getInt("oid"));
				vo.setCovers(rs.getString("covers"));
				vo.setDate(rs.getString("date"));
				vo.setTime(rs.getString("time"));
				vo.setTable_id(rs.getString("table_id"));
				vo.setCustomer_id(rs.getString("customer_id"));
				vo.setArrivalTime(rs.getString("arrivalTime"));

				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return list;
	}

	// reservation 테이블에 사람 지우기
	public int DeleteUpdateReservation(String customer_id, int oid) {
		int rst = 0;

		String sql = "delete from reservation where customer_id = ? and oid = ? order by oid desc";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, customer_id);
			pstmt.setInt(2, oid);

			rst = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return rst;
	}

	// reservation 테이블에 사람 지우기
	public int DeleteReservation(String customer_id, String date) {
		int rst = 0;

		String sql = "delete from reservation where customer_id = ? and date = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, customer_id);
			pstmt.setString(2,date);

			rst = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return rst;
	}
	public ArrayList<MemberVO> findInfo(String req, int index) {
		ArrayList<MemberVO> list = new ArrayList<MemberVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			conn = ds.getConnection();
			if (index == 0) {
				// 안되면 여기 name customer_id
				sql = "select * from reservation where customer_id like ? order by customer_id asc";
			} else {
				sql = "select * from reservation where time like ? order by customer_id asc";
			}
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, req);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MemberVO vo = new MemberVO();
				vo.setOid(rs.getInt("oid"));
				vo.setCovers(rs.getString("covers"));
				vo.setDate(rs.getString("date"));
				vo.setTime(rs.getString("time"));
				vo.setTable_id(rs.getString("table_id"));
				vo.setCustomer_id(rs.getString("customer_id"));
				vo.setArrivalTime(rs.getString("arrivalTime"));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return list;
	}

	// 현재 시간을 가져오는 함수
	public String getDate() {

		String sql = "select now()";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getString(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return "";
	}

	// bbsID 게시글 번호 가져오는 함수
	public int getNext() {

		String sql = "select bbsID from bbs order by bbsID desc";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getInt(1) + 1;
			}

			return 1; // 첫번째 게시물인 경우

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return -1;
	}

	// 글을 작성하는 함수
	public int write(String bbsTitle, String userID, String bbsContent) {

		String sql = "insert into bbs values(?,?,?,?,?,?)";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = ds.getConnection();

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);

			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return -1; // 데이터베이스 오휴
	}

	// 게시판 목록 가져오기
	public ArrayList<MemberVO> getList(int pageNumber) {

		String sql = "select * from bbs where bbsID < ? and bbsAvailable = 1 order by bbsID desc limit 10";

		ArrayList<MemberVO> list = new ArrayList<MemberVO>();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				MemberVO vo = new MemberVO();

				vo.setBbsID(rs.getInt(1));
				vo.setBbsTitle(rs.getString(2));
				vo.setUserID(rs.getString(3));
				vo.setBbsDate(rs.getString(4));
				vo.setBbsContent(rs.getString(5));
				vo.setBbsAvailable(rs.getInt(6));

				list.add(vo);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return list;
	}

	// 10단위 페이징 처리를 위한 함수
	public boolean nextPage(int pageNumber) {

		String sql = "select * from bbs where bbsID < ? and bbsAvailable = 1 order by bbsID desc limit 10";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return false;
	}

	// 리뷰들 가져오기
	public MemberVO getBbs(int bbsID) {

		String sql = "select * from bbs where bbsID = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = ds.getConnection();

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				MemberVO vo = new MemberVO();

				vo.setBbsID(rs.getInt(1));
				vo.setBbsTitle(rs.getString(2));
				vo.setUserID(rs.getString(3));
				vo.setBbsDate(rs.getString(4));
				vo.setBbsContent(rs.getString(5));
				vo.setBbsAvailable(rs.getInt(6));

				return vo;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				JdbcUtil.close(conn);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return null;
	}
	
	// 리뷰 수정
		public int update(int bbsID, String bbsTitle, String bbsContent) {

			String sql = "update bbs set bbsTitle = ?, bbsContent = ? where bbsID = ?";

			Connection conn = null;
			PreparedStatement pstmt = null;
			

			try {
				conn = ds.getConnection();

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, bbsTitle);
				pstmt.setString(2, bbsContent);
				pstmt.setInt(3, bbsID);
				
				return pstmt.executeUpdate();

				

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					JdbcUtil.close(conn);
					JdbcUtil.close(pstmt);
		
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}

			return -1;	//데이터베이스 오류
		}
		
		// 리뷰 삭제
		public int delete(int bbsID) {

			String sql = "update bbs set bbsAvailable = 0 where bbsID = ?";

			Connection conn = null;
			PreparedStatement pstmt = null;
	

			try {
				conn = ds.getConnection();

				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bbsID);
				
				return pstmt.executeUpdate();
				
				

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					JdbcUtil.close(conn);
					JdbcUtil.close(pstmt);
				
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}

			return -1;
		}
		
		// 공지사항 게시글 번호 가져오는 함수
		public int getNextNotice() {

			String sql = "select bbsIDn from bbsn order by bbsIDn desc";

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				conn = ds.getConnection();

				pstmt = conn.prepareStatement(sql);
				
				rs = pstmt.executeQuery();

				if (rs.next()) {
					return rs.getInt(1) +1;
				}
				
				return 1; //첫번째 게시물일 경우

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					JdbcUtil.close(conn);
					JdbcUtil.close(pstmt);
					JdbcUtil.close(rs);
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}

			return -1;
		}
		
		// 공지사항을 작성하는 함수
		public int writeNotice(String bbsTitlen, String userIDn, String bbsContentn) {

			String sql = "insert into bbsn values(?,?,?,?,?,?)";

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				conn = ds.getConnection();

				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, getNextNotice());
				pstmt.setString(2, bbsTitlen);
				pstmt.setString(3, userIDn);
				pstmt.setString(4, getDate());
				pstmt.setString(5, bbsContentn);
				pstmt.setInt(6, 1);
				
				return pstmt.executeUpdate();

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					JdbcUtil.close(conn);
					JdbcUtil.close(pstmt);
					JdbcUtil.close(rs);
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}

			return -1;	//데이터베이스 오류
		}
		
		// 공지사항 목록 가져오기
		public ArrayList<MemberVO> getListNotice(int pageNumber) {

			String sql = "select * from bbsn where bbsIDn < ? and bbsAvailablen = 1 order by bbsIDn desc limit 10";
			
			ArrayList<MemberVO> list = new ArrayList<MemberVO>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				conn = ds.getConnection();

				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, getNextNotice() - (pageNumber -1)*10);
				rs = pstmt.executeQuery();

				while(rs.next()) {
					MemberVO vo = new MemberVO();
					
					vo.setBbsIDn(rs.getInt(1));
					vo.setBbsTitlen(rs.getString(2));
					vo.setUserIDn(rs.getString(3));
					vo.setBbsDaten(rs.getString(4));
					vo.setBbsContentn(rs.getString(5));
					vo.setBbsAvailablen(rs.getInt(6));
					
					list.add(vo);
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					JdbcUtil.close(conn);
					JdbcUtil.close(pstmt);
					JdbcUtil.close(rs);
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}

			return list;
		}
		
		// 공지사항 페이징 처리
		public boolean nextPageNotice(int pageNumber) {

			String sql = "select * from bbsn where bbsIDn < ? and bbsAvailablen = 1 order by bbsIDn desc limit 10";

			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				conn = ds.getConnection();

				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, getNextNotice() - (pageNumber - 1)*10);
				rs = pstmt.executeQuery();

				if (rs.next()) {
	
					return true;
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					JdbcUtil.close(conn);
					JdbcUtil.close(pstmt);
					JdbcUtil.close(rs);
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}

			return false;
		}
		
		// 공지사항 가져오기
		public MemberVO getBbsNotice(int bbsIDn) {

			String sql = "select * from bbsn where bbsIDn = ?";

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				conn = ds.getConnection();

				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bbsIDn);
				rs = pstmt.executeQuery();

				if (rs.next()) {
					MemberVO vo = new MemberVO();

					vo.setBbsIDn(rs.getInt(1));
					vo.setBbsTitlen(rs.getString(2));
					vo.setUserIDn(rs.getString(3));
					vo.setBbsDaten(rs.getString(4));
					vo.setBbsContentn(rs.getString(5));
					vo.setBbsAvailablen(rs.getInt(6));

					return vo;
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					JdbcUtil.close(conn);
					JdbcUtil.close(pstmt);
					JdbcUtil.close(rs);
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}

			return null;
		}
		
		// 공지사항 수정
		public int updateNotice(int bbsIDn, String bbsTitlen, String bbsContentn) {

			String sql = "update bbsn set bbsTitlen = ? , bbsContentn = ? where bbsIdn = ?";

			Connection conn = null;
			PreparedStatement pstmt = null;

			try {
				conn = ds.getConnection();

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, bbsTitlen);
				pstmt.setString(2, bbsContentn);
				pstmt.setInt(3, bbsIDn);
				
				return pstmt.executeUpdate();

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					JdbcUtil.close(conn);
					JdbcUtil.close(pstmt);
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}

			return -1; //데이터베이스 오류
		}
		
		// 공지사항 삭제
				public int deleteNotice(int bbsIDn) {

					String sql = "update bbsn set bbsAvailablen = 0 where bbsIDn = ?";
					
					Connection conn = null;
					PreparedStatement pstmt = null;

					try {
						conn = ds.getConnection();

						pstmt = conn.prepareStatement(sql);

						pstmt.setInt(1, bbsIDn);
						
						return pstmt.executeUpdate();

					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						try {
							JdbcUtil.close(conn);
							JdbcUtil.close(pstmt);
						} catch (Exception e2) {
							e2.printStackTrace();
						}
					}

					return -1; //데이터베이스 오류
				}
				
				// reservation oid 게시글 번호 가져오는 함수
				public int getNextOid() {

					String sql = "select oid from reservation order by oid desc";

					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;

					try {
						conn = ds.getConnection();

						pstmt = conn.prepareStatement(sql);

						rs = pstmt.executeQuery();

						if (rs.next()) {
							return rs.getInt(1) + 1;
						}

						return 1; // 첫번째 게시물인 경우

					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						try {
							JdbcUtil.close(conn);
							JdbcUtil.close(pstmt);
							JdbcUtil.close(rs);
						} catch (Exception e2) {
							e2.printStackTrace();
						}
					}

					return -1;
				}
				
				// reservation 예약 정보 변경을 위한 메소드
				public int updateReservation(MemberVO vo) {
					int result = 0;

					String sql = "update reservation set covers = ?, date = ?, time = ?, table_id = ?, arrivalTime = ?, customer_id = ? where oid = ?";

					Connection conn = null;
					PreparedStatement pstmt = null;

					try {
						/*
						 * String id = (String)session.getAttribute("user_id");
						 * 
						 * String pw = request.getParameter("pw"); String callCom =
						 * request.getParameter("callCom"); String phone1 =
						 * request.getParameter("phone1"); String phone2 =
						 * request.getParameter("phone2"); String phone3 =
						 * request.getParameter("phone3"); String email1 =
						 * request.getParameter("email1"); String email2 =
						 * request.getParameter("email2"); String address1 =
						 * request.getParameter("address1"); String address2 =
						 * request.getParameter("address2"); String address3 =
						 * request.getParameter("address3");
						 */
						conn = ds.getConnection();
						
						pstmt = conn.prepareStatement(sql);
						
						pstmt.setString(1, vo.getCovers());
						pstmt.setString(2, vo.getDate());
						pstmt.setString(3, vo.getTime());
						pstmt.setString(4, vo.getTable_id());
						pstmt.setString(5, vo.getArrivalTime());
						pstmt.setString(6, vo.getCustomer_id());
						pstmt.setInt(7, vo.getOid());

						int check = pstmt.executeUpdate();

						if (check == 1) { // 성공적으로 정보를 수정했을 때
							System.out.println("예약 정보 수정 완료");
							result = 1;
						} else { // 회원정보를 바꾸지 못했을 경우
							System.out.println("예약 정보 수정 실패");
							result = 0;
						}

					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						try {
							JdbcUtil.close(conn);
							JdbcUtil.close(pstmt);
						} catch (Exception e2) {
							e2.printStackTrace();
						}
					}

					return result;
				}

				
}
