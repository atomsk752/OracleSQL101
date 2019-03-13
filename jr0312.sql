CREATE TABLE TEMP (
 EMP_ID      NUMBER NOT NULL PRIMARY KEY,
 EMP_NAME    VARCHAR2(20) NOT NULL,
 BIRTH_DATE  DATE,
 DEPT_CODE   VARCHAR2(20) NOT NULL,
 EMP_TYPE    VARCHAR2(20),
 USE_YN      VARCHAR2(20) NOT NULL,
 TEL         VARCHAR2(20),
 HOBBY       VARCHAR2(30),
 SALARY      NUMBER,
 LEV         VARCHAR2(10)
);

CREATE TABLE TDEPT (
 DEPT_CODE   VARCHAR2(10) NOT NULL PRIMARY KEY,
 DEPT_NAME   VARCHAR2(30) NOT NULL,
 PARENT_DEPT VARCHAR2(10) NOT NULL,
 USE_YN      VARCHAR2(10) NOT NULL,
 AREA        VARCHAR2(20),
 BOSS_ID     NUMBER
);

INSERT INTO TEMP VALUES (19970101,'김길동',TO_DATE('19740125','YYYYMMDD'),'AA0001','정규','Y','','등산',100000000,'부장');
INSERT INTO TEMP VALUES (19960101,'홍길동',TO_DATE('19730322','YYYYMMDD'),'AB0001','정규','Y','','낚시',72000000,'과장');
INSERT INTO TEMP VALUES (19970201,'박문수',TO_DATE('19750415','YYYYMMDD'),'AC0001','정규','Y','','바둑',50000000,'과장');
INSERT INTO TEMP VALUES (19930331,'정도령',TO_DATE('19760525','YYYYMMDD'),'BA0001','정규','Y','','노래',70000000,'차장');
INSERT INTO TEMP VALUES (19950303,'이순신',TO_DATE('19730615','YYYYMMDD'),'BB0001','정규','Y','','',56000000,'대리');
INSERT INTO TEMP VALUES (19966102,'지문덕',TO_DATE('19720705','YYYYMMDD'),'BC0001','정규','Y','','',45000000,'과장');
INSERT INTO TEMP VALUES (19930402,'강감찬',TO_DATE('19720815','YYYYMMDD'),'CA0001','정규','Y','','',64000000,'차장');
INSERT INTO TEMP VALUES (19960303,'설까치',TO_DATE('19710925','YYYYMMDD'),'CB0001','정규','Y','','',35000000,'사원');
INSERT INTO TEMP VALUES (19970112,'연흥부',TO_DATE('19761105','YYYYMMDD'),'CC0001','정규','Y','','',45000000,'대리');
INSERT INTO TEMP VALUES (19960212,'배뱅이',TO_DATE('19721215','YYYYMMDD'),'CD0001','정규','Y','','',39000000,'과장');

INSERT INTO TDEPT VALUES ('AA0001','경영지원','AA0001','Y','서울',19940101);
INSERT INTO TDEPT VALUES ('AB0001','재무','AA0001','Y','서울',19960101);
INSERT INTO TDEPT VALUES ('AC0001','총무','AA0001','Y','서울',19970201);
INSERT INTO TDEPT VALUES ('BA0001','기술지원','BA0001','Y','인천',19930301);
INSERT INTO TDEPT VALUES ('BB0001','H/W지원','BA0001','Y','인천',19950303);
INSERT INTO TDEPT VALUES ('BC0001','S/W지원','BA0001','Y','인천',19966102);
INSERT INTO TDEPT VALUES ('CA0001','영업','CA0001','Y','본사',19930402);
INSERT INTO TDEPT VALUES ('CB0001','영업기획','CA0001','Y','본사',19950103);
INSERT INTO TDEPT VALUES ('CC0001','영업1','CA0001','Y','본사',19970112);
INSERT INTO TDEPT VALUES ('CD0001','영업2','CA0001','Y','본사',19960212);
--
COMMIT;


desc temp;

select EMP_NAME, round(salary/18, 2), round(salary*2/18, 2)
from temp;

select EMP_NAME, round(salary/18, 2)+100000, round(salary*2/18, 2)+200000
from temp;

select EMP_NAME, HOBBY
from temp
where HOBBY is not null;

select emp_name, nvl(hobby, '없음')
from temp;

select emp_name, nvl2(hobby, '있음', '없음')
from temp;

select emp_name, nvl(hobby, '등산')
from temp
where hobby is null;

select emp_id, temp.dept_code, dept_name
from temp, tdept
where temp.dept_code = tdept.dept_code;

select a.emp_id, a.emp_name, b.boss_id, c.emp_name
from temp a, tdept b, temp c
where b.dept_code = a.dept_code
and c.emp_id = b.boss_id;

select emp_id as 사번, emp_name as 성명
from temp;

select emp_name||'('||lev||')' 성명
from temp;

select emp_name||' '''||lev||'''' 성명
from temp;

select object_name, object_type
from user_objects;

/* select 'drop'||object_name||''||object_type||';'
from user_objects 유저가 갖고 있는 테이블 전체 삭제*/

/*중간에 탭을 넣어주면 엑셀에서 사용하기 좋은 형태가 된다, 그냥 익스포트 하는게 나은거 같다*/
select emp_id||'    '||emp_name||'  '||lev
from temp;

select ''''||emp_name||''''||''''||birth_date||''''
from temp;

select emp_id, emp_name
from temp
where emp_id>0;

select index_name, column_name
from user_ind_columns;

select emp_id, emp_name, hobby
from temp
where lev = '과장' and hobby is not null;

select lev, emp_id, emp_name
from temp
order by 1 desc,2;

select emp_id, emp_name, dept_code
from temp
where dept_code like '%A%';

select emp_id, emp_name, dept_code
from temp
where dept_code like '_A____';

select emp_id, emp_name
from temp
where emp_id between 19970000 and 19979999;

select emp_id, emp_name
from temp
where emp_name between 'ㄱ' and '나';

select emp_id, emp_name
from temp
where emp_name in('김길동', '강감찬');

select lev, max(salary) maxsal
from temp
group by lev;

select area, min(boss_id) minid
from tdept
group by area
order by 2;

select lev, avg(salary) avgsal
from temp
group by lev
having avg(salary) > 500000;

select lev, max(emp_id)
from temp
group by lev
having max(emp_id) like '1997%';