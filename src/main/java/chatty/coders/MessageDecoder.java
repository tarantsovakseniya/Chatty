package chatty.coders;

import chatty.entities.Message;
import com.google.gson.Gson;

import javax.websocket.Decoder;
import javax.websocket.EndpointConfig;
import java.util.logging.Logger;

public class MessageDecoder implements Decoder.Text<Message> {
    private final Logger log = Logger.getLogger(getClass().getName());

    @Override
    public Message decode(String s)  {
        log.info("incoming message : " + s);

        Gson gson = new Gson();
        Message message = gson.fromJson(s, Message.class);
        return message;
    }

    @Override
    public boolean willDecode(String s) {
        return (s != null);
    }

    @Override
    public void init(EndpointConfig endpointConfig) {
    }

    @Override
    public void destroy() {
    }
}
