package dao;
import java.sql.*;

public class LikeDao {
	Connection con;
	public LikeDao(Connection con) {
		this.con = con;
	}
	public boolean insertLike(int pid, int uid) {
		boolean f = false;
		try {
			String query = "insert into liked(pid, uid) values (?, ? )";
			PreparedStatement pstmt = con.prepareStatement(query);
	        pstmt.setInt(1, pid);
	        pstmt.setInt(2, uid);
	        pstmt.executeUpdate();
	        f = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return f;
	}
	
	public int countLikeOnPost(int pid) {
		int count = 0;
		try {
			String query = "select count(*) from liked where pid = ?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, pid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count(*)");
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}
	
}