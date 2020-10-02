import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.Select;

public class JavaScriptExecutor{    //Do not change the class name
	
	//Use the below declarations
	public static WebDriver driver;
	public static Object jsfname,jslname, jsuname, jspwd, jsphone, jsemail, jssubmit, jsreset;
	
	public WebDriver createDriver()
	{
		//Create the driver using the class DriverSetup. Assign it to the variable 'driver' and return it.
		driver = DriverSetup.getWebDriver();
//		System.setProperty("webdriver.chrome.driver","C:/Users/wridd/Downloads/chromedriver_win32/chromedriver.exe");
//		 driver = new ChromeDriver();
//		driver.manage().window().maximize();
		driver.get("https://webapps.tekstac.com/Agent_Registration/");
		return driver;
	}
 
 
  public void submitForm(String fname,String lname, String uname, String pwd, String phone, String email) 
  {
	    JavascriptExecutor jse = ((JavascriptExecutor)driver);
	    
	    //Using javascript executor, locate the elements of 'firstname','lastname','username','password'
	    //'phonenumber','email' and send the received values.
	    //Submit the form
	    
	    jse.executeScript("document.forms[0][0].value=arguments[0];",fname);
	    jse.executeScript("document.forms[0][1].value=arguments[0];",lname);
	    jse.executeScript("document.forms[0][2].value=arguments[0];",uname);
	    jse.executeScript("document.forms[0][3].value=arguments[0];",pwd);
	    jse.executeScript("document.forms[0][4].value=arguments[0];",phone);
	    jse.executeScript("document.forms[0][5].value=arguments[0];",email);
	    jse.executeScript("document.getElementById('submit').click();");
	    
	    
	    
        
        
                
  }
  
  
  public void reset()
  {
	  JavascriptExecutor jse = ((JavascriptExecutor)driver);
	  //Using javascript executor, locate the element reset and click it.
	  jse.executeScript("document.getElementById('reset').click();");
  }
  
  
  public static void main(String[] args) {
	    JavaScriptExecutor at=new JavaScriptExecutor();
		at.createDriver();
		at.reset();
		//Use this values to submit the form
		at.submitForm("Rahul","Dravid","Rahul","rahul@123","6232126711","rahultest@gmail.com");
		
		 
	}
  
}