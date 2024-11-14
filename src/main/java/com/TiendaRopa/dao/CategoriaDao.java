
package com.TiendaRopa.dao;

import com.TiendaRopa.domain.Categoria;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoriaDao extends JpaRepository <Categoria,Long>{
    
}
