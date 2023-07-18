<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>UserList</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

	<!-- my97日期控件 -->
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/My97DatePicker/WdatePicker.js" charset="utf-8"></script>
	<!-- easyui控件 -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/jquery-easyui-1.5.1/themes/default/easyui.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/js/jquery-easyui-1.5.1/themes/icon.css" type="text/css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-easyui-1.5.1/jquery.min.js" charset="utf-8"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-easyui-1.5.1/jquery.easyui.min.js"  charset="utf-8"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-easyui-1.5.1/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/jquery-easyui-1.5.1/demo/demo.css">
  </head>
  
<script type="text/javascript">
  	
  	$(function(){
		var flag ;	
		setdatagrid();	
	});
  	

  	function setdatagrid(){
  		$('#tt').datagrid({
  			idField:'id' ,		
			fit:true , 					
			url:'${pageContext.request.contextPath}/user/getUserlist.action' ,
			fitColumns:true ,  				
			striped: true ,					
			loadMsg: '数据正在加载,请耐心的等待...' ,  
			rownumbers:true ,
			emptyMsg:'没有数据',	
			showFooter : true,
//			singleSelect:true ,		
			frozenColumns:[[			
				{
					field:'id' ,
					width:10 ,
					checkbox: true
				}
			]],
			columns:[[
				{field:'username',title:'用户名' ,width:300 ,align:'center' ,sortable:true},
				{field:'status' ,title:'状态' ,align:'center' ,width:300, sortable:true,
						formatter:function(value , record , index){
							if(value == 1){
								return '<span style=color:green; >可用</span>' ;
							} else if( value == 0){
								return '<span style=color:red; >停用</span>' ; 
							}
						}
				},
				{field:'id' ,
					title : '操作',width:300,align:'center' ,
					formatter:function(val,row,index){ 										
		               if(val!=null && val!='' && val!=undefined)
		                   return '<a href="javascript:void(0);"  onclick="viewpic(\'body.jpg\')">查看</a>';
		               else
		                   return '';
		            }
				}
			]] ,
			pagination: true ,    //显示分页栏
			pageSize: 20 ,		  //每页默认显示的条数	
			pageList:[5,10,15,20,50],  // 每页条数选择
			toolbar:[
				{
					text:'新增' ,
					iconCls:'icon-add' , 
					handler:function(){
						flag = 'add';
						$('#mydialog').dialog({title:'新增'});
						$('#myform').get(0).reset();
						$('#mydialog').dialog('open');
					}
				},{
					text:'修改' ,
					iconCls:'icon-edit' , 
					handler:function(){
						flag = 'edit';
						var arr =$('#tt').datagrid('getSelections');
						if(arr.length != 1){
							$.messager.show({
								title:'提示信息!',
								msg:'只能选择一行记录进行修改!'
							});
						} else {
							$('#mydialog').dialog({title:'修改'});
							$('#mydialog').dialog('open'); 
							$('#id').val(arr[0].id);
							$('#username').val(arr[0].username);
							$('#password').val(arr[0].password);
							$('#status').combobox('setValue', arr[0].status);
						}
					}
				},{
					text:'删除' ,
					iconCls:'icon-no' , 
					handler:function(){
						var arr =$('#tt').datagrid('getSelections');
						if(arr.length <=0){
							$.messager.show({
								title:'提示信息!',
								msg:'至少选择一行记录进行删除!'
							});
						} else {
							
							$.messager.confirm('提示信息' , '确认删除?' , function(r){
								if(r){
									var userArray=[]
									for(var i =0 ;i<arr.length;i++){
										userArray.push(arr[i].id);
									}
									$.ajax({
										type: 'post' ,
										url: '${pageContext.request.contextPath}/user/deleteUser.action' ,
										cache:false ,
										data:{"userlist":userArray} ,
										traditional: true,
										dataType:'json' ,
										success:function(result){
											$('#tt').datagrid('reload');
											$('#tt').datagrid('unselectAll');
											$.messager.show({
												title:result.status , 
												msg:result.message
											});
										} ,
										error:function(result){
											$('#tt').datagrid('reload');
											$('#tt').datagrid('unselectAll');
											$.meesager.show({
												title:result.status , 
												msg:result.message
											});
										}
									});
								}
							});
						}
					}								
				},{
					text:'导入' ,
					iconCls:'icon-excel' , 
					handler:function(){
						$('#uform').get(0).reset();
						$('#import').dialog('open');
					}
				}
			]
  		});
  		
  		
  		
  	}
  	
	
	//查询
	function searchUser(){
		var username_se = $('#username_se').val();
		var data = {"username":username_se};
		$('#tt').datagrid('load' ,data);
	}
	
	//清空
	function clearmysearch(){
		$('#mysearch').form('clear');
		$('#tt').datagrid('load' ,{});
	}

//   	提交表单
	function submitmyform(){
		var id = $('#id').val();
		var username = $('#username').val();
		var password = $('#password').val();
		var status = $('#status').val();
		
		if($('#myform').form('validate')){
			$.ajax({
				type: 'post' ,
				url: flag=='add'?'${pageContext.request.contextPath }/user/addUser.action':'${pageContext.request.contextPath }/user/editUser.action' ,
				cache:false ,
				data:JSON.stringify({id:id,username:username,password:password,status:status}),  
				contentType : "application/json;charset=UTF-8",
				dataType:'json' ,
				success:function(result){
					if(result.res=='fail'){
						$.messager.show({
							title:result.res , 
							msg:result.message
						});
					}else{
						$('#mydialog').dialog('close');
						$('#tt').datagrid('reload');
						
						$.messager.show({
							title:result.res , 
							msg:result.message
						});										
					}	

				} ,
				error:function(result){
					$.meesager.show({
						title:result.status , 
						msg:result.message
					});
				}
			});
		} else {
			$.messager.show({
				title:'提示信息!' ,
				msg:'数据验证不通过,不能保存!'
			});
		}
	}
	
	//关闭表单
	function closemyform(){
		$('#mydialog').dialog('close');
	}
	
	function upload(){
	
		$('#uform').form('submit',{
            url:'${pageContext.request.contextPath }/user/uploadUser.action',
            onSubmit:function(){
            	var filename = $('#uploadFile').val();
            	if(filename == null || filename == ''){
            		$.messager.show({
        				title:'提示信息!' ,
        				msg:'请选择文件!'
        			});
            		return false;
            	}
            	//获取后缀名  只允许上传xls和xlsx文件
            	var filesuffix = filename.substring(filename.lastIndexOf('.')+1);
            	if(filesuffix != 'xls' && filesuffix != 'xlsx'){
            		$.messager.show({
        				title:'提示信息!' ,
        				msg:'请选择Excel文件!'
        			});
            		return false;
            	}
            	$.messager.progress({
            	  
				    title: '请稍等',
				    msg: '正在上传...'
				    
				});
                return true;    // 返回false终止表单提交

            },
            type: 'post' ,
            contentType : "application/json;charset=UTF-8",
            dataType:'json' ,
            success:function(data){
          
            	var result =  eval("("+ data +")");  //通过js方式解析JSON字符串
            	
            	if(result.res=='fail'){
            		$.messager.progress('close');
					$.messager.show({
						title:result.res , 
						msg:result.message
					});
				}else{
					$.messager.progress('close');
					$('#uform').get(0).reset();
					$('#import').dialog('close');
					$('#tt').datagrid('reload');
					
					$.messager.show({
						title:result.res , 
						msg:result.message
					});										
				}
            },
            error:function(result){
				$.messager.progress('close');
				$.messager.alert("提示", "导入失败,请重试!","error"); 
			}

        });
	}
	
	function viewpic(pic){
		$('#viewdio').dialog('open');
		$("#im").attr("src","${pageContext.request.contextPath }/upload/"+pic);					
								
	}
	
	//序列化表单 			
	function serializeForm(form){
		var obj = {};
		$.each(form.serializeArray(),function(index){
			if(obj[this['name']]){
				obj[this['name']] = obj[this['name']] + ','+this['value'];
			} else {
				obj[this['name']] =this['value'];
			}
		});
		return obj;
	}
	
</script>
  
  <body class="easyui-layout">
		<div region="north"  style="height:30px;" >
			<form id="mysearch" method="post">
					用户名:<input id="username_se"  name="username_se" type="text" style="width:100px;" class="easyui-validatebox" value="" />&nbsp;&nbsp;
					<a id="searchbtn" iconCls="icon-search" class="easyui-linkbutton" onclick="searchUser();">查询</a> &nbsp;&nbsp;
					<a id="clearbtn" iconCls="icon-cancel" class="easyui-linkbutton" onclick="clearmysearch();">清空</a>
			</form>
		</div> 	
			
	  	<div region="center" >
			<table id="tt"></table>
		</div>
		
		<div id="mydialog" title="新增" modal="true"  draggable="false" class="easyui-dialog" closed="true" style="width:300px;">
	    	<form id="myform" action="" method="post">
	    		<input type="hidden" name="id" id="id" value="" />
	    		<table>
	    			<tr>
	    				<td>用户名:</td>
	    				<td><input id="username"  name="username" type="text" class="easyui-validatebox" required="true"  value="" /></td>
	    			</tr>
	    			<tr>
	    				<td>密码:</td>
	    				<td><input type="password" name="password" id="password" class="easyui-validatebox" required="true"   value="" /></td>
	    			</tr>
   					<tr>
   						<td>状态:</td>
   						<td><select id="status"  name="status" class="easyui-combobox" required=true style="width:150px;" data-options="editable:false" >
								<option value="1" >可用</option>
								<option value="0" >停用</option>
							</select>
						</td>
   					</tr>		
   					<tr align="center">
   						<td colspan="2">
   							<a id="btn1" class="easyui-linkbutton" iconCls="icon-save" onclick="submitmyform();">确定</a>
   							<a id="btn2" class="easyui-linkbutton" iconCls="icon-cancel" onclick="closemyform();">关闭</a>
   						</td>
   					</tr>   					 					    					    					    					    					    					    					    					
	    		</table>
	    	</form> 			
		</div>
		
		
		<div id="import" title="导入" modal="true"  draggable="false" class="easyui-dialog" closed=true style="width:400px;heigth:300px">
				<form id="uform" name="uform" action="${pageContext.request.contextPath }/user/uploadUser.action" method="post"  enctype="multipart/form-data" ">
					<a href="${pageContext.request.contextPath }/file/userInfo.xls" download="userInfo">文件模板下载</a>
					<p align="center">文件名：
						<input type="file" name="uploadFile" id="uploadFile" style="width:300"/></br>
						<a id="sc" class="easyui-linkbutton" iconCls="icon-excel" onclick="upload();">导入</a>
					</P>
				</form>
		</div>
		
		<div id="viewdio" title="查看图片" modal=true  draggable=false class="easyui-dialog" closed=true style="width:600px;height: 400px">
				<form id="myform1" action="" method="post">
					<img id="im" alt="" src=""  width="100%"/>
				</form>
		</div>
  </body>
</html>
