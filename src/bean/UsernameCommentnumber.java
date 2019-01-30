package bean;

public class UsernameCommentnumber {
	private String userName;
	private Integer commentNumber;
	
	public UsernameCommentnumber(){
		userName="";
		commentNumber=0;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Integer getCommentNumber() {
		return commentNumber;
	}

	public void setCommentNumber(Integer commentNumber) {
		this.commentNumber = commentNumber;
	}
	
	
}
