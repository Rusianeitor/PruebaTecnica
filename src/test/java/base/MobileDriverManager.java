package base;

import io.appium.java_client.AppiumDriver;
import io.appium.java_client.MobileElement;
import io.appium.java_client.remote.MobileCapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;

import java.net.MalformedURLException;
import java.net.URL;

public class MobileDriverManager {

    private static AppiumDriver<MobileElement> driver;

    public MobileDriverManager() {

    }

    public static void setMobileDriver() throws MalformedURLException {
        DesiredCapabilities desiredCapabilities = new DesiredCapabilities();

        desiredCapabilities.setCapability(MobileCapabilityType.AUTOMATION_NAME, "uiautomator2");
        desiredCapabilities.setCapability(MobileCapabilityType.PLATFORM_NAME, "Android");
        desiredCapabilities.setCapability(MobileCapabilityType.PLATFORM_VERSION, "11.0");
        desiredCapabilities.setCapability(MobileCapabilityType.APP, "C:\\Users\\Rusianeitor\\IdeaProjects\\DemoMobChoucair\\src\\test\\resources\\apps\\exito.apk");
        desiredCapabilities.setCapability(MobileCapabilityType.UDID, "emulator-5554");
        desiredCapabilities.setCapability("appWaitActivity", "*");

        URL url = new URL("http://127.0.0.1:4723/wd/hub");
        driver = new AppiumDriver<MobileElement>(url, desiredCapabilities);
        //driver = new AndroidDriver<MobileElement>(url, desiredCapabilities);
    }

    public static AppiumDriver<MobileElement> getMobileDriver() {
        return driver;
    }
}
