package util;

public class Datos {

    private String titulo;
    private Integer cantidad;
    private Integer precio;

    public Datos(String titulo, Integer cantidad, Integer precio) {
        this.titulo = titulo;
        this.cantidad = cantidad;
        this.precio = precio;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public Integer getCantidad() {
        return cantidad;
    }

    public void setCantidad(Integer cantidad) {
        this.cantidad = cantidad;
    }

    public Integer getPrecio() {
        return precio;
    }

    public void setPrecio(Integer precio) {
        this.precio = precio;
    }

    public Integer calcularPrecio() {
        return this.precio * this.cantidad;
    }
}
