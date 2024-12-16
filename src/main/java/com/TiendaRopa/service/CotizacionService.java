package com.TiendaRopa.service;

import com.TiendaRopa.domain.Cotizacion;
import java.util.List;

public interface CotizacionService {
    void saveCotizacion(Cotizacion cotizacion);
    
    List<Cotizacion> getCotizaciones();

}
