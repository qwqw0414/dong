package com.pro.dong.stomp.controller;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

@Configuration
@EnableWebSocketMessageBroker
//public class StompConfigurer extends AbstractWebSocketMessageBrokerConfigurer{//deprecated
	public class StompConfigurer implements WebSocketMessageBrokerConfigurer {
      
      /**
      * stomp로 접속한 경우의 connectEndPoint설정: client단의 `Stomp.over(socket)`에 대응함.
      * 
      * 내부적으로 SockJS를 통해, websocket, xhr-streaming, xhr-polling 중에 가장 적합한 transport를 찾음.
      */
      @Override
      public void registerStompEndpoints(StompEndpointRegistry registry) {
          registry.addEndpoint("/stomp")
                  .withSockJS()
                  .setInterceptors(new HttpSessionHandshakeInterceptor());//이 인터셉터를 통해 HttpSession객체에 접근할 수 있다.
          
      }

      @Override
      public void configureMessageBroker(MessageBrokerRegistry registry) {
          //핸들러메소드의 @SendTo 에 대응함. 여기서 등록된 url을 subscribe하는 client에게 전송.
          registry.enableSimpleBroker("/hello");
          
          //prefix로 contextPath를 달고 @Controller의 핸들러메소드@MessageMapping 를 찾는다.
          registry.setApplicationDestinationPrefixes("/spring");//contextPath
      }
      
  }
