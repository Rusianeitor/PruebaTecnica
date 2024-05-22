package stepdefinitions;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import net.serenitybdd.annotations.Steps;
import steps.ExitoSteps;

public class AnadirCarritoDefinitions {

    @Steps
    private ExitoSteps exitoSteps;

    @Given("ingreso a la pagina exito")
    public void ingresoALaPaginaExito() throws InterruptedException {
        exitoSteps.abrirPagina();
    }

    @When("selecciono la categoria Tecnologia")
    public void seleccionoLaCategoriaTecnologia() throws InterruptedException {
        exitoSteps.abrirMenu();
        exitoSteps.seleccionarCategoriaTecnologia();
    }

    @When("selecciono la subcategoria Impresion")
    public void seleccionoLaSubcategoriaImpresion() {
        exitoSteps.seleccionarSubCategoriaDespensa();
    }

    @When("selecciona productos Despensa")
    public void seleccionaProductosDespensa() throws InterruptedException {
        exitoSteps.seleccionProductosDespensa();
        exitoSteps.agregarProductosDespensa();
    }

    @Then("se muestran en el carrito")
    public void seMuestranEnElCarrito() throws InterruptedException {
        exitoSteps.calcularDatos();
        exitoSteps.visualizarCarrito();
        exitoSteps.calcularDatosCarrito();
        exitoSteps.validaciones();
    }
}
