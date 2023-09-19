package com.ffc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDao {
	Connection connection;

	public LikeDao(Connection connection) {
		super();
		this.connection = connection;
	}

	public boolean insertLike(int pid, int uid) {
		boolean f = false;
		try {
			String query = "INSERT INTO POST_LIKE(PID, ID) VALUES(?,?)";
			PreparedStatement pstmt = this.connection.prepareStatement(query);
			pstmt.setInt(1, pid);
			pstmt.setInt(2, uid);
			pstmt.executeUpdate();
			f = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public int likeCount(int pid) {
	int count = 0;
		try {
			String query = "SELECT COUNT(*) FROM POST_LIKE WHERE PID=?";
			PreparedStatement pstmt = this.connection.prepareStatement(query);
			pstmt.setInt(1, pid);
			ResultSet rSet = pstmt.executeQuery();
			if(rSet.next())
				count = rSet.getInt(1); // 1 means first column (we can also write getInt(count(*)))
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	public boolean isLikedByUser(int pid, int uid) {
		boolean f = false;
		try {
			String query = "SELECT * FROM POST_LIKE WHERE PID =? AND ID=?";
			PreparedStatement pstmt = this.connection.prepareStatement(query);
			pstmt.setInt(1, pid);
			pstmt.setInt(2, uid);
			ResultSet rSet = pstmt.executeQuery();
			if(rSet.next())
				f=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public void deleteLike(int pid, int uid) {
		try {
			String query = "DELETE FROM POST_LIKE WHERE PID =? AND ID=?";
			PreparedStatement pstmt = this.connection.prepareStatement(query);
			pstmt.setInt(1, pid);
			pstmt.setInt(2, uid);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
