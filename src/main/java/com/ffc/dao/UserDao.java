package com.ffc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.ffc.entitites.User;

public class UserDao {
	private Connection con;

	public UserDao(Connection con) {
		super();
		this.con = con;
	}

	// method to inserting user data into the database
	public boolean saveUser(User user) {
		boolean f = false;
		try {
			String query = "INSERT INTO USERS(NAME, EMAIL, GENDER, PASSWORD, ABOUT) VALUE(?,?,?,?,?)";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getGender());
			pstmt.setString(4, user.getPassword());
			pstmt.setString(5, user.getAbout());

			pstmt.executeUpdate();
			f = true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	// get user by useremail and userpassword:
	public User getUserByEmailAndPassword(String email, String password) {
		User user = null;

		try {

			String query = "select * from users where email =? and password=?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, email);
			pstmt.setString(2, password);

			ResultSet set = pstmt.executeQuery();

			if (set.next()) {
				user = new User();

//              data from db
				String name = set.getString("name");
//              set to user object
				user.setName(name);

				user.setId(set.getInt("id"));
				user.setEmail(set.getString("email"));
				user.setPassword(set.getString("password"));
				user.setGender(set.getString("gender"));
				user.setAbout(set.getString("about"));
				user.setDateTime(set.getTimestamp("regdate"));
				user.setProfile(set.getString("profile"));

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	public boolean updateUser(User user) {
		boolean f = false;
		try {
			String query = "UPDATE USERS SET NAME=?, EMAIL=?, GENDER=?, PASSWORD=?, ABOUT=?, PROFILE=? WHERE ID=?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getGender());
			pstmt.setString(4, user.getPassword());
			pstmt.setString(5, user.getAbout());
			pstmt.setString(6, user.getProfile());
			pstmt.setInt(7, user.getId());
			
			pstmt.executeUpdate();
			f=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	public User getUserByUserId(int uid) {
		User user =null;
		try {
			String q = "SELECT * FROM USERS WHERE ID=?";
			PreparedStatement p = this.con.prepareStatement(q);
			p.setInt(1, uid);
			ResultSet set = p.executeQuery();
			
			while(set.next()) {
				user = new User();

//              user name from db
				String name = set.getString("name");
//              set to user object
				user.setName(name);
//              Fetching other users details from db
				user.setId(set.getInt("id"));
				user.setEmail(set.getString("email"));
				user.setPassword(set.getString("password"));
				user.setGender(set.getString("gender"));
				user.setAbout(set.getString("about"));
				user.setDateTime(set.getTimestamp("regdate"));
				user.setProfile(set.getString("profile"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}
	public boolean deleteUser(int id) {
		boolean f = false;
		try {
			String query = "DELETE FROM USERS WHERE ID = ?";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			f = true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
}