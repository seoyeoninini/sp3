package com.sp.app.msg;

import java.io.IOException;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;

import javax.websocket.CloseReason;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/*
    - @ServerEndpoint
      (1) @ServerEndpoint가 처리된 클래스는 서버측 WebSocket 엔드포인트에 등록되며 해당 엔드포인트의
            WebSocket이 서버에 연결될 때마다 JWA 구현에 의해 해당 인스턴스가 생성되고 관리된다.
      (2) @ServerEndpoint가 처리된 클래스는 스프링 애노테이션을 사용할 수 없다.
            - 웹소켓이 연결될때마다 객체가 생성되기 때문에 @Autowired가 설정된 멤버가 정상적으로 초기화되지 않는다.
            - 해결책
               Config클래스를 정의하여 ServerEndpoint의 컨텍스트에 BeanFactory 또는 ApplicationContext를 연결해주면 된다.
 */

// 웹 소켓 path parameters - {  } : pathValue

@ServerEndpoint("/ws/{room-name}")
public class MessageHandler {
	private static final Logger logger = LoggerFactory.getLogger(MessageHandler.class);
	
	// static 이어야 함. 클라이언트가 접속 할 때 마다 MessageHandler 객체가 생성되고 관리된다.
	private static Map<String, User> sessionMap = new Hashtable<>();
	
	
	// 클라이언트가 접속시
	@OnOpen
    public void open(Session session, EndpointConfig conf, @PathParam("room-name") String roomName) {
		logger.info("client connect ...");
    }
	
	// Text 메시지를 받는 경우 
	@OnMessage
    public void onMessage(Session session, String message, @PathParam("room-name") String roomName) {
		JSONObject jsonReceive = null;
		
		try {
			jsonReceive = new JSONObject(message);
		} catch (Exception e) {
			// logger.error(e.toString()); // 일정시간 메시지 송수신이 없으면 계속 에러 메시지가 출력
			return;
		}
		
		String type = jsonReceive.getString("type");
		if (type == null || type.equals("")) {
			return;
		}
		
		if (type.equals("connect")) { // 처음 접속한 경우
			// 접속한 사용자의 아이디를 키로 session과 유저 정보를 저장 ----------------
			String uid = jsonReceive.getString("uid");
			String nickName = jsonReceive.getString("nickName");

			User user = new User();
			user.setRoomName(roomName);
			user.setUid(uid);
			user.setNickName(nickName);
			user.setSession(session);

			sessionMap.put(uid, user);

			// 현재 접속된 룸 유저 목록 전송 ----------------
			Iterator<String> it = sessionMap.keySet().iterator();
			
			JSONArray arrUsers = new JSONArray();
			while (it.hasNext()) {
				String key = it.next();

				if ( uid.equals(key) ) { // 자기 자신
					continue;
				}
				User vo = sessionMap.get(key);
				if( ! roomName.equals(vo.getRoomName()) ) {
					continue;
				}

				JSONArray arr = new JSONArray();
				arr.put(vo.getUid());
				arr.put(vo.getNickName());
				arrUsers.put(arr);
			}
			
			JSONObject jsonUsers = new JSONObject();
			jsonUsers.put("type", "userList");
			jsonUsers.put("users", arrUsers);

			sendTextMessageToOne(jsonUsers.toString(), session);

			// 다른 클라이언트에게 접속 사실을 알림 ----------------
			JSONObject job = new JSONObject();
			job.put("type", "userConnect");
			job.put("uid", uid);
			job.put("nickName", nickName);

			sendTextMessageToAll(job.toString(), roomName, uid);
		} else if (type.equals("message")) { // 채팅 문자열을 전송 한 경우
			User vo = getUser(session);
			String msg = jsonReceive.getString("chatMsg");

			JSONObject job = new JSONObject();
			job.put("type", "message");
			job.put("chatMsg", msg);
			job.put("uid", vo.getUid());
			job.put("nickName", vo.getNickName());

			// 다른 사용자에게 전송하기
			sendTextMessageToAll(job.toString(), roomName, vo.getUid());
		}
		
	}
	
	@OnClose
    public void close(Session session, CloseReason reason, @PathParam("room-name") String roomName) {
		removeUser(roomName, session);
		
		logger.info("client disConnect : "+ reason.getReasonPhrase());
    }

    @OnError
    public void error(Session session, Throwable t, @PathParam("room-name") String roomName) {
    	t.printStackTrace();
    }
    
	// 모든 사용자 또는 룸 사용자에게 텍스트 전송
    /**
     * @param message	전송할 메시지
     * @param room		전송할 룸 이름. null 이면 전체
     * @param exclude	제외할 사람. null 이면 전체
     */
	protected void sendTextMessageToAll(String message, String roomName, String exclude) {
		Iterator<String> it = sessionMap.keySet().iterator();
		while (it.hasNext()) {
			String key = it.next();
			if ( exclude != null && exclude.equals(key) )  { // 자기 자신
				continue;
			}

			User user = sessionMap.get(key);
			if( roomName != null && ! roomName.equals(user.getRoomName()) ) {
				continue;
			}
			
			Session session = user.getSession();

			try {
				if (session.isOpen()) {
					session.getBasicRemote().sendText(message);
				}
			} catch (IOException e) {
				
			}
		}
	}
    
	// 특정 사용자에게 텍스트 전송
	protected void sendTextMessageToOne(String message, Session session) {
		if (session.isOpen()) {
			try {
				session.getBasicRemote().sendText(message);
			} catch (Exception e) {
				logger.error("fail to send message!", e);
			}
		}
	}
	
	protected User getUser(Session session) {
		Iterator<String> it = sessionMap.keySet().iterator();

		while (it.hasNext()) {
			String key = it.next();

			User dto = sessionMap.get(key);
			if (dto.getSession() == session) {
				return dto;
			}
		}

		return null;
	}

	protected String removeUser(String roomName, Session session) {
		User user = getUser(session);

		if (user == null) {
			return null;
		}

		JSONObject job = new JSONObject();
		job.put("type", "userDisconnect");
		job.put("uid", user.getUid());
		job.put("nickName", user.getNickName());
		
		sendTextMessageToAll(job.toString(), roomName, user.getUid());

		try {
			user.getSession().close();
		} catch (Exception e) {
		}
		sessionMap.remove(user.getUid());

		return user.getUid();
	}
	
}
