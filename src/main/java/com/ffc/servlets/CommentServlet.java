package com.ffc.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import com.ffc.dao.CommentDao;
import com.ffc.entitites.Comment;
import com.ffc.entitites.Post;
import com.ffc.entitites.User;
import com.ffc.helper.ConProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CommentServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		
		String comment = request.getParameter("postCmt");

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		Post p = new Post();
		Comment cmt = new Comment(comment, p.getPid());
		CommentDao cDao = new CommentDao(ConProvider.getCon());
		if(cDao.addComment(cmt))
			out.print("Comment added");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

}
