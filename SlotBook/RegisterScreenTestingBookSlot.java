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

public class RegisterScreenTestingBookSlot {
	
	private AppiumDriver driver;

	@Before
	public void setUp() throws MalformedURLException {
		DesiredCapabilities caps = new DesiredCapabilities();
		caps.setCapability(MobileCapabilityType.PLATFORM_NAME, "Android");
		caps.setCapability(MobileCapabilityType.DEVICE_NAME, "Xiaomi Redmi Note 9 Pro");
		caps.setCapability("appPackage", "com.example.slotbook");
		caps.setCapability("appActivity", "com.example.slotbook.ui.LoginActivity");
		caps.setCapability(MobileCapabilityType.AUTOMATION_NAME, "UiAutomator2");

		driver = new AndroidDriver(new URL("http://127.0.0.1:4723"), caps);
	}

	@Test
	public void testElements() throws InterruptedException {
		
		//for Register Button on Login Screen
		WebElement registerButton = driver.findElement(By.id("com.example.slotbook:id/btnRegister"));
		if(registerButton.isDisplayed()) {
			System.out.println("Register button is displayed on the login screen");
		}else {
			System.out.println("Register Button is not displayed");
		}
		registerButton.click();
		
		Thread.sleep(2000);
		//For Name element on register screen 
		WebElement name = driver.findElement(By.id("com.example.slotbook:id/etName"));
		if(name.isDisplayed()) {
			System.out.println("name text is displayed on the Register screen");
		}else {
			System.out.println("name text is not displayed");
		}
		
		//for email element checking 
		WebElement email = driver.findElement(By.id("com.example.slotbook:id/etEmail"));
		if(email.isDisplayed()) {
			System.out.println("email text is displayed on the Register screen");
		}else {
			System.out.println("email text is not displayed");
		}
		
		//for password element checking
		WebElement password = driver.findElement(By.id("com.example.slotbook:id/etPassword"));
		if(email.isDisplayed()) {
			System.out.println("Password text is displayed on the Register screen");
		}else {
			System.out.println("Password text is not displayed");
		}
		
		//for register Button checking on the Register screen
		WebElement register = driver.findElement(By.id("com.example.slotbook:id/btnRegister"));
		if(register.isDisplayed()) {
			System.out.println("Register Button is displayed on the Register screen");
		}else {
			System.out.println("Register Button is not displayed");
		}
		
		//for checking Already button is there or not
		WebElement alreadyRegister = driver.findElement(By.id("com.example.slotbook:id/btnBack"));
		if(alreadyRegister.isDisplayed()) {
			System.out.println("Already Registered Button is displayed on the Register screen");
		}else {
			System.out.println("Already Registered Button is not displayed");
		}
	}
	
	@Test
	public void testFunctionality() throws InterruptedException {
		//checking register button on Login page
		WebElement registerButton = driver.findElement(By.id("com.example.slotbook:id/btnRegister"));
		registerButton.click();
		Thread.sleep(2000);
		WebElement imageView = driver.findElement(By.id("com.example.slotbook:id/appLogo"));
		if(imageView.isDisplayed()) {
			System.out.println("Successfully navigated to the Register Activity From Login Activity");
		}else {
			System.out.println("Navigation Failed");
		}
		
		WebElement name = driver.findElement(By.id("com.example.slotbook:id/etName"));
		name.sendKeys("Krishna");
		
		WebElement email = driver.findElement(By.id("com.example.slotbook:id/etEmail"));
		email.sendKeys("Krishna@gmail.com");
		
		WebElement password = driver.findElement(By.id("com.example.slotbook:id/etPassword"));
		password.sendKeys("Krishna@264842");
		
		WebElement register = driver.findElement(By.id("com.example.slotbook:id/btnRegister"));
		register.click();
		
		Thread.sleep(2000);
		WebElement validation = driver.findElement(By.id("com.example.slotbook:id/btnLogin"));
		if(validation.isDisplayed()) {
			System.out.println("User Registered Successfully");
		}else {
			System.out.println("Registration Failed");
		}
		
	}
	
	@After
	public void tearDown() {
		if (driver != null) {
			driver.quit();
		}
	}
}

































