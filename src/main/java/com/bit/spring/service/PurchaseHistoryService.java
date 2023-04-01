package com.bit.spring.service;

import com.bit.spring.model.OrderProductDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PurchaseHistoryService {
    private final String NAMESPACE = "mapper.PurchaseHistoryMapper";
    private SqlSession session;

    @Autowired
    public PurchaseHistoryService(SqlSession session){
        this.session = session;
    }

    public void insert(OrderProductDTO attempt){
        session.insert(NAMESPACE + ".insert", attempt);
    }
    public void update(OrderProductDTO attempt){
        session.update(NAMESPACE + ".update", attempt);
    }
    public void delete(int id){
        session.delete(NAMESPACE + ".delete", id);
    }
    public OrderProductDTO selectOne(int id){
        return session.selectOne(NAMESPACE + ".selectOne", id);
    }
    public List<OrderProductDTO> selectAll(){
        return session.selectList(NAMESPACE + ".selectAll");
    }
    public List<OrderProductDTO> selectAllByLogin(int loginId){
        return session.selectList(NAMESPACE + ".selectAllByLogin", loginId);
    }
    public int insertMulti(List<OrderProductDTO> list) {
        int count = 0;
        Map<String, Object> map = new HashMap<>();
        map.put("list", list);

        // 실행 결과 row 갯수를 리턴
        count += session.insert(".insertMulti", map);
        return count;
    }


}
