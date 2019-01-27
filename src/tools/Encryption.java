package tools;
import java.security.MessageDigest;
import java.util.Random;

import org.apache.commons.codec.binary.Base64;

import bean.User;
public class Encryption {
  private static final MessageDigest md;
  private static final Base64 b64Encoder;
  private static final Integer saltLen=15;
  static{
	  try{
		  md =MessageDigest.getInstance("MD5","SUN");
		  b64Encoder=new Base64();
	  }catch(Exception e){
		  throw new RuntimeException(e);
	  }
  }
  public static void encryptPassword(User user){
		System.out.println("aassadasd");
	  String salt="";
	  Random rand=new Random();
	  String base="abcdefghijklmnopqrstuvwxyz0123456789~!@#$%^&*()_+";
	  for(int i=0;i<saltLen;i++){
		  String target=String.valueOf(base.charAt(rand.nextInt(base.length())));
		  salt+=target;
	  }
	  try{
		md.reset();
		String passwordSalt=user.getPassword()+salt;
		md.update(passwordSalt.getBytes("UTF-8"));
		byte[] bys=md.digest();
		byte[] lastPassword=b64Encoder.encode(bys);
		user.setPassword(new String (lastPassword));
		user.setSalt(salt);
		System.out.printf(user.getSalt());
 	  }catch(Exception ex){
		  ex.printStackTrace();
	  }
  }
  public static boolean checkPassword(User user,String dataBasePassword){
       try{
    	   md.reset();
    	   String passwordSalt=user.getPassword()+user.getSalt();
    	   md.update(passwordSalt.getBytes("UTF-8"));
    	   byte[] bys=md.digest();
    	   byte[] lastPassword=b64Encoder.encode(bys);
    	   String inputPassword=new String(lastPassword);
    	   if(dataBasePassword.equals(inputPassword))
    		   return true;
    	   else
    		   return false;
       }catch(Exception ex)  {
    	   ex.printStackTrace();
    	   return false;
       }
       
  }
}
