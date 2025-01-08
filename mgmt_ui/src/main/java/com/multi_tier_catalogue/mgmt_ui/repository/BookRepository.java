package com.multi_tier_catalogue.mgmt_ui.repository;

import com.multi_tier_catalogue.mgmt_ui.model.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookRepository extends JpaRepository<Book, String> {
}
