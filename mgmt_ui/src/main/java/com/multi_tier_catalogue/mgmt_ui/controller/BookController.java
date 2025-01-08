package com.multi_tier_catalogue.mgmt_ui.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.multi_tier_catalogue.mgmt_ui.model.Book;
import com.multi_tier_catalogue.mgmt_ui.service.BookService;

import java.util.List;
import java.util.UUID;
import java.util.Optional;

@RestController
@RequestMapping("/api/books")
@CrossOrigin(origins = { "http://localhost:8080", "http://localhost:8082" })
public class BookController {
    private static final Logger logger = LoggerFactory.getLogger(BookController.class);

    @Autowired
    private BookService bookService;

    @GetMapping
    public ResponseEntity<List<Book>> getAllBooks() {
        return ResponseEntity.ok(bookService.getAllBooks());
    }

    @GetMapping("/{isbn}")
    public ResponseEntity<?> getBook(@PathVariable String isbn) {
        return bookService.getBook(isbn)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<?> addBook(@RequestBody Book book) {
        return ResponseEntity.ok(bookService.addBook(book));
    }

    @DeleteMapping("/{isbn}")
    public ResponseEntity<?> deleteBook(@PathVariable String isbn) {
        logger.info("Delete request received for ISBN: {}", isbn);

        try {
            if (isbn == null || isbn.trim().isEmpty()) {
                return ResponseEntity.badRequest().body("ISBN is required");
            }

            boolean deleted = bookService.deleteBook(isbn.trim());

            if (deleted) {
                logger.info("Successfully deleted book with ISBN: {}", isbn);
                return ResponseEntity.ok().build();
            } else {
                logger.warn("Book not found with ISBN: {}", isbn);
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            logger.error("Error deleting book: ", e);
            return ResponseEntity.internalServerError().body(e.getMessage());
        }
    }

    @PutMapping("/{isbn}")
    public ResponseEntity<?> updateBook(@PathVariable String isbn, @RequestBody Book book) {
        return ResponseEntity.ok(bookService.updateBook(isbn, book));
    }
}
