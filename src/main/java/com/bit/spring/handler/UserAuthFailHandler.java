package com.bit.spring.handler;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Service    // 다른곳에서 찾을수있게도와줌
public class UserAuthFailHandler implements AuthenticationFailureHandler {

    // 로그인이 실패하면 발생하는 친구
    @Override
    public void onAuthenticationFailure(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AuthenticationException e) throws IOException, ServletException {
        e.printStackTrace();

        httpServletResponse.sendRedirect("/user/auth");
    }
}
