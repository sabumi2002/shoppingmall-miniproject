package com.bit.spring.service;

import com.bit.spring.model.AddressDTO;
import com.bit.spring.model.LikeDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class LikeService {
    private final String NAMESPACE = "mapper.LikeMapper";
    private SqlSession session;

    @Autowired
    public LikeService(SqlSession session){
        this.session = session;
    }

    public void insert(LikeDTO attempt){
        session.insert(NAMESPACE + ".insert", attempt);
    }
    public void update(LikeDTO attempt){
        session.update(NAMESPACE + ".update", attempt);
    }
    public void delete(int id){
        session.delete(NAMESPACE + ".delete", id);
    }
    public LikeDTO selectOne(int id){
        return session.selectOne(NAMESPACE + ".selectOne", id);
    }
    public List<LikeDTO> selectAll(int userId){
        return session.selectList(NAMESPACE + ".selectAll", userId);
    }


    public LikeDTO selectAuth(int userId, int productId) {
        Map<String, Object> params = new HashMap<>();
        params.put("userId", userId);
        params.put("productId", productId);


        return session.selectOne(NAMESPACE + ".selectByAuth", params);
    }
}
