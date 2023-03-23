package com.bit.spring.model;

import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Data
public class UserCustomDetails implements UserDetails {
    private UserDTO userDTO;
    public UserCustomDetails(UserDTO userDTO){
        this.userDTO = userDTO;
    }

    // 계정의 권한 목록을 리턴
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> list = new ArrayList<>();
        list.add(new SimpleGrantedAuthority(userDTO.getRole()));

        return list;
    }

    // 계정의 비밀번호를 리턴
    @Override
    public String getPassword() {
        return userDTO.getPassword();
    }

    // 계정의 고유한 값을 리턴
    //( ex : DB PK값, 중복이 없는 이메일 값 )
    @Override
    public String getUsername() {
        return userDTO.getUsername();
    }


    // 계정의 만료 여부 리턴	true ( 만료 안됨 )
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    // 계정의 잠김 여부 리턴	true ( 잠기지 않음 )
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    // 비밀번호 만료 여부 리턴	true ( 만료 안됨 )
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    // 계정의 활성화 여부 리턴	true ( 활성화 됨 )
    @Override
    public boolean isEnabled() {
        return true;
    }
}