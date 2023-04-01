package com.bit.spring.model;

import lombok.Data;

@Data
public class LikeDTO {
    private int id;
    private int userId;
    private int productId;
}
