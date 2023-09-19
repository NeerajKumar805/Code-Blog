package com.ffc.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import com.ffc.dao.LikeDao;
import com.ffc.helper.ConProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class LikeServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		/*
		 * response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		 * // HTTP 1.1 response.setHeader("Pragma", "no-cache"); // HTTP 1.0
		 * response.setDateHeader("Expires", 0); // Proxies
		 */
		
		PrintWriter out = response.getWriter();
		String op = request.getParameter("operation");
		int pid = Integer.parseInt(request.getParameter("pid"));
		int uid = Integer.parseInt(request.getParameter("uid"));

		LikeDao likeDao = new LikeDao(ConProvider.getCon());
		
		if(op.equals("like")) {
			if(likeDao.isLikedByUser(pid,uid)) {
				likeDao.deleteLike(pid, uid);
				out.print("false");
			}
			else {
				boolean f = likeDao.insertLike(pid, uid);
				out.print(f);
			}
		}
		else {
			out.print("Something went wrong");
		}
	}
}
