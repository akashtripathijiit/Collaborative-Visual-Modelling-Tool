<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="worksheet.aspx.cs" Inherits="cvmt.index" %>
<%@ Import Namespace = "System.Configuration" %>
<%@ Import Namespace = "System.Data.SqlClient" %>
<%@ Import Namespace = "System.Data" %>
<%@ Import Namespace = "cvmt" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8"/> 
    <title>Worksheet</title>
    <link rel="stylesheet" href="css/bootstrap.css"  type="text/css"/>
</head>
<body onload="init()">
    <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
    
    <script src="https://cdn.firebase.com/v0/firebase.js"></script>
    
    <script src="http://code.createjs.com/easeljs-0.7.0.min.js"></script>

    <script type="text/javascript">
        $(window).load(function () {
            $('#new_page_modal').modal('show');
        });
    </script>

    <script>
        var chat_box = document.getElementById("chat_box");
        var u_name = "fake";
        var p_name = "fake proj";
        var connect_chat_to = "https://cvmt-chat.firebaseio.com/fake";
        var chathead;
        var connect_canvas_to = "https://cvmt-chat.firebaseio.com/fake";
        var canvashead;

        var stage;
        var count = 0;
        var fixed = 0;
        var remove = false;

        var point_1_x = 100 , point_1_y = 100, point_2_x = 200, point_2_y = 200;

        function init() {
            stage = new createjs.Stage("work_canvas");
        }

        function draw_text() {
            var list_1 = stage.on("stagemouseup", function (evt) {
                console.log("mouseup");
                point_1_x = evt.stageX;
                point_1_y = evt.stageY;
                console.log(point_1_x + ":" + point_1_y);

                stage.off("stagemouseup", list_1);
                var textbox = document.getElementById("textbox");
                var type = 6;
                create_text(point_1_x, point_1_y, textbox.value);
                insert_text_to_db(type, point_1_x, point_1_y, textbox.value);

            });
        }
        function draw_shape(type) {
           
            var list_1 = stage.on("stagemousedown", function (evt) {
                console.log("mousedown");
                point_1_x = evt.stageX;
                point_1_y = evt.stageY;
                console.log(point_1_x+":"+point_1_y);

                stage.off("stagemousedown", list_1);

                
            });
            var list_2 = stage.on("stagemouseup", function (evt) {
                console.log("mouseup");

                point_2_x = evt.stageX;
                point_2_y = evt.stageY;
                stage.off("stagemouseup", list_2);
                console.log(point_2_x + ":" + point_2_y);
                if (type == 3) {
                    create_circle(point_1_x, point_1_y, point_2_x, point_2_y);
                    insert_to_db(type, point_1_x, point_1_y, point_2_x, point_2_y);
                }
                else if (type == 1) {
                    create_line(point_1_x, point_1_y, point_2_x, point_2_y);
                    insert_to_db(type, point_1_x, point_1_y, point_2_x, point_2_y);
                }
                else if (type == 2) {
                    create_rect(point_1_x, point_1_y, point_2_x, point_2_y);
                    insert_to_db(type, point_1_x, point_1_y, point_2_x, point_2_y);
                }
                else if (type == 4) {
                    create_para(point_1_x, point_1_y, point_2_x, point_2_y);
                    insert_to_db(type, point_1_x, point_1_y, point_2_x, point_2_y);
                }
                else if (type == 5) {
                    create_diamond(point_1_x, point_1_y, point_2_x, point_2_y);
                    insert_to_db(type, point_1_x, point_1_y, point_2_x, point_2_y);
                }
            });
            //create_circle(point_1_x, point_1_y, point_2_x, point_2_y);

        }

        function draw_old_shapes(type, x1, y1, x2, y2) {
            if (type == 3) {
                create_circle(x1, y1, x2, y2);
            }
            else if (type == 1)
            {
                create_line(x1, y1, x2, y2);
            }
            else if (type == 2)
            {
                create_rect(x1, y1, x2, y2);
            }
            else if (type == 4) {
                create_para(x1, y1, x2, y2);
            }
            else if (type == 5) {
                create_diamond(x1, y1, x2, y2);
            }
            else if (type == 0) {
                null_obj(x1, y1, x2, y2);
            }
        }

        function create_diamond(x1, y1, x2, y2) {
            var diamond = new createjs.Shape();
            diamond.id = count + 20;
            diamond.x = x1;
            diamond.y = y1;
            diamond.graphics.beginStroke("black").beginFill("rgba(255,255,255,0.1)").moveTo((x2 - x1) / 2, 0).lineTo(0, (y2 - y1) / 2).lineTo((x2 - x1) / 2, y2 - y1).lineTo(x2 - x1, (y2 - y1) / 2).lineTo((x2 - x1) / 2, 0);
            stage.addChild(diamond);
            stage.update();

            diamond.on("pressmove", function (evt) {
                if (remove == false) {
                    evt.target.x = evt.stageX;
                    evt.target.y = evt.stageY;
                    console.log(evt.target.id);
                    stage.update();
                }
            });

            diamond.on("click", function (evt) {
                if (remove == true) {
                    console.log("removing rect :");
                    canvashead.once('value', function (snapshot1) {
                        snapshot1.forEach(function (snap) {
                            var snap_obj = snap.val();
                            console.log(snap_obj.priority + "==" + evt.target.id);
                            if ((snap_obj.priority + 20) == evt.target.id) {
                                var address = snap.ref() + "";
                                var upd = new Firebase(address);
                                console.log(address);
                                upd.update({ type: 0 });
                                //stage.update();
                                //start_canvas();
                            }
                        });
                    });

                }
                remove = false;
            });

            diamond.on("pressup", function (evt) {
                if (remove == false) {
                    canvashead.once('value', function (snapshot1) {
                        snapshot1.forEach(function (snap) {
                            var snap_obj = snap.val();
                            console.log(snap_obj.priority + ":" + evt.target.id);
                            if ((snap_obj.priority + 20) == evt.target.id) {
                                //console.log(snapshot1.ref() + "");
                                var xdiff = snap_obj.x1 - evt.target.x;
                                var ydiff = snap_obj.y1 - evt.target.y;
                                var x2new = snap_obj.x2 - xdiff;
                                var y2new = snap_obj.y2 - ydiff;
                                var address = snap.ref() + "";
                                var upd = new Firebase(address);
                                upd.update({ x1: evt.target.x, y1: evt.target.y, x2: x2new, y2: y2new });

                                //start_canvas();
                            }
                        });
                    });
                }
            })
        }

        function create_para(x1, y1, x2, y2) {
            var para = new createjs.Shape();
            para.id = count + 20;
            para.x = x1;
            para.y = y1;
            para.graphics.beginStroke("black").beginFill("rgba(255,255,255,0.1)").moveTo(15, 0).lineTo(0, y2 - y1).lineTo(x2 - x1 - 15, y2 - y1).lineTo(x2 - x1, 0).lineTo(15, 0);
            stage.addChild(para);
            stage.update();

            para.on("pressmove", function (evt) {
                if (remove == false) {
                    evt.target.x = evt.stageX;
                    evt.target.y = evt.stageY;
                    console.log(evt.target.id);
                    stage.update();
                }
            });

            para.on("click", function (evt) {
                if (remove == true) {
                    console.log("removing rect :");
                    canvashead.once('value', function (snapshot1) {
                        snapshot1.forEach(function (snap) {
                            var snap_obj = snap.val();
                            console.log(snap_obj.priority + "==" + evt.target.id);
                            if ((snap_obj.priority + 20) == evt.target.id) {
                                var address = snap.ref() + "";
                                var upd = new Firebase(address);
                                console.log(address);
                                upd.update({ type: 0 });
                                //stage.update();
                                //start_canvas();
                            }
                        });
                    });

                }
                remove = false;
            });

            para.on("pressup", function (evt) {
                if (remove == false) {
                    canvashead.once('value', function (snapshot1) {
                        snapshot1.forEach(function (snap) {
                            var snap_obj = snap.val();
                            console.log(snap_obj.priority + ":" + evt.target.id);
                            if ((snap_obj.priority + 20) == evt.target.id) {
                                //console.log(snapshot1.ref() + "");
                                var xdiff = snap_obj.x1 - evt.target.x;
                                var ydiff = snap_obj.y1 - evt.target.y;
                                var x2new = snap_obj.x2 - xdiff;
                                var y2new = snap_obj.y2 - ydiff;
                                var address = snap.ref() + "";
                                var upd = new Firebase(address);
                                upd.update({ x1: evt.target.x, y1: evt.target.y, x2: x2new, y2: y2new });

                                //start_canvas();
                            }
                        });
                    });
                }
            })
        }

        function create_rect(x1,y1,x2,y2) {
            var rect = new createjs.Shape();
            rect.id = count + 20;
            rect.x = x1;
            rect.y = y1;
            rect.graphics.beginStroke("black").beginFill("rgba(255,255,255,0.1)").moveTo(0, 0).lineTo(0, y2 - y1).lineTo(x2-x1,y2-y1).lineTo(x2-x1,0).lineTo(0,0);
            stage.addChild(rect);
            stage.update();

            rect.on("pressmove", function (evt) {
                if (remove == false) {
                    evt.target.x = evt.stageX;
                    evt.target.y = evt.stageY;
                    console.log(evt.target.id);
                    stage.update();
                }
            });

            rect.on("click", function (evt) {
                if (remove == true) {
                    console.log("removing rect :");
                    canvashead.once('value', function (snapshot1) {
                        snapshot1.forEach(function (snap) {
                            var snap_obj = snap.val();
                            console.log(snap_obj.priority + "==" + evt.target.id);
                            if ((snap_obj.priority + 20) == evt.target.id) {
                                var address = snap.ref() + "";
                                var upd = new Firebase(address);
                                console.log(address);
                                upd.update({ type: 0 });
                                //stage.update();
                                //start_canvas();
                            }
                        });
                    });

                }
                remove = false;
            });

            rect.on("pressup", function (evt) {
                if (remove == false) {
                    canvashead.once('value', function (snapshot1) {
                        snapshot1.forEach(function (snap) {
                            var snap_obj = snap.val();
                            console.log(snap_obj.priority + ":" + evt.target.id);
                            if ((snap_obj.priority + 20) == evt.target.id) {
                                //console.log(snapshot1.ref() + "");
                                var xdiff = snap_obj.x1 - evt.target.x;
                                var ydiff = snap_obj.y1 - evt.target.y;
                                var x2new = snap_obj.x2 - xdiff;
                                var y2new = snap_obj.y2 - ydiff;
                                var address = snap.ref() + "";
                                var upd = new Firebase(address);
                                upd.update({ x1: evt.target.x, y1: evt.target.y, x2: x2new, y2: y2new });

                                //start_canvas();
                            }
                        });
                    });
                }
            })
        }

        function create_line(x1, y1, x2, y2) {
            var line = new createjs.Shape();
            line.id = count + 20;
            line.x = x1;
            line.y = y1;
            line.graphics.beginStroke("black").moveTo(0,0).lineTo(x2-x1,y2-y1);
            stage.addChild(line);
            stage.update();
            line.on("pressmove", function (evt) {
                if (remove == false) {
                    evt.target.x = evt.stageX;
                    evt.target.y = evt.stageY;
                    console.log(evt.target.id);
                    stage.update();
                }
            });

            line.on("click", function (evt) {
                if (remove == true) {
                    console.log("removing line :");
                    canvashead.once('value', function (snapshot1) {
                        snapshot1.forEach(function (snap) {
                            var snap_obj = snap.val();
                            console.log(snap_obj.priority + "==" + evt.target.id);
                            if ((snap_obj.priority + 20) == evt.target.id) {
                                var address = snap.ref() + "";
                                var upd = new Firebase(address);
                                console.log(address);
                                upd.update({type: 0});
                                //stage.update();
                                //start_canvas();
                            }
                        });
                    });

                }
                remove = false;
            });

            line.on("pressup", function (evt) {
                if (remove == false) {
                    canvashead.once('value', function (snapshot1) {
                        snapshot1.forEach(function (snap) {
                            var snap_obj = snap.val();
                            console.log(snap_obj.priority + ":" + evt.target.id);
                            if ((snap_obj.priority + 20) == evt.target.id) {
                                //console.log(snapshot1.ref() + "");
                                var xdiff = snap_obj.x1 - evt.target.x;
                                var ydiff = snap_obj.y1 - evt.target.y;
                                var x2new = snap_obj.x2 - xdiff;
                                var y2new = snap_obj.y2 - ydiff;
                                var address = snap.ref() + "";
                                var upd = new Firebase(address);
                                upd.update({ x1: evt.target.x, y1: evt.target.y, x2: x2new, y2: y2new });

                                //start_canvas();
                            }
                        });
                    });
                }
            })
        }
       
        function create_circle(x1,y1,x2,y2) {
            

            var circle = new createjs.Shape();
            circle.x = x1;
            circle.y = y1;
            circle.id = count + 20;
            if (x2 > x1) {
                var temp = x2;
                x2 = x1;
                x1 = temp;
            }
            if (y2 > y1) {
                var temp = y2;
                y2 = y1;
                y1 = temp;
            }
            var radius = Math.sqrt( (Math.pow((x1-x2),2)) + (Math.pow((y1-y2),2)));
            circle.graphics.beginStroke("black").beginFill("rgba(255,255,255,0.1)").drawCircle(0, 0, radius);
            //count++;
            stage.addChild(circle);
            stage.update();

            //console.log("index = "+stage.getChildIndex(circle));

            circle.on("click", function (evt) {
                if (remove == true) {
                    console.log("removing");
                    canvashead.once('value', function (snapshot1) {
                        snapshot1.forEach(function (snap) {
                            var snap_obj = snap.val();
                            if ((snap_obj.priority + 20) == evt.target.id) {
                                var address = snap.ref() + "";
                                var upd = new Firebase(address);
                                upd.update({type: 0});
                                //stage.update();
                                //start_canvas();
                            }
                        });
                    });
                    
                }
                remove = false;
            });

            circle.on("pressmove", function (evt) {
                if (remove == false) {
                    evt.target.x = evt.stageX;
                    evt.target.y = evt.stageY;
                    console.log(evt.target.id);
                    stage.update();
                }
            });

            circle.on("pressup", function (evt) {
                if(remove == false)
                {
                    canvashead.once('value', function (snapshot1) {
                        snapshot1.forEach(function (snap) {
                            var snap_obj = snap.val();
                            console.log(snap_obj.priority + ":" + evt.target.id);
                            if ((snap_obj.priority + 20) == evt.target.id) {
                                console.log(snapshot1.ref() + "");
                                var xdiff = snap_obj.x1 - evt.target.x;
                                var ydiff = snap_obj.y1 - evt.target.y;
                                var x2new = snap_obj.x2 - xdiff;
                                var y2new = snap_obj.y2 - ydiff;
                                var address = snap.ref() + "";
                                var upd = new Firebase(address);
                                upd.update({ x1: evt.target.x, y1: evt.target.y, x2: x2new, y2: y2new });
                            
                                //start_canvas();
                            }
                        });
                    });
                }
            })
            
        }

        function create_text(x1, y1, text){
            console.log("created text "+text);
            var t = new createjs.Text(text, "12px Arial", "black");
            t.textBaseline = "alphabetic";
            t.id = count + 20;
            t.x = x1;
            t.y = y1;

            stage.addChild(t);
            stage.update();

            t.on("pressmove", function (evt) {
                if (remove == false) {
                    evt.target.x = evt.stageX;
                    evt.target.y = evt.stageY;
                    console.log(evt.target.id);
                    stage.update();
                }
            });
            t.on("click", function (evt) {
                if (remove == true) {
                    console.log("removing line :");
                    canvashead.once('value', function (snapshot1) {
                        snapshot1.forEach(function (snap) {
                            var snap_obj = snap.val();
                            console.log(snap_obj.priority + "==" + evt.target.id);
                            if ((snap_obj.priority + 20) == evt.target.id) {
                                var address = snap.ref() + "";
                                var upd = new Firebase(address);
                                console.log(address);
                                upd.update({ type: 0 });
                                //stage.update();
                                //start_canvas();
                            }
                        });
                    });

                }
                remove = false;
            });

            t.on("pressup", function (evt) {
                if (remove == false) {
                    canvashead.once('value', function (snapshot1) {
                        snapshot1.forEach(function (snap) {
                            var snap_obj = snap.val();
                            console.log(snap_obj.priority + ":" + evt.target.id);
                            if ((snap_obj.priority + 20) == evt.target.id) {
                                //console.log(snapshot1.ref() + "")
                                var address = snap.ref() + "";
                                var upd = new Firebase(address);
                                upd.update({ x1: evt.target.x, y1: evt.target.y});

                                //start_canvas();
                            }
                        });
                    });
                }
            })
        }

        function cnf() {
            var file = document.getElementById('filename');
            var share = document.getElementById('share_with');
            u_name = '<%: Session["u_name"] %>';
            p_name = file.value;
            console.log(u_name + " " + p_name);
        
            <%            
               /*SqlConnection conn10 = new SqlConnection(ConfigurationManager.ConnectionStrings["cmvtConnectionString"].ConnectionString);
               conn10.Open();
               string query_max_no = "SELECT * FROM projects";
               SqlCommand query_max = new SqlCommand(query_max_no, conn10);
               object result = query_max.ExecuteScalar();
               conn10.Close();
               int proj_no = Convert.ToInt32( result.ToString());
               proj_no++;
               */Console.Write("hahahahahaha");
               //Console.WriteLine(result);
               %>
        }
        
        
        
<%            
         /*SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["cmvtConnectionString"].ConnectionString);
               conn.Open();
               string query_max_no = "SELECT MAX(p_number) FROM projects";
               SqlCommand query_max = new SqlCommand(query_max_no, conn);
               object result = query_max.ExecuteScalar();
               int proj_no = Convert.ToInt32( result.ToString());
               proj_no++;
               Console.WriteLine(proj_no);
               conn.Close();
            
        conn = new SqlConnection(ConfigurationManager.ConnectionStrings["cmvtConnectionString"].ConnectionString);

        string strSql = "INSERT INTO projects (p_number,user_id,p_name,shared_by) ";
        
        strSql = strSql + "VALUES (@p_number, @user_id, @p_name, @shared_by)";
        SqlCommand Command = new SqlCommand(strSql, conn);
        Command.CommandType = CommandType.Text;

        try
        {
            //define the command parameters 
            Command.Parameters.Add(new SqlParameter("@p_number", SqlDbType.Int));
            Command.Parameters["@p_number"].Value = proj_no;

            Command.Parameters.Add(new SqlParameter("@user_id", SqlDbType.VarChar));
            Command.Parameters["@user_id"].Value = Session["u_name"];

            Command.Parameters.Add(new SqlParameter("@p_name", SqlDbType.VarChar));
            Command.Parameters["@p_name"].Value = filename;

            Command.Parameters.Add(new SqlParameter("@shared_by", SqlDbType.VarChar));
            Command.Parameters["@shared_by"].Value = share_with;

            conn.Open();
            Command.ExecuteNonQuery();
            conn.Close();
        }
        catch
        {
        }*/
%>



      //      start_chat();
      //      start_canvas();
     //   }
        function load_file()
        {
            var radios = document.getElementsByName('optionsRadios');

            for (var i = 0, length = radios.length; i < length; i++)
            {
                if (radios[i].checked)
                {
                    
                    var res = radios[i].value;
                    var info = res.split("/");
                    u_name = info[0];
                    p_name = info[1];

                    break;
                }
            }
            start_chat();
            start_canvas();
        }
        
        

        function add_to_chatbox(name, text) {
            var chat_box = document.getElementById("chat_box");

            if (chat_box.value !== "") {
                chat_box.value += "\n";
            }
            var msg = name + " : " + text;
            chat_box.value += msg;
            
            chat_box.scrollTop = chat_box.scrollHeight;
        }

        function send() {
            var text_value = document.getElementById("message");

            var text = text_value.value;
            chathead.push({ name: '<%: Session["u_name"] %>', text: text });
            text_value.value = "";
        }
        function start_chat() {
            //var filename = document.getElementById('filename');
            connect_chat_to = "https://cvmt-chat.firebaseio.com/" + u_name + "/" + p_name + "/chat/";
            //filename.value = connect_chat_to;
            chathead = new Firebase(connect_chat_to);

            chathead.on('child_added', function (snapshot) {
                var message = snapshot.val();
                add_to_chatbox(message.name, message.text);
            });
        }

        function start_canvas() {
            //var filename = document.getElementById('filename');
            stage.removeAllChildren();
            stage.removeAllEventListeners();
            stage.clear();
            connect_canvas_to = "https://cvmt-chat.firebaseio.com/" + u_name + "/" + p_name + "/canvas/";
            //filename.value = connect_chat_to;
            canvashead = new Firebase(connect_canvas_to);
            
            canvashead.once('value', function (snapshot1) {
                snapshot1.forEach(function (snap)
                {
                    var message = snap.val();
                    if (message.type == 6)
                        create_text(message.x1, message.y1, message.text);
                    else                     
                        draw_old_shapes(message.type, message.x1, message.y1, message.x2, message.y2);
                    count++;
                });
                fixed = count;
                console.log(count + "-count and fixed-" + fixed);
                count = 0;
                canvashead.on('child_added', function (snapshot) {
                    var message = snapshot.val();
                    
                    count++;
                    console.log(message.priority + " >= " + fixed);
                    if ((message.by != '<%: Session["u_name"] %>') && (message.priority >= fixed)) {
                        console.log("shape creating : " + message.priority)
                        count--;

                        if (message.type == 6) {
                            //console.log("creating text");
                            create_text(message.x1, message.y1, message.text);
                            
                        }
                        else
                            draw_old_shapes(message.type, message.x1, message.y1, message.x2, message.y2);
                        count++;
                    }
                });
                canvashead.on('child_changed', function (snapshot) {
                    var temp = snapshot.val();
                    console.log("changing " + temp.priority);
                    modify_shape = stage.getChildAt(temp.priority);
                    
                    if (temp.type == 3) {
                        modify_circle(modify_shape, temp.x1, temp.y1, temp.x2, temp.y2);
                    }
                    else if (temp.type == 1) {
                        modify_line(modify_shape, temp.x1, temp.y1, temp.x2, temp.y2)
                    }
                    else if(temp.type == 2) {
                        modify_rect(modify_shape, temp.x1, temp.y1, temp.x2, temp.y2)
                    }
                    else if (temp.type == 4) {
                        modify_para(modify_shape, temp.x1, temp.y1, temp.x2, temp.y2)
                    }
                    else if (temp.type == 5) {
                        modify_diamond(modify_shape, temp.x1, temp.y1, temp.x2, temp.y2)
                    }
                    else if (temp.type == 6) {
                        modify_text(modify_shape, temp.x1, temp.y1)
                    }
                    else if (temp.type == 0) {
                        create_null(modify_shape);
                    }
                });
            });
            
            
        }

        function null_obj(x1, y1, x2, y2) {
            var obj = new createjs.Shape();
            obj.id = count + 20;
            obj.x = x1;
            obj.y = y1;
            obj.graphics.beginStroke("black").beginFill("rgba(255,255,255,0.0)").moveTo(0, 0).lineTo(x2-x1, y2 - y1);
            obj.alpha = 0;
            stage.addChild(obj);
            stage.update();

        }

        function create_null(null_shape) {
            null_shape.alpha = 0;
            stage.update();
        }

        function modify_rect(rect, x1, y1, x2, y2) {
            rect.x = x1;
            rect.y = y1;
            stage.update();
        }

        function modify_diamond(diamond, x1, y1, x2, y2) {
            diamond.x = x1;
            diamond.y = y1;
            stage.update();
        }

        function modify_para(para, x1, y1, x2, y2) {
            para.x = x1;
            para.y = y1;
            stage.update();
        }

        function modify_line(line, x1, y1, x2, y2) {
            line.x = x1;
            line.y = y1;
            stage.update();
        }

        function modify_circle(circle, x1, y1, x2, y2) {
            circle.x = x1;
            circle.y = y1;
            if (x2 > x1) {
                var temp = x2;
                x2 = x1;
                x1 = temp;
            }
            if (y2 > y1) {
                var temp = y2;
                y2 = y1;
                y1 = temp;
            }
            var radius = Math.sqrt((Math.pow((x1 - x2), 2)) + (Math.pow((y1 - y2), 2)));
            //circle.graphics.beginStroke("black").beginFill("rgba(255,255,255,0.1)").drawCircle(0, 0, radius);

            stage.update();

        }

        function modify_text(text, x1, y1) {
            text.x = x1;
            text.y = y1;
            stage.update();
        }

        function remove_shape() {
            
            remove = true;
            
        }

        function insert_to_db(t,tx1,ty1,tx2,ty2) {
            canvashead.push({ by: '<%: Session["u_name"] %>', type: t, x1: tx1, y1: ty1, x2: tx2, y2: ty2, priority: count});
            
        }

        function insert_text_to_db(t, tx1, ty1, te) {
            canvashead.push({ by: '<%: Session["u_name"] %>', type: t, x1: tx1, y1: ty1, text:te, priority: count });
            
        }

     </script>

    <form id="form1" runat="server">
    
    <div class="container">
        <div class="modal fade" id="new_page_modal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Welcome</h4>
                    </div>
                    <div class="modal-body">
                        <p>Choose a file from the following or click on New worksheet to get going.</p>
                        
                        <%
                            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["cmvtConnectionString"].ConnectionString);
                            string writing;
                            int count;
                            conn.Open();
                            string check_for_p_name = "SELECT p_name FROM projects WHERE user_id ='" + Session["u_name"] + "'";
                            SqlCommand p_names = new SqlCommand(check_for_p_name, conn);
                            
                            SqlDataReader result = p_names.ExecuteReader();
                            
                            count=0;
                            while (result.Read())
                            {
                                count++;
                                writing = @" <div class= ""radio""> <label> <input type=""radio"" name=""optionsRadios"" id=""optionsRadios";
                                writing+=count;
                                writing += @""" value=""" + Session["u_name"] + "/" + result["p_name"];
                                writing+= @""" checked>" +Session["u_name"]+"/"+ result["p_name"] + "</label> </div>";
                                Response.Write(writing);
                            }
                            result.Close();

                            check_for_p_name = "SELECT user_id,p_name FROM projects WHERE shared_by ='" + Session["u_name"] + "'";
                            SqlCommand p_names_2 = new SqlCommand(check_for_p_name, conn);

                            SqlDataReader result_2 = p_names_2.ExecuteReader();

                            while (result_2.Read())
                            {
                                count++;
                                writing = @" <div class= ""radio""> <label> <input type=""radio"" name=""optionsRadios"" id=""optionsRadios";
                                writing += count;
                                writing += @""" value=""";
                                writing += result_2["user_id"] + "/" + result_2["p_name"];
                                writing += @""" checked>" + result_2["user_id"]+"/"+ result_2["p_name"] + "</label> </div>";
                                Response.Write(writing);
                            }
                            if (count == 0)
                            {
                                Response.Write("<p>No Saved files found");
                            }
                            
                            conn.Close();    
                            
                        %>
                        
                        
   
                            <button type="button" class="btn btn-success" onclick="load_file()" data-dismiss="modal">Load Worksheet</button>
                        
                    </div>
                    <div class="modal-footer">
                    <!--    <input id="filename" class="form-control" type="text" style="width:200px;float:left" placeholder="New File name"/>
                        <input id="share_with" class="form-control" type="text" style="width:200px;float:left" placeholder="Share with"/>
                        <button type="button" class="btn btn-primary pull-right" onclick="create_new_file()" data-dismiss="modal">New Worksheet</button>
                        
                     -->
                        <asp:TextBox ID="filename" CssClass ="form-control" Width="200px" runat="server" placeholder="New File name"/>
                        <asp:TextBox ID="share_with" CssClass ="form-control" Width="200px" runat="server" placeholder="Share with"/>
                        <button type="button" class="btn btn-success" onclick="cnf()" data-dismiss="modal">New file</button>
                        

                    </div>
                </div><!-- /.-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
        
        <h1><a href="”#”">Worksheet</a></h1>
        <div class="navbar">
          <div class="navbar-inner">
            <div class="container">
              <ul class="nav">
                <li style="float:left" class="active"><a href="default.aspx">Home</a></li>
                <li style="float:left"><a href="worksheet.aspx">New Project</a></li>
                <li style="float:left"><a href="worksheet.aspx">Load</a></li>
                <li style="float:left"><a href="#">Tutorial</a></li>
                <li style="float:left"><a href="#">Development Team</a></li>
              </ul>
            </div>
          </div>
        </div>

        
        <div class="row">
          <div class="span9 pull-left" style="border:2px; width:75%;height:500px; overflow:hidden">
             <canvas id="work_canvas" width="870" height="500">
                alternate content
             </canvas>
          </div>
         
          <div class="span3 pull-right" style="width:25%;overflow:hidden">
            <p>Draw shapes</p>
            <!--<button type="button" onclick="draw_shape(1)" class="btn btn-default" style='height:40px;width:40px;background-position:center;background-repeat:no-repeat; background-image:url("/images/arrow.png")'></button>
            -->
            <button type="button" onclick="draw_shape(1)" class="btn btn-default">Line connector</button><p></p>
            <button type="button" onclick="draw_shape(2)" class="btn btn-default">Rectangle</button><p></p>
            <button type="button" onclick="draw_shape(3)" class="btn btn-default">Circle</button><p></p>
            <button type="button" onclick="draw_shape(4)" class="btn btn-default">Parallelogram</button><p></p>
            <button type="button" onclick="draw_shape(5)" class="btn btn-default">Diamond</button><p></p>
            <p>Other functions</p>
            <button type="button" onclick="remove_shape()" class="btn btn-default">Remove shape</button><p></p>
            <button type="button" onclick="draw_text()" class="btn btn-default">Text Box</button>
            <input type="text" id="textbox" style=" height: 30px; margin: 2px" />
            

            <ul class="nav nav-list">
                <li class="nav-header">Chat</li>
            </ul>
          
            <textarea id="chat_box" readonly="readonly" style="width: 250px; height: 250px; margin: 2px; resize: none"></textarea>
            <input type="text" id="message" style="width: 190px; height: 30px; margin: 2px" />
            <button type="button" onclick="send()" id="send_msg" class="btn btn-success">Send</button>
            
            </div>
        </div>
    </div>
    </form>
</body>
</html>
