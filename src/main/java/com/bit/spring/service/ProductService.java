package com.bit.spring.service;

import com.bit.spring.model.AddressDTO;
import com.bit.spring.model.ProductDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {
    private final String NAMESPACE = "mapper.ProductMapper";
    private SqlSession session;

    @Autowired
    public ProductService(SqlSession session){
        this.session = session;
    }

    public void insert(ProductDTO attempt){
        session.insert(NAMESPACE + ".insert", attempt);
    }
    public void update(ProductDTO attempt){
        session.update(NAMESPACE + ".update", attempt);
    }
    public void delete(int id){
        session.delete(NAMESPACE + ".delete", id);
    }
    public ProductDTO selectOne(int id){
        return session.selectOne(NAMESPACE + ".selectOne", id);
    }
    public List<ProductDTO> selectAll(){
        return session.selectList(NAMESPACE + ".selectAll");
    }
    public List<ProductDTO> selectAllByCategory(int categoryId){
        return session.selectList(NAMESPACE + ".selectAllByCategory", categoryId);
    }


}
