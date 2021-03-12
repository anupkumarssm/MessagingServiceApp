package com.nitya.messaging;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class CustomSiteMeshFilter extends ConfigurableSiteMeshFilter {
    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
            builder.addDecoratorPath("/*", "/WEB-INF/sitemesh/decorator.jsp")
     .addExcludedPath("/get-messages")
     .addExcludedPath("/addMessage")
     .addExcludedPath("/getNewMessages")
     .addExcludedPath("/getUpdatedMessage");
            
            
    }
}