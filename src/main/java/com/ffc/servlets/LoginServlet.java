package com.ffc.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import com.ffc.dao.UserDao;
import com.ffc.entitites.Message;
import com.ffc.entitites.User;
import com.ffc.helper.ConProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		try (PrintWriter out = response.getWriter()) {
//          login 
//          fetch username and password from request
			String userEmail = request.getParameter("email");
			String userPassword = request.getParameter("password");

			UserDao dao = new UserDao(ConProvider.getCon());

			User u = dao.getUserByEmailAndPassword(userEmail, userPassword);

			if (u == null) {
//				login error.................
//				out.println("Invalid Details..try again");
				
				Message msg = new Message("Invalid Details! plese try again", "error", "alert-danger");
				HttpSession s = request.getSession();
				s.setAttribute("msg", msg);

				response.sendRedirect("login.jsp");
			} else {
//              login success
				
				HttpSession s = request.getSession();
				s.setAttribute("currentUser", u);
//				out.println("Hey " + userEmail + ", your pasowrd is " + userPassword);
				response.sendRedirect("profile.jsp");
			}
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}
}