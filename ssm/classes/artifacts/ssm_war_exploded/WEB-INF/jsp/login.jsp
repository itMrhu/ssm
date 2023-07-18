<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>登录</title>
		<meta charset="UTF-8" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/jquery-easyui-1.5.1/themes/default/easyui.css" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/jquery-easyui-1.5.1/themes/icon.css" />
		<script src="${pageContext.request.contextPath }/js/jquery-easyui-1.5.1/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="${pageContext.request.contextPath }/js/jquery-easyui-1.5.1/jquery.easyui.min.js" type="text/javascript" charset="utf-8"></script>
		<style type="text/css">
			table{
				margin: auto;
				margin-top: 20px;
			}
			tr{
				height: 40px;
				text-align: center;
			}
		</style>
		<script type="text/javascript">
			function login(){
				var username = $("#username").val();
				var psw = $("#psw").val();
				if(username == ""){
					$.messager.alert('提示',"用户名不能为空！","warning");
				}else if(psw == ""){
					$.messager.alert('提示',"密码不能为空！","warning");
				}else{
					$.messager.progress({
					    title: '请稍等',
					    msg: '正在登陆...'
					});
					$.ajax({
						type: 'post' ,
						url: '${pageContext.request.contextPath }/user/logindo.action' ,
						cache:false ,
						data:JSON.stringify({username:username,password:psw}),  
						contentType : "application/json;charset=UTF-8",
						dataType:'json' ,
						success:function(data){
							if (data.res == "1") {		
								$.messager.progress('close');
								window.location.href = "${pageContext.request.contextPath }/user/main.action";
							} else {
								$.messager.progress('close');
								$.messager.alert("提示", "用户名或密码输入不正确!","error"); 			
							}
						} ,
						error:function(result){
							$.messager.progress('close');
							$.messager.alert("提示", "登录失败,请重试!","error"); 
						}
					});
				}
			}		
			function reset(){
				$("form").get(0).reset();
			}
			
		</script>
	</head>

	<body>
		<div id="panel_login" style="margin: auto;width: 500px;margin-top: 100px;">
			<div id="login" class="easyui-panel" title="登录界面" data-options="iconCls:'icon-logo',minimizable:false,maximizable:false
				,collapsible:false,closable:false" style="width: 500px;height: 200px;">
				<form action="" method="post">
					<table>
						<tr>
							<td>用户名:</td>
							<td>
								<input type="text" name="username" id="username"/>
							</td>
						</tr>
						<tr>
							<td>密&nbsp;&nbsp;&nbsp;码:</td>
							<td>
								<input type="password" name="psw" id="psw" />
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<a id="btnCon" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="login();">登录</a>&nbsp; &nbsp;&nbsp;
								<a id="btnCan" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">重置</a>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</body>
</html>