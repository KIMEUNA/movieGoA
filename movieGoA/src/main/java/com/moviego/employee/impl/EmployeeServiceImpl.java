package com.moviego.employee.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moviego.common.dao.CommonDAO;
import com.moviego.employee.Employee;
import com.moviego.employee.EmployeeService;

@Service("employee.employeeService")
public class EmployeeServiceImpl implements EmployeeService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public Employee getReadEmployee2(String eid) {
		// TODO Auto-generated method stub
		Employee dto=null;
		try {
			dto=dao.getReadData("employee.getReadEmployee2", eid);
			
		} catch (Exception e) {
		}
		return dto;
	}

	

}
