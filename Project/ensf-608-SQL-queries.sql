# Group
# Matt De Filippo (30202259)
# Gi-E Thang (30031722)
# Jeremy Sugimoto (30232526)
# Shad Sajid (30021753)


# Question 1
# Describe each table and show triggers.
USE cirquedusoleil;
DESCRIBE PERFORMER;
DESCRIBE SHOWS;
DESCRIBE PERFORMS_IN;
DESCRIBE VENUE;
DESCRIBE HOST;
DESCRIBE EMERGENCY_CONTACT;
DESCRIBE MUSICIAN;
DESCRIBE INSTRUMENTS;
DESCRIBE AERIALIST;
DESCRIBE ENTERTAINER;
DESCRIBE MEDICATIONS;
SHOW TRIGGERS;

# Question 2
# List all Performers.
SELECT * FROM PERFORMER;

# Question 3
# SHow Performers listed in descending order by Birthdate.
SELECT * FROM performer ORDER BY Birthdate DESC;

# Question 4
# Show all Performers with First Name and Last Name who are Entertainers.
SELECT PerformerID, FName, LName FROM PERFORMER
WHERE PerformerID IN (
    SELECT PerformerID
    FROM Entertainer
);

# Question 5
# Show all Performers in the Performance Alegeria.
SELECT Performer.PerformerID, Performer.FName, Performer.LName, Performs_In.Show_name
FROM Performer 
JOIN Performs_In ON Performer.PerformerID = Performs_In.PerformerID
WHERE Performs_In.Show_name = 'Alegeria';

# Question 6
# Update the Understudy of performer 2100
UPDATE PERFORMER
SET UnderstudyID = '3535'
WHERE PerformerID = 2100;

# Question 7
# Delete Performer with PerformerID 9999.
DELETE FROM performer WHERE PerformerID = 9999;



