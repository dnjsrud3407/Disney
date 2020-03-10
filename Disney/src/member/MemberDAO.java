package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.sun.corba.se.spi.orbutil.fsm.Guard.Result;

public class MemberDAO {
	public Connection getConnection() throws Exception{
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		con = ds.getConnection();
		return con;
	}
	
	public void insertMember(MemberBean mb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			String sql = 
					"insert into member(id,pass,name,reg_date,email,address_postcode,address,phone,mobile) values(?,?,?,now(),?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPass());
			pstmt.setString(3, mb.getName());
			pstmt.setString(4, mb.getEmail());
			pstmt.setString(5, mb.getAddress_postcode());
			pstmt.setString(6, mb.getAddress());
			pstmt.setString(7, mb.getPhone());
			pstmt.setString(8, mb.getMobile());
			pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if(con != null) try {con.close();} catch (SQLException e) {}
		}
	}
	
	public int userCheck(String id, String pass) {		// login, update, delete할 때 사용
		int check = -1;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {	// 일치하는 id가 있으면
				String dbpass = rs.getString("pass");
				if(dbpass.equals(pass)) {	// 비밀번호가 일치하면
					check = 1;
				} else {					// 비밀번호가 일치하지 않으면
					check = 0;
				}
			} else {
				check = -1;					// id가 없으면
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch (SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if(con != null) try {con.close();} catch (SQLException e) {}
		}
		return check;	// 일치하는 id가 없으면 기본값인 -1이 전달
	}
	
	public int idCheck(String id) {		// login시 중복체크
		int check = -1;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {	// 일치하는 id가 있으면
				check = 1;
			} else {
				check = -1;	// id가 없으면 - 아이디 사용가능
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch (SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if(con != null) try {con.close();} catch (SQLException e) {}
		}
		return check;	// 일치하는 id가 없으면 기본값인 -1이 전달
	}
	
	public int updateMember(MemberBean mb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int check = userCheck(mb.getId(), mb.getPass());
		if(check == 1) {
			try {
				con = getConnection();
				String sql = "update member set name=?,email=?,address_postcode=?,address=?,phone=?,mobile=? where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, mb.getName());
				pstmt.setString(2, mb.getEmail());
				pstmt.setString(3, mb.getAddress_postcode());
				pstmt.setString(4, mb.getAddress());
				pstmt.setString(5, mb.getPhone());
				pstmt.setString(6, mb.getMobile());
				pstmt.setString(7, mb.getId());
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(pstmt != null) try {pstmt.close();} catch (SQLException e) {}
				if(con != null) try {con.close();} catch (SQLException e) {}
			}
		}
		return check;
	}
	public MemberBean getMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberBean mb = new MemberBean();
		try {
			con = getConnection();
			String sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setEmail(rs.getString("email"));
				mb.setAddress_postcode(rs.getString("address_postcode"));
				mb.setAddress(rs.getString("address"));
				mb.setPhone(rs.getString("phone"));
				mb.setMobile(rs.getString("mobile"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch (SQLException e) {}
			if(pstmt != null) try {pstmt.close();} catch (SQLException e) {}
			if(con != null) try {con.close();} catch (SQLException e) {}
		}
		return mb;
	}
	public int deleteMember(String id, String pass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int check = userCheck(id, pass);
		if(check == 1) {
			try {
				con = getConnection();
				String sql = "delete from member where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(pstmt != null) try {pstmt.close();} catch (SQLException e) {}
				if(con != null) try {con.close();} catch (SQLException e) {}
			}
		}
		return check;
	} // deleteMember()
	
}
