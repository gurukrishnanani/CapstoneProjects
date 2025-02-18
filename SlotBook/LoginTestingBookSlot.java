package bookSlot;
import static org.junit.Assert.*;

import java.net.MalformedURLException;
import java.net.URL;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.remote.DesiredCapabilities;

import io.appium.java_client.AppiumDriver;
import io.appium.java_client.android.AndroidDriver;
import io.appium.java_client.remote.MobileCapabilityType;

public class LoginTestingBookSlot {
	
	private AppiumDriver driver;

	@Before
	public void setUp() throws MalformedURLException {
		DesiredCapabilities caps = new DesiredCapabilities();
		caps.setCapability(MobileCapabilityType.PLATFORM_NAME, "Android");
		caps.setCapability(MobileCapabilityType.DEVICE_NAME, "Xiaomi Redmi Note 9 Pro");
		caps.setCapability("appPackage", "com.example.slotbook");
		caps.setCapability("appActivity", "com.example.slotbook.ui.LoginActivity");
		caps.setCapability(MobileCapabilityType.AUTOMATION_NAME, "UiAutomator2");

		driver = new AndroidDriver(new URL("http://localhost:4723"), caps);
	}
	
	
	@Test
	public void testLoginElements() {
		//For checking email element
		WebElement email = driver.findElement(By.id("com.example.slotbook:id/etEmail"));
		if(email.isDisplayed()) {
			System.out.println("email text is displayed on the Register screen");
		}else {
			System.out.println("email text is not displayed");
		}
		
		//For checking password element
		WebElement name = driver.findElement(By.id("com.example.slotbook:id/etPassword"));
		if(email.isDisplayed()) {
			System.out.println("password text is displayed on the Register screen");
		}else {
			System.out.println("Password text is not displayed");
		}
		
		//For Login Button
		WebElement loginButton = driver.findElement(By.id("com.example.slotbook:id/btnLogin"));
		if(loginButton.isDisplayed()) {
			System.out.println("Login button is displayed on the login screen");
		}else {
			System.out.println("Login Button is not displayed");
		}
		
		//for registered button
		WebElement registerButton = driver.findElement(By.id("com.example.slotbook:id/btnRegister"));
		if(registerButton.isDisplayed()) {
			System.out.println("Register button is displayed on the login screen");
		}else {
			System.out.println("Register Button is not displayed");
		}
	}
	
	@Test
	public void testFunctionality() throws InterruptedException {
		WebElement registerButton = driver.findElement(By.id("com.example.slotbook:id/btnRegister"));
		registerButton.click();
		
		Thread.sleep(2000);
		WebElement name = driver.findElement(By.id("com.example.slotbook:id/etName"));
		name.sendKeys("Krishna");
		
		WebElement email = driver.findElement(By.id("com.example.slotbook:id/etEmail"));
		email.sendKeys("Krishna@gmail.com");
		
		WebElement password = driver.findElement(By.id("com.example.slotbook:id/etPassword"));
		password.sendKeys("Krishna@264842");
		
		WebElement register = driver.findElement(By.id("com.example.slotbook:id/btnRegister"));
		register.click();
		
		System.out.println("Registration successfull");
		
		Thread.sleep(2000);
		
		WebElement validateEmail = driver.findElement(By.id("com.example.slotbook:id/etEmail"));
		validateEmail.sendKeys("Krishna@gmail.com");
		
		WebElement validatePassword = driver.findElement(By.id("com.example.slotbook:id/etPassword"));
		validatePassword.sendKeys("Krishna@264842");
		
		WebElement loginButton = driver.findElement(By.id("com.example.slotbook:id/btnLogin"));
		loginButton.click();
		
		Thread.sleep(2000);
		WebElement imageView = driver.findElement(By.id("com.example.slotbook:id/appLogo"));
		if(imageView.isDisplayed()) {
			System.out.println("User login Successfull");
			System.out.println("Navigated from Login screen to Dashboard screen");
		}else {
			System.out.println("Login Failed");
		}
		
	}
	
	@After
	public void tearDown() {
		if (driver != null) {
			driver.quit();
		}
	}
}