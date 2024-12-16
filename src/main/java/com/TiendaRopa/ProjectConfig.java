package com.TiendaRopa;

import java.util.Locale;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

@Configuration
public class ProjectConfig implements WebMvcConfigurer {

    /* Los siguientes métodos son para incorporar el tema de internacionalización en el proyecto */

 /* localeResolver se utiliza para crear una sesión de cambio de idioma*/
    @Bean
    public LocaleResolver localeResolver() {
        var slr = new SessionLocaleResolver();
        slr.setDefaultLocale(Locale.getDefault());
        slr.setLocaleAttributeName("session.current.locale");
        slr.setTimeZoneAttributeName("session.current.timezone");
        return slr;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    /* localeChangeInterceptor se utiliza para crear un interceptor de cambio de idioma*/
    @Bean
    public LocaleChangeInterceptor localeChangeInterceptor() {
        var lci = new LocaleChangeInterceptor();
        lci.setParamName("lang");
        return lci;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registro) {
        registro.addInterceptor(localeChangeInterceptor());
    }

    //Bean para poder acceder a los Messages.properties en código...
    @Bean("messageSource")
    public MessageSource messageSource() {
        ResourceBundleMessageSource messageSource = new ResourceBundleMessageSource();
        messageSource.setBasenames("messages");
        messageSource.setDefaultEncoding("UTF-8");
        return messageSource;
    }

    /* Los siguiente métodos son para implementar el tema de seguridad dentro del proyecto */
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("index");
        registry.addViewController("/index").setViewName("index");
        registry.addViewController("/login").setViewName("login");
        registry.addViewController("/registro/nuevo").setViewName("/registro/nuevo");
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests((request) -> request
                // Rutas públicas
                .requestMatchers(
                        "/",
                        "/index",
                        "/errores/**",
                        "/contacto/cotizacion/guardar",
                        "/contacto/listado",
                        "/js/**",
                        "/nosotros/resenas/guardar",
                        "/pruebas/**",
                        "/producto/buscar",
                        "/reportes/**",
                        "/registro/**",
                        "/webjars/**",
                        "/categoria/listado",
                        "/nosotros/listado",
                        "/faq/listado",
                        "/producto/listado",
                        "/cotizacion/**"
                ).permitAll()
                // Rutas restringidas a ADMIN
                .requestMatchers(
                        "/categoria/nuevo",
                        "/categoria/guardar", 
                        "/categoria/modificar/**",
                        "/categoria/eliminar/**",
                        "/carrito/**",
                        "/cotizacion/**",
                        "/contacto/cotizaciones",
                        "/factura/listado",
                        "/producto/buscar?query=/**",
                        "/producto/eliminar/**",
                        "/producto/guardar",
                        "/producto/modificar/**",
                        "/producto/nuevo",
                        "/reportes/**",
                        "/usuario/eliminar/**",
                        "/usuario/guardar",
                        "/usuario/modificar/**",
                        "/usuario/nuevo"
                ).hasRole("ADMIN")
                // Rutas restringidas a ADMIN y VENDEDOR
                .requestMatchers(
                        "/categoria/listado",
                        "/categoria/guardar",
                        "/nosotros/listado",
                        "/contacto/listado",
                        "/faq/listado",
                        "/producto/listado",
                        "/usuario/listado"
                ).hasAnyRole("ADMIN", "VENDEDOR")
                // Rutas restringidas a USER
                .requestMatchers(
                        "/facturar/carrito",
                        "/nosotros/listado",
                        "/contacto/listado",
                        "/faq/listado",
                        "/categoria/listado",
                        "/producto/listado"
                ).hasRole("USER")
                )
                // Configuración de inicio de sesión
                .formLogin((form) -> form
                .loginPage("/login").permitAll()
                .defaultSuccessUrl("/index", true)
                )
                // Configuración de cierre de sesión
                .logout((logout) -> logout.permitAll());

        return http.build();
    }

    @Autowired
    private UserDetailsService userDetailsService; //aqui se obtiene la info del usuario como por ejemplo el nombre, la contraseña y los roles

    @Autowired
    public void configurerGlobal(AuthenticationManagerBuilder build) throws Exception {
        build.userDetailsService(userDetailsService).passwordEncoder(new BCryptPasswordEncoder());
    }

}
