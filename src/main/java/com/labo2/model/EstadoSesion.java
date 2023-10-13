package com.labo2.model;

/**
*
* @author Igui
*/
public enum EstadoSesion {
    NO_LOGIN,           // nunca intentó iniciar sesión
    LOGIN_TURISTA,// tiene la sesión iniciada 
    LOGIN_PROVEEDOR,
    LOGIN_INCORRECTO    // le erro a la sesión al menos una vez
}
