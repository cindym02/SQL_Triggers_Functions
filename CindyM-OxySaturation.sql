CREATE TABLE CindyM_Data (
	id INT AUTO_INCREMENT PRIMARY KEY,
	patientUID INT NOT NULL,
	lastname VARCHAR(40) NOT NULL,
	oxygen_saturation INT NOT NULL
);

INSERT INTO CindyM_Data (patientUID, lastname, oxygen_saturation)
VALUES (32289, 'M', '90');

delimiter $$
CREATE TRIGGER oxysat BEFORE INSERT ON CindyM_Data
FOR EACH ROW
BEGIN
	IF NEW.oxygen_saturation <=50 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERROR: Oxygen saturation MUST BE ABOVE 50 mm Hg!';
	END IF;
END; $$
delimiter ;

DELIMITER $$ 
CREATE FUNCTION medicationcosts(cost DECIMAL(10,2))  
RETURNS VARCHAR(20) 
DETERMINISTIC 
BEGIN 
	DECLARE drugCost VARCHAR(20);  
    IF cost > 300 THEN 
		SET drugCost = ‘expensive’; 
	ELSEIF (cost >= 20 AND credit <= 300) THEN 
		SET drugCost = 'average';  
    ELSEIF cost < 20 THEN 
		SET drugCost = 'affordable';  
    END IF; 
    RETURN (drugCost);
END$$
DELIMITER $$ 









