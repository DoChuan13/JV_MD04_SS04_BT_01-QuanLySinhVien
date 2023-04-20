CREATE DATABASE QuanLySinhVien;
USE QuanLySinhVien;
CREATE TABLE Class
(
    ClassID   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME    NOT NULL,
    Status    BIT
);
CREATE TABLE Student
(
    StudentId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address     VARCHAR(50),
    Phone       VARCHAR(20),
    Status      BIT,
    ClassId     INT         NOT NULL,
    FOREIGN KEY (ClassId) REFERENCES Class (ClassID)
);
CREATE TABLE Subject
(
    SubId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit  TINYINT     NOT NULL DEFAULT 1 CHECK ( Credit >= 1 ),
    Status  BIT                  DEFAULT 1
);

CREATE TABLE Mark
(
    MarkId    INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubId     INT NOT NULL,
    StudentId INT NOT NULL,
    Mark      FLOAT   DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId),
    FOREIGN KEY (SubId) REFERENCES Subject (SubId),
    FOREIGN KEY (StudentId) REFERENCES Student (StudentId)
);


#Add value in Class
INSERT INTO Class
VALUES (1, 'A1', '2008-12-20', 1);
INSERT INTO Class
VALUES (2, 'A2', '2008-12-22', 1);
INSERT INTO Class
VALUES (3, 'B3', current_date, 0);

#Add value in Student
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
    VALUES ('Hung', 'Ha Noi', '0912113113', 1, 1);
INSERT INTO Student (StudentName, Address, Status, ClassId)
VALUES ('Hoa', 'Hai phong', 1, 1);
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Manh', 'HCM', '0123123123', 0, 2);
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('An', 'HCM', '0123123123', 1, 2);

#Add value in Subject
INSERT INTO Subject
VALUES (1, 'Toan', 5, 1),
       (2, 'Ly', 6, 1),
       (3, 'Hoa', 5, 1),
       (4, 'Van', 10, 1),
       (5, 'Anh', 10, 1);

#Add value in Mark
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES (1, 1, 8, 1),
       (1, 2, 10, 2),
       (2, 3, 12, 1),
        (2, 4, 12, 1),
        (1, 4, 15, 1);

-- Exercise 03
SELECT * FROM Student WHERE StudentName LIKE "h%";
SELECT * FROM CLASS WHERE  MONTH(StartDate) >=  12;
SELECT * FROM Subject WHERE Credit BETWEEN 3 AND 5;
UPDATE Student SET ClassId = 2 WHERE StudentName = "Hung";

SELECT Student.StudentId, Student.StudentName, Mark.Mark, Subject.SubName AS Subject 
FROM Mark 
    INNER JOIN Student ON Mark.StudentId = Student.StudentId
    INNER JOIN Subject ON Mark.SubId = Subject.SubId
ORDER BY Mark DESC, StudentName ASC;

SELECT * FROM Class;
SELECT * FROM Mark;
SELECT * FROM Student;
SELECT * FROM Subject;


-- Exercise 04
-- Show Subject With Max Mark
SELECT Subject.*, Mark.Mark AS "Max Point"
FROM Mark
    JOIN Subject ON Mark.SubId = Subject.SubID
    WHERE Mark.Mark = (SELECT max(Mark) FROM Mark);

-- Show Subject With Max Credit
SELECT * FROM Subject WHERE Credit = (SELECT  max(Credit) FROM Subject);

-- Show Student List and AVG DESC
SELECT Student.*, AVG(Mark.Mark) AS AVG
FROM Mark
    JOIN Student ON Mark.StudentId = Student.StudentId
GROUP BY Mark.StudentId
ORDER BY AVG(Mark.Mark) DESC;