package tests;

import io.appium.java_client.AppiumDriver;
import io.appium.java_client.MobileElement;
import org.junit.jupiter.api.Test;
import views.HomeView;
import views.RegistroView;

import java.net.MalformedURLException;

public class RegistroTest {

    private AppiumDriver<MobileElement> driver;
    public HomeView homeView;
    public RegistroView registroView;

    @Test
    public void registro() throws MalformedURLException, InterruptedException {
        homeView = new HomeView(driver);
        registroView = new RegistroView(driver);
        homeView.seleccionarRegistrar();
        registroView.registro();
    }

}

