package com.ffc.servlets;

import java.io.IOException;

import com.ffc.dao.UserDao;
import com.ffc.entitites.Message;
import com.ffc.helper.ConProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class DeleteUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int id = Integer.parseInt(request.getParameter("id"));
		
		HttpSession s = request.getSession();
		UserDao userDao = new UserDao(ConProvider.getCon());
		
		if(userDao.deleteUser(id)) {
			Message msg = new Message("Account Deleted successfully...", "danger", "alert-danger");
			s.setAttribute("msg", msg);
		}
		else {
			Message msg = new Message("Something went wrong!!!", "danger", "alert-danger");
			s.setAttribute("msg", msg);
		}
		response.sendRedirect("login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
