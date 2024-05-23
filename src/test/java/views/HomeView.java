package views;

import base.Base;
import io.appium.java_client.AppiumDriver;
import io.appium.java_client.MobileElement;
import org.openqa.selenium.By;

import java.net.MalformedURLException;

public class HomeView extends Base {

    public HomeView(AppiumDriver<MobileElement> driver) {
        super(driver);
    }

    By btnIngresar = By.id("com.exito.appcompania:id/AppCompatButton_ingresar");
    By btnRegistrar = By.id("com.exito.appcompania:id/AppCompatButton_registrarse");

    public void seleccionarIngresar() throws MalformedURLException {
        setMobileDriver();
        esperaExplicita(10, btnIngresar);
        click(btnIngresar);
    }

    public void seleccionarRegistrar() throws MalformedURLException, InterruptedException {
        setMobileDriver();
        esperaExplicita(10, btnRegistrar);
        click(btnRegistrar);
    }
}
