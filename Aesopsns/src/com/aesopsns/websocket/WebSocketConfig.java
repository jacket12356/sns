package com.aesopsns.websocket;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;


@Configuration
@EnableWebMvc
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		// TODO Auto-generated method stub
		//registry.addHandler(myHandler(), "/myHandler").addInterceptors(new WebSocketInterceptor());
		//需要用拦截器获取到httpsession中的信息
		registry.addHandler(myHandler(), "/myHandler").setAllowedOrigins("*").addInterceptors(new WebSocketInterceptor());
	}
	@Bean
    public WebSocketHandler myHandler() {
        return new MyHandler();
    }
}
