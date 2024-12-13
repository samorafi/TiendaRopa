package com.TiendaRopa.service;

import com.TiendaRopa.domain.Usuario;
import jakarta.mail.MessagingException;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

@Service
public interface RegistroService {

    public Model activar(Model model, String usuario, String clave);

    public Model crearUsuario(Model model, Usuario usuario) throws MessagingException;

    public void activar(Usuario usuario, MultipartFile imagenFile);

    public Model recordarUsuario(Model model, Usuario usuario) throws MessagingException;
}
