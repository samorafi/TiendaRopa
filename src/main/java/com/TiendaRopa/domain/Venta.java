
package com.TiendaRopa.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import lombok.Data;

@Data
@Entity
@Table(name="venta")
public class Venta implements Serializable{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_venta")
    private Long idVenta;
    private Long idFactura;
    private Long idProducto;    
    private double precio;
    private int cantidad;    
    
    public Venta() {
    }

    public Venta(Long idFactura, Long idProducto, double precio, int cantidad) {
        this.idFactura = idFactura;
        this.idProducto = idProducto;
        this.precio = precio;
        this.cantidad = cantidad;
    }
}
