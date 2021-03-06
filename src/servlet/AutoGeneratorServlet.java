package servlet;

import com.google.gson.Gson;
import service.AutoGeneratorService;
import tools.Message;
import tools.Tool;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AutoGeneratorServlet extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String type=request.getParameter("type");
		Message message=new Message();
		
		if(type.equals("newsHtml")){
			AutoGeneratorService AutoGeneratorService=new AutoGeneratorService();
			message.setResult(AutoGeneratorService.generateNewsHtml(request));
			
			Gson gson = new Gson();
			String jsonString= gson.toJson(message);//将对象转换成json格式的字符串
			Tool.returnJsonString(response, jsonString);//返回客户端
		}
		
		
		
		
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost( request,  response);
	}
}
