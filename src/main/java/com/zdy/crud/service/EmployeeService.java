package com.zdy.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zdy.crud.bean.Employee;
import com.zdy.crud.bean.EmployeeExample;
import com.zdy.crud.bean.EmployeeExample.Criteria;
import com.zdy.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;

	/**
	 * 查询所有员工
	 * 
	 * @return
	 */
	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}

	/**
	 * 员工保存方法
	 * 
	 * @param employee
	 */
	public void saveEmp(Employee employee) {
		employeeMapper.insertSelective(employee);
	}

	/**
	 * 校验用户名是否可用
	 * 
	 * @param empName
	 * @return
	 */
	public boolean checkUser(String empName) {
		EmployeeExample employeeExample = new EmployeeExample();
		Criteria criteria = employeeExample.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(employeeExample);

		return count == 0;
	}

	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	/**
	 * 员工删除
	 * 
	 * @param empId
	 */
	public void deleteEmp(int empId) {
		employeeMapper.deleteByPrimaryKey(empId);
	}

	public void deleteEmpBatch(List<Integer> empIds) {
		EmployeeExample employeeExample = new EmployeeExample();
		Criteria criteria = employeeExample.createCriteria();
		criteria.andEmpIdIn(empIds);
		employeeMapper.deleteByExample(employeeExample);
	}

}
