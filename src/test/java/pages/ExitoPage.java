package pages;

import net.serenitybdd.annotations.DefaultUrl;
import net.serenitybdd.core.annotations.findby.FindBy;
import net.serenitybdd.core.pages.WebElementFacade;
import net.thucydides.core.pages.PageObject;

@DefaultUrl("https://www.exito.com/")
public class ExitoPage extends PageObject {
    //@FindBy(xpath = "//span[contains(text(),'Menú')]")
    @FindBy(css = "button[aria-label='Collapse menu']>div")
    public WebElementFacade btnMenu;

    @FindBy(css = "section:nth-child(3)>div>li:nth-child(3)")
    public WebElementFacade btnCategoriaTec;

    @FindBy(xpath = "//b[contains(text(),'Audio')]")
    public WebElementFacade btnSubCategoriaAud;

    @FindBy(css = "a[href='/tecnologia/impresion']")
    public WebElementFacade btnSubCategoriaImp;

}
