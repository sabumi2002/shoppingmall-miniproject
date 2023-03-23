package com.bit.spring.model;

import lombok.Data;

@Data
public class AddressDTO {
    private int id;
    private int userId;
    private String zipCode;
    private String streetAddress;
    private String numberAddress;
    private String detailedAddress;
}
