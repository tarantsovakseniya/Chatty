package chatty.endpoints;

import chatty.entities.Message;
import chatty.coders.MessageDecoder;
import chatty.coders.MessageEncoder;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.logging.Logger;
import javax.websocket.*;
import javax.websocket.server.*;

@ServerEndpoint(
        value="/chat/{username}",
        decoders = MessageDecoder.class,
        encoders = MessageEncoder.class
)
public class ChatEndpoint {
    private final Logger log = Logger.getLogger(getClass().getName());

    private Session session;
    private static final Set<ChatEndpoint> chatEndpoints = new CopyOnWriteArraySet<>();
    private static Map<Session,String> users = Collections.synchronizedMap(new HashMap<>());

    //
    @OnOpen
    public void onOpen(Session session, @PathParam("username") String username, EndpointConfig config) throws IOException, EncodeException {
        log.info(session.getId() + " connected!");

        this.session = session;
        chatEndpoints.add(this);
        users.put(session, username);

        Message message = new Message();
        message.setFrom(username);
        message.setContent("connected!");
        broadcast(message);
    }

    @OnMessage
    public void onMessage(Session session, Message message) throws IOException, EncodeException {
        log.info(message.toString());

        message.setFrom(users.get(session));
        sendMessageToOneUser(message);
    }

    @OnClose
    public void onClose(Session session, @PathParam("username") String username) throws IOException, EncodeException {
        log.info(session.getId() + " disconnected!");
        chatEndpoints.remove(this);

        Message message = new Message();
        message.setFrom(username);
        message.setContent("disconnected!");

        users.remove(session);

        broadcast(message);
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        log.warning(throwable.toString());
    }

    private static void broadcast(Message message) throws IOException, EncodeException {
        String currentUsers = userList();

        for (ChatEndpoint endpoint : chatEndpoints) {
            synchronized(endpoint) {
                endpoint.session.getBasicRemote().sendObject(message);
//                endpoint.session.getBasicRemote().sendText(currentUsers);
            }
        }
    }

    private static void sendMessageToOneUser(Message message) throws IOException, EncodeException {
        for (ChatEndpoint endpoint : chatEndpoints) {
            synchronized(endpoint) {
                if (endpoint.session.equals(getSession(message.getTo()))) {
                    endpoint.session.getBasicRemote().sendObject(message);
                }
                else if (message.getTo().isEmpty() && !message.getFrom().equals(users.get(endpoint.session))){
                    endpoint.session.getBasicRemote().sendObject(message);
                }
            }
        }
    }

    private static Session getSession(String to) {
        if (users.containsValue(to)) {
            for (Session session: users.keySet()) {
                if (users.get(session).equals(to)) {
                    return session;
                }
            }
        }
        return null;
    }

    private  static String userList(){
        StringBuilder stringBuilder = new StringBuilder();
        for (String username : users.values()){  stringBuilder.append("<br>").append(username); }
        return stringBuilder.toString();
    }
}