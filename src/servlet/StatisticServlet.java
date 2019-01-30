package servlet;

import com.google.gson.Gson;
import service.NewsService;
import service.StatisticSevice;
import tools.Message;
import tools.Tool;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class StatisticServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String type=request.getParameter("type");
		Message message=new Message();
		if("articleNumberByMonthInAYear".equals(type)){
			NewsService newsService=new NewsService();
			String result=newsService.articleNumberByMonthInAYear(request.getParameter("year"), request);
			
			if( result.startsWith("-")){
				message.setResult(-1);
				message.setMessage("操作失败！");
			}else{
				message.setResult(1);
				message.setMessage("成功！请下载以下链接的excel文件。");
				message.setRedirectUrl(result);
			}
			Gson gson = new Gson();
			String jsonString= gson.toJson(message);
			Tool.returnJsonString(response, jsonString);
		} else if("articleNumberByMonthInAYearEveryYear".equals(type)){
			NewsService newsService=new NewsService();
			String result=newsService.articleNumberByMonthInAYearEveryYear(request);
			
			if( result.startsWith("-")){
				message.setResult(-1);
				message.setMessage("操作失败！");
			}else{
				message.setResult(1);
				message.setMessage("成功！请下载以下链接的excel文件。");
				message.setRedirectUrl(result);
			}
			Gson gson = new Gson();
			String jsonString= gson.toJson(message);
			Tool.returnJsonString(response, jsonString);
		} else if("firstTenCommentNumberAYearEveryYear".equals(type)){
			StatisticSevice statisticSevice=new StatisticSevice();
			String result=statisticSevice.firstTenCommentNumberAYearEveryYear(request);
			
			if( result.startsWith("-")){
				message.setResult(-1);
				message.setMessage("操作失败！");
			}else{
				message.setResult(1);
				message.setMessage("成功！请下载以下链接的excel文件。");
				message.setRedirectUrl(result);
			}
			Gson gson = new Gson();
			String jsonString= gson.toJson(message);
			Tool.returnJsonString(response, jsonString);
		}
	}

}
