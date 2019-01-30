package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsRequest;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import service.UserService;
import tools.Encryption;
import tools.Message;
import tools.PageInformation;
import tools.SearchTool;
import tools.Tool;
import bean.User;
import bean.Userinformation;

public class UserServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String type = request.getParameter("type1");
		UserService userService = new UserService();
		Message message = new Message();
		if (type.equals("register")) {
//			PrintWriter out = response.getWriter();
//			User user = new User();
//			user.setType(request.getParameter("type"));
//			user.setName(request.getParameter("name"));
//			user.setPassword(request.getParameter("password"));
//			user.setEmail(request.getParameter("emailNumber"));
//			user.setPhone(request.getParameter("phoneNumber"));
//			if (user.getType().equals("user"))
//				user.setEnable("use");
//			else
//				user.setEnable("stop");
//			int result = userService.register(user);
//			//	message.setResult(result);
//			if (result == 1) {
//				out.println("注册成功");
////				message.setMessage("注册成功！");
////				message.setRedirectUrl("/news/user/free/login.jsp");
//			} else if (result == 0) {
//				out.println("同名用户已存在，请改名重新注册！");
////				message.setMessage("同名用户已存在，请改名重新注册！");
////				message.setRedirectUrl("/news/user/free/register.jsp");
//			} else if (result == -2) {
//				out.println("邮箱已存在，请改名重新注册！");
////                message.setMessage("邮箱已存在，请改名重新注册！");
////                message.setRedirectUrl("/news/user/free/register.jsp");
//			} else if (result == -3) {
//				out.println("手机已被注册，请改名重新注册！");
////                message.setMessage("手机已被注册，请改名重新注册！");
////                message.setRedirectUrl("/news/user/free/register.jsp");
//			} else {
//				out.println("注册失败！");
////				message.setMessage("注册失败！");
////				message.setRedirectUrl("/news/user/free/register.jsp");
//			}
////			request.setAttribute("message", message);
////			getServletContext().getRequestDispatcher("/message.jsp").forward(request,response);
//			return;

			User user=new User();
			user.setType(request.getParameter("type"));
			user.setName(request.getParameter("name"));
			user.setPassword(request.getParameter("password"));
			user.setEmail(request.getParameter("email"));
			if(user.getType().equals("user"))
				user.setEnable("use");
			else
				user.setEnable("stop");

			String checkCode = request.getParameter("checkCode");
			HttpSession session=request.getSession();
			String severCheckCode=(String)session.getAttribute("checkCode");//获取session中的验证码

			int result;
			if(severCheckCode==null ){//服务器端验证图片验证码不存在
				message.setResult(-3);
				message.setMessage("注册失败！服务器端验证图片验证码不存在，请重新注册！");
				message.setRedirectUrl("/news/user/public/register.jsp");
			}else if(!severCheckCode.equals(checkCode)){//服务器端验证图片验证码验证失败
				message.setResult(-4);
				message.setMessage("注册失败！服务器端验证图片验证码验证失败，请重新注册！");
				message.setRedirectUrl("/news/user/public/register.jsp");
			}else{//验证码验证正确
				result=userService.register(user);
				message.setResult(result);
				if(result==1){
					message.setMessage("注册成功！");
					message.setRedirectUrl("/news/user/public/login.jsp");
				}else if(result==0){
					message.setMessage("同名用户已存在，请改名重新注册！");
					message.setRedirectUrl("/news/user/public/register.jsp");
				}else if(result==-1){
					message.setMessage("电子邮箱已被使用，请换一个电子邮箱重新注册！");
					message.setRedirectUrl("/news/user/public/register.jsp");
				}else{
					message.setMessage("注册失败！请重新注册！");
					message.setRedirectUrl("/news/user/public/register.jsp");
				}
			}
			Gson gson = new Gson();
			String jsonString= gson.toJson(message);
			Tool.returnJsonString(response, jsonString);

		} else if (type.equals("login")) {
			PrintWriter out = response.getWriter();
			String checkCode = request.getParameter("checkCode");
			HttpSession session = request.getSession();
			String severCheckCode = (String) session.getAttribute("checkCode");//获取session中的验证码
			if (severCheckCode == null) {//服务器端验证图片验证码不存在
//				message.setResult(-4);
				out.println("登录失败！服务器端验证图片验证码不存在，请重新登录！");
//				message.setRedirectUrl("/news2/user/public/login.jsp");
			} else if (!severCheckCode.equals(checkCode)) {//服务器端验证图片验证码验证失败
//				message.setResult(-5);
				out.println("验证码错误!");
//				message.setRedirectUrl("/news2/user/public/login.jsp");
			} else {//验证码验证正确
				User user = new User();
				user.setName(request.getParameter("name"));
				user.setPassword(request.getParameter("password"));
				int result = userService.login(user);
				message.setResult(result);
				if (result == 1) {
					user.setPassword(null);//防止密码泄露
					request.getSession().setAttribute("user", user);
					String originalUrl = (String) request.getSession().getAttribute("originalUrl");

					if (originalUrl == null)
						message.setRedirectUrl("/news2/user/manageUIMain/manageMain.jsp");
					else
						message.setRedirectUrl(originalUrl);
//					request.setAttribute("message", message);
//					getServletContext().getRequestDispatcher("/message.jsp").forward(request, response);
					Gson gson = new Gson();
					String jsonString = gson.toJson(message);
					Tool.returnJsonString(response, jsonString);
					return;
				} else if (result == 0) {
					out.println("用户存在，但已被停用，请联系管理员！");
//				message.setMessage("用户存在，但已被停用，请联系管理员！");
//				message.setRedirectUrl("/news/user/free/login.jsp");
					return;
				} else if (result == -1) {
					out.println("用户不存在，或者密码错误，请重新登录！");
//				message.setMessage("用户不存在，或者密码错误，请重新登录！");
//				message.setRedirectUrl("/news/user/free/login.jsp");
					return;
				} else if (result == -2) {
					out.println("出现其它错误，请重新登录！");
//				   message.setMessage("出现其它错误，请重新登录！");
//				   message.setRedirectUrl("/news/user/free/login.jsp");
					return;
				}
			}
			//	return;
		}else if (type.equals("showPage")) {
            PageInformation pageInformation=new PageInformation();
            Tool.getPageInformation("user", request, pageInformation);
            //Tool.getPageInformationFromBootstrapTable("user", request, pageInformation);

            List<User> users=userService.getOnePage(pageInformation);

            Gson gson = new Gson();
            String usersJsonString= gson.toJson(users);
            String jsonString = "{\"total\":" + pageInformation.getAllRecordCount() + ",\"rows\":" + usersJsonString + "}";
            Tool.returnJsonString(response, jsonString);
        } else if (type.equals("search")) {
			PageInformation pageInformation = new PageInformation();
			Tool.getPageInformation("user", request, pageInformation);
			pageInformation.setSearchSql(SearchTool.user(request));
			List<User> users = userService.getOnePage(pageInformation);
			request.setAttribute("pageInformation", pageInformation);
			request.setAttribute("users", users);
			getServletContext().getRequestDispatcher("/manager/userShow.jsp").forward(request, response);
		} else if (type.equals("check")) {
			PageInformation pageInformation = new PageInformation();
			Tool.getPageInformation("user", request, pageInformation);
			String id = pageInformation.getIds();
			pageInformation.setIds(null);
			List<User> users = userService.check(pageInformation, id);
			if (users == null) {
				message.setMessage("切换可用性失败，请联系管理员！");
				message.setRedirectUrl("/news/servlet/UserServlet?type1=check&page=1&pageSize=2");
			} else {
				request.setAttribute("pageInformation", pageInformation);
				request.setAttribute("users", users);
				getServletContext().getRequestDispatcher("/manager/userCheck.jsp").forward(request, response);
			}
		} else if (type.equals("delete")) {
			PageInformation pageInformation = new PageInformation();
			Tool.getPageInformation("user", request, pageInformation);
			pageInformation.setSearchSql(" (type='user' or type='newsAuthor')");
			List<User> users = userService.deletes(pageInformation);
			request.setAttribute("pageInformation", pageInformation);
			request.setAttribute("users", users);
			getServletContext().getRequestDispatcher("/manager/userDelete.jsp").forward(request, response);
		} else if (type.equals("changePassword")) {
			String newPassword = request.getParameter("newPassword");
			User user = (User) request.getSession().getAttribute("user");
			user.setPassword(request.getParameter("oldPassword"));
			Integer result = userService.changePassword(user, newPassword);
			message.setResult(result);
			if (result == 1) {
				message.setMessage("修改密码成功！");
			} else if (result == 0) {
				message.setMessage("修改密码失败，请联系管理员！");
			}
			message.setRedirectTime(1000);
			request.setAttribute("message", message);
			getServletContext().getRequestDispatcher("/message.jsp").forward(request, response);
		} else if (type.equals("showPrivate")) {//显示普通用户个人信息
			User user=(User)request.getSession().getAttribute("user");
			List<Object> list = new ArrayList<Object>();
			list.add(user);
			if("user".equals(user.getType())){
				Userinformation userinformation=userService.getByUserId(user.getUserId());
				list.add(userinformation);
			}
			Gson gson = new Gson();
			String jsonString= gson.toJson(list);
			Tool.returnJsonString(response, jsonString);
		} else if (type.equals("changePrivate1")) {//修改用户个人信息的第一步：显示可修改信息
			User user=(User)request.getSession().getAttribute("user");
			List<Object> list = new ArrayList<Object>();
			list.add(user);

			if("user".equals(user.getType())){
				Userinformation userinformation=userService.getByUserId(user.getUserId());
				list.add(userinformation);
			}

			Gson gson = new Gson();
			String jsonString= gson.toJson(list);
			Tool.returnJsonString(response, jsonString);
		} else if (type.equals("changePrivate2")) {//修改用户个人信息的第二步：修改信息
			User user=(User)request.getSession().getAttribute("user");
			if("user".equals(user.getType())){
				Userinformation userinformation=new Userinformation();
				userinformation.setUserId(user.getUserId());
				userinformation.setSex(request.getParameter("sex"));
				userinformation.setHobby(request.getParameter("hobby"));
			}
			Integer result=userService.updatePrivate(user, request);
			message.setResult(result);
			if(result==5||result==4){
				message.setMessage("修改个人信息成功！");
				message.setRedirectUrl("/news/servlet/UserServlet?type1=showPrivate");
			}else if(result==0){
				message.setMessage("修改个人信息失败，请联系管理员！");
				message.setRedirectUrl("/news/servlet/UserServlet?type1=showPrivate");
			}

			Gson gson = new Gson();
			String jsonString= gson.toJson(message);
			Tool.returnJsonString(response, jsonString);
		} else if (type.equals("phoneLogin")) {
			PrintWriter out = response.getWriter();
			String phoneNumber = request.getParameter("phoneNumber");
			String Message = request.getParameter("phoneMessage");
			String phoneMessage = String.valueOf(request.getSession().getAttribute(phoneNumber));
			String username = String.valueOf(request.getSession().getAttribute("username"));
			if (phoneMessage.equals(Message)) {
				User user = new User();
				user.setName(username);
				request.getSession().setAttribute("user", user);
				String originalUrl = (String) request.getSession().getAttribute("originalUrl");
				out.println("success");
			} else {
				out.println("验证码错误");
			}
		} else if (type.equals("sendMessage")) {
			PrintWriter out = response.getWriter();
			String phoneNumber = request.getParameter("phoneNumber");
			String username = userService.getUserByPhoneNumber(phoneNumber);
			if (username == null) {
				out.println("手机未被未注册!");
				return;
			} else {
				String phoneMessage = String.valueOf((int) (Math.random() * 100000));
				System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
				System.setProperty("sun.net.client.defaultReadTimeout", "10000");
				//初始化ascClient需要的几个参数
				final String product = "Dysmsapi";//短信API产品名称（短信产品名固定，无需修改）
				final String domain = "dysmsapi.aliyuncs.com";//短信API产品域名（接口地址固定，无需修改）
				//替换成你的AK
				final String accessKeyId = "LTAIBYpIBtMD4H2W";//你的accessKeyId,参考本文档步骤2
				final String accessKeySecret = "F5jWgDFBS64I1o6ZVXsbaX2eHIQdn1";//你的accessKeySecret，参考本文档步骤2
				//初始化ascClient,暂时不支持多region（请勿修改）
				try {
					IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", accessKeyId,
							accessKeySecret);
					DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", product, domain);
					IAcsClient acsClient = new DefaultAcsClient(profile);

					//组装请求对象
					SendSmsRequest request1 = new SendSmsRequest();
					//使用post提交
					request1.setMethod(MethodType.POST);
					//必填:待发送手机号。支持以逗号分隔的形式进行批量调用，批量上限为1000个手机号码,批量调用相对于单条调用及时性稍有延迟,验证码类型的短信推荐使用单条调用的方式；发送国际/港澳台消息时，接收号码格式为00+国际区号+号码，如“0085200000000”
					request1.setPhoneNumbers(phoneNumber);
					//必填:短信签名-可在短信控制台中找到
					request1.setSignName("顺手校园生活");
					//必填:短信模板-可在短信控制台中找到，发送国际/港澳台消息时，请使用国际/港澳台短信模版
					request1.setTemplateCode("SMS_144851626");
					//可选:模板中的变量替换JSON串,如模板内容为"亲爱的${name},您的验证码为${code}"时,此处的值为
					//友情提示:如果JSON中需要带换行符,请参照标准的JSON协议对换行符的要求,比如短信内容中包含\r\n的情况在JSON中需要表示成\\r\\n,否则会导致JSON在服务端解析失败
					request1.setTemplateParam("{\"name\":\"Tom\", \"code\":\"" + phoneMessage + "\"}");
					//可选-上行短信扩展码(扩展码字段控制在7位或以下，无特殊需求用户请忽略此字段)
					//request.setSmsUpExtendCode("90997");
					//可选:outId为提供给业务方扩展字段,最终在短信回执消息中将此值带回给调用者
					request1.setOutId("yourOutId");
					//请求失败这里会抛ClientException异常
					SendSmsResponse sendSmsResponse = null;
					sendSmsResponse = acsClient.getAcsResponse(request1);
					if (sendSmsResponse.getCode() != null && sendSmsResponse.getCode().equals("OK")) {
						//请求成功
						request.getSession().setAttribute(phoneNumber, phoneMessage);
						request.getSession().setAttribute("username", username);
						out.println("发送成功");
					} else {
						out.println("发送失败!");
					}
				} catch (ClientException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		} else if (type.equals("emailLogin")) {
			PrintWriter out = response.getWriter();
			String emailUser = request.getParameter("emailUser");
			String Message = request.getParameter("emailMessage");
			String emailMessage = String.valueOf(request.getSession().getAttribute(emailUser));
			String username = String.valueOf(request.getSession().getAttribute("username"));
			if (emailMessage.equals(Message)) {
				User user = new User();
				user.setName(username);
				request.getSession().setAttribute("user", user);
				out.println("success");
			} else {
				out.println("验证码错误");
			}
		} else if (type.equals("sendEmail")) {
			PrintWriter out = response.getWriter();
			String emailUser = request.getParameter("emailUser");
			String username = userService.getUserByEmailUser(emailUser);
			if (username == null) {
				out.println("邮箱未被注册!");
			} else {
				String emailMessage = String.valueOf((int) (Math.random() * 10000));
				if (userService.sendEmail(emailUser, "3213", emailMessage)) {
					request.getSession().setAttribute(emailUser, emailMessage);
					request.getSession().setAttribute("username", username);
					out.println("发送成功");
				} else {
					out.println("发送失败!");
				}
			}
		} else if ("user".equals(type)) {
			HttpSession session = request.getSession();
			User user = (User) session.getAttribute("user");
			if(user!=null) {
				System.out.println(user.getName() + user.getUserId());
			}
			Gson gson = new Gson();
			String jsonString = gson.toJson(user);
			Tool.returnJsonString(response, jsonString);
			return;
		} else if (type.equals("exit")) {
			request.getSession().removeAttribute("user");
			message.setResult(1);
			Gson gson = new Gson();
			String jsonString = gson.toJson(message);
			Tool.returnJsonString(response, jsonString);
		}
	}

}
