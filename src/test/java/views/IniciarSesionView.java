package views;

import base.Base;
import io.appium.java_client.AppiumDriver;
import io.appium.java_client.MobileElement;
import org.openqa.selenium.By;

public class IniciarSesionView extends Base {

    public IniciarSesionView(AppiumDriver<MobileElement> driver) {
        super(driver);
    }

    By txtEmail = By.id("com.exito.appcompania:id/TextInputEditText_email");
    By txtContrasena = By.xpath("//android.widget.LinearLayout[@resource-id=\"com.exito.appcompania:id/CustomEditText_password\"]/android.widget.FrameLayout//android.widget.EditText");
    By btnIngresar = By.id("com.exito.appcompania:id/AppCompatButton_ingresar");


    public void ingresar() {
        esperaExplicita(10, txtEmail);
        type("temporal@yopmail.com", txtEmail);
        type("Backinblack1", txtContrasena);
        click(btnIngresar);
    }

}
