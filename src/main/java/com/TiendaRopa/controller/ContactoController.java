package com.TiendaRopa.controller;

import com.TiendaRopa.domain.Cotizacion;
import com.TiendaRopa.service.CotizacionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/contacto")
public class ContactoController {

    @Autowired
    private CotizacionService cotizacionService;

    @GetMapping("/listado")
    public String listadoContacto(Model model) {
        model.addAttribute("cotizacion", new Cotizacion());
        return "contacto/listado";
    }

    @PostMapping("/cotizacion/guardar")
    public String guardarCotizacion(Cotizacion cotizacion) {
        cotizacionService.saveCotizacion(cotizacion);
        return "redirect:/contacto/listado";
    }

    @GetMapping("/cotizaciones")
    public String verCotizaciones(Model model) {
        var listaCotizaciones = cotizacionService.getCotizaciones();
        model.addAttribute("cotizaciones", listaCotizaciones);
        return "contacto/cotizaciones";
    }

}
