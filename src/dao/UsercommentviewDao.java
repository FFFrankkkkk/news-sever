package dao;

import bean.FirstTenCommentNumberAYear;
import bean.UsernameCommentnumber;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UsercommentviewDao {

	public List<FirstTenCommentNumberAYear> firstTenCommentNumberAYearInAYearEveryYear() throws SQLException,Exception{
		List<FirstTenCommentNumberAYear> firstTenCommentNumberAYearEveryYearList =new ArrayList<FirstTenCommentNumberAYear>();
		String sql="select name,  count(*) as commentNumber , YEAR(time) as year1 from usercommentview   group by year1, name order by  year1 , commentNumber desc ";
		DatabaseDao databaseDao=new DatabaseDao();
		databaseDao.query(sql);
		Integer nowYear=-1, index=-1, totalCommentNumber=0;
		
		FirstTenCommentNumberAYear firstTenCommentNumberAYear=null;
		while (databaseDao.next()) {			
			Integer nowDatabaseYear=databaseDao.getInt("year1") ;			
			if(  !nowYear.equals(nowDatabaseYear) ){//新的一年  //注意：Integer相等必须用equals方法进行比较,不能直接用==比较是否相等
				nowYear=nowDatabaseYear;
				index=0;//下标
				if(firstTenCommentNumberAYear!=null){//不是第一次进入循环体，表示之前有某一年的数据
					firstTenCommentNumberAYear.setTotalCommentNumber(totalCommentNumber);//设置旧的一年的总评论数
					firstTenCommentNumberAYearEveryYearList.add(firstTenCommentNumberAYear);//将旧的一年的数据加入数组	
					totalCommentNumber=0;//新的一年评论数先清零
				}
				//新的一年的数据
				firstTenCommentNumberAYear=new FirstTenCommentNumberAYear();
				firstTenCommentNumberAYear.setYear(nowYear);				
			}		
			if( index<10 ){//加入前十的数据
				UsernameCommentnumber usernameCommentnumber=new UsernameCommentnumber();
				usernameCommentnumber.setUserName(databaseDao.getString("name"));
				usernameCommentnumber.setCommentNumber(databaseDao.getInt("commentNumber"));
				
				firstTenCommentNumberAYear.getFirstTenCommentNumberList().set(index, usernameCommentnumber );
				index++;
			}
			totalCommentNumber+=databaseDao.getInt("commentNumber");//累加当年的评论数
		}	
		if(firstTenCommentNumberAYear!=null){
			firstTenCommentNumberAYear.setTotalCommentNumber(totalCommentNumber);//设置旧的一年的总评论数
			firstTenCommentNumberAYearEveryYearList.add(firstTenCommentNumberAYear);;//将最后一年的数据加入数组
		}
		
		return firstTenCommentNumberAYearEveryYearList;
	}
}
