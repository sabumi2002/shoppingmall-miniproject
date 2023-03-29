package com.bit.spring.service;

import com.bit.spring.model.CategoryDTO;
import com.bit.spring.model.DeliveryDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeliveryService {
    private final String NAMESPACE = "mapper.DeliveryMapper";
    private SqlSession session;

    @Autowired
    public DeliveryService(SqlSession session) {
        this.session = session;
    }

    public DeliveryDTO selectOne(int id){
        return session.selectOne(NAMESPACE + ".selectOne", id);
    }

    public List<DeliveryDTO> selectAll(){
        return session.selectList(NAMESPACE + ".selectAll");
    }





}