package com.aesopsns.websocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

//主要处理流程如下：
//
//a.在afterConnectionEstablished连接建立成功之后，记录用户的连接标识，便于后面发信息，这里我是记录将id记录在Map集合中。
//
//b.在handleTextMessage中可以对H5 Websocket的send方法进行处理
//
//c.sendMessageToUser向指定用户发送消息，传入用户标识和消息体
//
//d.sendMessageToAllUsers向左右用户广播消息，只需要传入消息体
//
//e.handleTransportError连接出错处理，主要是关闭出错会话的连接，和删除在Map集合中的记录
//
//f.afterConnectionClosed连接已关闭，移除在Map集合中的记录。
//
//g.getClientId我自己封装的一个方法，方便获取用户标识

@Service
public class MyHandler extends TextWebSocketHandler {
	//在线用户列表(诶呦，还是多线程的)
    private static final Map<String, WebSocketSession> users;
    
    static {
        users = new HashMap<>();
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        System.out.println("成功建立连接");
        String name = getUserName(session);
        //System.out.println(name);
        if (name != null) {
            users.put(name, session);
//          session.sendMessage(new TextMessage("成功建立socket连接"));
        }
    }

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) {
        // ...
//        System.out.println(message.getPayload());
//
//        WebSocketMessage message1 = new TextMessage("server:"+message);
//        try {
//            session.sendMessage(message1);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
    }

    /**
     * 发送信息给指定用户
     * @param clientId
     * @param message
     * @return
     */
    public boolean sendMessageToUser(String name, TextMessage message) {
        if (users.get(name) == null) return false;
        WebSocketSession session = users.get(name);
        if (!session.isOpen()) return false;
        try {
        	System.out.println(message.toString());
            session.sendMessage(message);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    /**
     * 广播信息
     * @param message
     * @return
     */
    public boolean sendMessageToAllUsers(TextMessage message) {
//        boolean allSendSuccess = true;
//        Set<Integer> clientIds = users.keySet();
//        WebSocketSession session = null;
//        for (Integer clientId : clientIds) {
//            try {
//                session = users.get(clientId);
//                if (session.isOpen()) {
//                    session.sendMessage(message);
//                }
//            } catch (IOException e) {
//                e.printStackTrace();
//                allSendSuccess = false;
//            }
//        }
//
//        return  allSendSuccess;
    	return false;
    }

    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        if (session.isOpen()) {
            session.close();
        }
        System.out.println("连接出错");
//        users.remove(getClientId(session));
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        System.out.println("连接已关闭：" + status);
        users.remove(getUserName(session));
    }

    @Override
    public boolean supportsPartialMessages() {
        return false;
    }

    /**
     * 获取用户标识
     * @param session
     * @return
     */
    private String getUserName(WebSocketSession session) {
        try {
            String name = (String) session.getAttributes().get("WEBSOCKET_USERNAME");
            return name;
        } catch (Exception e) {
            return null;
        }
    }
}
