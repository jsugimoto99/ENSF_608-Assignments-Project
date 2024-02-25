# Question 1
SELECT competitor.Fname, competitor.LName, teacher.StudioName
FROM competitor
JOIN teacher ON competitor.TeacherID = teacher.TeacherID;

# Question 2
SELECT teacher.StudioName, COUNT(competitor.CompetitorID) AS StudentCount
FROM teacher
LEFT JOIN competitor ON teacher.TeacherID = competitor.TeacherID
GROUP BY teacher.StudioName;

# Question 3
SELECT studio.Name, COUNT(teacher.TeacherID) AS TeacherCount
FROM studio
LEFT JOIN teacher ON studio.Name = teacher.StudioName
GROUP BY studio.Name;

# Question 4
SELECT DISTINCT teacher.LName
FROM teacher
Join competitor ON teacher.TeacherID = competitor.TeacherID
GROUP BY teacher.LName
HAVING COUNT(DISTINCT competitor.CompetitorID) > 1;

# Question 5
SELECT competitor.Fname, competitor.LName, composition.Title
FROM competitor
JOIN performance ON competitor.CompetitorID = performance.CompetitorID
JOIN composition ON performance.MusicID = composition.MusicID
WHERE composition.Genre = 'Romantic';

# Question 6
SELECT composition.Title, GROUP_CONCAT( DISTINCT performance.categoryID) AS AssociatedCategories
FROM composition
LEFT JOIN performance ON composition.MusicID = performance.MusicID
GROUP BY composition.MusicID;

# Question 7
CREATE VIEW SCORE_ANALYSIS AS
SELECT competitor.CompetitorID, competitor.Age, performance.Score
FROM competitor
LEFT JOIN performance ON competitor.CompetitorID = performance.CompetitorID;

# Question 8
SELECT *  FROM competition.score_analysis Order BY Score DESC;

# Question 9
SELECT
  MAX(Score) AS highest_score,
  MIN(Score) AS lowest_score,
  AVG(Score) AS average_score
FROM SCORE_ANALYSIS;

# Question 10
ALTER TABLE composition
ADD COLUMN Copyright VARCHAR(15) DEFAULT "SOCAN";
SELECT* FROM composition;

# Question 11
Select competitor.CompetitorID, competitor.Age, category.CategoryID
FROM competitor
JOIN performance ON competitor.CompetitorID = performance.CompetitorID
JOIN category ON performance.CategoryID = category.CategoryID
WHERE NOT EXISTS(
SELECT *
FROM category
WHERE performance.CategoryID = category.CategoryID
AND competitor.Age BETWEEN category.AgeMin AND category.AgeMax
);

# Question 12
ALTER TABLE competitor
ADD CONSTRAINT CheckAge
CHECK (Age >= 5 AND Age <= 18);

# Question 13
UPDATE studio
SET Name = 'Harmony Studio'
Where Name = 'Harmony Inc.';
	# When The PK 'Name' of the Studio table is changed all references of that PK are 
    # changed as well for example the FK 'Studio Name' will also be updated accordingly. 
    
# Question 14
DELETE FROM COMPOSITION WHERE Composer = 'Beethoven';
	# The Error message displayed "Error Code: 1175" states that because the composition table is
    # using safe update mode, the table cannot be updated without a WHERE that uses a KEY column
    # This mode can be disabled under the preferences tab which would allow the deletion of aspects
    # of a table without a KEY in the WHERE statement.

# Question 15
CREATE TRIGGER Certification # Create Trigger named Certification on the teacher table
BEFORE UPDATE ON TEACHER FOR EACH ROW # Trigger will activate before an update operation on teacher
SIGNAL SQLSTATE '45000' # Signal an error with SQLSTATE '45000' which means “unhandled user-defined exception.”
SET MESSAGE_TEXT = 'Proof of certification must be provided to the main 
office.'; # Specified Error message


