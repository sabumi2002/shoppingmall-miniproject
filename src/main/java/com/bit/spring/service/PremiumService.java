package com.bit.spring.service;

import com.bit.spring.model.CategoryDTO;
import com.bit.spring.model.PremiumDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PremiumService {
    private final String NAMESPACE = "mapper.PremiumMapper";
    private SqlSession session;

    @Autowired
    public PremiumService(SqlSession session) {
        this.session = session;
    }

    public PremiumDTO selectOne(int id){
        return session.selectOne(NAMESPACE + ".selectOne", id);
    }
    public PremiumDTO selectOne(String role){
        return session.selectOne(NAMESPACE + ".selectOneByRole", role);
    }
    public List<PremiumDTO> selectAll(){
        return session.selectList(NAMESPACE + ".selectAll");
    }





}