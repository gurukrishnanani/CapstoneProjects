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

public class TechTrackActivityBookSlot{

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
	public void testTracksPresentTesting() throws InterruptedException {
		// for registration
		WebElement registerButton = driver.findElement(By.id("com.example.slotbook:id/btnRegister"));
		registerButton.click();

		Thread.sleep(2000);
		WebElement name = driver.findElement(By.id("com.example.slotbook:id/etName"));
		name.sendKeys("Krishna");

		WebElement email = driver.findElement(By.id("com.example.slotbook:id/etEmail"));
		email.sendKeys("Krishna@gmail.com");

		WebElement password = driver.findElement(By.id("com.example.slotbook:id/etPassword"));
		password.sendKeys("Krishna@123");

		WebElement register = driver.findElement(By.id("com.example.slotbook:id/btnRegister"));
		register.click();

		// for login
		Thread.sleep(2000);
		WebElement validateEmail = driver.findElement(By.id("com.example.slotbook:id/etEmail"));
		validateEmail.sendKeys("Krishna@gmail.com");

		WebElement validatePassword = driver.findElement(By.id("com.example.slotbook:id/etPassword"));
		validatePassword.sendKeys("Krishna@123");

		WebElement loginButton = driver.findElement(By.id("com.example.slotbook:id/btnLogin"));
		loginButton.click();

		Thread.sleep(2000);
		// for checking navigation from Dashboard to tech tracks activity
		WebElement trackNavigation = driver.findElement(By.id("com.example.slotbook:id/btnManageTracks"));
		trackNavigation.click();

		Thread.sleep(3000);
		WebElement title = driver.findElement(By.xpath("//android.widget.TextView[@text='Android Development']"));
		if (title.isDisplayed()) {
			System.out.println("Navagated from dashboard to Tech tracks activity");
			System.out.println("Tech tracks are visible");
		} else {
			System.out.println("Navigation failed");
		}
		
		WebElement dashboard = driver.findElement(By.id("com.example.slotbook:id/btnDashboard"));
		dashboard.click();
		
		Thread.sleep(2000);
		WebElement imageView = driver.findElement(By.id("com.example.slotbook:id/appLogo"));
		if (imageView.isDisplayed()) {
			System.out.println("Navigated back to Dashboard activity");
		} else {
			System.out.println("Navigation failed");
		}
		
	}
	
	@After
	public void tearDown() {
		if (driver != null) {
			driver.quit();
		}
	}

}
