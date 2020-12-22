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
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>department</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="emp">
						<tr>
							<td>${emp.empId }</td>
							<td>${emp.empName }</td>
							<td>${emp.gender }</td>
							<td>${emp.email }</td>
							<td>${emp.department.deptName }</td>
							<td>
								<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									新增
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<!-- 分页组件 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6">当前第${pageInfo.pageNum }页，总共${pageInfo.pages }页，总共${pageInfo.total }条记录</div>
			<!-- 分页条信息 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
					<ul class="pagination">
						<c:if test="${pageInfo.hasPreviousPage == true }">
							<li class="disable"><a href="${APP_PATH }/emps?pn=1">首页</a></li>
							<li><a href="${APP_PATH }/emps?pn=${pageInfo.pageNum-1 }"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
							</a></li>
						</c:if>
						<c:forEach items="${pageInfo.navigatepageNums }" var="pageNumNow">
							<c:if test="${pageNumNow == pageInfo.pageNum }">
								<li class="active"><a href="#">${pageNumNow }</a></li>
							</c:if>
							<c:if test="${pageNumNow != pageInfo.pageNum }">
								<li><a href="${APP_PATH }/emps?pn=${pageNumNow }">${pageNumNow }</a></li>
							</c:if>
						</c:forEach>
						<c:if test="${pageInfo.hasNextPage == true }">
							<li><a href="${APP_PATH }/emps?pn=${pageInfo.pageNum+1 }"
								aria-label="Next"> <span aria-hidden="true">&raquo;</span>
							</a></li>
							<li><a href="${APP_PATH }/emps?pn=${pageInfo.pages } ">末页</a></li>
						</c:if>
					</ul>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>