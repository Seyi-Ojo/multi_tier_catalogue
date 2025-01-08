package com.multi_tier_catalogue.web_ui.controller;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import com.multi_tier_catalogue.web_ui.model.Book;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.client.RestClientException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.slf4j.Logger;

import java.util.Arrays;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/")
public class BookController {

    @Value("${backend.api.url}")
    private String BASE_URL;

    @Autowired
    private RestTemplate restTemplate;

    private static final Logger logger = LoggerFactory.getLogger(BookController.class);

    @GetMapping
    public String home() {
        return "redirect:/books";
    }

    @GetMapping("/books")
    public String listBooks(Model model) {
        try {
            ResponseEntity<Book[]> response = restTemplate.getForEntity(BASE_URL, Book[].class);
            model.addAttribute("books", response.getBody());
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
        }
        return "books";
    }

    @GetMapping("/books/add")
    public String addBookForm() {
        return "addBook";
    }

    @GetMapping("/books/edit/{isbn}")
    public String editBookForm(@PathVariable String isbn, Model model) {
        try {
            ResponseEntity<Book> response = restTemplate.getForEntity(
                    BASE_URL + "/" + isbn,
                    Book.class);
            model.addAttribute("book", response.getBody());
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "redirect:/books";
        }
        return "editBook";
    }

    @PostMapping("/books/delete/{isbn}")
    public String deleteBook(@PathVariable("isbn") String isbn, RedirectAttributes redirectAttributes) {
        try {
            logger.info("Attempting to delete book with ISBN: {}", isbn);
            restTemplate.delete(BASE_URL + "/" + isbn);
            redirectAttributes.addFlashAttribute("message", "Book deleted successfully!");
        } catch (Exception e) {
            logger.error("Error deleting book: ", e);
            redirectAttributes.addFlashAttribute("error", "Failed to delete book: " + e.getMessage());
        }
        return "redirect:/books";
    }

    @PostMapping("/books/add")
    public String addBook(@ModelAttribute Book book, RedirectAttributes redirectAttributes) {
        try {
            logger.info("Attempting to add book: {}", book);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            HttpEntity<Book> request = new HttpEntity<>(book, headers);

            logger.info("Sending request to {}: {}", BASE_URL, request);

            ResponseEntity<Book> response = restTemplate.postForEntity(
                    BASE_URL,
                    request,
                    Book.class);

            logger.info("Response received: {}", response);

            if (response.getStatusCode().is2xxSuccessful()) {
                redirectAttributes.addFlashAttribute("message", "Book added successfully!");
                return "redirect:/books";
            }

            throw new Exception("Server returned: " + response.getStatusCode());
        } catch (Exception e) {
            logger.error("Error adding book: ", e);
            redirectAttributes.addFlashAttribute("error", "Failed to add book: " + e.getMessage());
            return "redirect:/books/add";
        }
    }
}