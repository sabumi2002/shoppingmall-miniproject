package com.bit.spring.model;

import lombok.Data;

@Data
public class DeliveryDTO {
    private int id;
    private String name;
    private int price;
    private int period;
}
