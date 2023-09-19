package com.ffc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.ffc.entitites.Category;
import com.ffc.entitites.Post;

public class PostDao {
	Connection connection;

	public PostDao(Connection connection) {
		super();
		this.connection = connection;
	}

	public ArrayList<Category> getAllCategories() {
		ArrayList<Category> list = new ArrayList<>();
		try {
			String query = "SELECT * FROM CATEGORIES";
			Statement stmt = this.connection.createStatement();
			ResultSet rSet = stmt.executeQuery(query);
			while (rSet.next()) {
				int cid = rSet.getInt("cid");
				String cname = rSet.getString("cname");
				String cdes = rSet.getString("cdes");
				Category category = new Category(cid, cname, cdes);
				list.add(category);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean savePost(Post p) {
		boolean f = false;
		try {

			String q = "insert into posts(pTitle,pContent,pCode,pPic,cId,userId) values(?,?,?,?,?,?)";
			PreparedStatement pstmt = connection.prepareStatement(q);
			pstmt.setString(1, p.getpTitle());
			pstmt.setString(2, p.getpContent());
			pstmt.setString(3, p.getpCode());
			pstmt.setString(4, p.getpPic());
			pstmt.setInt(5, p.getCatId());
			pstmt.setInt(6, p.getUserId());
			pstmt.executeUpdate();
			f = true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	public List<Post> getAllPosts() {

		List<Post> list = new ArrayList<>();
		try {
			String q = "SELECT * FROM POSTS ORDER BY PDATE DESC";
			PreparedStatement pstmt = connection.prepareStatement(q);

			ResultSet rSet = pstmt.executeQuery();

			while (rSet.next()) {
				int pid = rSet.getInt("pid");
				String pTitle = rSet.getString("ptitle");
				String pContent = rSet.getString("pcontent");
				String pCode = rSet.getString("pcode");
				String pPic = rSet.getString("ppic");
				Timestamp date = rSet.getTimestamp("pdate");
				int cid = rSet.getInt("cid");
				int uid = rSet.getInt("userId");
				Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, cid, uid);
				list.add(post);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	public List<Post> getPostsByCatId(int cid) {
		List<Post> list = new ArrayList<>();
		try {
			String q = "SELECT * FROM POSTS where cid=? ORDER BY PID DESC ";
			PreparedStatement pstmt = connection.prepareStatement(q);
			pstmt.setInt(1, cid);
			ResultSet rSet = pstmt.executeQuery();
			
			while (rSet.next()) {
				int pid = rSet.getInt("pid");
				String pTitle = rSet.getString("ptitle");
				String pContent = rSet.getString("pcontent");
				String pCode = rSet.getString("pcode");
				String pPic = rSet.getString("ppic");
				Timestamp date = rSet.getTimestamp("pdate");
				int uid = rSet.getInt("userId");
				Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, cid, uid);
				list.add(post);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	public Post getPostByPostId(int pid){
		Post post = null;
		try {
			String query = "SELECT * FROM POSTS WHERE PID=?";
			PreparedStatement pStatement = connection.prepareStatement(query);
			pStatement.setInt(1, pid);
			
			ResultSet rSet = pStatement.executeQuery();
			
			if(rSet.next()) {
				String pTitle = rSet.getString("ptitle");
				String pContent = rSet.getString("pcontent");
				String pCode = rSet.getString("pcode");
				String pPic = rSet.getString("ppic");
				Timestamp date = rSet.getTimestamp("pdate");
				int cid = rSet.getInt("cid");
				int uid = rSet.getInt("userId");
				post = new Post(pid, pTitle, pContent, pCode, pPic, date, cid, uid);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return post;
	}
	public List<Post> getPostsByUserId(int uid) {
		List<Post> list = new ArrayList<>();
		try {
			String q = "SELECT * FROM POSTS where userId=? ORDER BY PID DESC ";
			PreparedStatement pstmt = connection.prepareStatement(q);
			pstmt.setInt(1, uid);
			ResultSet rSet = pstmt.executeQuery();
			
			while (rSet.next()) {
				int pid = rSet.getInt("pid");
				String pTitle = rSet.getString("ptitle");
				String pContent = rSet.getString("pcontent");
				String pCode = rSet.getString("pcode");
				String pPic = rSet.getString("ppic");
				Timestamp date = rSet.getTimestamp("pdate");
				Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, uid);
				list.add(post);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	public boolean deletePostByPostId(int pid){
		boolean f = false;
		Post post = null;
		try {
			String query = "DELETE FROM POSTS WHERE PID=?";
			PreparedStatement pStatement = connection.prepareStatement(query);
			pStatement.setInt(1, pid);
			
			int a = pStatement.executeUpdate();
			if(a==1)
				f=true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
}
