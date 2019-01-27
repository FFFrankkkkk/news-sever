package service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tools.PageInformation;
import tools.Tool;
import tools.WebProperties;
import dao.DatabaseDao;
import dao.NewsDao;
import dao.NewsDao;
import bean.News;
import bean.News;


public class NewsService {
	public Integer add(News news){
		try {
			DatabaseDao databaseDao=new DatabaseDao();
			NewsDao newsDao=new NewsDao();
			return newsDao.add( news, databaseDao);
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		} catch (Exception e) {
			e.printStackTrace();
			return -2;
		}
	}
	
	public List<News> getOnePage(PageInformation pageInformation) {	
		List<News> newses=new ArrayList<News>();
		try {
			DatabaseDao databaseDao=new DatabaseDao();			
			NewsDao newsDao=new NewsDao();		
			newses=newsDao.getOnePage(pageInformation,databaseDao);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return newses;
	}
	
	public News getNewsById(Integer newsId){
		NewsDao newsDao=new NewsDao();		
		try {
			return newsDao.getById(newsId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	//删除多条记录
	public List<News> deletes(PageInformation pageInformation) {	
		List<News> newses=null;
		try {
			DatabaseDao databaseDao=new DatabaseDao();			
			NewsDao newsDao=new NewsDao();
			newsDao.deletes(pageInformation.getTableName(),pageInformation.getIds(),databaseDao);
			pageInformation.setIds(null);
			newses=newsDao.getOnePage(pageInformation,databaseDao);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return newses;
	}	
	
	public List<List<News>> getByTypesTopN(String[] newsTypes, Integer n){
		List<List<News>>  newsesList=new ArrayList<List<News>>();
		try {			
			DatabaseDao databaseDao=new DatabaseDao();
			NewsDao newsDao=new NewsDao();
			for(String type: newsTypes){
				List<News> newses=newsDao.getByTypesTopN(type, n, databaseDao);
				newsesList.add(newses);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return newsesList;
	}
	
	public List<List<News>> getByTypesTopN1(String[] newsTypes, Integer n,List<List<String>> newsCaptionsList){
		List<List<News>>  newsesList=new ArrayList<List<News>>();
		try {			
			DatabaseDao databaseDao=new DatabaseDao();
			NewsDao newsDao=new NewsDao();
			for(String type: newsTypes){
				List<News> newses=newsDao.getByTypesTopN(type, n, databaseDao);
				List<String> newsCaptions=new ArrayList<String>();
				for(News news:newses){
					String newsCaption=Tool.getStringByMaxLength(news.getCaption(),
						Integer.parseInt(WebProperties.config.getString("homePageNewsCaptionMaxLength")));
					newsCaptions.add(newsCaption);
				}
				newsesList.add(newses);
				newsCaptionsList.add(newsCaptions);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return newsesList;
	}	
	
	public Integer update(News news){
		try {
			DatabaseDao databaseDao=new DatabaseDao();
			NewsDao newsDao=new NewsDao();
			return newsDao.update( news, databaseDao);
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		} catch (Exception e) {
			e.printStackTrace();
			return -2;
		}		
	}
	//获取首页各类新闻的函数
	public List<List<News>> getByTypesTopN2(String[] newsTypes, Integer n){
		//newsesList为数组元素为新闻数组的数组，newsesList的每个数组元素为一个数组（存放一类新闻），
		List<List<News>>  newsesList=new ArrayList<List<News>>();
		try {
			DatabaseDao databaseDao=new DatabaseDao();
			NewsDao newsDao=new NewsDao();
			for(String type: newsTypes){//遍历newsTypes
				List<News> newses=newsDao.getByTypesTopN(type, n, databaseDao);  //获取相对应的类别的新闻
				newsesList.add(newses);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return newsesList;
	}
}
