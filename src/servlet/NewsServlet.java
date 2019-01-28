package servlet;

import java.io.IOException;
import java.io.PrintWriter;
//import java.time.LocalDateTime;
//import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.*;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import bean.News;
import bean.News;
import com.google.gson.Gson;
import service.CommentService;
import service.NewsService;
import tools.Message;
import tools.PageInformation;
import tools.ServletTool;
import tools.Tool;
import tools.WebProperties;

public class NewsServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String type=request.getParameter("type1");
		NewsService newsService=new NewsService();
		Message message=new Message();
		if(type.equals("add")){
			News news=ServletTool.news(request);
			int result=newsService.add(news);
			message.setResult(result);
			if(result==1){
				message.setMessage("添加新闻成功！");
				message.setRedirectUrl("/news/news/manage/addNews.jsp");
			}else if(result==0){
				message.setMessage("添加新闻失败！请联系管理员！");
				message.setRedirectUrl("/user/manageUIMain/manageMain.jsp");
			}
			request.setAttribute("message", message);
			getServletContext().getRequestDispatcher("/tool/message.jsp").forward(request,response);
		}else if(type.equals("showNews")){
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("news", request, pageInformation);
			List<News> newss=newsService.getOnePage(pageInformation);
			request.setAttribute("pageInformation", pageInformation);
			request.setAttribute("newses", newss);
			getServletContext().getRequestDispatcher("/news/newsShow.jsp").forward(request,response);
		}else if(type.equals("showANews")){
            CommentService commentService=new CommentService();
            PageInformation pageInformation=new PageInformation();
            Integer newsId=Integer.parseInt(request.getParameter("newsId"));
            News news=newsService.getNewsById(newsId);//根据新闻id获取一条新闻

            Tool.getPageInformation("commentUserView", request, pageInformation);//新闻评论首页的分页信息
            pageInformation.setSearchSql(" (newsId="+newsId+") ");
            pageInformation.setOrder("desc");
            pageInformation.setOrderField("time");//排序字段
            List<CommentUserView> commentUserViews=commentService.getOnePage(pageInformation);//查询一页新闻评论

            request.setAttribute("pageInformation", pageInformation);
            request.setAttribute("commentUserViews", commentUserViews);
            request.setAttribute("news", news);
            getServletContext().getRequestDispatcher("/news/aNewsShowTemplate.jsp").forward(request,response);
		}else if(type.equals("deleteANews")||type.equals("manageNews")){
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("news", request, pageInformation);
			List<News> newses=null;
			
			if(type.equals("manageNews"))
				newses=newsService.getOnePage(pageInformation);
			else if(type.equals("deleteANews"))
				newses=newsService.deletes(pageInformation);

			request.setAttribute("pageInformation", pageInformation);
			request.setAttribute("newses", newses);
			getServletContext().getRequestDispatcher("/news/manage/manageNews.jsp").forward(request,response);
		}else if(type.equals("editANews")){//显示编辑页面
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("news", request, pageInformation);
			Integer newsId=Integer.parseInt(pageInformation.getIds());
			News news=newsService.getNewsById(newsId);
			request.setAttribute("pageInformation", pageInformation);
			request.setAttribute("news", news);
			getServletContext().getRequestDispatcher("/news/manage/editANews.jsp").forward(request,response);
		}else if(type.equals("edit")){//修改新闻
			News news=ServletTool.news(request);
			int result=newsService.update(news);
			message.setResult(result);
			if(result==1){
				message.setMessage("添加新闻成功！请添加新的新闻！");
			}else if(result==0){
				message.setMessage("添加新闻失败！请联系管理员！");
			}
			message.setRedirectTime(1000);
			request.setAttribute("message", message);
			getServletContext().getRequestDispatcher("/message.jsp").forward(request,response);
		}else if(type.equals("homepageTypes1")){//主页多个分类新闻区			
			String newsTypesString=new String(WebProperties.config.getString("newsTypes").getBytes("ISO-8859-1"),"UTF-8");
			String[] newsTypes=newsTypesString.split(",");
			Integer homePageNewsN=Integer.parseInt(WebProperties.config.getString("homePageNewsN"));
			List<List<News>>  newsesList=newsService.getByTypesTopN(newsTypes, homePageNewsN);
			request.setAttribute("newsTypes", newsTypes);
			request.setAttribute("newsesList", newsesList);
			request.setAttribute("homePageNewsCaptionMaxLength", 
					Integer.parseInt(WebProperties.config.getString("homePageNewsCaptionMaxLength")));
			getServletContext().getRequestDispatcher("/index2.jsp").include(request,response);
			return;
		}else if(type.equals("homepageTypes")){//主页多个分类新闻区			
//			String newsTypesString=new String(WebProperties.config.getString("newsTypes").getBytes("ISO-8859-1"),"UTF-8");
//			String[] newsTypes=newsTypesString.split(",");
//			Integer homePageNewsN=Integer.parseInt(WebProperties.config.getString("homePageNewsN"));
//			List<List<String>> newsCaptionsList=new ArrayList<List<String>>();
//			List<List<News>>  newsesList=newsService.getByTypesTopN1(newsTypes, homePageNewsN,newsCaptionsList);
//			int newsTypesNumber=newsTypes.length;
//			request.setAttribute("newsTypes", newsTypes);
//			request.setAttribute("newsTypesNumber", newsTypesNumber);
//			request.setAttribute("newsesList", newsesList);
//			request.setAttribute("newsCaptionsList",newsCaptionsList);
//			StringBuilder sb = new StringBuilder();
//			Gson gson =new Gson();
//            JSONArray array = new JSONArray();
//            array.put(newsTypes);
//            array.put(newsTypesNumber);
//            array.put(newsesList);
//            array.put(newsCaptionsList);
//			System.out.println(newsCaptionsList);
//			System.out.println(newsesList);
//			String newsCaptionsListJson=gson.toJson(newsCaptionsList);
//			String newsTypesJson=gson.toJson(newsTypes);
//			String newsesListJson=gson.toJson(newsesList);
//			System.out.println(	newsCaptionsListJson);
//			PrintWriter out = response.getWriter();
//			out.println(array);
//			System.out.println(array);
//			out.println(newsTypesNumber);
//			out.println(newsesList);
//			out.println(newsTypes);
//			getServletContext().getRequestDispatcher("/index2.jsp").include(request,response);
//			return;
            //newsTypes：所有新闻类别：all,国际,社会,体育,汽车,科学
//            String newsTypesString=new String(WebProperties.config.getString("newsTypes").getBytes("ISO-8859-1"),"UTF-8");
//            String[] newsTypes=newsTypesString.split(",");
			String newsTypesString=new String(WebProperties.config.getString("newsTypes"));
			System.out.println(newsTypesString);
			String[] newsTypes=newsTypesString.split(",");
            //homePageNewsN：主页上，每类新闻最大条数
            Integer homePageNewsN=Integer.parseInt(WebProperties.config.getString("homePageNewsN"));
            List<List<News>>  newsesList=newsService.getByTypesTopN2(newsTypes, homePageNewsN);
            int newsTypesNumber=newsTypes.length;

            List<Object> list = new ArrayList<Object>();
            list.add(newsTypesNumber);
            list.add(newsTypes);
            list.add(newsesList);

            Gson gson = new Gson();
            String jsonString= gson.toJson(list);//将对象转换成json格式的字符串
            Tool.returnJsonString(response, jsonString);//返回客户端
		}else if(type.equals("showNewsByNewsType")){//主页多个分类新闻区			
//			List<NewsType> newsTypes=(List<NewsType>)this.getServletContext().getAttribute("newsTypes")
			String newsTypesString=new String(WebProperties.config.getString("newsTypes"));
			System.out.println(newsTypesString);
			String[] newsTypes=newsTypesString.split(",");
			PageInformation pageInformation=new PageInformation();
			Tool.getPageInformation("news", request, pageInformation);
			String newsType=request.getParameter("newsType");

			if( !("all").equals(newsType))
				pageInformation.setSearchSql(" newsType='"+newsType+"' ");
			
			List<News> newss=newsService.getOnePage(pageInformation);
			request.setAttribute("pageInformation", pageInformation);
			request.setAttribute("newses", newss);
			request.setAttribute("newsTypes", newsTypes);
			request.setAttribute("newsType", newsType);
			getServletContext().getRequestDispatcher("/news/newsShowByType.jsp").forward(request,response);
			return;
		}else if(type.equals("showNewsByNewsTypeAjax")){//主页多个分类新闻区
            request.setCharacterEncoding("UTF-8");
		    PageInformation pageInformation=new PageInformation();
            Tool.getPageInformation("news", request, pageInformation);
             String newsType = new String(request.getParameter("newsType").getBytes("iso-8859-1"), "utf-8");
            System.out.println(newsType);
            if( !("all").equals(newsType))
                pageInformation.setSearchSql(" newsType='"+newsType+"' ");

            List<News> newses=newsService.getOnePage(pageInformation);

            List<Object> list = new ArrayList<Object>();
            list.add(pageInformation);//第一个对象保存分页信息
            list.add(newses);

            Gson gson = new Gson();
            String jsonString= gson.toJson(list);//将对象转换成json格式的字符串
            Tool.returnJsonString(response, jsonString);//返回客户端
        }
	}

}
