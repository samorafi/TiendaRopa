package com.TiendaRopa.controller;

import com.TiendaRopa.dao.FacturaDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class FacturaController {

    @Autowired
    private FacturaDao facturaDao;

    @GetMapping("/factura/listado")
    public String listarFacturas(Model model) {
        var listaFacturas = facturaDao.findAll();
        model.addAttribute("facturas", listaFacturas);
        return "factura/listado";
    }
}
