package bookSlot;
import static org.junit.Assert.*;

import java.net.MalformedURLException;
import java.net.URL;
import java.time.Duration;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import io.appium.java_client.AppiumDriver;
import io.appium.java_client.MobileBy;
import io.appium.java_client.android.AndroidDriver;
import io.appium.java_client.remote.MobileCapabilityType;

public class BookSlotTesting {

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
	public void testBookSlot() throws InterruptedException {
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

		WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
		WebElement slotNavigation = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//android.widget.TextView[@text='Android Development']")));
		slotNavigation.click();
		
		Thread.sleep(3000);
		WebDriverWait wait2 = new WebDriverWait(driver, Duration.ofSeconds(10));
		WebElement bookNavigation = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//android.widget.TextView[@text='10:00 AM']")));
		bookNavigation.click();
		
		Thread.sleep(2000);
		WebElement bookSlot = driver.findElement(By.id("com.example.slotbook:id/btnBookSlot"));
		if(bookSlot.isDisplayed()) {
			System.out.println("Navigated successfully from availability slots to Book Slot");
		}else {
			System.out.println("Navigation Failed");
		}
		bookSlot.click();
		
		Thread.sleep(2000);
		WebElement dashboard = driver.findElement(By.id("com.example.slotbook:id/btnDashboard"));
		dashboard.click();
		
		Thread.sleep(2000);
		WebElement bookedSlots = driver.findElement(By.id("com.example.slotbook:id/btnBookedSlots"));
		bookedSlots.click();
		
		WebElement slotTime = driver.findElement(MobileBy.id("com.example.slotbook:id/textViewSlotTime"));
		System.out.println("Slot Time: " + slotTime.getText());

		WebElement slotStatus = driver.findElement(MobileBy.id("com.example.slotbook:id/textViewInterviewerName"));
		System.out.println("Slot Status: " + slotStatus.getText());
	}
	
	@After
	public void tearDown() {
		if (driver != null) {
			driver.quit();
		}
	}
}
