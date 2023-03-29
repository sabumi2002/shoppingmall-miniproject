package com.bit.spring.model;

import lombok.Data;

import java.util.Date;

@Data
public class OderProductDTO {
    private int id;
    private String state;
    private int productId;
    private int buyerId;
    private int count;
    private int finalPrice;
    private String deliveryDate;
    private Date entryDate;
}
