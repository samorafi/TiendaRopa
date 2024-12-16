package com.TiendaRopa.service.impl;

import com.TiendaRopa.dao.ResenaDao;
import com.TiendaRopa.domain.Resena;
import com.TiendaRopa.service.ResenaService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ResenaServiceImpl implements ResenaService {

    @Autowired
    private ResenaDao resenaDao;

    @Override
    public List<Resena> getResenas() {
        return resenaDao.findAll();
    }

    @Override
    public void saveResena(Resena resena) {
        resenaDao.save(resena);
    }
}
