<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- 引入JQuery -->
<script src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<!-- 引入bootstrap的css和js -->
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_btn">新增</button>
				<button class="btn btn-danger" id="emp_del_btn">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all" /></th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>department</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>
		</div>
		<!-- 分页组件 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>


	<!-- 员工新增Modal -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<!-- 模态框体 -->
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control"
									id="empName_add_input" placeholder="empName">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add" value="M" checked> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="email" name="email" class="form-control"
									id="email_add_input" placeholder="email@ssm_crud.com">
							</div>
						</div>
						<div class="form-group">
							<label for="department_add_select" class="col-sm-2 control-label">department</label>
							<div class="col-sm-10">
								<select name="dId" class="form-control"
									id="department_add_select">
									<option selected disabled value="">请选择部门</option>
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">Save</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 员工修改Modal -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">员工修改</h4>
				</div>
				<!-- 模态框体 -->
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<p class="form-control-static" id="empId_update_static" hidden></p>
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"></p>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update" value="M" checked> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update" value="F"> 女
								</label>
							</div>

						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="email" name="email" class="form-control"
									id="email_update_input" placeholder="email@ssm_crud.com">
							</div>
						</div>
						<div class="form-group">
							<label for="department_add_select" class="col-sm-2 control-label">department</label>
							<div class="col-sm-10">
								<select name="dId" class="form-control"
									id="department_update_select">
									<option selected disabled value="">请选择部门</option>
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">Update</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		var totalRecord; // 全局变量保存总记录数目
		var pageNum;
		// 页面加载完成以后，直接取发送ajax请求分页的数据
		$(function() {
			to_page(1);
		});

		function to_page(pn) {
			// 清空全选框的选中状态
			// 			$("#check_all").prop("checked", false);
			$("#check_all").removeAttr("checked");
			$.ajax({
				url : "${APP_PATH }/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					// console.log(result);
					// 1、解析并显示员工数据
					build_emps_table(result);
					// 2、解析并显示分页信息
					build_page_info(result);
					build_page_nav(result);
				}
			});
		}

		function build_emps_table(result) {
			// 清空表格数据
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$
					.each(
							emps,
							function(index, item) {
								var checkBoxTd = $("<td><input type='checkbox' class='check_item' /></td>");
								var empIdTd = $("<td></td>").append(item.empId);
								var empNameTd = $("<td></td>").append(
										item.empName);
								var genderTd = $("<td></td>").append(
										item.gender == "M" ? "男" : "女");
								var emailTd = $("<td></td>").append(item.email);
								var departmentTd = $("<td></td>").append(
										item.department.deptName);
								var editBtn = $("<button></button>")
										.addClass(
												"btn btn-primary btn-sm edit_btn")
										.attr("empId", item.empId)
										.attr("empName", item.empName)
										.append(
												$("<span></span>")
														.addClass(
																"glyphicon glyphicon-pencil")
														.append("编辑"));
								var delBtn = $("<button></button>")
										.addClass(
												"btn btn-danger btn-sm delete_btn")
										.attr("empId", item.empId)
										.append(
												$("<span></span>")
														.addClass(
																"glyphicon glyphicon-trash")
														.append("删除"));
								var btnTd = $("<td></td>").append(editBtn)
										.append(" ").append(delBtn);
								// append方法执行完成以后还是返回原来的元素
								$("<tr></tr>").append(checkBoxTd).append(
										empIdTd).append(empNameTd).append(
										genderTd).append(emailTd).append(
										departmentTd).append(btnTd).appendTo(
										"#emps_table tbody");
							});
		}

		function build_page_info(result) {
			// 清空分页信息数据
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前第" + result.extend.pageInfo.pageNum + "页，总共"
							+ result.extend.pageInfo.pages + "页，总共"
							+ result.extend.pageInfo.total + "条记录");
			totalRecord = result.extend.pageInfo.total;
			pageNum = result.extend.pageInfo.pageNum;
		}

		function build_page_nav(result) {
			// 清空分页组件数据
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;").attr("href", "#"));
			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;").attr("href", "#"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));

			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				firstPageLi.click(function() {
					to_page(1);
				});
				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}
			ul.append(firstPageLi).append(prePageLi);
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append(
						$("<a></a>").append(item).attr("href", "#"));
				if (item == result.extend.pageInfo.pageNum) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				});
				ul.append(numLi);
			});
			if (result.extend.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});
				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
			}
			ul.append(nextPageLi).append(lastPageLi);
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
	</script>
	<script type="text/javascript">
		// 新增员工按钮响应事件
		$("#emp_add_btn").click(function() {
			// 查询出部门信息显示在模态框下拉列表中
			get_dept_info("#department_add_select");
			$('#empAddModal').modal({
				backdrop : "static"
			});
		});
		// 修改员工按钮响应事件
		$(document).on("click", ".edit_btn", function() {
			// 员工信息显示在模态框静态框中
			$("#emp_update_btn").attr("empId", $(this).attr("empId"));
			$("#empName_update_static").empty();
			$("#empName_update_static").append($(this).attr("empName"));
			// 查询出部门信息显示在模态框下拉列表中
			get_dept_info("#department_update_select");
			$('#empUpdateModal').modal({
				backdrop : "static"
			});
		});

		// 保存员工信息按钮响应事件
		$("#emp_save_btn").click(function() {
			// 1、先对要提交的数据进行合法性校验
			if (!validate_add_form()) {
				return false;
			}
			// 2、校验通过则提交服务端保存			
			$.ajax({
				url : "${APP_PATH }/emp",
				type : "POST",
				data : $("#empAddModal form").serialize(),
				success : function(result) {
					console.log(result.msg);
					// 当员工保存成功
					if (result.code == 100) {
						// 1、 关闭模态框
						$('#empAddModal').modal('hide')
						// 2、 跳至最后一页查看新增的记录
						to_page(totalRecord);
					} else {
						console.log(result);
						if (undefined != result.extend.errorFields.empName)
							alert(result.extend.errorFields.empName);
						if (undefined != result.extend.errorFields.email)
							alert(result.extend.errorFields.email);
					}
				}
			});
		});
		// 更新员工信息按钮响应事件
		$("#emp_update_btn").click(function() {
			// 1、先对要提交的数据进行合法性校验
			if (!validate_update_form()) {
				return false;
			}
			// 2、校验通过则提交服务端保存			
			$.ajax({
				url : "${APP_PATH }/emp/" + $(this).attr("empId"),
				type : "PUT",
				data : $("#empUpdateModal form").serialize(),
				success : function(result) {
					console.log(result.msg);
					// 当员工保存成功
					if (result.code == 100) {
						// 1、 关闭模态框
						$('#empUpdateModal').modal('hide')
						// 2、 跳至最后一页查看新增的记录
						to_page(pageNum);
					} else {
						console.log(result);
						if (undefined != result.extend.errorFields.empName)
							alert(result.extend.errorFields.empName);
						if (undefined != result.extend.errorFields.email)
							alert(result.extend.errorFields.email);
					}
				}
			});
		});

		// 删除员工按钮响应事件
		$(document).on("click", ".delete_btn", function() {
			// 弹出删除确认
			let isDelConfirm = confirm("删除是不可恢复的，你确认要删除吗？");
			if (isDelConfirm != true) {
				return;
			} else {
				// 发送ajax请求删除该员工信息	
				$.ajax({
					url : "${APP_PATH }/emp/" + $(this).attr("empId"),
					type : "DELETE",
					success : function(result) {
						console.log(result.msg);
						// 当员工删除成功
						if (result.code == 100) {
							// 1、 关闭模态框
							$('#empAddModal').modal('hide')
							// 2、 刷新当前页
							to_page(pageNum);
						} else {
							console.log(result);
							alert("删除失败");
						}
					}
				});
			}
		});

		// 校验新增表单数据方法
		function validate_add_form() {

			// 校验用户名
			let empName = $("#empName_add_input").val();
			let regName = /(^[a-zA-Z0-9\u2E80-\u9FFF_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5}&)/;
			$("#empName_add_input").siblings().remove();
			$("#empName_add_input").parent().removeClass("has-error");
			if (!regName.test(empName)) {
				//alert("用户名长度为3-16，请重新检查");
				let errInfo = $("<span></span>").addClass("help-block").append(
						"用户名长度为3-16，请重新检查");
				$("#empName_add_input").parent().append(errInfo).addClass(
						"has-error");
				return false;
			}

			// 校验邮箱信息
			let email = $("#email_add_input").val();
			let regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			$("#email_add_input").siblings().remove();
			$("#email_add_input").parent().removeClass("has-error");
			if (!regEmail.test(email)) {
				//alert("邮箱格式错误，请重新检查");
				let errInfo = $("<span></span>").addClass("help-block").append(
						"邮箱格式错误，请重新检查");
				$("#email_add_input").parent().append(errInfo).addClass(
						"has-error");
				return false;
			}

			// 校验部门信息
			let department = $("#department_add_select").val();
			$("#department_add_select").siblings().remove();
			$("#department_add_select").parent().removeClass("has-error");
			if (department == null) {
				// alert("部门不能为空，请重新选择");
				let errInfo = $("<span></span>").addClass("help-block").append(
						"部门不能为空，请重新选择");
				$("#department_add_select").parent().append(errInfo).addClass(
						"has-error");
				return false;
			}

			return true;
		}
		// 校验修改表单数据方法
		function validate_update_form() {

			// 校验用户名
			let empName = $("#empName_update_input").val();
			let regName = /(^[a-zA-Z0-9\u2E80-\u9FFF_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5}&)/;
			$("#empName_update_input").siblings().remove();
			$("#empName_update_input").parent().removeClass("has-error");
			if (!regName.test(empName)) {
				//alert("用户名长度为3-16，请重新检查");
				let errInfo = $("<span></span>").addClass("help-block").append(
						"用户名长度为3-16，请重新检查");
				$("#empName_update_input").parent().append(errInfo).addClass(
						"has-error");
				return false;
			}

			// 校验邮箱信息
			let email = $("#email_update_input").val();
			let regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			$("#email_update_input").siblings().remove();
			$("#email_update_input").parent().removeClass("has-error");
			if (!regEmail.test(email)) {
				//alert("邮箱格式错误，请重新检查");
				let errInfo = $("<span></span>").addClass("help-block").append(
						"邮箱格式错误，请重新检查");
				$("#email_update_input").parent().append(errInfo).addClass(
						"has-error");
				return false;
			}

			// 校验部门信息
			let department = $("#department_update_select").val();
			$("#department_update_select").siblings().remove();
			$("#department_update_select").parent().removeClass("has-error");
			if (department == null) {
				// alert("部门不能为空，请重新选择");
				let errInfo = $("<span></span>").addClass("help-block").append(
						"部门不能为空，请重新选择");
				$("#department_update_select").parent().append(errInfo)
						.addClass("has-error");
				return false;
			}

			return true;
		}

		// 校验用户名是否可用(发送ajax校验)
		$("#empName_add_input").change(
				function() {
					let empName = this.value;
					$("#empName_add_input").siblings().remove();
					$("#empName_add_input").parent().removeClass("has-error");
					// 发送ajax请求验证可用性
					$.ajax({
						url : "${APP_PATH }/checkuser",
						data : "empName=" + empName,
						type : "POST",
						success : function(result) {
							if (result.code == 200) {
								let errInfo = $("<span></span>").addClass(
										"help-block").append("用户名已被占用，请重新设置");
								$("#empName_add_input").parent()
										.append(errInfo).addClass("has-error");
							}
						}

					});

				});

		// 获取下拉列表部门信息
		function get_dept_info(ele) {
			// 清空下拉列表数据
			$(ele).empty().append("<option selected disabled>请选择部门</option>");

			$.ajax({
				url : "${APP_PATH }/depts",
				type : "GET",
				success : function(result) {
					console.log(result);
					$.each(result.extend.depts, function(index, dept) {
						var dept_info_option = $("<option></option>").attr(
								"value", dept.deptId).append(dept.deptName);
						dept_info_option.appendTo(ele);
					});
				}
			});
		}

		// 点击全部删除按钮响应事件
		$("#emp_del_btn").click(function() {
			// 遍历$(".check_item:checked")选中的元素
			let empIds = "";
			$.each($(".check_item:checked"), function() {
				empIds += $(this).parents("tr").find("td:eq(1)").text() + ",";
			});
			empIds = empIds.substring(0, empIds.length - 1);
			if (confirm("确定删除所选员工？")) {
				// 发送ajax请求删除所选员工信息
				$.ajax({
					url : "${APP_PATH }/emp/" + empIds,
					type : "DELETE",
					success : function(result) {
						console.log(result.msg);
						// 当员工删除成功
						if (result.code == 100) {
							// 1、 关闭模态框
							$('#empAddModal').modal('hide')
							// 2、 刷新当前页
							to_page(pageNum);
						} else {
							console.log(result);
							alert("删除失败");
						}
					}
				});
			}
		});

		// 全选/全不选按钮响应事件
		$("#check_all").click(function() {
			// attr 获取checked是undefined, 所以建议用prop获取dom原生的属性
			// 所有check_item多选框和全选框的状态一致
			$(".check_item").prop("checked", $(this).prop("checked"))
		});
	</script>
</body>
</html>