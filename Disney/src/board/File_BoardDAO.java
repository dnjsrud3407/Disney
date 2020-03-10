package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class File_BoardDAO {
	public Connection getConnection() throws Exception {
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		con = ds.getConnection();
		return con;
	}
	
	public int getBoardCount() {		// 전체 게시글 개수
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = getConnection();
			String sql = "select count(*) from f_board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				count = Integer.parseInt(rs.getString(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch (SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if(con != null) try {con.close();} catch (SQLException e) {}
		}
		return count;
	}
	public int getBoardCount(String search) {	// 검색어 포함한 게시글 수 가져오기
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = getConnection();
			String sql = "select count(*) from f_board where subject like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				count = Integer.parseInt(rs.getString(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch (SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if(con != null) try {con.close();} catch (SQLException e) {}
		}
		return count;
	}
	
	public String compareDate(File_BoardBean getbb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String time = null;
		try {
			con = getConnection();
			sql = "select time(date) from f_board where date(now())=date(?) and num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setDate(1, getbb.getDate());
			pstmt.setInt(2, getbb.getNum());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				time = rs.getString("time(date)");
			}else{
				sql = "select date(date) from f_board where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, getbb.getNum());
				rs = pstmt.executeQuery();
				if(rs.next()) {
					time = rs.getString("date(date)");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch (SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if(con != null) try {con.close();} catch (SQLException e) {}
		}
		return time;
	}
	
	//notice, main에서 전체 게시글 가지고 올 때 사용
	public List getBoardList(int startRow, int pageSize) {	
		List list = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "select * from f_board order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				File_BoardBean bb = new File_BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setId(rs.getString("id"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getDate("date"));
				list.add(bb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch (SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if(con != null) try {con.close();} catch (SQLException e) {}
		}
		return list;
	}
	
	public List getBoardList(int startRow, int pageSize, String search) {	
		List list = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = 
			"select * from f_board where subject like ? order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				File_BoardBean bb = new File_BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setId(rs.getString("id"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getDate("date"));
				list.add(bb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch (SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if(con != null) try {con.close();} catch (SQLException e) {}
		}
		return list;
	}
	
	public void updateReadCount(int num) {	// content에서 게시글 조회수 증가
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			String sql = "update f_board set readcount = readcount + 1 where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if(con != null) try {con.close();} catch (SQLException e) {}
		}
	}
	
	public File_BoardBean getBoard(int num) {	// content에서 게시글 보기
		File_BoardBean bb = new File_BoardBean();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			String sql = "select * from f_board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bb.setNum(num);
				bb.setId(rs.getString("id"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getDate("date"));
				bb.setFile(rs.getString("file"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch (SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if(con != null) try {con.close();} catch (SQLException e) {}
		}
		return bb;
	}
	
	public int insertBoard(File_BoardBean getbb) {	//writeBoard에서 게시글 작성
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int num = 0;
		try {
			con = getConnection();
			// num 최대값 구하기
			String sql = "select max(num) from f_board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num = rs.getInt("max(num)") + 1;
			}
			sql = "insert into f_board(id, subject, content, readcount, date, num, file)"
				+ "values (?,?,?,?,now(),?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, getbb.getId());
			pstmt.setString(2, getbb.getSubject());
			pstmt.setString(3, getbb.getContent());
			pstmt.setInt(4, 0);
			pstmt.setInt(5, num);
			pstmt.setString(6, getbb.getFile());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch (SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if(con != null) try {con.close();} catch (SQLException e) {}
		}
		return num;
	}
	public void updateForm(File_BoardBean bb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			String sql = "update f_board set subject=?, content=?, file=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bb.getSubject());
			pstmt.setString(2, bb.getContent());
			pstmt.setString(3, bb.getFile());
			pstmt.setInt(4, bb.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if(con != null) try {con.close();} catch (SQLException e) {}
		}
	}
	public void deleteForm(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			String sql = "delete from f_board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if(con != null) try {con.close();} catch (SQLException e) {}
		}
	}
}


















