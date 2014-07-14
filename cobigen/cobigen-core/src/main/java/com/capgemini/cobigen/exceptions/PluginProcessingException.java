/*
 * Copyright © Capgemini 2013. All rights reserved.
 */
package com.capgemini.cobigen.exceptions;

/**
 * 
 * @author mbrunnli (10.04.2014)
 */
public class PluginProcessingException extends RuntimeException {

    /**
     * Generated Serial Version UID
     */
    private static final long serialVersionUID = -4177043804842002035L;

    /**
     * Creates a new {@link PluginProcessingException} with the given message
     * @param msg
     *            error message
     * @author mbrunnli (10.04.2014)
     */
    public PluginProcessingException(String msg) {
        super(msg);
    }

}