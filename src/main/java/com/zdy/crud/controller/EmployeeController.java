package com.zdy.crud.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.commons.beanutils.ConvertUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zdy.crud.bean.Employee;
import com.zdy.crud.bean.Msg;
import com.zdy.crud.service.EmployeeService;

/**
 * 处理员工 CRUD 请求的控制器
 * 
 * @author yang9
 *
 */
@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;

	/**
	 * 查询员工数据（分页查询）---返回JSON版
	 * 
	 * @param pn
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		// 这不是一个分页查询
		// 引入PageHelper
		// 在查询之前只需要调用PageHelper并传入页码及分页大小
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟这个查询的就是一个分页查询
		List<Employee> emps = employeeService.getAll();
		// 使用PageInfo包装查询后的结果，只需要将Pageinfo交给页面即可
		// PageInfo封装了详细的分页信息和查询出来的数据
		PageInfo pageInfo = new PageInfo(emps, 5);

		return Msg.success().add("pageInfo", pageInfo);
	}

	/**
	 * 查询员工数据（分页查询）---返回页面版
	 * 
	 * @param pn
	 * @param model
	 * @return
	 */
	// @RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
		// 这不是一个分页查询
		// 引入PageHelper
		// 在查询之前只需要调用PageHelper并传入页码及分页大小
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟这个查询的就是一个分页查询
		List<Employee> emps = employeeService.getAll();
		// 使用PageInfo包装查询后的结果，只需要将Pageinfo交给页面即可
		// PageInfo封装了详细的分页信息和查询出来的数据
		PageInfo pageInfo = new PageInfo(emps, 5);

		model.addAttribute("pageInfo", pageInfo);
		System.out.println(pageInfo.getList().get(1).toString());
		return "/list";
	}

	/**
	 * 员工保存 1、支持JSR303校验 2、导入Hibernate-Validator
	 * 
	 * @param employee
	 * @param result
	 * @return
	 */
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result) {
		if (result.hasErrors()) {
			// 校验失败，在模态框中显示错误信息
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名: " + fieldError.getField());
				System.out.println("错误信息: " + fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		} else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}

	}

	/**
	 * 员工更新
	 * 
	 * @param employee
	 * @param result
	 * @return
	 */
	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmp(@Valid Employee employee, BindingResult result) {
		if (result.hasErrors()) {
			// 校验失败，在模态框中显示错误信息
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名: " + fieldError.getField());
				System.out.println("错误信息: " + fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		} else {
			employeeService.updateEmp(employee);
			return Msg.success();
		}
	}

	/**
	 * 员工删除(支持删除单个和多个)
	 * 
	 * @return
	 */
	@RequestMapping(value = "/emp/{empIds}", method = RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmp(@PathVariable("empIds") String empIds) {
		if (empIds.equals(""))
			return Msg.fail().add("errorMsg", "员工ID错误，删除失败！");
		if (empIds.contains(",")) {
			String[] str_empIds = empIds.split(",");
			List<Integer> integer_empIds = (List<Integer>) ConvertUtils.convert(str_empIds, Integer.class);
			employeeService.deleteEmpBatch(integer_empIds);
		} else {
			Integer empId = Integer.valueOf(empIds);
			employeeService.deleteEmp(empId);
		}

		return Msg.success();
	}

	/**
	 * 校验用户名是否可用
	 * 
	 * @param empName
	 * @return
	 */
	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkUser(String empName) {
		boolean b = employeeService.checkUser(empName);
		if (b)
			return Msg.success();
		else
			return Msg.fail();
	}
}
