package service;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import org.apache.commons.mail.SimpleEmail;
import tools.Encryption;
import tools.FileTool;
import tools.PageInformation;
import tools.WebProperties;
import bean.User;
import bean.Userinformation;
import dao.DatabaseDao;
import dao.UserDao;
import dao.UserinformationDao;

public class UserService {
	public Integer register(User user){
		try {
			DatabaseDao databaseDao=new DatabaseDao();
			UserDao UserDao=new UserDao();			
			if(UserDao.hasUser(user, databaseDao)){
				return 0;//失败，用户已存在
			}
			else if(UserDao.hasEmail(user, databaseDao)){
				return -2;//失败，邮箱已存在
			}
            else if(UserDao.hasPhone(user,databaseDao)){
                return -3;
            }
              else{//没有同名用户，可以注册
				Encryption.encryptPassword(user);
				if(UserDao.register(user, databaseDao)>0)
					return 1;	//成功
				else
					return -1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;//数据库操作失败
		} catch (Exception e) {
			e.printStackTrace();
			return -2;//其他异常
		}		
	}
	
	public Integer login(User user){
		int result=-2;	//数据库操作失败	
		try {
			UserDao UserDao=new UserDao();
            User user1=UserDao.getUserByName(user.getName());
            if(user1.getName()==null){
                return -1;
            }else {
                user.setSalt(user1.getSalt());
                if (Encryption.checkPassword(user, user1.getPassword())) {
                	user.setHeadIconUrl(user1.getHeadIconUrl());
                	user.setEmail(user1.getEmail());
                	user.setPhone(user1.getPhone());
                	user.setType(user1.getType());
                	user.setRegisterDate(user1.getRegisterDate());
                	user.setUserId(user1.getUserId());
                	System.out.println(user1.getHeadIconUrl());
                    if (user1.getEnable().equals("stop")) {
                        return 0;
                    } else return 1;
                } else {
                    return -1;
                }
            }
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return result;
	}	
	
	public List<User> getOnePage(PageInformation pageInformation) {	
		List<User> users=new ArrayList<User>();
		try {
			DatabaseDao databaseDao=new DatabaseDao();			
			UserDao userDao=new UserDao();		
			users=userDao.getOnePage(pageInformation,databaseDao);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return users;
	}

	public List<User> check(PageInformation pageInformation,String id) {	
		List<User> users=null;
		try {
			DatabaseDao databaseDao=new DatabaseDao();			
			UserDao userDao=new UserDao();
			
			if(id!=null && !id.isEmpty())
				userDao.changeEnable(id,databaseDao);
			
			users=userDao.getOnePage(pageInformation,databaseDao);
			
		} catch (SQLException e) {
			users=null;
			e.printStackTrace();
		} catch (Exception e) {
			users=null;
			e.printStackTrace();
		}		
		return users;
	}
	//删除多条记录
	public List<User> deletes(PageInformation pageInformation) {	
		List<User> users=null;
		try {
			DatabaseDao databaseDao=new DatabaseDao();			
			UserDao userDao=new UserDao();
			userDao.deletes(pageInformation.getIds(),databaseDao);
			pageInformation.setIds(null);
			users=userDao.getOnePage(pageInformation,databaseDao);
		} catch (SQLException e) {
			users=null;
			e.printStackTrace();
		} catch (Exception e) {
			users=null;
			e.printStackTrace();
		}		
		return users;
	}
	//修改密码
	public Integer changePassword(User user, String newPassword) {	
		try {
			DatabaseDao databaseDao=new DatabaseDao();			
			UserDao userDao=new UserDao();
			if(userDao.hasUser( user, databaseDao)){
				if(databaseDao.updateAStringFieldById("user",
						user.getUserId(),"password",newPassword)>0)
					return 1;//修改成功
				else
					return 0;//用户存在，但修改失败，可能是密码问题
			}else
				return -1;//用户不存在
		} catch (SQLException e) {
			e.printStackTrace();
			return -2;//数据库问题
		} catch (Exception e) {
			e.printStackTrace();
			return -3;//其它异常			
		}		
	}	
	
	public Userinformation getByUserId(Integer userId){
		Userinformation userinformation=null;
		try {
			DatabaseDao databaseDao=new DatabaseDao();
			UserinformationDao userinformationDao=new UserinformationDao();
			userinformation=userinformationDao.getByUserId(userId,databaseDao);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return userinformation;
	}

	public Integer updatePrivate(User user,HttpServletRequest request){
		Integer result;
		DatabaseDao databaseDao=null;
		try {
			Userinformation userinformation=new Userinformation();
			if("user".equals(user.getType())){
				userinformation.setUserId(user.getUserId());
			}
			String oldHeadIconUrl=user.getHeadIconUrl();
			// Create a factory for disk-based file items
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// Configure a repository (to ensure a secure temp location is used)
			String fullPath=request.getServletContext()
								   .getRealPath(WebProperties.config.getString("tempDir"));//获取相对路径的绝对路径
			File repository = new File(fullPath);
			factory.setRepository(repository);//设置临时文件存放的文件夹
			// Create a new file upload handler
			ServletFileUpload upload = new ServletFileUpload(factory);
			// 解析request，将其中各表单元素和上传文件提取出来

			List<FileItem> items = upload.parseRequest(request);//items存放各表单元素

			Iterator<FileItem> iter = items.iterator();
			while (iter.hasNext()) {//遍历表单元素
				FileItem item = iter.next();

				if (item.isFormField()) {//非上传文件表单元素
					if("sex".equals(item.getFieldName()))//获取表单元素的name属性
						userinformation.setSex(item.getString("UTF-8"));//获取表单元素的值（一般是value属性）
					if("hobby".equals(item.getFieldName()))//获取表单元素的name属性
						userinformation.setHobby(item.getString("UTF-8"));//获取表单元素的值（一般是value属性）
				} else {//上传文件
					File uploadedFile ;
					String randomFileName;
					do{
						randomFileName=FileTool.getRandomFileNameByCurrentTime(item.getName());
						String full=request.getServletContext()
										   .getRealPath(WebProperties.config.getString("headIconDirDefault")+"\\"
												   +randomFileName);
						uploadedFile=new File(full);
					}while(uploadedFile.exists());//确保文件未存在

					item.write(uploadedFile);//将临时文件转存为新文件保存
					result=1;//表示上传文件成功
					//item.delete();//删除临时文件
					result=2;//表示上传文件成功，且临时文件删除
					String url=WebProperties.config.getString("headIconDirDefault").replace("\\", "/");
					user.setHeadIconUrl("/"+WebProperties.config.getString("projectName")
							+url+"/"+randomFileName);
				}
			}
			databaseDao=new DatabaseDao();
			UserDao userDao=new UserDao();
			UserinformationDao userinformationDao=new UserinformationDao();

			//开始事务处理
			databaseDao.setAutoCommit(false);
			userDao.updateHeadIcon(user, databaseDao);//更新用户表的头像
			if("user".equals(user.getType())){
				userinformation.setUserId(user.getUserId());
				//普通用户有userinformation信息
				if(userinformationDao.hasUserId(user.getUserId(), databaseDao))
					userinformationDao.update(userinformation, databaseDao);//更新用户详细信息
				else
					userinformationDao.insert(userinformation, databaseDao);//插入新的用户详细信息
			}
			databaseDao.commit();
			databaseDao.setAutoCommit(true);
			result=3;//表示上传文件成功，临时文件删除，且路径保存到数据库成功

			if(oldHeadIconUrl.contains(FileTool.getFileName(
					WebProperties.config.getString("headIconFileDefault"))))
				result=5;////表示上传文件成功，临时文件删除，且路径保存到数据库成功，老的图片使用系统默认图片，不需要删除
			else//老的图片没有使用系统默认图片，需要删除
				if(FileTool.deleteFile(new File(FileTool.root.replace(
						"\\"+WebProperties.config.getString("projectName"), "")+oldHeadIconUrl)))
					result=5;////表示上传文件成功，临时文件删除，且路径保存到数据库成功，老的图片被删除
				else
					result=4;////表示上传文件成功，临时文件删除，且路径保存到数据库成功，老的图片无法被删除
		}catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -2;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -3;
		}finally{
			try {
				databaseDao.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return  result;
	}
	public String getUserByPhoneNumber(String phoneNumber){
        UserDao userDao=new UserDao();
        try {
            DatabaseDao databaseDao = new DatabaseDao();
            return userDao.getUserByPhoneNumber(phoneNumber, databaseDao);
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
	}
	public String getUserByEmailUser(String emailUser){
        UserDao userDao=new UserDao();
        try {
            DatabaseDao databaseDao=new DatabaseDao();
            return userDao.getUserByemailUser(emailUser,databaseDao);
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }
	public boolean sendEmail(String to,String subject,String emailContent){
        SimpleEmail simpleEmail=new SimpleEmail();
        simpleEmail.setCharset("UTF-8");
        try{
            //设置邮件服务器
            simpleEmail.setHostName( "smtp.163.com");
            //设置帐号密码
            simpleEmail.setAuthentication("13422892533@163.com","yz789520");
            //设置发送源邮箱
            simpleEmail.setFrom("13422892533@163.com");
            //设置目标邮箱
            simpleEmail.addTo("m13826972883_2@163.com");
         //   simpleEmail.addTo(to);
            //设置主题
            simpleEmail.setSubject(subject);
            //设置邮件内容
            simpleEmail.setMsg(emailContent);
            //发送邮件
            simpleEmail.send();
          return true;
        }catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }
}
