package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.BoardBean;

public class CommentDAO {
	public Connection getConnection() throws Exception {
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		con = ds.getConnection();
		return con;
	}
	//gcontent에 댓글 작성
	public int insertComment(CommentBean cb) {	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int c_num = 0;
		try {
			con = getConnection();
			// comment_num 최대값 구하기
			String sql = "select max(c_num) from comment";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				c_num = rs.getInt("max(c_num)") + 1;
			}
			// 댓글 추가 시키기
			sql = "insert into comment values (?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, c_num);
			// gallery 번호
			pstmt.setInt(2, cb.getNum());
			pstmt.setString(3, cb.getId());
			pstmt.setString(4, cb.getContent());
			pstmt.executeUpdate();
			// gallery DB에 댓글수 증가시키기
			sql = "update gallery set cmtCount=cmtCount+1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cb.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch (SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if(con != null) try {con.close();} catch (SQLException e) {}
		}
		// gallery 번호 전달
		return cb.getNum();
	}
	// 댓글 총 갯수 구하기
	public int getCommentCount(int num) {
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "select count(*) from comment where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count(*)");
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
	// 게시글 번호로 댓글리스트 가져오기
	public List getCommentList(int num, int startRow, int size) {	
		List list = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "select * from comment where num=? "
					+ "order by date desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, size);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CommentBean cb = new CommentBean();
				cb.setC_num(rs.getInt("c_num"));
				cb.setNum(rs.getInt("num"));
				cb.setId(rs.getString("id"));
				cb.setContent(rs.getString("content"));
				cb.setDate(rs.getDate("date"));
				list.add(cb);
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
	// 댓글 삭제하기 - cmtCount 도 1줄여줘야함
	public int deleteComment(int c_num, int num) {
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "delete from comment where c_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, c_num);
			pstmt.executeUpdate();
			sql = "update gallery set cmtCount=cmtCount-1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch (SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if(con != null) try {con.close();} catch (SQLException e) {}
		}
		return count;
	}
	// 댓글 수정하기 위해 댓글정보를 가져옴
	public CommentBean getComment(int c_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CommentBean cb = null;
		try {
			con = getConnection();
			String sql = "select * from comment where c_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, c_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cb = new CommentBean();
				cb.setNum(rs.getInt("num"));
				cb.setContent(rs.getString("content"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch (SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if(con != null) try {con.close();} catch (SQLException e) {}
		}
		return cb;
	}
	public void updateComment(CommentBean cb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			String sql = "update comment set content=? where c_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cb.getContent());
			pstmt.setInt(2, cb.getC_num());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if(con != null) try {con.close();} catch (SQLException e) {}
		}
	}
}
