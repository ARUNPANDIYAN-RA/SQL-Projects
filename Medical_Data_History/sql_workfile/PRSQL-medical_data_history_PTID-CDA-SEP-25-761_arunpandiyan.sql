SHOW databases;
USE project_medical_data_history;
SHOW tables;
SELECT * FROM admissions;
SELECT count(*) from admissions;   #total number of admisssions
SELECT * FROM doctors LIMIT 5;
SELECT count(*) from doctors;
select * FROM patients;
select count(*) from patients;
select * FROM province_names LIMIT 5;
select count(*) FROM province_names;
DESCRIBE admissions;
DESCRIBE doctors;
DESCRIBE patients;
DESCRIBE province_names;
SELECT patient_id, admission_date, discharge_date, diagnosis, attending_doctor_id as doctor_id from admissions;
SELECT count(*) FROM admissions;
SELECT * FROM doctors LIMIT 5;
SELECT a.patient_id, a.admission_date, a.discharge_date, a.diagnosis, a.attending_doctor_id FROM admissions a
JOIN doctors d ON a.attending_doctor_id = d.doctor_id;
select patient_id, admission_date, discharge_date, diagnosis, attending_doctor_id as doctor_id from admissions;
SELECT first_name, last_name, gender
FROM patients
WHERE gender = 'M';  #first name, last name, and gender of patients who's gender is 'M'
SELECT first_name, last_name, gender
FROM patients
WHERE gender = 'F';
SELECT first_name, last_name
FROM patients
WHERE allergies IS NULL OR allergies = '';   #first name and last name of patients who does not have allergies
SELECT first_name, last_name
FROM patients
WHERE weight BETWEEN 100 AND 120;   #first name and last name of patients that weight within the range of 100 to 120 (inclusive)
SELECT first_name
FROM patients
WHERE first_name LIKE "C%";    #first name of patients that start with the letter 'C'
SELECT patient_id, first_name, last_name, birth_date, gender, height, weight, province_id, city,
CASE WHEN allergies IS NULL THEN 'NKA' ELSE allergies END AS allergies
FROM patients;   #Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM patients;   #Show first name and last name concatenated into one column to show their full name
SELECT p.first_name, p.last_name, pr.province_name
FROM patients p
join province_names pr on p.province_id=pr.province_id;   #first name, last name, and the full province name of each patient
SELECT COUNT(*) AS patient_count
FROM patients
WHERE YEAR(birth_date) = 2010;   #how many patients have a birth_date with 2010 as the birth year
SELECT first_name, last_name, height
FROM patients
WHERE height = (SELECT MAX(height) FROM patients);  #frist_name, last_name and height of the patients with the greatest height
SELECT * FROM patients
WHERE patient_id IN (1,45,534,879,1000);  #all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
SELECT *
FROM admissions
WHERE DATE(admission_date) = DATE(discharge_date);  #all the columns from admissions where the patient was admitted and discharged on the same day.
SELECT count(*) AS total_count_in_id_579
FROM admissions
WHERE patient_id=579;  #the total number of admissions for patient_id 579
SELECT DISTINCT city
FROM patients
WHERE province_id='NS';  #unique cities that are in province_id 'NS'
SELECT first_name, last_name, birth_date
FROM patients
WHERE height > 160 AND weight > 70;   #first_name, last name and birth date of patients who have height more than 160 and weight more than 70
SELECT DISTINCT YEAR(birth_date) AS birth_year
FROM patients
ORDER BY birth_year ASC;  #unique birth years from patients and order them by ascending
SELECT COUNT(*) AS unique_first_name_count
FROM (
    SELECT first_name
    FROM patients
    GROUP BY first_name
    HAVING COUNT(*) = 1
) AS unique_names;    #unique first names from the patients table which only occurs once in the list and the count of it
SELECT patient_id, first_name
FROM patients
WHERE first_name LIKE 's%s' AND LENGTH(first_name) >= 6;   #patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long
SELECT p.patient_id, p.first_name, p.last_name
FROM patients p
join admissions a ON p.patient_id = a.patient_id
WHERE a.diagnosis = 'Dementia';  #patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'
SELECT first_name
FROM patients
ORDER BY LENGTH(first_name), first_name;  #patient's first_name. Order the list by the length of each name and then by alphbetically.
SELECT 
    SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS male_count,
    SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS female_count
FROM patients;   #the total amount of male patients and the total amount of female patients in the patients table in the same row
SELECT patient_id, diagnosis
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1;   #patient_id, diagnosis from admissions and patients admitted multiple times for the same diagnosis
SELECT city, COUNT(*) AS patient_count
FROM patients
GROUP BY city
ORDER BY patient_count DESC, city ASC;   #the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.
SELECT first_name, last_name, 'Patient' AS role
FROM patients
UNION
SELECT first_name, last_name, 'Doctor' AS role
FROM doctors;   #Show first name, last name and role of every person that is either patient or doctor.    The roles are either "Patient" or "Doctor"
SELECT allergies, COUNT(*) AS allergy_count
FROM patients
WHERE allergies IS NOT NULL AND allergies != 'NKA'
GROUP BY allergies
ORDER BY allergy_count DESC;    #all allergies ordered by popularity. Remove NULL values from query
SELECT first_name, last_name, birth_date
FROM patients
WHERE YEAR(birth_date) BETWEEN 1970 AND 1979
ORDER BY birth_date ASC;   #all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort by earliest birth_date
SELECT CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS full_name
FROM patients
ORDER BY first_name DESC;  #each patient's full name in a single column. Last_name in all upper letters first, then first_name in all lower case letters, separated by a comma. Order by first_name descending
SELECT province_id, SUM(height) AS total_height
FROM patients
GROUP BY province_id
HAVING SUM(height) >= 7000;    #the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000
SELECT MAX(weight) - MIN(weight) AS weight_difference
FROM patients
WHERE last_name = 'Maroni';   #the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
SELECT DAY(admission_date) AS day_of_month, COUNT(*) AS admission_count
FROM admissions
GROUP BY DAY(admission_date)
ORDER BY admission_count DESC;   #all days of the month (1-31) and how many admission_dates occurred on that day. Sort by most admissions to least
SELECT FLOOR(weight / 10) * 10 AS weight_group, COUNT(*) AS patient_count
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;   #patients grouped into weight groups (e.g., 100-109, 110-119). Show total patients in each group, ordered by weight group descending
SELECT patient_id, weight, height,
CASE WHEN weight / POWER(height / 100, 2) >= 30 THEN 1 ELSE 0 END AS isObese
FROM patients;   #patient_id, weight, height, isObese from the patients table. Display isObese as a boolean 0 or 1. Obese is defined as weight(kg)/(height(m). Weight is in units kg. Height is in units cm.
SELECT p.patient_id, p.first_name, p.last_name, d.specialty
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy' AND d.first_name = 'Lisa';   #patient_id, first_name, last_name, and attending doctor's specialty for patients with diagnosis 'Epilepsy' and doctor's first name 'Lisa'
SELECT patient_id, admission_date, discharge_date, diagnosis, attending_doctor_id as doctor_id FROM admissions LIMIT 5;

