package steps;

import net.serenitybdd.annotations.Step;
import org.fluentlenium.core.annotation.Page;
import org.openqa.selenium.interactions.Actions;
import pages.CarritoPage;
import pages.DespensaPage;
import pages.ExitoPage;
import util.Datos;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

import static java.time.temporal.ChronoUnit.SECONDS;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;

public class ExitoSteps {
    @Page
    private ExitoPage exitoPage;
    private DespensaPage despensaPage;
    private CarritoPage carritoPage;
    //GUARDAR DATOS DE LISTA
    Datos datosLista1;
    Datos datosLista2;
    Datos datosLista3;
    Datos datosLista4;
    Datos datosLista5;
    //GUARDAR DATOS DE CARRITO
    Datos datosCar1;
    Datos datosCar2;
    Datos datosCar3;
    Datos datosCar4;
    Datos datosCar5;

    List<String> tempTitulos = new ArrayList<>();
    List<String> tempPrecios = new ArrayList<>();
    List<String> tempUnidades = new ArrayList<>();

    //Guardar precio carrito
    List<String> carritoTitulos = new ArrayList<>();
    List<String> carritoPrecios = new ArrayList<>();
    List<String> carritoUnidades = new ArrayList<>();

    List<Integer> preciosAntesCarrito = new ArrayList<>();
    List<Integer> unidadesAntesCarrito = new ArrayList<>();
    List<Integer> totalAntesCarrito = new ArrayList<>();

    @Step("Usuario ingresa a la web Exito")
    public void abrirPagina() throws InterruptedException {
        exitoPage.open();
        exitoPage.setImplicitTimeout(10, SECONDS);
        despensaPage.setImplicitTimeout(60, SECONDS);
        carritoPage.setImplicitTimeout(60, SECONDS);
    }

    public void abrirMenu() throws InterruptedException {
        exitoPage.btnMenu.click();
    }

    @Step("Usuario selecciona categoria Tec")
    public void seleccionarCategoriaTecnologia() {
        exitoPage.btnCategoriaTec.click();
    }

    @Step("Usuario selecciona subcategoria Despensa")
    public void seleccionarSubCategoriaDespensa() {
        exitoPage.btnSubCategoriaImp.click();
        despensaPage.labelImpresion.waitUntilPresent();
        despensaPage.botonAgregar.waitUntilPresent();
    }

    @Step("Usuario selecciona 5 productos en despensa")
    public void seleccionProductosDespensa() throws InterruptedException {
        Random rand = new Random();
        //Thread.sleep(5000);
        despensaPage.botonAgregar.waitUntilVisible();
        int randomNumber1 = rand.nextInt(2);
        int randomNumber2 = rand.nextInt(2) + 2;
        int randomNumber3 = rand.nextInt(2) + 4;
        int randomNumber4 = rand.nextInt(2) + 6;
        int randomNumber5 = rand.nextInt(2) + 8;

        new Actions(despensaPage.getDriver()).moveToElement(despensaPage.botonesAgregar.get(randomNumber1)).click().pause(7000).build().perform();
        new Actions(despensaPage.getDriver()).moveToElement(despensaPage.botonesAgregar.get(randomNumber2)).click().pause(7000).build().perform();
        new Actions(despensaPage.getDriver()).moveToElement(despensaPage.botonesAgregar.get(randomNumber3)).click().pause(7000).build().perform();
        new Actions(despensaPage.getDriver()).moveToElement(despensaPage.botonesAgregar.get(randomNumber4)).click().pause(7000).build().perform();
        new Actions(despensaPage.getDriver()).moveToElement(despensaPage.botonesAgregar.get(randomNumber5)).click().pause(7000).build().perform();

        for (short i = 0; i < 5; i++) {
            tempTitulos.add(despensaPage.titulos.get(i).getText());
            tempPrecios.add(despensaPage.precios.get(i).getText());
            System.out.println("titulo: " + tempTitulos.get(i));
            System.out.println("precio: " + tempPrecios.get(i));
        }
    }

    public void agregarProductosDespensa() throws InterruptedException {
        Random rand = new Random();
        despensaPage.botonSumar.waitUntilClickable();
        for (short i = 0; i < despensaPage.botonesSumar.size(); i++) {
            int cantidadProducto = rand.nextInt(9) + 1;
            for (short j = 0; j < cantidadProducto; j++) {
                new Actions(despensaPage.getDriver()).moveToElement(despensaPage.botonesSumar.get(i)).click().pause(700).build().perform();
            }
        }
        Thread.sleep(5000);
        for (short i = 0; i < 5; i++) {
            tempUnidades.add(despensaPage.unidades.get(i).getText());
        }
        System.out.println("unidad: " + tempUnidades.get(0));
        System.out.println("unidad: " + tempUnidades.get(1));
        System.out.println("unidad: " + tempUnidades.get(2));
        System.out.println("unidad: " + tempUnidades.get(3));
        System.out.println("unidad: " + tempUnidades.get(4));
    }

    public void calcularDatos() {
//        List<Integer> preciosAntesCarrito = new ArrayList<>();
//        List<Integer> unidadesAntesCarrito = new ArrayList<>();
//        List<Integer> totalAntesCarrito = new ArrayList<>();
        for (short i = 0; i < 5; i++) {
            String precioString = tempPrecios.get(i);
            String precioLimpio = precioString.replaceAll("[^\\d]", "");
            int precioDouble = Integer.parseInt(precioLimpio);
            preciosAntesCarrito.add(precioDouble);
        }
        for (short i = 0; i < 5; i++) {
            String cantidadString = tempUnidades.get(i);
            String cantidadLimpia = cantidadString.replaceAll("[^\\d]", "");
            int cantidadEntera = Integer.parseInt(cantidadLimpia);
            unidadesAntesCarrito.add(cantidadEntera);
        }
        for (short i = 0; i < 5; i++) {
            totalAntesCarrito.add(preciosAntesCarrito.get(i) * unidadesAntesCarrito.get(i));
        }
        System.out.println(totalAntesCarrito.get(0));
        System.out.println(totalAntesCarrito.get(1));
        System.out.println(totalAntesCarrito.get(2));
        System.out.println(totalAntesCarrito.get(3));
        System.out.println(totalAntesCarrito.get(4));
    }

    public void visualizarCarrito() throws InterruptedException {
        despensaPage.carrito.waitUntilVisible().waitUntilClickable().click();
        //Thread.sleep(3000);
        carritoPage.unidad.waitUntilPresent();
    }

    public void calcularDatosCarrito() throws InterruptedException {
        //Thread.sleep(3000);
        carritoPage.titulos.get(0).waitUntilVisible();
        for (short i = 0; i < 5; i++) {
            carritoTitulos.add(carritoPage.titulos.get(i).getText());
            carritoPrecios.add(carritoPage.precios.get(i).getText());
            carritoUnidades.add(carritoPage.unidades.get(i).getText());
        }
        for (short i = 0; i < 5; i++) {
            System.out.println(carritoTitulos.get(i));
            System.out.println(carritoPrecios.get(i));
            System.out.println(carritoUnidades.get(i));
        }
    }

    public void convertirObjeto() {
        datosLista1 = new Datos(tempTitulos.get(0), unidadesAntesCarrito.get(0), preciosAntesCarrito.get(0));
        datosLista2 = new Datos(tempTitulos.get(1), unidadesAntesCarrito.get(1), preciosAntesCarrito.get(1));
        datosLista3 = new Datos(tempTitulos.get(2), unidadesAntesCarrito.get(2), preciosAntesCarrito.get(2));
        datosLista4 = new Datos(tempTitulos.get(3), unidadesAntesCarrito.get(3), preciosAntesCarrito.get(3));
        datosLista5 = new Datos(tempTitulos.get(4), unidadesAntesCarrito.get(4), preciosAntesCarrito.get(4));
    }

    public boolean listasIguales(List<String> lista1, List<String> lista2) {
        // Ordena ambas listas
        Collections.sort(lista1);
        Collections.sort(lista2);
        // Compara si las listas ordenadas son iguales
        return lista1.equals(lista2);
    }

    public void validaciones() {
        //COMPARAR QUE El NOMBRE DE LOS PRODUCTOS AGREGADOS ES IGUAL AL DEL CARRITO
        boolean sonIguales = listasIguales(tempTitulos, carritoTitulos);
        assertThat(sonIguales, is(true));

        // COMPARAR EL TOTAL DE LOS PRECIOS DE LOS PRODUTOS AGREGADOS DEBE SER IGUAL EN EL CARRITO
        int cantidadLista = totalAntesCarrito.get(0) + totalAntesCarrito.get(1) + totalAntesCarrito.get(2) + totalAntesCarrito.get(3) + totalAntesCarrito.get(4);
        int cantidadCarrito = 0;
        for (short i = 0; i < 5; i++) {
            String cantidadString = carritoPrecios.get(i);
            String cantidadLimpia = cantidadString.replaceAll("[^\\d]", "");
            int cantidadEntera = Integer.parseInt(cantidadLimpia);
            cantidadCarrito += cantidadEntera;
        }
        assertThat(cantidadLista, is(cantidadCarrito));

        // COMPARAR CANTIDAD DE PRODUCTOS AGREGADOS SEA IGUAL AL DEL CARRITO
//        if (tempTitulos.size() == carritoTitulos.size()) {
//            System.out.println("Son iguales en punto 3");
//            System.out.println("Lista: " + tempTitulos.size());
//            System.out.println("Carrito: " + carritoTitulos.size());
//        }
        assertThat(tempTitulos.size(), is(carritoTitulos.size()));

        // El número de productos agregados debe ser igual que en el carrito
        convertirObjeto();
        int count = 0;
        for (short i = 0; i < 5; i++) {
            if (datosLista1.getTitulo().equals(carritoTitulos.get(i))) {
                System.out.println("Encontro igualdad de tit 1");
                count++;
            }
            if (datosLista2.getTitulo().equals(carritoTitulos.get(i))) {
                System.out.println("Encontro igualdad de tit 2");
                count++;
            }
            if (datosLista3.getTitulo().equals(carritoTitulos.get(i))) {
                System.out.println("Encontro igualdad de tit 3");
                count++;
            }
            if (datosLista4.getTitulo().equals(carritoTitulos.get(i))) {
                System.out.println("Encontro igualdad de tit 4");
                count++;
            }
            if (datosLista5.getTitulo().equals(carritoTitulos.get(i))) {
                System.out.println("Encontro igualdad de tit 5");
                count++;
            }
        }
        assertThat(5, is(count));

    }
}
