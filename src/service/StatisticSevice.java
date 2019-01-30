package service;

import bean.FirstTenCommentNumberAYear;
import com.jacob.com.ComThread;
import dao.UsercommentviewDao;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import tools.JacobExcelTool;
import tools.JacobWordManager;
import tools.Tool;
import tools.WebProperties;

import javax.servlet.http.HttpServletRequest;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.List;

public class StatisticSevice {
	public String firstTenCommentNumberAYearEveryYear(HttpServletRequest request){
		UsercommentviewDao usercommentviewDao=new UsercommentviewDao();
		List<FirstTenCommentNumberAYear> firstTenCommentNumberAYearEveryYearList=null;
		try {
			firstTenCommentNumberAYearEveryYearList=usercommentviewDao.firstTenCommentNumberAYearInAYearEveryYear();
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		String wordFile="-1";
		Workbook wb=null;
		FileInputStream fis=null;
		//打开word
		ComThread.InitMTA(true);
		JacobWordManager jacobWordManager=null;
		try {
			int first=1;			

			for(FirstTenCommentNumberAYear firstTenCommentNumberAYear: firstTenCommentNumberAYearEveryYearList){
				String fullPath=request.getServletContext().getRealPath(WebProperties.config.getString("excelTemplate"));//获取相对路径的绝对路径
		    	String excelFileFullPath=fullPath+"\\excelTemplate.xlsm";			    	
		        //使用poi对excel文件读写 //  这里也可以使用jacob对excel文件进行读写，但poi的代码简单，可读性更强
		        fis = new FileInputStream(excelFileFullPath);
		        wb= new XSSFWorkbook(fis);
	    		fis.close();// 输入流使用后，及时关闭
		        
				Sheet sheet = wb.getSheetAt(0);
				Row row ;
				//修改年度
				row = sheet.getRow(1);
				row.getCell(1).setCellValue(firstTenCommentNumberAYear.getYear()+"年前十名发帖数");
				// 遍历excel行				
				for (int i = 2; i <= 11; i++) {//12行
					row = sheet.getRow(i);			
					row.getCell(0).setCellValue(firstTenCommentNumberAYear.getFirstTenCommentNumberList().get(i-2).getUserName());;
					row.getCell(1).setCellValue(firstTenCommentNumberAYear.getFirstTenCommentNumberList().get(i-2).getCommentNumber());;
				}
				
				//将最新的 Excel 内容写回到原始 Excel 文件中
				FileOutputStream excelFileOutPutStream = new FileOutputStream(excelFileFullPath);
				wb.write(excelFileOutPutStream);
				excelFileOutPutStream.flush();
				excelFileOutPutStream.close();
				
				wb.close();	
				
				//excel调用宏,poi无法调用宏
				JacobExcelTool jacobExcelTool = new JacobExcelTool();
				//打开
				jacobExcelTool.OpenExcel(excelFileFullPath,false,false);
				//调用Excel宏
				jacobExcelTool.callMacro("firstTenCommentNumber");
		    	//关闭并保存，释放对象
		    	jacobExcelTool.CloseExcel(true, true);		
				
				jacobWordManager=new JacobWordManager(false);
				//单个年份的word文件
				fullPath=request.getServletContext().getRealPath(WebProperties.config.getString("wordTemplate"));//获取相对路径的绝对路径
		    	
		    	String oneYearWord=fullPath+"\\oneYear.docm";
		    	
		    	jacobWordManager.openDocument(oneYearWord);		    	
		    	jacobWordManager.callMacro("deleteAll");
		    	jacobWordManager.callMacro("pasteChart");
		    	jacobWordManager.copyContentFromAnotherDocInsertBefore(fullPath+"\\oneYear-origin.docx");//复制oneYear-origin.docx文件内容到本文件中	
		    	jacobWordManager.goToBegin();
		    	jacobWordManager.replaceAllText("#year", firstTenCommentNumberAYear.getYear().toString());
		    	jacobWordManager.goToBegin();
		    	jacobWordManager.replaceText("#total", firstTenCommentNumberAYear.getTotalCommentNumber().toString());
		    	jacobWordManager.goToBegin();		    	
		    	jacobWordManager.replaceText("#averageByMonth", ""+ Tool.formatDouble(firstTenCommentNumberAYear.getTotalCommentNumber()*1.0/12).toString());
		    	jacobWordManager.callMacro("println");
		    	jacobWordManager.closeDocumentWithSave();//关闭文件
		    	
		    	//多个年份合并的word文件
		    	jacobWordManager.openDocument(fullPath+"\\allYear.docm");
		    	
		    	if(first==1){//输入第一年数据前，先将word文档清空（删除旧数据）
		    		jacobWordManager.callMacro("deleteAllContent");
		    		first++;
		    	}
		    	jacobWordManager.goToEnd();//到文件尾
		    	jacobWordManager.copyContentFromAnotherDocInsertAfter(oneYearWord);//复制wordTemplateFileFullPath文件内容到本文件中
		    	jacobWordManager.closeDocumentWithSave();
		    	jacobWordManager.close();//关闭word程序
			}			
			 
			wordFile="\\"+ WebProperties.config.getString("projectName")+ WebProperties.config.getString("wordTemplate")+"\\allYear.docm";
			wordFile=wordFile.replace("\\", "/");
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			wordFile="-2";
		}finally{
			jacobWordManager.close();//关闭word程序
			ComThread.Release();
		}
		return wordFile;
	}		
}
