package views;

import base.Base;
import io.appium.java_client.AppiumDriver;
import io.appium.java_client.MobileElement;
import org.openqa.selenium.By;

public class RegistroView extends Base {

    public RegistroView(AppiumDriver<MobileElement> driver) {
        super(driver);
    }

    By txtNombres = By.xpath("//android.widget.EditText[@text=\"Nombres\"]");
    By txtApellidos = By.xpath("//android.widget.EditText[@text=\"Apellidos\"]");
    By txtDocumento = By.xpath("//android.widget.LinearLayout[@resource-id=\"com.exito.appcompania:id/CustomEditText_numero_doc\"]/android.widget.FrameLayout//android.widget.EditText");
    By selAnioRegistro = By.id("com.exito.appcompania:id/filled_exposed_dropdown_anio_registro");
    By selMesRegistro = By.id("com.exito.appcompania:id/filled_exposed_dropdown_mes_registro");
    By selDiaRegistro = By.id("com.exito.appcompania:id/filled_exposed_dropdown_dia_registro");
    By txtTelefono = By.id("com.exito.appcompania:id/TextInputEditText_tel");
    By txtCorreo = By.xpath("//android.widget.LinearLayout[@resource-id=\"com.exito.appcompania:id/CustomEditText_email_register\"]/android.widget.FrameLayout//android.widget.EditText");
    By cbxTerminos = By.id("com.exito.appcompania:id/AppCompatCheckBox_send_advertising");
    By btnRegistrar = By.id("com.exito.appcompania:id/AppCompatButton_registrar");

    public void registro() throws InterruptedException {
        esperaExplicita(10, txtNombres);
        type("Tester senior", txtNombres);
        type("Prueba Mobile", txtApellidos);
        type("1111111111", txtDocumento);
        type("2000", selAnioRegistro);
        type("10", selMesRegistro);
        type("10", selDiaRegistro);
        type("3333333333", txtTelefono);
        type("temporal@yopmail.com", txtCorreo);
        click(cbxTerminos);
        esperaExplicita(10, btnRegistrar);
        click(btnRegistrar);
        stop();
    }
}
