package base;

import io.appium.java_client.AppiumDriver;
import io.appium.java_client.MobileElement;
import io.appium.java_client.remote.MobileCapabilityType;
import org.openqa.selenium.By;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.concurrent.TimeUnit;

public class Base {
    private static AppiumDriver<MobileElement> driver;

    public Base(AppiumDriver<MobileElement> driver) {
        //PageFactory.initElements(new AppiumFieldDecorator(MobileDriverManager.getMobileDriver()), this);
        this.driver = driver;
    }

    public static void setMobileDriver() throws MalformedURLException {
        DesiredCapabilities desiredCapabilities = new DesiredCapabilities();

        desiredCapabilities.setCapability(MobileCapabilityType.AUTOMATION_NAME, "uiautomator2");
        desiredCapabilities.setCapability(MobileCapabilityType.PLATFORM_NAME, "Android");
        desiredCapabilities.setCapability(MobileCapabilityType.PLATFORM_VERSION, "11.0");
        desiredCapabilities.setCapability(MobileCapabilityType.APP, "C:\\Users\\Rusianeitor\\IdeaProjects\\Mobile\\src\\test\\resources\\apps\\exito.apk");
        desiredCapabilities.setCapability(MobileCapabilityType.UDID, "emulator-5554");
        desiredCapabilities.setCapability("appWaitActivity", "*");

        URL url = new URL("http://127.0.0.1:4723/wd/hub");
        driver = new AppiumDriver<MobileElement>(url, desiredCapabilities);
        //driver = new AndroidDriver<MobileElement>(url, desiredCapabilities);
    }

    public static AppiumDriver<MobileElement> getMobileDriver() {
        return driver;
    }

    public void clickElement(MobileElement element) {
        element.click();
    }

    public void click(By locator) {
        driver.findElement(locator).click();
    }

    public void type(String inputText, By locator) {
        driver.findElement(locator).sendKeys(inputText);
    }

    public Boolean isDisplayed(By locator) {
        try {
            return driver.findElement(locator).isDisplayed();
        } catch (org.openqa.selenium.NoSuchElementException e) {
            return false;
        }
    }

    public void esperaExplicita(int time, By locator) {
        WebDriverWait ewait = new WebDriverWait(driver, time);
        ewait.until(ExpectedConditions.elementToBeClickable(locator));
    }

    public String getText(MobileElement element) {
        return element.getText();
    }

    public boolean isObjectVisible(MobileElement element) {
        MobileDriverManager.getMobileDriver().manage().timeouts().implicitlyWait(20L, TimeUnit.SECONDS);
        boolean esVisible = false;
        esVisible = element.isDisplayed();
        return esVisible;
    }

    public static void esperaObjeto(MobileElement element) {
        WebDriverWait wait = new WebDriverWait(MobileDriverManager.getMobileDriver(), 60L);
        wait.until(ExpectedConditions.elementToBeClickable(element));
    }

    public static void cambiarTiempoDeEsperaImplicito(int tiempoEspera) {
        MobileDriverManager.getMobileDriver().manage().timeouts().implicitlyWait((long) tiempoEspera, TimeUnit.SECONDS);
    }

    public static void stop() throws InterruptedException {
        driver.quit();
    }

}
