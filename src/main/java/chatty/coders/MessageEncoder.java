package chatty.coders;

import chatty.entities.Message;
import com.google.gson.Gson;

import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;
import java.util.logging.Logger;

public class MessageEncoder implements Encoder.Text<Message> {

    private final Logger log = Logger.getLogger(getClass().getName());

    private Gson gson = new Gson();

    @Override
    public String encode(Message message)  {
        log.info("converting message obj to json format");

        return gson.toJson(message);
    }

    @Override
    public void init(EndpointConfig endpointConfig) {
    }

    @Override
    public void destroy() {
    }
}
