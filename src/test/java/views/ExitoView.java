package views;

import base.Base;
import io.appium.java_client.AppiumDriver;
import io.appium.java_client.MobileElement;
import org.openqa.selenium.By;

public class ExitoView extends Base {

    public ExitoView(AppiumDriver<MobileElement> driver) {
        super(driver);
    }

    By btnPermisos = By.id("com.android.permissioncontroller:id/permission_deny_button");
    By lblDireccion = By.id("com.exito.appcompania:id/linearLayout_address");
    By opcionDireccion = By.xpath("//android.view.ViewGroup[@resource-id=\"com.exito.appcompania:id/constraitLayout_user_address\"]/android.view.ViewGroup");
    By btnContinuar = By.id("com.exito.appcompania:id/appCompatButton_continue");
    By txtBusqueda = By.id("com.exito.appcompania:id/appCompatEditText_search_bar");
    By txtProducto = By.xpath("(//android.widget.FrameLayout[@resource-id=\"com.exito.appcompania:id/CardView_option\"])[1]/android.view.ViewGroup");
    By btnAgregar = By.xpath("(//android.view.ViewGroup[@resource-id=\"com.exito.appcompania:id/constraitLayout_add_item\"])[1]");
    By btnCarrito = By.id("com.exito.appcompania:id/appCompatImageView_shopping_cart");
    By txtCarrito = By.id("com.exito.appcompania:id/appCompatTextView_shopping_cart_title");

    public void quitarPermisos() {
        esperaExplicita(10, btnPermisos);
        click(btnPermisos);
    }

    public void seleccionarDespacho() {
        esperaExplicita(10, lblDireccion);
        click(lblDireccion);
        esperaExplicita(10, opcionDireccion);
        click(opcionDireccion);
        esperaExplicita(10, btnContinuar);
        click(btnContinuar);
    }

    public void buscarProducto() {
        esperaExplicita(10, txtBusqueda);
        click(txtBusqueda);
        esperaExplicita(10, txtProducto);
        click(txtProducto);
        esperaExplicita(15, btnAgregar);
        click(btnAgregar);
    }

    public void ingresarCarrito() {
        esperaExplicita(10, btnCarrito);
        click(btnCarrito);
        esperaExplicita(20, txtCarrito);
        isDisplayed(txtCarrito);
    }


}
