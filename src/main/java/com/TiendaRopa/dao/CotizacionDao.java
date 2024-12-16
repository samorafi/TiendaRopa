package com.TiendaRopa.dao;

import com.TiendaRopa.domain.Cotizacion;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CotizacionDao extends JpaRepository<Cotizacion, Long> {
}
