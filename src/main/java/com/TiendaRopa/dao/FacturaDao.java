
package com.TiendaRopa.dao;

import com.TiendaRopa.domain.Factura;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FacturaDao extends JpaRepository<Factura, Long>{
    
}
