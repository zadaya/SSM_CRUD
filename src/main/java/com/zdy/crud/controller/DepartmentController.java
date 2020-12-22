package com.zdy.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zdy.crud.bean.Department;
import com.zdy.crud.bean.Employee;
import com.zdy.crud.bean.Msg;
import com.zdy.crud.service.DepartmentService;

/**
 * 处理和部门有关的请求的控制器
 * 
 * @author yang9
 *
 */
@Controller
public class DepartmentController {

	@Autowired
	private DepartmentService departmentService;

	/**
	 * 返回所有部门的信息
	 * 
	 * @return
	 */
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
		List<Department> depts = departmentService.getDepts();

		return Msg.success().add("depts", depts);
	}
}
