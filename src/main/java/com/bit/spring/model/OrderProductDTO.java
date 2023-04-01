package com.bit.spring.model;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.Date;

@Data
public class OrderProductDTO {
    private int id;
    private String state;
    private int productId;
    private int buyerId;
    private int count;
    private int finalPrice;
    private LocalDateTime deliveryDate;
    private LocalDateTime entryDate;
    private String buyerAddress;
    private String productTitle;
    private String img;
}
