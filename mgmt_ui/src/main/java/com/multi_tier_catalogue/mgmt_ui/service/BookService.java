package com.multi_tier_catalogue.mgmt_ui.service;

import com.multi_tier_catalogue.mgmt_ui.model.Book;
import com.multi_tier_catalogue.mgmt_ui.repository.BookRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BookService {

    @Autowired
    private BookRepository bookRepository;

    private static final Logger logger = LoggerFactory.getLogger(BookService.class);

    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }

    public Book getBookByIsbn(String isbn) {
        return bookRepository.findById(isbn).orElse(null);
    }

    public Book addBook(Book book) {
        try {
            logger.info("Adding new book: {}", book);
            Book savedBook = bookRepository.save(book);
            logger.info("Successfully saved book: {}", savedBook);
            return savedBook;
        } catch (Exception e) {
            logger.error("Error saving book: ", e);
            throw new RuntimeException("Failed to save book: " + e.getMessage());
        }
    }

    public Book updateBook(String isbn, Book book) {
        if (bookRepository.existsById(isbn)) {
            book.setIsbn(isbn);
            return bookRepository.save(book);
        }
        throw new RuntimeException("Book not found with ISBN: " + isbn);
    }

    public boolean deleteBook(String isbn) {
        try {
            if (bookRepository.existsById(isbn)) {
                bookRepository.deleteById(isbn);
                logger.info("Deleted book with ISBN: {}", isbn);
                return true;
            }
            logger.warn("Book not found with ISBN: {}", isbn);
            return false;
        } catch (Exception e) {
            logger.error("Error deleting book: ", e);
            throw new RuntimeException("Failed to delete book: " + e.getMessage());
        }
    }

    public Optional<Book> getBook(String isbn) {
        return bookRepository.findById(isbn);
    }
}
