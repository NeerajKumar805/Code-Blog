package com.ffc.servlets;

import java.io.IOException;

import com.ffc.dao.PostDao;
import com.ffc.dao.UserDao;
import com.ffc.entitites.Message;
import com.ffc.helper.ConProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class DeletePost extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		int pid = Integer.parseInt(request.getParameter("pid"));

		HttpSession s = request.getSession();
		PostDao postDao = new PostDao(ConProvider.getCon());

		if (postDao.deletePostByPostId(pid)) {
			Message msg = new Message("Post Deleted successfully...", "success", "alert-success");
			s.setAttribute("msg", msg);
		} else {
			Message msg = new Message("Something went wrong!!!", "danger", "alert-danger");
			s.setAttribute("msg", msg);
		}
		response.sendRedirect("profile.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
