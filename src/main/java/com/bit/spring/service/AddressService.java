package com.bit.spring.service;

import com.bit.spring.model.AddressDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class AddressService {
    private final String NAMESPACE = "mapper.AddressMapper";
    private SqlSession session;

    @Autowired
    public AddressService(SqlSession session){
        this.session = session;
    }

    public void insert(AddressDTO attempt){
        session.insert(NAMESPACE + ".insert", attempt);
    }
    public void update(AddressDTO attempt){
        session.update(NAMESPACE + ".update", attempt);
    }
    public void delete(int id){
        session.delete(NAMESPACE + ".delete", id);
    }
    public AddressDTO selectOne(int id){
        return session.selectOne(NAMESPACE + ".selectOne", id);
    }
    public List<AddressDTO> selectAll(int userId){
        return session.selectList(NAMESPACE + ".selectAll", userId);
    }


}
