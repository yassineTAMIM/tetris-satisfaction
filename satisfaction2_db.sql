-- Create database
CREATE DATABASE IF NOT EXISTS satisfaction_db;
USE satisfaction_db;

-- Create questions table
CREATE TABLE questions (
    id int NOT NULL AUTO_INCREMENT,
    question_text text NOT NULL,
    question_type enum('rating','stars','choice','text') NOT NULL,
    max_value int DEFAULT NULL,
    class VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Create surveys table
CREATE TABLE surveys (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    created_at datetime DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Create responses table
CREATE TABLE responses (
    id int NOT NULL AUTO_INCREMENT,
    survey_id int NOT NULL,
    question_id int NOT NULL,
    answer text NOT NULL,
    optional_answer TEXT DEFAULT NULL,
    nlp_analysis JSON DEFAULT NULL,
    responded_at datetime DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY survey_id (survey_id),
    KEY question_id (question_id),
    CONSTRAINT responses_ibfk_1 FOREIGN KEY (survey_id) REFERENCES surveys (id) ON DELETE CASCADE,
    CONSTRAINT responses_ibfk_2 FOREIGN KEY (question_id) REFERENCES questions (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Create low_satisfaction_responses table
CREATE TABLE low_satisfaction_responses (
    id int NOT NULL AUTO_INCREMENT,
    survey_id int NOT NULL,
    name varchar(255) NOT NULL,
    phone varchar(20) NOT NULL,
    email varchar(255) NOT NULL,
    created_at datetime DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY survey_id (survey_id),
    CONSTRAINT low_satisfaction_responses_ibfk_1 FOREIGN KEY (survey_id) REFERENCES surveys (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE question_options (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT,
    option_text VARCHAR(255),
    option_order INT,
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

-- Insert questions
INSERT INTO questions (id, question_text, question_type, max_value, class) VALUES
(1, "Recommanderiez-vous notre service à d'autres courtiers ?", 'rating', 10, 'satisfaction'),
(2, "Quel est votre niveau de satisfaction globale concernant nos services ?", 'stars', 5, 'satisfaction'),
(3, "Comment évaluez-vous la rapidité de nos réponses à vos demandes ?", 'choice', NULL, 'performance'),
(4, "Les solutions d'assurance proposées correspondent-elles à vos besoins ?", 'choice', NULL, 'adequacy'),
(5, "Comment jugez-vous la clarté des informations fournies ?", 'choice', NULL, 'clarity'),
(6, "Le processus de soumission des dossiers est-il simple à utiliser ?", 'choice', NULL, 'usability'),
(7, "Les délais de traitement des dossiers sont-ils respectés ?", 'choice', NULL, 'performance'),
(8, "Comment évaluez-vous le support technique fourni ?", 'choice', NULL, 'support'),
(9, "La tarification proposée est-elle compétitive ?", 'choice', NULL, 'pricing'),
(10, "Avez-vous des suggestions d'amélioration ou des commentaires ?", 'text', NULL, 'feedback');