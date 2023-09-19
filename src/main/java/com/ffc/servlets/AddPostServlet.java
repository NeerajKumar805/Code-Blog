package com.ffc.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import com.ffc.dao.PostDao;
import com.ffc.entitites.Post;
import com.ffc.entitites.User;
import com.ffc.helper.ConProvider;
import com.ffc.helper.Helper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@MultipartConfig
public class AddPostServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			
			int cid = Integer.parseInt(request.getParameter("cid"));
			String pTitle = request.getParameter("pTitle");
			String pContent = request.getParameter("pContent");
			String pCode = request.getParameter("pCode");
			Part part = request.getPart("postPic");
			
//          Getting current user id
			
			HttpSession session = request.getSession();
			User user = (User) session.getAttribute("currentUser");

			Post p = new Post(pTitle, pContent, pCode, part.getSubmittedFileName(), null, cid, user.getId());
			PostDao dao = new PostDao(ConProvider.getCon());
			if (dao.savePost(p)) {

				String path = "C:\\Local D\\College_Projects\\FacebookForCoders\\src\\main\\webapp\\blogPics" + File.separator
				+ part.getSubmittedFileName();
				Helper.saveFile(part.getInputStream(), path);
				out.println("done");
			} else {
				out.println("error");
			}

		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
