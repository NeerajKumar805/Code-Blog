package com.ffc.servlets;

import java.io.File;
import java.io.IOException;

import com.ffc.dao.UserDao;
import com.ffc.entitites.Message;
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
public class EditServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 
//		PrintWriter out = response.getWriter();
		String name = request.getParameter("user_name");
		String email = request.getParameter("user_email");
		String password = request.getParameter("user_password");
		String about = request.getParameter("user_about");
		Part part = request.getPart("image");
		String pic = part.getSubmittedFileName();

		// Getting the current user from the session

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		user.setName(name);
		user.setEmail(email);
		user.setPassword(password);
		user.setAbout(about);
//		String oldPic = user.getProfile(); // for deleting previous pic from system while uploading new one
		if(!pic.equals(""))
			user.setProfile(pic);

		// Update the details in the db
		UserDao dao = new UserDao(ConProvider.getCon());
		if (dao.updateUser(user)) {
//			out.println("Details inserted into the database successfully");
			Message msg = new Message("Profile updated successfully...", "success", "alert-success");
			HttpSession s = request.getSession();
			s.setAttribute("msg", msg);

			response.sendRedirect("profile.jsp");
			
			if (!pic.equals("")) {
				/*
				 * String oldPicPath =
				 * "C:\\Local D\\College_Projects\\FacebookForCoders\\src\\main\\webapp\\pics" +
				 * File.separator + oldPic;
				 */
				String path = "C:\\Local D\\College_Projects\\FacebookForCoders\\src\\main\\webapp\\pics" + File.separator
						+ user.getProfile();
				/*
				 * if (!oldPic.equalsIgnoreCase("default.png")) Helper.deleteFile(oldPicPath);
				 */
				Helper.saveFile(part.getInputStream(), path);
			}
		} else {
//			out.println("Something went wrong");
			Message msg = new Message("OOPs, Something went wrong!!!", "error", "alert-danger");
			HttpSession s = request.getSession();
			s.setAttribute("msg", msg);

			response.sendRedirect("profile.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
