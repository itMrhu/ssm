<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>主页面</title>
		<meta charset="UTF-8" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/jquery-easyui-1.5.1/themes/default/easyui.css" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/jquery-easyui-1.5.1/themes/icon.css" />
		<script src="${pageContext.request.contextPath }/js/jquery-easyui-1.5.1/jquery.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="${pageContext.request.contextPath }/js/jquery-easyui-1.5.1/jquery.easyui.min.js" type="text/javascript" charset="utf-8"></script>
		
		
		<style type="text/css">
			#sdiv {
				text-align: left;
				font-size: 14px;
				font-weight: bold;
				line-height: 30px;
				background-color: #EAEAEA;
			}
			/*修改头部标题样式*/
			
			#n_title {
				color: white;
				font-size: 14px;
				line-height: 40px;
			}
			/*修改标题超链接样式*/
			
			#n_title a {
				text-decoration: none;
				color: white;
			}
			
			#n_title a:hover {
				color: orange;
			}
			/*修改密码样式*/
			
			#div_pwd table {
				margin: auto;
				margin-top: 10px;
			}
			
			#div_pwd table tr {
				height: 40px;
				text-align: center;
			}
		</style>
		<script type="text/javascript">
			$(function() {
				//设定时间
				setCurrentDate();
				
				//退出
				$("#n_title_out").click(function() {
					$.messager.confirm('系统提示', '您确定要退出本次登录吗?', function(r) {
	                	if(r){
	                		$.ajax({
	                			type: 'post' ,
								url: '${pageContext.request.contextPath }/user/logout.action' ,
								cache:false ,
								success:function(data){
									if (data.result == "1") {
										location.href='${pageContext.request.contextPath }/index.jsp';					
									} else {
									   location.href='${pageContext.request.contextPath }/index.jsp';	
									}
								},
								error:function(result){
									alert(result);
									location.href='${pageContext.request.contextPath }/index.jsp';	
								}
	                		});
	                	
	                    }
	                });
				});
					
				//修改密码
				$("#n_title_pwd").click(function() {
					//打开修改密码窗口
					$("#div_pwd").window("open");
					$('#mypwdform').get(0).reset();  
				});
						
			  //确认修改密码
				$("#btnCon").click(function() {
					var oldpw = $("#txtOldPass").val();
					var newpw = $("#txtNewPass").val();
					var repw = $("#txtRePass").val();
					var username = $("#username").val();
					
					if (oldpw == "") { //校验原有密码
						$.messager.alert("原有密码", "原有密码不能为空！", "warning");
						return false;
					} else if (newpw == "") { //校验新密码
						$.messager.alert("新密码", "新密码不能为空！", "warning");
						return false;
					} else if (repw == "") { //校验确认密码
						$.messager.alert("确认密码", "确认密码不能为空！", "warning");
						return false;
					} else if (newpw != repw) { //校验两次密码
						$.messager.alert("密码校验", "两次密码不一致！", "error");
						return false;
					} else {
						$.ajax({
							type: 'post' ,
							url: 'user/editPsw.do' ,
							cache:false ,
							data:{oldpass:oldpw,newpass:newpw,rePass:repw,username:username} ,
							dataType:'json' ,
							success:function(result){
								$("#div_pwd").window("close");  //关闭密码窗口
								$.messager.show({
									title:result.status , 
									msg:result.message
								});
							} ,
							error:function(result){
								$.meesager.show({
									title:result.status , 
									msg:result.message
								});
							}
						});
					}
				});
				
			  //取消密码修改
				$("#btnCan").click(function(){
					$("#div_pwd").window("close");
				});
				
			  
			  
			  
			  
			  
			  //树状菜单和选项卡的联动
				//给菜单添加单击事件
				$("#treeMenu").tree({
					onClick:function(node){
						//获取attributes属性,判断是菜单还是菜单描述
						var attrs=node.attributes;
						if(attrs==null || attrs.url==null){
							return;
						}
						//判断选项卡是否存在
						var has=$("#layout_center_tabs").tabs("exists",node.text);
						if(has){
							//选中存在的选项卡
							$("#layout_center_tabs").tabs("select",node.text);
						}else{
							//创建新的选项卡面板
							$("#layout_center_tabs").tabs("add",{
								title:node.text,
								closable:true,
								content:"<iframe src="+attrs.url+" style='width:100%;height:98%' frameborder='0'/>"
							})
						}
					}
				});
				
				
				$('#layout_center_tabsMenu').menu({
					onClick : function(item) {
						var curTabTitle = $(this).data('tabTitle');
						var type = $(item.target).attr('type');
		
						if (type === 'refresh') {
							layout_center_refreshTab(curTabTitle);
							return;
						}
		
						if (type === 'close') {
							var t = $('#layout_center_tabs').tabs('getTab', curTabTitle);
							if (t.panel('options').closable) {
								$('#layout_center_tabs').tabs('close', curTabTitle);
							}
							return;
						}
		
						var allTabs = $('#layout_center_tabs').tabs('tabs');
						var closeTabsTitle = [];
		
						$.each(allTabs, function() {
							var opt = $(this).panel('options');
							if (opt.closable && opt.title != curTabTitle && type === 'closeOther') {
								closeTabsTitle.push(opt.title);
							} else if (opt.closable && type === 'closeAll') {
								closeTabsTitle.push(opt.title);
							}
						});
		
						for ( var i = 0; i < closeTabsTitle.length; i++) {
							$('#layout_center_tabs').tabs('close', closeTabsTitle[i]);
						}
					}
				});
				
				
				$('#layout_center_tabs').tabs({
					fit : true,
					border : false,
					onContextMenu : function(e, title) {
						e.preventDefault();
						$('#layout_center_tabsMenu').menu('show', {
							left : e.pageX,
							top : e.pageY
						}).data('tabTitle', title);
					},
					tools : [ {
						iconCls : 'icon-reload',
						handler : function() {
							var href = $('#layout_center_tabs').tabs('getSelected').panel('options').href;
							if (href) {/*说明tab是以href方式引入的目标页面*/
								var index = $('#layout_center_tabs').tabs('getTabIndex', $('#layout_center_tabs').tabs('getSelected'));
								$('#layout_center_tabs').tabs('getTab', index).panel('refresh');
							} else {/*说明tab是以content方式引入的目标页面*/
								var panel = $('#layout_center_tabs').tabs('getSelected').panel('panel');
								var frame = panel.find('iframe');
								try {
									if (frame.length > 0) {
										for ( var i = 0; i < frame.length; i++) {
											frame[i].contentWindow.document.write('');
											frame[i].contentWindow.close();
											frame[i].src = frame[i].src;
										}
										if ($.browser.msie) {
											CollectGarbage();
										}
									}
								} catch (e) {
								}
							}
						}
					}]
				});
			})
			
			

			function layout_center_refreshTab(title) {
				$('#layout_center_tabs').tabs('getTab', title).panel('refresh');
			}

			function layout_center_addTabFun(opts) {
				var t = $('#layout_center_tabs');
				if (t.tabs('exists', opts.title)) {
					t.tabs('select', opts.title);
				} else {
					t.tabs('add', opts);
				}
			}
			
			
			
			
			
			function setCurrentDate() {
		        var now = new Date();
		        var year = now.getFullYear(); //得到年份
		        var month = now.getMonth();//得到月份
		        var date = now.getDate();//得到日期
		        var day = now.getDay();//得到周几
		        var hour = now.getHours();//得到小时
		        var minu = now.getMinutes();//得到分钟
		        var sec = now.getSeconds();//得到秒
		        var MS = now.getMilliseconds();//获取毫秒
		        var week;
		        month = month + 1;
		        if (month < 10) month = "0" + month;
		        if (date < 10) date = "0" + date;
		        if (hour < 10) hour = "0" + hour;
		        if (minu < 10) minu = "0" + minu;
		        if (sec < 10) sec = "0" + sec;
		        if (MS < 100)MS = "0" + MS;
		        var arr_week = new Array("星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六");
		        week = arr_week[day];
		        var time = "";
		        time = year + "年" + month + "月" + date + "日" + " " + hour + ":" + minu + ":" + sec + " " + week;
		        //当前日期赋值给当前日期输入框中（jQuery easyUI）
		        $("#currentDate").html(time);
		        //设置得到当前日期的函数的执行间隔时间，每1000毫秒刷新一次。
		        var timer = setTimeout("setCurrentDate()", 1000);
		      }
		</script>
	</head>

	<body class="easyui-layout">
		<!--布局：北-->
		<div data-options="region:'north'" style="height: 8%;background-image: url(${pageContext.request.contextPath }/images/layout-browser-hd-bg.gif);">
			<input type="hidden" id="username" name="username"  value="${currentUser.username}" /> 
			<span id="n_logo" style="margin-left: 20px;">
				<img src="${pageContext.request.contextPath }/images/logo.png" width="35px" style="margin-top: 5px;"/>
				<font color="white" size="4px">班级管理系统</font>
			</span>
			<span id="n_title" style="float: right;">
				<span id="currentDate"></span>&nbsp;&nbsp;&nbsp;
				欢迎&nbsp;&nbsp;&nbsp;<font color='#FFA07A'>${currentUser.username}</font>&nbsp;&nbsp;&nbsp;
				<a id="n_title_pwd" href="javascript:void(0)">修改密码</a>&nbsp;|
				<a id="n_title_out" href="javascript:void(0)">退出</a>&nbsp;&nbsp;&nbsp;
			</span>
		</div>
		
		<!--布局：南-->
		<div id="sdiv" data-options="region:'south',border:false" style="height:5%;">
			&copy;青春年华
		</div>
		
		<!--布局：西-->
		<div data-options="region:'west',title:'系统菜单',split:true" style="width: 200px;">
			<div class="easyui-accordion" data-options="fit:true,border:false">
				<div id="" title="请选择" >
					<!--创建菜单-->
					<ul id="treeMenu" class="easyui-tree">
						<li>
							<span>学生管理</span>
							<!--二级-->
							<ul>
								<li data-options="attributes:{url:'${pageContext.request.contextPath }/student/studentlist.action'}">学生信息</li>
							</ul>
							<ul>
								<li data-options="attributes:{url:'jsp/productionlist.jsp'}">学生作品</li>
							</ul>
							<ul>
								<li data-options="attributes:{url:'${pageContext.request.contextPath }/echart/Echartlist.action'}">成绩汇总</li>
							</ul>
						</li>
						<li>
							<span>用户管理</span>
							<ul>
								<li data-options="attributes:{url:'${pageContext.request.contextPath }/user/userlist.action'}">用户列表</li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
			
		</div>
		<!--布局：中-->
		<div data-options="region:'center'">
			<!--选项卡使用-->
			<div id="layout_center_tabs" class="easyui-tabs" data-options="fit:true,border:false">
				<div id="" title="首页" style="background-image:url(${pageContext.request.contextPath }/images/body.jpg) ;background-size: cover;">
				<h1>班级管理系统欢迎您</h1>
				</div>
			</div>
		</div>
		
		<div id="layout_center_tabsMenu" style="width: 120px;display:none;">
			<div type="refresh">刷新</div>
			<div class="menu-sep"></div>
			<div type="close">关闭</div>
			<div type="closeOther">关闭其他</div>
			<div type="closeAll">关闭所有</div>
		</div>
		
		<!--创建修改密码窗口-->
		<div id="div_pwd" class="easyui-window" title="修改密码" style="width: 400px;height: 250px;" data-options="collapsible:false,minimizable:false,maximizable:false,closed:true,modal:true">
			<form id="mypwdform" action="" method="post">
			<table>
				<tr>
					<td>原有密码:</td>
					<td>
						<input type="password" id="txtOldPass"/>
					</td>
				</tr>
				<tr>
					<td>新密码:</td>
					<td>
						<input type="password" id="txtNewPass"/>
					</td>
				</tr>
				<tr>
					<td>确认密码:</td>
					<td>
						<input type="password" id="txtRePass"/>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<a id="btnCon" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'">确认修改</a> &nbsp;&nbsp;&nbsp;&nbsp;
						<a id="btnCan" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
					</td>
				</tr>
			</table>
			</form>
		</div>
	</body>
</html>