# database-queries

자세한 실습 쿼리 전문 및 사용한 데이터는 <br>
각 Part 폴더 내에서 확인할 수 있습니다.


# University & World DB | SQL Core Operators Practice

관계형 데이터베이스의 기본 연산을 두 개의 샘플 DB(`UNIVERSITY`, `world`)로 실습하며 정리한 레포입니다.  
`SELECT / WHERE / ORDER BY / (self) JOIN / 문자열 연산 / 집합 연산(UNION)` 등 **SQL의 핵심 문법을 “쿼리 단위로” 익히는 것**이 목표입니다.

[Goal]
- `SELECT`로 필요한 컬럼/튜플을 조회하고 결과 형태를 제어
- `WHERE` 조건 + 논리 연산자로 필터링
- `AS`(alias)로 컬럼/테이블 이름을 명확하게 관리
- Cartesian product & self-join 패턴 이해
- 문자열 처리(`CONCAT`, `UPPER/LOWER`, `LIKE`) 및 범위/정렬(`BETWEEN`, `ORDER BY`)
- `UNION / UNION ALL`로 집합 연산 이해
- `NULL`이 논리/연산에서 어떻게 동작하는지 확인

---

## 주요 구현 사항

- **Two DB practice**
  - `USE UNIVERSITY;` → `instructor`, `teaches`, `section`
  - `USE world;` → `country`, `city`
- **중복 제어**
  - `DISTINCT` vs `ALL` 차이 확인
- **출력값 변형**
  - 숫자 연산 + 함수 적용 (`FLOOR(salary/12)`, `FLOOR(population/1000)`)
  - alias로 의미 있는 컬럼명 생성 (`AS monthly_salary`, `AS Pop10k`)
- **조건 필터링**
  - `WHERE` + `AND` 조합
  - 문자열 패턴 검색 `LIKE '%ing%'`, `LIKE 'S%'`, `LIKE '_anada'`
- **FROM / JOIN 감각 익히기**
  - Cartesian product + 키 매칭으로 join 효과 만들기
  - self-join으로 “특정 집합과 비교”하는 질의 패턴 실습
- **정렬 / 범위 / 집합 연산**
  - `ORDER BY ... ASC/DESC`
  - `BETWEEN a AND b`
  - `UNION` (중복 제거) / `UNION ALL` (중복 허용)
- **NULL semantics**
  - `IS NULL`로 NULL 필터링
  - NULL 연산/3-valued logic(unknown)로 인해 `WHERE`에서 제외되는 동작 정리

---

## 실습 구성

### [Part A] UNIVERSITY DB Queries
- **중복 제거**
  - `SELECT DISTINCT dept_name FROM instructor;`
- **연봉 → 월급 변환 + rename**
  - `SELECT ID, name, FLOOR(salary/12) AS monthly_salary FROM instructor;`
- **조건 필터링**
  - `WHERE dept_name='Comp. Sci.' AND salary > 70000`
- **Cartesian product & join-like filtering**
  - `FROM instructor, teaches`
  - `WHERE instructor.ID = teaches.ID`
- **Self-Join 예시 (비교 기반 질의)**
  - `instructor AS A, instructor AS B` 형태로 비교
- **NULL 처리**
  - `WHERE salary IS NULL`

---

### [Part B] WORLD DB Queries
- **기본 조회 / 상수 테이블**
  - `SELECT name FROM country;`
  - `SELECT '437' AS FOO;`
- **인구 스케일 변환**
  - `SELECT name, FLOOR(population/1000) AS Pop10k FROM country;`
- **조건 필터링**
  - `continent='Asia' AND population >= 50000000`
  - `population BETWEEN 40000000 AND 50000000`
- **Self-Join 패턴 (자가 비교)**
  - “아시아 국가들과 비교해서 더 큰 조건” 등 비교 기반 질의
- **문자열 연산**
  - `UPPER(CONCAT(name,'-',continent)) AS country_info`
  - `LIKE` 패턴 매칭 (`'S%'`, `'_anada'`)
- **정렬**
  - `ORDER BY population DESC, continent ASC`
- **집합 연산**
  - `Asia UNION Europe`
  - `UNION ALL` 차이도 함께 정리

> Note: MySQL에서는 `INTERSECT`, `EXCEPT`를 기본 지원하지 않아 실습 코드에서는 주석 처리했습니다.

---
## 실행 환경

MySQL

---

## Repository Structure

```text
.
├─ PartA/
│  ├─ queries/
│  │  └─ Univ dataset Queries.sql
│  └─ datasets/
│     ├─ DDL.sql
│     └─ smallRelationsInsertFile.sql
│
└─ PartB/
   ├─ queries/
   │  └─ World dataset Queries.sql
   └─ datasets/
      └─ world.sql
