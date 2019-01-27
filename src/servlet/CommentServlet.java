package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import bean.Comment;
import bean.CommentUserView;
import bean.User;
import service.CommentService;
import tools.Message;
import tools.PageInformation;
import tools.Tool;

public class CommentServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String type=request.getParameter("type");
		String newsId=request.getParameter("newsId");
		CommentService commentService=new CommentService();
		Message message=new Message();
		if(type.equals("showComment")){
			showComment( request,  response, newsId, commentService);
			return ;
		}else if(type.equals("praise")){//点赞
			String commentId=request.getParameter("commentId");

			int result=commentService.paise(Integer.parseInt(commentId));
			message.setResult(result);
			Gson gson = new Gson();
			String jsonString= gson.toJson(message);
			Tool.returnJsonString(response, jsonString);
		}else if(type.equals("addComment")){//添加评论
			Comment comment=new Comment();
			comment.setContent(request.getParameter("content"));
			comment.setNewsId(Integer.parseInt(newsId));
			User user=(User)request.getSession().getAttribute("user");
			comment.setUserId(user.getUserId());
			String commentId=request.getParameter("commentId");

			String url;
			if(commentId==null || commentId.isEmpty()){
				commentService.addComment(comment);//对新闻的回复
				//url="/servlet/NewsServlet?type1=showANews&newsId="+newsId
				//		+"&page=1&addCommnet=addCommnet";
			}else{
				comment.setCommentId(Integer.parseInt(commentId));
				commentService.addCommentToComment(comment);//对回复的回复
				//url="/servlet/NewsServlet?type1=showANews&newsId="+newsId
				//		+"&page=1";
			}


			showComment( request,  response, newsId, commentService);

		}

	}

	private void showComment(HttpServletRequest request, HttpServletResponse response,
							 String newsId,CommentService commentService){
		PageInformation pageInformation=new PageInformation();
		Tool.getPageInformation("commentUserView", request, pageInformation);
		pageInformation.setSearchSql(" (newsId="+newsId+") ");
		pageInformation.setOrder("desc");
		pageInformation.setOrderField("time");
		List<CommentUserView> commentUserViews=commentService.getOnePage(pageInformation);
		request.setAttribute("pageInformation", pageInformation);
		request.setAttribute("commentUserViews", commentUserViews);

		try {
			request.getServletContext().getRequestDispatcher("/comment/showComment.jsp").include(request,response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}


}
