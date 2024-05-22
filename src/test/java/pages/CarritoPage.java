package pages;

import net.serenitybdd.core.annotations.findby.FindBy;
import net.serenitybdd.core.pages.WebElementFacade;
import net.thucydides.core.pages.PageObject;

import java.util.List;

public class CarritoPage extends PageObject {

    @FindBy(xpath = "//div[@data-atom-container]//parent::div//parent::div//div[4]//span[@data-molecule-product-detail-name-span]")
    public List<WebElementFacade> titulos;

    @FindBy(xpath = "//div[@data-atom-container]//parent::div//parent::div//div[5]//div[@data-molecule-product-detail-price-best-price]")
    public List<WebElementFacade> precios;

    @FindBy(xpath = "//span[@data-molecule-quantity-und-value]")
    public List<WebElementFacade> unidades;

    @FindBy(xpath = "//span[@data-molecule-quantity-und-value]")
    public WebElementFacade unidad;

}
