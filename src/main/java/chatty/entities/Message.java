package chatty.entities;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
public class Message {

    private String from;
    private String to;
    private String content;

}
