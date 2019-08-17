<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<html>
<head>
    <title>Chat</title>

     <script src="https://code.jquery.com/jquery-1.10.2.js"
            type="text/javascript"></script>
</head>
<body>

 <table>
    <tr>
        <td colspan="3">
            <input type="text" id="username" placeholder="Username"/>
            <button type="button" onclick="connect();" >Connect</button>
            <button type="button" onclick="disconnect();" >Disconnect</button>
        </td>
    </tr>
    <tr>
        <td>
            <textarea readonly="true" rows="10" cols="80" id="log"></textarea>
        </td>
    </tr>
    <tr>
        <td>
            <input type="text" size="15" id="to" placeholder="To"/>
            <input type="text" size="51" id="msg" placeholder="Message"/>
            <button type="button" onclick="send();" >Send</button>
        </td>
    </tr>
    <tr>
        <td>
            <textarea readonly="true" rows="10" cols="80" id="allUsers"></textarea>
        </td>
    </tr>
</table>
</body>

 <script>
 var ws=null;

  function connect() {
     var username = document.getElementById("username").value;

      ws = new WebSocket("ws://" + document.location.host + "/chatty/chat/" + username);


      ws.onmessage = function(event) {
         var log = document.getElementById("log");
             console.log(event.data);
             var message = JSON.parse(event.data);
             log.innerHTML += message.from + " : " + message.content + "\n";
     };

  }

  function disconnect() {
     var username = document.getElementById("username").value;
     ws.close();

      ws.onmessage = function(event) {
         var log = document.getElementById("log");
             console.log(event.data);
             log.innerHTML += username + " : " + "disconnected!" + "\n";
     };
 }

  function send() {
     var content = document.getElementById("msg").value;
     var to = document.getElementById("to").value;
     var json = JSON.stringify({
         "to":to,
         "content":content
     });

      ws.send(json);
     log.innerHTML += "Me : " + content + "\n";
 }
 </script>

 </html>