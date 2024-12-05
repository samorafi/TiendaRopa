package com.TiendaRopa.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.TiendaRopa.domain.Usuario;

public interface UsuarioDao extends JpaRepository<Usuario, Long> {
    Usuario findByUsername(String username);
    
    Usuario findByUsernameAndPassword(String username, String Password);

    Usuario findByUsernameOrCorreo(String username, String correo);

    boolean existsByUsernameOrCorreo(String username, String correo);
}
