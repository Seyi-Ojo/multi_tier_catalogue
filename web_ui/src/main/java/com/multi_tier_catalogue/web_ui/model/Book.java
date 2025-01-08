package com.multi_tier_catalogue.web_ui.model;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Book {
    private String isbn;
    private String name;
    private String publishDate; // Keep as String for web UI
    private String bookType;
    private Double price;

    // Default constructor
    public Book() {
    }

    // Getters and setters
    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(String publishDate) {
        this.publishDate = publishDate;
    }

    public String getBookType() {
        return bookType;
    }

    public void setBookType(String bookType) {
        this.bookType = bookType;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
}
