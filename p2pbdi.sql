DROP TABLE tb_student_predictions

CREATE TABLE tb_student_predictions(
	STUDENTID VARCHAR PRIMARY KEY,
	SALARY INT,
	MOTHER_EDU INT,
	FATHER_EDU INT,
	PREP_STUDY INT,
	PREP_EXAM INT,
	GRADE INT
);

SELECT * FROM tb_student_predictions


--2
CREATE OR REPLACE PROCEDURE aprovado_pais_phd(OUT num_aprovados INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COUNT(*)
    INTO num_aprovados
    FROM tb_student_predictions
    WHERE FATHER_EDU = 6 AND MOTHER_EDU = 6 AND GRADE > 0;
END;
$$;

--
--3
CREATE OR REPLACE PROCEDURE sp_alunos_aprovados_estudam_sozinhos(
    OUT v_num_alunos_aprovados INT
) LANGUAGE plpgsql
AS $$
BEGIN
    v_num_alunos_aprovados := 0;
    SELECT COUNT(*)
    INTO v_num_alunos_aprovados
    FROM tb_student_predictions
    WHERE prep_exam = 1  -- Estuda sozinho
    AND grade > 0;       -- Aprovado


    RAISE NOTICE 'Número de alunos aprovados que estudam sozinhos: %', v_num_alunos_aprovados;

END;
$$;

---Uso

DO $$
DECLARE
    resultado INT;
BEGIN
    CALL sp_alunos_aprovados_estudam_sozinhos(resultado);
    RAISE NOTICE 'Número total de alunos aprovados que estudam sozinhos: %', resultado;
END;
$$;


---4

CREATE OR REPLACE FUNCTION salario_vs_estudos()
RETURNS INT AS $$
DECLARE
    num_alunos INT;
BEGIN
    SELECT COUNT(*)
    INTO num_alunos
    FROM tb_student_predictions
    WHERE SALARY = 5 AND PREP_EXAM = 2;
    
    RETURN num_alunos;
END;
$$ LANGUAGE plpgsql;

-- Uso
SELECT salario_vs_estudos() AS num_alunos;
