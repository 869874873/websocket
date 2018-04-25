package com.websocket.controller;  
  
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.TextMessage;

import com.websocket.handler.WebSocketHandler;  
  
/** 
 * 测试类 
 */  
  
@Controller  
public class PageController {  
  
    @Bean//这个注解会从Spring容器拿出Bean  
    public WebSocketHandler infoHandler() {  
        return new WebSocketHandler();  
    }  
  
    @RequestMapping("/login")  
    public void login(HttpServletRequest request, HttpServletResponse response) throws Exception {  
        String username = request.getParameter("username"); 
        if(username.equals(new String(username.getBytes("ISO-8859-1"),"ISO-8859-1")))
        	username = new String(username.getBytes("ISO-8859-1"),"UTF-8");
        System.out.println(username + "登录");  
        HttpSession session = request.getSession();  
        session.setAttribute("SESSION_USERNAME", username);  
        response.sendRedirect("websocket.jsp");  
    }  
  
    @RequestMapping("/send")  
    @ResponseBody  
    public String send(HttpServletRequest request) {  
        String username = request.getParameter("username");  
        infoHandler().sendMessageToUser(username, new TextMessage("你好，欢迎测试！！！！"));  
        return null;  
    }  
}
