package com.ffc.helper;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConProvider {
	private static Connection conn;

	public static Connection getCon() {
		try {
			if (conn == null) {
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/fbforcoders", "root", "root");
				System.out.println("Done");
			}
		} catch (Exception e) {
			System.out.println("Something went wrong!!!");
			e.printStackTrace();
		}
		return conn;
	}
}
