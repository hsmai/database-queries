# SQL 3.3 Queries 실습

USE world;

#1 (select 'name' attribute from 'country' table)
SELECT name
FROM country;



#2 (select all attributes)
SELECT *
FROM country;



#3 (1열 테이블 만들기)
SELECT '437' AS FOO;



#4 (select시, 각 attribute에 포함되는 데이터들에 사칙연산 적용 가능)

#population attribute 속 데이터들을 1000으로 나누고, floor함수 적용
SELECT name, floor(population/1000)
FROM country;



#5 (select 시, 표시되는 table의 attribute 이름 rename 가능)
SELECT name, floor(population/1000) as Pop10k
FROM country;



#6 (where clause로 조건 설정 : 보통 attribute 단위를 다룸)
SELECT name
FROM country
WHERE continent = 'Aisa';



#7 (where에 작성하는 조건에 논리연산자 사용 가능)
SELECT name
FROM country
#아시아 대륙의 국가들 중, 인구 수가 5천만 이상인 국가만 표시
WHERE continent = 'Asia' AND population >= 50000000;



#8 (from clause 연습 : 두 테이블의 Cartesian Product 출력하기)
#모든 가능한 쌍을 출력
#속성 이름이 겹칠 시, 각 relation.속성 <- 이런식으로 자동 변경됨
SELECT *
FROM country, city;



#9 (Rename Operation)
#old-name as new-name
#select, from 두곳에서 사용 가능
#중간에 as 생략 가능 !

SELECT name AS country_name, population as pop
FROM country;


#Rename 사용 이유 : 간결함 확보 / 자가 비교 
#자가비교
#"아시아의 어떤 나라보다도 인구가 많은 나라들의 이름을 중복 없이 출력하라"
#(C1이 C2보다 인구 많고, C2는 Asia 국가인 경우)

SELECT DISTINCT C1.name
FROM country as C1, country as C2
WHERE C1.population > C2.population AND C2.continent = 'Asia';

#C1.population > C2.population → C1의 인구가 C2보다 많기만 하면 됨
#C2.continent = 'Asia' → C2는 아시아 국가만 선택됨




#10 (self-join Operation)
#연쇄법칙 처럼 적용됨
#SQL2 p.8 참고



#11 (String Operation)
#문자열 붙이기 : CONCAT(attribute1, attribute2)
#대,소문자 변경 : UPPER(attribute), LOWER(attribute)
#길이 구하기 : LENGTH(attribute) / CHAR_LENGTH('') 두가지 방식

SELECT UPPER(CONCAT(name, '-', continent)) AS country_info
FROM country;


#특정 문자 포함 여부로 데이터 찾기 : LIKE %, _

#국가 이름 중 S로 시작하는 국가들 출력
SELECT name
FROM country
WHERE name LIKE 'S%';

#국가 이름 중 anada로 끝나는 국가들 출력
SELECT name
FROM country
WHERE name LIKE '_anada';


#examples
#'Intro%' : Intro로 시작하는 데이터들
#'%Comp% : 문자열에 Comp를 포함하는 데이터들
#'_ana' : 4자리로 이루어져 있고, ana로 끝나는 데이터들
#'___' : 정확히 3개의 문자로 구성된 데이터들
#'___%' : 3개 이상의 문자로 구성된 데이터들


#escape 문자 : \ 앞에 오는 것을 문자화(특수 문자로 취급하지 않음)
#example : LIKE '100\%'



#12 (Ordering Operation)
#내림,올림차순 으로 출력 가능
#2개 이상의 속성들 정렬 가능
SELECT name, population, continent
FROM country
ORDER BY population desc, continent asc;



#13 (Between operator)
#WHERE 조건문에서 특정 범위에 있는 데이터만을 'between' operator로 추출 가능

SELECT name, population
FROM country
WHERE population BETWEEN 40000000 AND 50000000;

#튜플 부분집합 별로 비교 가능
SELECT *
FROM country
WHERE(continent, population) = ('Asia', 46844000);



#14 (Union Operation)
#합집합 연산과 동일

SELECT name, continent
FROM country
WHERE continent = 'Asia'

UNION

SELECT name, continent
FROM country
WHERE continent = 'Europe';

#UNION ALL : 합집합 연산 대신, 걍 중복 허용하면서 다 합침



#15 (Intersect Operation)
#교집합 연산과 동일

#엥 intersect 지원 안한다는데 ..?
#아시아 대륙의 국가들 중, 인구 수가 1억명 이상인 국가만 출력
/*
SELECT name
FROM country
WHERE continent = 'Asia'

INTERSECT

SELECT name
FROM country
WHERE population >= 100000000;
*/



#16 (Except Operation)
#차집합 연산과 동일

#엥 intersect 지원 안한다는데 ..?
#아시아 대륙의 국가들 중, 인구 수가 1억을 넘어가는 국가 제외하고 출력
/*
SELECT name
FROM country
WHERE continent = 'Asia'

EXCEPT

SELECT name
FROM country
WHERE population >= 100000000;
*/

# 중복 허용하려면, UNION / INTERSECT / EXCEPT 연산자 뒤에 all 붙이기

