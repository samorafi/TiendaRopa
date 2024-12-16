package com.TiendaRopa.service.impl;

import com.TiendaRopa.dao.CotizacionDao;
import com.TiendaRopa.domain.Cotizacion;
import com.TiendaRopa.service.CotizacionService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CotizacionServiceImpl implements CotizacionService {

    @Autowired
    private CotizacionDao cotizacionDao;

    @Override
    public void saveCotizacion(Cotizacion cotizacion) {
        cotizacionDao.save(cotizacion);
    }

    @Override
    public List<Cotizacion> getCotizaciones() {
        return cotizacionDao.findAll();
    }

}
