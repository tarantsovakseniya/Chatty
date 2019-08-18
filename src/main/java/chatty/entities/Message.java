package chatty.entities;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.StringJoiner;

@Data
public class Message{

    private String from;
    private String to;
    private String content;
    private StringJoiner userList = new StringJoiner("<br>");

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public StringJoiner getUserList() {
        return userList;
    }

    public void setUserList(StringJoiner userList) {
        this.userList = userList;
    }
}
