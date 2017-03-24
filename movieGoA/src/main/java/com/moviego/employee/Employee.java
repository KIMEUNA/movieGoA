package com.moviego.employee;

public class Employee {

	// 직원 정보
	private int employeeIdx, isEmployee;
	private String id, name, pass;
	private String birth;
	private String email;
	private String tel;
	private String grade;
	private String e_regdate;
	
	// 권한
	private int num;
	private String authority;
	
	// 지점 정보
	private int cinemaIdx;
	
	public int getEmployeeIdx() {
		return employeeIdx;
	}
	public void setEmployeeIdx(int employeeIdx) {
		this.employeeIdx = employeeIdx;
	}
	public int getIsEmployee() {
		return isEmployee;
	}
	public void setIsEmployee(int isEmployee) {
		this.isEmployee = isEmployee;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getE_regdate() {
		return e_regdate;
	}
	public void setE_regdate(String e_regdate) {
		this.e_regdate = e_regdate;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public int getCinemaIdx() {
		return cinemaIdx;
	}
	public void setCinemaIdx(int cinemaIdx) {
		this.cinemaIdx = cinemaIdx;
	}
	
}
