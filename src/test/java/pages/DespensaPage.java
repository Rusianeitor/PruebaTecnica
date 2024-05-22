package pages;

import net.serenitybdd.annotations.At;
import net.serenitybdd.core.annotations.findby.FindBy;
import net.serenitybdd.core.pages.WebElementFacade;
import net.thucydides.core.pages.PageObject;

import java.util.List;

@At("https://www.exito.com/mercado/impresion")
public class DespensaPage extends PageObject {

    @FindBy(xpath = "//h1[contains(text(),'Impresoras al mejor precio')]")
    public WebElementFacade labelImpresion;

    @FindBy(css = "div[data-fs-product-card-non-grid-right='true']>div>button")
    public List<WebElementFacade> botonesAgregar;

    @FindBy(css = "div[data-fs-product-card-non-grid-right='true']>div>button")
    public WebElementFacade botonAgregar;

    @FindBy(css = "button[class='QuantitySelectorDefault_plus__1LAkq']")
    public List<WebElementFacade> botonesSumar;

    @FindBy(css = "button[class='QuantitySelectorDefault_plus__1LAkq']")
    public WebElementFacade botonSumar;

    @FindBy(css = "button[data-testid='cart-toggle']")
    public WebElementFacade carrito;

    @FindBy(xpath = "//div[@class='QuantitySelectorDefault_defaultStyles__qlGCK  ']//parent::div//parent::div//parent::section//div//div//div//h3")
    public List<WebElementFacade> titulos;

    @FindBy(xpath = "//div[@class='QuantitySelectorDefault_defaultStyles__qlGCK  ']//parent::div//parent::div//div//div//div//div//p[@data-fs-container-price-otros]")
    public List<WebElementFacade> precios;

    @FindBy(css = "div[class='QuantitySelectorDefault_custom-quantity-selector__selector__info__xqku5']>p")
    public List<WebElementFacade> unidades;


}
