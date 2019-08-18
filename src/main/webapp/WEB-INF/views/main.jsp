<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<html>
<head>
    <title>Chat</title>

     <script src="https://code.jquery.com/jquery-1.10.2.js"
            type="text/javascript"></script>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
    <div class="container-fluid">
        <div class="card w-80 text-white bg-success mt-3">

            <div class="card-header">
            <p class="text text-center"><b>CHATTY</b></p>
            </div>

            <div class="card-body">

                <div class="form-row">
                    <div class="form-group col-md-6">
                        <input type="text" class="form-control form-control-sm" id="username" placeholder="Enter your nickname here..."/>
                    </div>

                    <div class="form-group col-md-6">
                        <button type="button" class="btn btn-sm btn-outline-light" onclick="connect();" >Connect</button>
                        <button type="button" class="btn btn-sm btn-danger" onclick="disconnect();" >Disconnect</button>
                    </div>
                </div>
                <div class="form-row">
                    <div class="card border-success w-80 mt-3">
                        <div class="card-header text-success">
                        <p class="text text-center">general window</p>
                        </div>
                        <div class="card-body">
                            <textarea class="form-control" readonly="true" rows="10" cols="100" id="log" bordered></textarea>

                            <div class="form-row mt-2">
                                <div class="form-group col-md-2">
                                    <input type="text" class="form-control form-control-sm" id="to" placeholder="To"/>
                                </div>
                                <div class="form-group col-md-8">
                                    <input type="text" class="form-control form-control-sm" id="msg" placeholder="Message"/>
                                </div>
                                <div class="form-group col-md-2">
                                    <button type="button" class="btn btn-sm btn-info" onclick="send();" >Send</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card border-success w-20 mt-3">
                        <div class="card-header text-success">
                        <p class="text text-center">users on-line</p>
                        </div>
                        <div class="card-body"
                        <textarea readonly="true" rows="10"  id="allUsers"></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>

 <script>
 var ws;
var username;
  function connect() {
     username = document.getElementById("username").value;

      ws = new WebSocket("ws://" + document.location.host + "/chatty/chat/" + username);


      ws.onmessage = function(event) {
         var log = document.getElementById("log");
         var allUsers = document.getElementById("allUsers");
             console.log(event.data);
             var message = JSON.parse(event.data);
             log.innerHTML += message.from + " : " + message.content + "\n";
allUsers.append(message.userList);

     };

  }

  function disconnect() {
      var username = document.getElementById("username").value;
      ws.close();
      ws.onmessage = function(event) {
         var log = document.getElementById("log");
              console.log(event.data);
              var message = JSON.parse(event.data);
              log.innerHTML += message.from + " : " + "disconnected!" + "\n";
     };
 }

  function send() {
     var username = document.getElementById("username").value;
     var content = document.getElementById("msg").value;
     var to = document.getElementById("to").value;
     var json = JSON.stringify({
         "from" : username,
         "to":to,
         "content":content
     });

      ws.send(json);
     log.innerHTML += "Me : " + content + "\n";
 }
 </script>

 </html>