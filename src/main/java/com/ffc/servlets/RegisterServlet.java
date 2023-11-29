package com.ffc.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import com.ffc.dao.UserDao;
import com.ffc.entitites.User;
import com.ffc.helper.ConProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@MultipartConfig
public class RegisterServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
//		Fetching check field from form
		String check = request.getParameter("user_check");
		if (check == null) {
			out.println("T&C not accepted");
		} else {
// 			Fetching all remaining form data
			String name = request.getParameter("user_name");
			String email = request.getParameter("user_email");
			String gender = request.getParameter("user_gender");
			String password = request.getParameter("user_password");
			String about = request.getParameter("user_about");
//			out.println(name+" "+email+" "+gender+" "+password+" "+about);
			
			//Creating User class object and passing the details to that object
			User user = new User(name,email,gender,password,about);
			UserDao dao = new UserDao(ConProvider.getCon());
			if(dao.saveUser(user))
				out.print("done");
			else {
				out.print("Oops! This email has already registerd...");
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
