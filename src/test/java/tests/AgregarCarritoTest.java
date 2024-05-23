package tests;

import io.appium.java_client.AppiumDriver;
import io.appium.java_client.MobileElement;
import org.junit.jupiter.api.Test;
import views.ExitoView;
import views.HomeView;
import views.IniciarSesionView;

import java.net.MalformedURLException;

public class AgregarCarritoTest {

    private AppiumDriver<MobileElement> driver;
    public HomeView homeView;
    public IniciarSesionView iniciarSesionView;
    public ExitoView exitoView;

    @Test
    public void iniciarSesion() throws MalformedURLException, InterruptedException {
        homeView = new HomeView(driver);
        iniciarSesionView = new IniciarSesionView(driver);
        exitoView = new ExitoView(driver);
        homeView.seleccionarIngresar();
        iniciarSesionView.ingresar();
        exitoView.quitarPermisos();
        exitoView.seleccionarDespacho();
        exitoView.buscarProducto();
        exitoView.ingresarCarrito();
    }

}

