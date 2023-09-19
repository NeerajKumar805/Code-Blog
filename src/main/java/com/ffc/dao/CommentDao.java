package com.ffc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.ffc.entitites.Comment;

public class CommentDao {
	Connection connection;

	public CommentDao(Connection connection) {
		super();
		this.connection = connection;
	}

	public boolean addComment(Comment cmt) {
		boolean f = false;
		System.out.println("Comment addded successfully");
		try {

			String q = "INSERT INTO COMMENTS (postCmt, postId) VALUES(?,?)";
			PreparedStatement pstmt = connection.prepareStatement(q);
			pstmt.setString(1, cmt.getCmt());
			pstmt.setInt(2, cmt.getPid());
			pstmt.executeUpdate();
			f = true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		f = true;
		return f;
	}
}
