package chatty.coders;

import chatty.entities.Message;
import com.google.gson.Gson;

import javax.websocket.Decoder;
import javax.websocket.EndpointConfig;
import java.util.logging.Logger;

public class MessageDecoder implements Decoder.Text<Message> {

    private final Logger log = Logger.getLogger(getClass().getName());

    private Gson gson = new Gson();

    @Override
    public Message decode(String s)  {
        log.info("incoming message : " + s);

        return gson.fromJson(s, Message.class);
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
