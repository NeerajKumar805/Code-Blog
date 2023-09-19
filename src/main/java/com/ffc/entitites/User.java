package com.ffc.entitites;

import java.sql.Timestamp;

public class User {

	private int id;
	private String name;
	private String email;
	private String gender;
	private String password;
	private String about;
	private Timestamp dateTime;
	private String profile;

	public User() {
		super();
	}

	public User(String name, String email, String gender, String password, String about) {
		super();
		this.name = name;
		this.email = email;
		this.gender = gender;
		this.password = password;
		this.about = about;
	}

	public User(int id, String name, String email, String gender, String password, String about, Timestamp dateTime) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.gender = gender;
		this.password = password;
		this.about = about;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAbout() {
		return about;
	}

	public void setAbout(String about) {
		this.about = about;
	}
	public Timestamp getDateTime() {
		return dateTime;
	}
	
	public void setDateTime(Timestamp dateTime) {
		this.dateTime = dateTime;
	}
	
	public String getProfile() {
		return profile;
	}
	
	public void setProfile(String profile) {
		this.profile = profile;
	}
}