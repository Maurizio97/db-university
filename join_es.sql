/* GROUP BY

1. Contare quanti iscritti ci sono stati ogni anno
2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
3. Calcolare la media dei voti di ogni appello d'esame
4. Contare quanti corsi di laurea ci sono per ogni dipartimento

JOIN

1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
2. Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze
3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
4. Selezionare tutti gli studenti con relativo corso di laurea e relativo dipartimento, 
    in ordine alfabetico per cognome e nome
5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)

7. BONUS: Selezionare per ogni studente quanti tentativi d'esame ha sostenuto per
superare ciascuno dei suoi esami


_________________________________________________________________________________________________________________ */

/* GROP BY */

-- 1.
SELECT YEAR(enrolment_date), COUNT(YEAR(enrolment_date))
FROM students
GROUP BY YEAR(enrolment_date);


-- 2.
SELECT office_address, COUNT(office_address)
FROM teachers
GROUP BY office_address
ORDER BY COUNT(office_address);

-- 3
SELECT exam_id ,ROUND(AVG(vote), 1) 
FROM exam_student
GROUP BY exam_id;

-- 4
SELECT department_id, COUNT(department_id)
FROM degrees
GROUP BY department_id;

/* __________________________________________________________________________________________________________________ */

-- JOIN

-- 1.
SELECT *
FROM students
    INNER JOIN degrees
    ON students.degree_id = degrees.id
WHERE degrees.name LIKE 'Corso di Laurea in Economia';

-- 2
SELECT * 
FROM departments
    JOIN degrees
    ON departments.id = degrees.departement_id
WHERE departments.name LIKE 'Dipartimento di Neuroscienze';

-- 3
SELECT *
FROM teachers
    JOIN course_teacher
        ON teachers.id = course_teacher.teacher_id
    JOIN courses
        ON course_teacher.course_id = courses.id
WHERE teachers.id=44;

-- 4
SELECT *
FROM students
    JOIN degrees
        ON students.degree_id = degrees.id
    JOIN departments
        ON degrees.department_id = departments.id
ORDER BY students.surname, students.name;

-- 5
SELECT *
FROM degrees 
    JOIN courses 
        ON degrees.id = courses.degree_id
    JOIN course_teacher
        ON courses.id = course_teacher.course_id
    JOIN teachers 
        ON course_teacher.teacher_id = teachers.id
ORDER BY degrees.name;

-- 6
SELECT *
FROM teachers
    JOIN course_teacher
        ON teachers.id = course_teacher.teacher_id
    JOIN courses
        ON courses.id = course_teacher.course_id
    JOIN degrees
        ON degrees.id = courses.degree_id
    JOIN departments
        ON departments.id = degrees.department_id
WHERE departments.name LIKE 'Dipartimento di Matematica';

-- 7
SELECT *
  FROM students 
    JOIN exam_student 
        ON students.id = exam_student.student_id 
    JOIN exams 
        ON exams.id = exam_student.exam_id
    JOIN courses
        ON exams.course_id = courses.id
