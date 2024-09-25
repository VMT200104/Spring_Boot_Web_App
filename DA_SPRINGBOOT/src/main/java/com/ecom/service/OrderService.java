package com.ecom.service;

import com.ecom.model.OrderRequest;
import com.ecom.model.ProductOrder;

import java.util.List;
import java.util.Optional;

public interface OrderService {
    public void saveOrder(Integer userid,OrderRequest orderRequest);
    public List<ProductOrder> getAllOrders();
    public Optional<ProductOrder> getOrderById(Integer id);
    public void saveOrder(ProductOrder order);
    public void deleteOrder(Integer id);
}
