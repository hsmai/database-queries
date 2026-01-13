USE UNIVERSITY;


#1 (remove duplicates)
SELECT DISTINCT dept_name
FROM instructor;



#2 (don't remove duplicates)
SELECT ALL dept_name
FROM instructor;



#3 (각 attribute 속 데이터들 확인하기)
#실제 salary attribute는 1년 단위이므로, 이를 월급으로 변환하기 위해 12로 나눠줌, 이후 rename
SELECT ID, name, floor(salary/12) as monthly_salary
FROM instructor;




#4 (where 조건문 연습)
SELECT name
FROM instructor
WHERE dept_name = 'Comp. Sci.' AND salary > 70000;




#5 (from cartesian 곱 연습)
#카르테시안 곱 생성 시, 각 테이블의 'primary key'는 이름이 겹치더라도 이름이 변경되지 않고 유지됨 (본 예제에서는 'ID')
SELECT *
FROM instructor, teaches;



#6 (Rename Operation)
SELECT name as instructor_name
FROM instructor;



#7 (Self-Join)
SELECT DISTINCT B.name as instructor_who_has_higher_salary_then_CompSci
FROM instructor as A, instructor as B
WHERE A.dept_name = 'Comp. SCi.' AND B.salary > A.salary;




#8 (String Operation)
SELECT DISTINCT name
FROM instructor
WHERE name LIKE '%ing%';



# 9 (* symbol)
#table명.* : 걍 싹 다 가져오기

SELECT instructor.*
FROM instructor, teaches #Cartesian Product
WHERE instructor.ID = teaches.ID;



#10 (Ordering Operation)
#ORDER BY : sorting clause

SELECT DISTINCT name
FROM instructor
ORDER BY name; #name의 알파벳 순으로 정렬


#desc : 내림차순
SELECT DISTINCT name
FROM instructor
ORDER BY name desc;


#asc : 올림차순
SELECT name, salary
FROM instructor
ORDER BY name asc, salary desc;


SELECT name, salary
FROM instructor
ORDER BY name ASC, salary DESC;


SELECT name, course_id
FROM instructor, teaches
WHERE (instructor.ID, dept_name) = (teaches.course_id, 'Biology');



#11 (여러 연산)
SELECT course_id
FROM section
WHERE semester = 'Fall' AND year = '2017'

UNION

SELECT course_id
FROM section
WHERE semester = 'Spring' AND year = '2018';



#12 (Null value)
#WHERE 조건문에서, 'is null' 붙이기 : 값이 null인 것만 추출 가능
#마찬가지로 'is not null' 붙이기 : 값이 null이 아닌 것만 추출 가능

SELECT name
FROM instructor
WHERE salary is null;


#null value 사용시 : unknown 상태 or 존재하지 않는 상태 

#사칙연산과 함께 사용시, 무조건 null이 됨 (블랙홀 처럼)
#5 + null = null


#WHERE 에서 논리 연산자와 null이 사용될 시, 'unknown' 상태가 추가됨
#false > unknown > true 와 같은 관계
#범위 크기로 생각해 보면 : true > unknown > false
#not unknown = unknown
#and, or, not에서 3가지가 사용됨에 따라 각 범위에 따른 규칙을 지키며 결과가 나옴

#WHERE에서 결과가 unknown으로 나오면, false로 취급함



