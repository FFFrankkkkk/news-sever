package bean;

import java.util.ArrayList;
import java.util.List;

public class FirstTenCommentNumberAYear {
	private Integer year=0;
	private Integer totalCommentNumber=0;
	private List<UsernameCommentnumber> firstTenCommentNumberList;
	
	
	public FirstTenCommentNumberAYear(){
		firstTenCommentNumberList=new ArrayList<UsernameCommentnumber>();
		for(int i=0;i<10;i++){
			UsernameCommentnumber usernameCommentnumber=new UsernameCommentnumber();			
			firstTenCommentNumberList.add(usernameCommentnumber);
		}		
	}


	public Integer getYear() {
		return year;
	}


	public void setYear(Integer year) {
		this.year = year;
	}


	public List<UsernameCommentnumber> getFirstTenCommentNumberList() {
		return firstTenCommentNumberList;
	}


	public void setFirstTenCommentNumberList(List<UsernameCommentnumber> firstTenCommentNumberList) {
		this.firstTenCommentNumberList = firstTenCommentNumberList;
	}


	public Integer getTotalCommentNumber() {
		return totalCommentNumber;
	}


	public void setTotalCommentNumber(Integer totalCommentNumber) {
		this.totalCommentNumber = totalCommentNumber;
	}
	
	
}
