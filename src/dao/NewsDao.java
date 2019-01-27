package dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tools.PageInformation;
import tools.Tool;
import bean.News;
import bean.News;

public class NewsDao {
	public Integer add(News news,DatabaseDao databaseDao) throws SQLException{
		String sql="insert into news(caption,author,newsType,content,newsTime) values("
				+"'"+news.getCaption()+"','"
				+news.getAuthor()+"','"
				+news.getNewsType()+"','"
				+news.getContent()+"','"
				+news.getNewsTime()+"')";
		return databaseDao.update(sql);
	}
	public Integer update(News news,DatabaseDao databaseDao) throws SQLException{
		String sql=" update news set caption='"+news.getCaption()
				+"',author='"+news.getAuthor()
				+"',newsType='"+news.getNewsType()
				+"',content='"+news.getContent()
				+"',newsTime='"+news.getNewsTime()
				+"' where newsId="+news.getNewsId().toString();
		return databaseDao.update(sql);
	}	
	
	
	public List<News> getOnePage(PageInformation pageInformation,DatabaseDao databaseDao) throws SQLException{
        List<News> newses=new ArrayList<News>();
        String sqlCount=Tool.getSql(pageInformation,"count");
        Integer allRecordCount=databaseDao.getCount(sqlCount);//符合条件的总记录数
        Tool.setPageInformation(allRecordCount, pageInformation);//更新pageInformation的总页数等

        String sqlSelect=Tool.getSql(pageInformation,"select");

        //不取出新闻内容
        sqlSelect=sqlSelect.replace("*", " newsId,caption,author,newsType,newsTime,publishTime,url ");

        databaseDao.query(sqlSelect);
        while (databaseDao.next()) {
            News news=new News();
            news.setNewsId(databaseDao.getInt("newsId"));
            news.setCaption(databaseDao.getString("caption"));
            news.setAuthor(databaseDao.getString("author"));
            news.setNewsType(databaseDao.getString("newsType"));
            news.setNewsTime(databaseDao.getLocalDateTime("newsTime"));
            news.setPublishTime(databaseDao.getTimestamp("publishTime"));
            news.setUrl(databaseDao.getString("url"));
            newses.add(news);
        }
        return newses;
	}	
	
	public News getById(Integer newsId) throws SQLException,Exception{
		DatabaseDao databaseDao=new DatabaseDao();
		News news=new News();
		
		databaseDao.getById("news", newsId);
		while (databaseDao.next()) {			
			news.setNewsId(databaseDao.getInt("newsId"));
			news.setCaption(databaseDao.getString("caption"));
			news.setAuthor(databaseDao.getString("author"));
			news.setNewsType(databaseDao.getString("newsType"));
			news.setContent(databaseDao.getString("content"));
			news.setNewsTime(databaseDao.getLocalDateTime("newsTime"));
			news.setPublishTime(databaseDao.getTimestamp("publishTime"));
		}	
		return news;
	}
	
	public Integer deletes(String tableName,String ids,DatabaseDao databaseDao)throws SQLException,Exception{
		return databaseDao.deletes(tableName, ids, databaseDao);
	}

	public List<News> getByTypesTopN(String type, Integer n,
									 DatabaseDao databaseDao)throws SQLException,Exception{
		List<News> newses=new ArrayList<News>();
		String sql;
		if(type.equals("all"))
			sql="select newsId,caption,author,newsType,newsTime,publishTime,url from news order by newsTime desc limit 0,"+n.toString();
		else
			sql="select newsId,caption,author,newsType,newsTime,publishTime,url from news where newsType ='" + type +"' order by newsTime desc limit 0,"+n.toString();

		databaseDao.query(sql);
		while (databaseDao.next()) {
			News news=new News();
			news.setNewsId(databaseDao.getInt("newsId"));
			news.setCaption(databaseDao.getString("caption"));
			news.setAuthor(databaseDao.getString("author"));
			news.setNewsType(databaseDao.getString("newsType"));
			news.setNewsTime(databaseDao.getLocalDateTime("newsTime"));
			news.setPublishTime(databaseDao.getTimestamp("publishTime"));
			news.setUrl(databaseDao.getString("url"));
			newses.add(news);
		}
		return newses;
	}
}
