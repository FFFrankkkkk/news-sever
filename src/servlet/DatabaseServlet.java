package servlet;

import bean.Databasebackup;
import com.google.gson.Gson;
import service.DatabaseService;
import tools.Message;
import tools.Tool;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class DatabaseServlet extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String type=request.getParameter("type");
		Message message;
		if("backup".equals(type)){
			Tool.isMaintain=true;
			DatabaseService databaseService=new DatabaseService();
			message=databaseService.backup();			

			Tool.isMaintain=false;
			Gson gson = new Gson();
			String jsonString= gson.toJson(message);
			Tool.returnJsonString(response, jsonString);
		}else if("restoreFirst".equals(type)){
			DatabaseService databaseService=new DatabaseService();
			List<Databasebackup> databasebackups=new ArrayList<Databasebackup>();
			databasebackups=databaseService.getAll();
			request.setAttribute("databasebackups", databasebackups);
			getServletContext().getRequestDispatcher("/manager/databaseRestore.jsp").forward(request,response);			
		}else if("restoreSecond".equals(type)){
			Tool.isMaintain=true;
			DatabaseService databaseService=new DatabaseService();
			
			message=databaseService.restore(request);			
			
			Tool.isMaintain=false;
			Gson gson = new Gson();
			String jsonString= gson.toJson(message);
			Tool.returnJsonString(response, jsonString);
		}
	}

	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}
}
