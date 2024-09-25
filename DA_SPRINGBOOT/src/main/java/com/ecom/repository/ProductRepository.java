package com.ecom.repository;

import com.ecom.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Integer> {
    List<Product> findByIsActiveTrue();
    List<Product> findByCategory(String category);
    @Query(value = "SELECT * FROM product s WHERE s.title LIKE %:keyword% OR s.category LIKE %:keyword%",
            nativeQuery = true)
    List<Product> findByKeyword(@Param("keyword") String keyword);
}
