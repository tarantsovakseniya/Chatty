'use strict';

var ws=null;

 function connect() {
    var username = document.getElementById("username").value;

     ws = new WebSocket("ws://localhost:8080/chatty/chat/" + username);


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