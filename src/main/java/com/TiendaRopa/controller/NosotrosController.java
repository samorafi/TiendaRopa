package com.TiendaRopa.controller;

import com.TiendaRopa.domain.Resena;
import com.TiendaRopa.service.ResenaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/nosotros")
public class NosotrosController {

    @Autowired
    private ResenaService resenaService;

    @GetMapping("/listado")
    public String listadoNosotros(Model model) {
        var listaResenas = resenaService.getResenas();
        model.addAttribute("resenas", listaResenas);
        model.addAttribute("resena", new Resena());
        return "nosotros/listado";
    }

    @PostMapping("/resenas/guardar")
    public String guardarResena(Resena resena) {
        resenaService.saveResena(resena);
        return "redirect:/nosotros/listado";
    }

}
