Feature: Anadir productos al carrito de compras y validar las condiciones

  # El nombre de los productos agregados deberá ser igual que en el carrito
  # El total de los precios de los productos agregados deberá ser igual que en el carrito
  # Las cantidades de los productos agregados deberá ser igual que en el carrito
  # El número de productos agregados debe ser igual que en el carrito

  Background:

  @AgregarCarrito
  Scenario: Agregar producto al carrito
    Given ingreso a la pagina exito
    When selecciono la categoria Tecnologia
    And selecciono la subcategoria Impresion
    And selecciona productos Despensa
    Then se muestran en el carrito