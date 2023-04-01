package com.bit.spring.service;

import com.bit.spring.model.OrderProductDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CartService {
    private final String NAMESPACE = "mapper.CartMapper";
    private SqlSession session;

    @Autowired
    public CartService(SqlSession session) {
        this.session = session;
    }

    public void insert(OrderProductDTO attempt) {
        session.insert(NAMESPACE + ".insert", attempt);
    }

    public void update(OrderProductDTO attempt) {
        session.update(NAMESPACE + ".update", attempt);
//        session.commit();
    }

    public void delete(int id) {
        session.delete(NAMESPACE + ".delete", id);
    }

    public OrderProductDTO selectOne(int id) {
        return session.selectOne(NAMESPACE + ".selectOne", id);
    }

    public List<OrderProductDTO> selectAll(int userId) {
        return session.selectList(NAMESPACE + ".selectAll", userId);
    }

    public List<OrderProductDTO> selectPayAll(int userId) {
        return session.selectList(NAMESPACE + ".selectPayAll", userId);
    }

    public List<OrderProductDTO> selectAllByLogin(int loginId) {
        return session.selectList(NAMESPACE + ".selectAllByLogin", loginId);
    }

    public boolean selectDup(OrderProductDTO item) {
        OrderProductDTO result = session.selectOne(NAMESPACE + ".selectDup", item);
        if (result == null) {
            return false;
        } else {
            return true;
        }
    }

    public int insertMulti(List<OrderProductDTO> list) {
        int count = 0;
        Map<String, Object> map = new HashMap<>();
        map.put("list", list);

        // 실행 결과 row 갯수를 리턴
        count += session.insert(".insertMulti", map);
        return count;
    }

    public int updateMulti(List<OrderProductDTO> cartList) {
        for (OrderProductDTO o : cartList) {
            System.out.println(o);
        }
        return session.update(".updateMulti", cartList);
    }


}
