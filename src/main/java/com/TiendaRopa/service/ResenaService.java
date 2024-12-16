package com.TiendaRopa.service;

import com.TiendaRopa.domain.Resena;
import java.util.List;

public interface ResenaService {

    List<Resena> getResenas();

    void saveResena(Resena resena);
}
