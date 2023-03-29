package com.bit.spring.model;

import lombok.Data;

@Data
public class PremiumDTO {
    private int id;
    private String grade;
    private int discount;
    private int coupon;
}
