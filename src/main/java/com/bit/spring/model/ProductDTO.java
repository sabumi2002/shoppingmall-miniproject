package com.bit.spring.model;

import lombok.Data;

@Data
public class ProductDTO {
    private int id;
    private String title;
    private String brand;
    private int price;
    private int categoryId;
    private int deliveryId;
    private int sellerId;
    private String content;
    private String img;
    private int remaining;
}
