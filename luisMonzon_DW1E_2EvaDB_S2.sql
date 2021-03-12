-- 1 
select university_degree.nameUDegree 'Degree Name', count(students.codeUDegree) 'Student Number'
From university_degree
inner join students
on university_degree.codeUDegree = students.codeUDegree
where university_degree.nameUDegree = 'Matematicas' or university_degree.nameUDegree = 'Físicas' or university_degree.nameUDegree = 'Biología'
group by university_degree.nameUDegree;

-- 2
select nameStaff 'Student' , surnameStaff 'Surname' , phone 'Phone', position 'Position'
from staff
where codeCenter = (Select codeCenter from centers where nameCenter = 'Galeno');

-- 3
select nameStudent 'Students', surnameStudent 'Surname', codeUDegree 'Degree'
from students 
where codeUDegree in (Select codeUDegree from university_degree where nameUDegree = 'Fisicas' or nameUDegree = 'Biologia')
group by nameStudent
order by nameStudent desc;


-- 4
select uni.nameUDegree as 'Degree', group_concat(subjects.nameSubject) as 'Subjects'
from university_degree uni
inner join subjects_udegrees
on uni.codeUDegree = subjects_udegrees.codeUDegree
inner join subjects
on subjects.codeSubject = subjects_udegrees.codeSubject
where subjects_udegrees.codeUDegree in (Select codeUDegree from university_degree where nameUDegree = 'Matematicas' or nameUDegree = 'Literatura Hispánica')
group by uni.nameUDegree;

-- 5
select nameUDegree as 'Degree', codeCenter as 'codeCenter'
from university_degree
where codeCenter not like '%2' and codeCenter not like '%3' and codeCenter not like '%4'
group by nameUDegree;

-- 6
select count(centers.nameCenter)
from centers
where nameCenter != 'Rectorate';

-- 7
select count(students.codeStudent) as 'Student Number'
from students
where nameStudent like 'lc%a' or nameStudent like 'c%a' or nameStudent like 'm%a';

-- 8
select position as 'Staff', count(position)
from staff
where position in (select codePosition from positionlist where positionName = 'Decano' or positionName = 'Profesor' or positionName = 'Limpieza')
group by position;

-- 9
select uni.nameUDegree 'UDegree'  , centers.nameCenter 'Center'
from university_degree uni
inner join centers
on centers.codeCenter = uni.codeCenter
group by centers.codeCenter;

-- 10
select staff.nameStaff 'Staff', staff.surnameStaff 'Surname', centers.nameCenter 'Center'
from staff
inner join centers
on centers.codeCenter = staff.codeCenter
order by centers.nameCenter, staff.surnameStaff desc;

-- 11
select staff.nameStaff 'Name', staff.surnameStaff 'Surname' , staff.phone 'Phone' , positionlist.positionName 'Position'
from staff
inner join positionlist
on positionlist.codePosition = staff.position
order by staff.nameStaff desc , staff.surnameStaff desc;

-- 12
select students.codeStudent 'Code', students.nameStudent 'Name', students.surnameStudent 'Surname', students.dateOfBirth 'DateOfBirth'
from students
where dateOfBirth in (select min(dateOfBirth) from students union select max(dateOfBirth) from students);


-- 13
select nameStudent 'Name', address 'Address'
from students
where address in (select address from students where address != 'Ventilla 5');

-- 14
select students.nameStudent 'Name', students.dateOfBirth 'Date of Birth',  group_concat(nameSubject) 'Subjects'
from students
inner join subjects_udegrees
on subjects_udegrees.codeUDegree = students.codeUDegree
inner join subjects
on subjects.codeSubject = subjects_udegrees.codeSubject
where dateOfBirth in (select min(dateOfBirth) from students);


-- 15
select staff.codeStaff 'Code', staff.nameStaff 'Name', staff.surnameStaff 'Surname', positionlist.positionName 'Position'
from staff
inner join positionlist
on positionlist.codePosition = staff.position
where position in (select codePosition from positionlist where positionName = 'Administrativo');

-- 16 
select distinct centers.nameCenter 'Center without Cleaning staff'
from centers
where codeCenter not in (select staff.codeCenter from staff inner join positionlist on positionlist.codePosition = staff.position where positionlist.positionName = 'Limpieza');

-- 17
select *
from centers
where town not in (select town from centers where town = 'Madrid');

-- 18
select *, timestampdiff(YEAR, dateOfBirth, curdate()) Age
from students
where timestampdiff(YEAR, dateOfBirth, curdate()) > 25; 




-- 19
select distinct month(students.dateOfBirth) 'Months', group_concat(nameStudent) 'Names'
from students
group by month(dateOfBirth)
order by 1;


-- 20
select university_degree.nameUDegree 'University Degree', count(subjects_udegrees.codeSubject) 'Subject Number'
from university_degree
inner join subjects_udegrees
on subjects_udegrees.codeUDegree = university_degree.codeUDegree
group by university_degree.nameUDegree;

-- 21
select centers.nameCenter, staff.nameStaff
from centers
inner join staff
on staff.codeCenter = centers.codeCenter
where staff.codeStaff in (select codeStaff from staff where isnull(phone));

select staff.codeStaff, staff.nameStaff
from staff
where staff.phone is null and (staff.codeCenter like 'c004' or staff.codeCenter like 'c002');

-- 22

select *
from staff
where staff.codeCenter in (select staff.codeCenter from staff inner join centers on centers.codeCenter = staff.codeCenter where centers.nameCenter = 'Margarita Salas' and centers.nameCenter = 'Rey Pastor'); 


-- 23
select students.codeStudent 'Student Code', students.nameStudent 'Name', students.tuitionCost 'Tuition Cost'
from students
where tuitionCost < 1200;

-- 24


-- 25
Update students
set tuitionCost = (tuitionCost + tuitionCost* 0.5)
where tuitionCost < 1000;