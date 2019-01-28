package service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tools.PageInformation;
import dao.CommentDao;
import dao.DatabaseDao;
import bean.Comment;
import bean.CommentUserView;

public class CommentService {
	public List<CommentUserView> getOnePage(PageInformation pageInformation) {
		List<CommentUserView> commentUserViews=new ArrayList<CommentUserView>();
		DatabaseDao databaseDao=null;
		try {
			databaseDao=new DatabaseDao();
			CommentDao commentDao=new CommentDao();
			commentUserViews=commentDao.getOnePage(pageInformation,databaseDao);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(databaseDao.close()<0)
				commentUserViews=null;
		}
		return commentUserViews;
	}
	//点赞
	public Integer paise(Integer commentId){
		CommentDao commentDao=new CommentDao();
		return commentDao.paise(commentId);
	}

	//点赞
	public Integer getPaise(Integer commentId){
		Integer result;
		DatabaseDao databaseDao=null;
		try {
			databaseDao = new DatabaseDao();
			Integer praise = null;
			String sql = "SELECT * FROM comment WHERE commentId ="+commentId;
			databaseDao.query(sql);
			if(databaseDao.next())
				praise = databaseDao.getInt("praise");
			result= praise;
		} catch (SQLException e) {
			e.printStackTrace();
			result= -20;//
		} catch (Exception e) {
			e.printStackTrace();
			result= -30;//
		} finally{
			if(databaseDao.close()<0)
				result= -10000;
		}

		return result;
	}

	//对新闻的回复
	public Integer addComment(Comment comment){
		Integer result;
		CommentDao commentDao=new CommentDao();
		DatabaseDao databaseDao=null;
		try {
			databaseDao=new DatabaseDao();
			Integer stair=commentDao.getStairByNewsId(comment.getNewsId(),databaseDao);
			comment.setStair(stair+1);
			result= commentDao.addComment(comment,databaseDao);
		} catch (SQLException e) {
			e.printStackTrace();
			result=  -2;
		} catch (Exception e) {
			e.printStackTrace();
			result=  -3;
		} finally{
			if(databaseDao.close()<0)
				result=  -10000;
		}
		return result;
	}

	//对回复的回复
	public Integer addCommentToComment(Comment comment){
		Integer result;
		CommentDao commentDao=new CommentDao();
		DatabaseDao databaseDao=null;
		try {
			databaseDao=new DatabaseDao();
			CommentUserView oldCommentUserView=commentDao.getByIdFromView(comment.getCommentId(),databaseDao);
			String content=	oldCommentUserView.getContent();
			if(content.contains("<br><br>")){//消除之前的留言
				content=content.substring(content.indexOf("<br><br>")+8);
			}
			String s="回复第"+oldCommentUserView.getStair()+"楼层&nbsp;"
					+oldCommentUserView.getUserName()+"&nbsp;的留言："
					+content+"<br><br>";

			comment.setContent(s+comment.getContent());
			Integer stair=commentDao.getStairByNewsId(comment.getNewsId(),databaseDao);
			comment.setStair(stair+1);
			result= commentDao.addComment(comment,databaseDao);
		} catch (SQLException e) {
			e.printStackTrace();
			result=  -2;
		} catch (Exception e) {
			e.printStackTrace();
			result= -3;
		} finally{
			if(databaseDao.close()<0)
				result=  -10000;
		}
		return result;
	}


}
