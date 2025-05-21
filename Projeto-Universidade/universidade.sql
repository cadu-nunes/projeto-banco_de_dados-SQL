-- CRIAÇÃO DO BANCO DE DADOS
CREATE DATABASE Universidade;
GO

USE Universidade;
GO

-- TABELA DEPARTAMENTO: armazena os departamentos acadêmicos
CREATE TABLE Departamento (
 cod_departamento INT PRIMARY KEY IDENTITY(1,1), -- chave primária auto-incrementável
 nome_departamento VARCHAR(255) NOT NULL -- nome do departamento
);

-- TABELA ENDERECO: armazena endereços genéricos para alunos e professores
CREATE TABLE Endereco (
 cod_endereco INT PRIMARY KEY IDENTITY(1,1),
 nome_rua VARCHAR(255) NOT NULL,
 numero INT NOT NULL,
 complemento VARCHAR(50),
 bairro VARCHAR(100) NOT NULL,
 cidade VARCHAR(100) NOT NULL,
 estado VARCHAR(100) NOT NULL,
 cep VARCHAR(10) NOT NULL
);

-- TABELA CURSO: armazena os cursos da universidade
CREATE TABLE Curso (
 cod_curso INT PRIMARY KEY IDENTITY(1,1),
 nome_curso VARCHAR(255) NOT NULL,
 tipo VARCHAR(255) NOT NULL, -- Bacharelado, Licenciatura, Tecnólogo
 duracao_meses INT NOT NULL,
 cod_departamento INT NOT NULL,
 turno VARCHAR(50) NOT NULL,
 carga_horaria_total INT NOT NULL,
 modalidade VARCHAR(50) NOT NULL,
 FOREIGN KEY (cod_departamento) REFERENCES Departamento(cod_departamento)
);

-- TABELA DISCIPLINA: armazena as disciplinas oferecidas
CREATE TABLE Disciplina (
 cod_disciplina INT PRIMARY KEY IDENTITY(1,1),
 nome_disciplina VARCHAR(255) NOT NULL,
 ementa TEXT NOT NULL,
 cod_departamento INT NOT NULL,
 carga_horaria_total INT NOT NULL,
 FOREIGN KEY (cod_departamento) REFERENCES Departamento(cod_departamento)
);

-- Associativa CURSO_DISCIPLINA: define quais disciplinas pertencem a quais cursos
CREATE TABLE Curso_Disciplina (
 cod_curso INT NOT NULL,
 cod_disciplina INT NOT NULL,
 tipo_disciplina VARCHAR(20) NOT NULL, -- obrigatória, optativa
 PRIMARY KEY (cod_curso, cod_disciplina),
 FOREIGN KEY (cod_curso) REFERENCES Curso(cod_curso),
 FOREIGN KEY (cod_disciplina) REFERENCES Disciplina(cod_disciplina)
);

-- Pré-requisitos de disciplinas
CREATE TABLE Disciplina_PreRequisito (
 cod_disciplina INT NOT NULL,
 cod_pre_requisito INT NOT NULL,
 PRIMARY KEY (cod_disciplina, cod_pre_requisito),
 FOREIGN KEY (cod_disciplina) REFERENCES Disciplina(cod_disciplina),
 FOREIGN KEY (cod_pre_requisito) REFERENCES Disciplina(cod_disciplina)
);

-- ALUNO: cadastro completo dos alunos
CREATE TABLE Aluno (
 ra_aluno INT PRIMARY KEY,
 nome_aluno VARCHAR(255) NOT NULL,
 sobrenome_aluno VARCHAR(255) NOT NULL,
 data_nascimento DATE NOT NULL,
 identificacao_genero VARCHAR(50),
 cpf VARCHAR(14) NOT NULL UNIQUE,
 rg VARCHAR(20) NOT NULL UNIQUE,
 nacionalidade VARCHAR(100) NOT NULL,
 estado_civil VARCHAR(50) NOT NULL,
 naturalidade VARCHAR(100) NOT NULL,
 deficiencia VARCHAR(255) NOT NULL,
 data_ingresso DATE NOT NULL,
 email_pessoal VARCHAR(255),
 email_corporativo VARCHAR(255),
 status_aluno VARCHAR(50) NOT NULL,
 nome_mae VARCHAR(255) NOT NULL,
 nome_pai VARCHAR(255),
 cod_endereco INT NOT NULL,
 cod_curso INT NOT NULL,
 FOREIGN KEY (cod_endereco) REFERENCES Endereco(cod_endereco),
 FOREIGN KEY (cod_curso) REFERENCES Curso(cod_curso)
);

-- PROFESSOR: cadastro completo dos professores
CREATE TABLE Professor (
 cod_professor INT PRIMARY KEY IDENTITY(1,1),
 nome_professor VARCHAR(255) NOT NULL,
 sobrenome_professor VARCHAR(255) NOT NULL,
 data_nascimento DATE NOT NULL,
 identificacao_genero VARCHAR(50),
 data_contratacao DATE NOT NULL,
 tipo_vinculo VARCHAR(50) NOT NULL,
 cpf VARCHAR(14) NOT NULL UNIQUE,
 rg VARCHAR(20) NOT NULL UNIQUE,
 titulacao VARCHAR(50) NOT NULL,
 email_pessoal VARCHAR(255),
 email_corporativo VARCHAR(255),
 cod_departamento INT NOT NULL,
 status_professor VARCHAR(50) NOT NULL,
 cod_endereco INT NOT NULL,
 FOREIGN KEY (cod_departamento) REFERENCES Departamento(cod_departamento),
 FOREIGN KEY (cod_endereco) REFERENCES Endereco(cod_endereco)
);

-- TELEFONES ALUNO
CREATE TABLE Telefone_Aluno (
 cod_telefone INT PRIMARY KEY,
 ra_aluno INT NOT NULL,
 num_telefone VARCHAR(15) NOT NULL,
 tipo_telefone VARCHAR(30) NOT NULL,
 FOREIGN KEY (ra_aluno) REFERENCES Aluno(ra_aluno)
);

-- TELEFONES PROFESSOR
CREATE TABLE Telefone_Professor (
 cod_telefone_professor INT PRIMARY KEY,
 cod_professor INT NOT NULL,
 num_telefone VARCHAR(15) NOT NULL,
 tipo_telefone VARCHAR(30) NOT NULL,
 FOREIGN KEY (cod_professor) REFERENCES Professor(cod_professor)
);

-- PROFESSOR_DISCIPLINA: associativa
CREATE TABLE Professor_Disciplina (
 cod_professor INT NOT NULL,
 cod_disciplina INT NOT NULL,
 PRIMARY KEY (cod_professor, cod_disciplina),
 FOREIGN KEY (cod_professor) REFERENCES Professor(cod_professor),
 FOREIGN KEY (cod_disciplina) REFERENCES Disciplina(cod_disciplina)
);

-- TURMAS: define as turmas
CREATE TABLE Turma (
 cod_turma INT PRIMARY KEY IDENTITY(1,1),
 cod_curso INT NOT NULL,
 sala VARCHAR(50) NOT NULL,
 ano INT NOT NULL,
 semestre INT NOT NULL,
 cod_disciplina INT NOT NULL,
 cod_professor INT NOT NULL,
 periodo VARCHAR(50) NOT NULL,
 numero_alunos INT NOT NULL,
 data_inicio DATE NOT NULL,
 data_fim DATE,
 FOREIGN KEY (cod_curso) REFERENCES Curso(cod_curso),
 FOREIGN KEY (cod_disciplina) REFERENCES Disciplina(cod_disciplina),
 FOREIGN KEY (cod_professor) REFERENCES Professor(cod_professor)
);

-- MATRÍCULA (atualizada)
CREATE TABLE Matricula (
 cod_matricula INT PRIMARY KEY IDENTITY(1,1),
 ra_aluno INT NOT NULL,
 cod_turma INT NOT NULL,
 data_matricula DATE NOT NULL,
 data_cancelamento DATE,
 motivo_cancelamento TEXT,
 status_matricula VARCHAR(50) NOT NULL,
 FOREIGN KEY (ra_aluno) REFERENCES Aluno(ra_aluno),
 FOREIGN KEY (cod_turma) REFERENCES Turma(cod_turma)
);

-- HISTÓRICO ESCOLAR
CREATE TABLE Historico (
 cod_disciplina INT NOT NULL,
 ra_aluno INT NOT NULL,
 ano INT NOT NULL,
 semestre INT NOT NULL,
 nota DECIMAL(4,2) NOT NULL,
 frequencia INT NOT NULL,
 situacao_historico VARCHAR(50) NOT NULL,
 PRIMARY KEY (cod_disciplina, ra_aluno, ano, semestre),
 FOREIGN KEY (cod_disciplina) REFERENCES Disciplina(cod_disciplina),
 FOREIGN KEY (ra_aluno) REFERENCES Aluno(ra_aluno)
);

-- Inserir Campos Departamento
INSERT INTO Departamento (nome_departamento) VALUES ('Ciências Exatas');
INSERT INTO Departamento (nome_departamento) VALUES ('Ciências Humanas');
INSERT INTO Departamento (nome_departamento) VALUES ('Engenharia');
INSERT INTO Departamento (nome_departamento) VALUES ('Letras e Artes');
INSERT INTO Departamento (nome_departamento) VALUES ('Ciências Biológicas');
INSERT INTO Departamento (nome_departamento) VALUES ('Educação Física');
INSERT INTO Departamento (nome_departamento) VALUES ('Administração e Negócios');
INSERT INTO Departamento (nome_departamento) VALUES ('Tecnologia da Informação');
INSERT INTO Departamento (nome_departamento) VALUES ('Saúde');
INSERT INTO Departamento (nome_departamento) VALUES ('Direito');

-- Inserir Campos Endereço
INSERT INTO Endereco (nome_rua, numero, complemento, bairro, cidade, estado, cep)
VALUES ('Rua Augusta', 101, 'Apto 12', 'Consolação', 'São Paulo', 'SP', '01305-000');
INSERT INTO Endereco (nome_rua, numero, complemento, bairro, cidade, estado, cep)
VALUES ('Avenida Paulista', 1578, 'Sala 403', 'Bela Vista', 'São Paulo', 'SP', '01310-200');
INSERT INTO Endereco (nome_rua, numero, complemento, bairro, cidade, estado, cep)
VALUES ('Rua Oscar Freire', 560, 'Casa', 'Jardins', 'São Paulo', 'SP', '01426-001');
INSERT INTO Endereco (nome_rua, numero, complemento, bairro, cidade, estado, cep)
VALUES ('Rua Vergueiro', 1009, 'Apto 101', 'Paraíso', 'São Paulo', 'SP', '01504-001');
INSERT INTO Endereco (nome_rua, numero, complemento, bairro, cidade, estado, cep)
VALUES ('Rua Domingos de Morais', 348, 'Bloco B', 'Vila Mariana', 'São Paulo', 'SP', '04010-000');
INSERT INTO Endereco (nome_rua, numero, complemento, bairro, cidade, estado, cep)
VALUES ('Rua da Consolação', 222, 'Apto 64', 'Centro', 'São Paulo', 'SP', '01302-000');
INSERT INTO Endereco (nome_rua, numero, complemento, bairro, cidade, estado, cep)
VALUES ('Rua Itapeva', 470, 'Cobertura', 'Bela Vista', 'São Paulo', 'SP', '01332-000');
INSERT INTO Endereco (nome_rua, numero, complemento, bairro, cidade, estado, cep)
VALUES ('Avenida Rebouças', 920, 'Fundos', 'Pinheiros', 'São Paulo', 'SP', '05402-000');
INSERT INTO Endereco (nome_rua, numero, complemento, bairro, cidade, estado, cep)
VALUES ('Rua Frei Caneca', 1243, 'Apto 707', 'Consolação', 'São Paulo', 'SP', '01307-003');
INSERT INTO Endereco (nome_rua, numero, complemento, bairro, cidade, estado, cep)
VALUES ('Rua Haddock Lobo', 595, 'Loja 2', 'Cerqueira César', 'São Paulo', 'SP', '01414-001');

-- Inserir Campos Curso
INSERT INTO Curso (nome_curso, tipo, duracao_meses, cod_departamento, turno, carga_horaria_total, modalidade)
VALUES ('Engenharia de Computação', 'Bacharelado', 60, 3, 'Matutino', 3600, 'Presencial');
INSERT INTO Curso (nome_curso, tipo, duracao_meses, cod_departamento, turno, carga_horaria_total, modalidade)
VALUES ('Administração', 'Bacharelado', 48, 7, 'Noturno', 3200, 'Presencial');
INSERT INTO Curso (nome_curso, tipo, duracao_meses, cod_departamento, turno, carga_horaria_total, modalidade)
VALUES ('Direito', 'Bacharelado', 60, 10, 'Noturno', 3800, 'Presencial');
INSERT INTO Curso (nome_curso, tipo, duracao_meses, cod_departamento, turno, carga_horaria_total, modalidade)
VALUES ('Ciência da Computação', 'Bacharelado', 48, 8, 'Matutino', 3600, 'Presencial');
INSERT INTO Curso (nome_curso, tipo, duracao_meses, cod_departamento, turno, carga_horaria_total, modalidade)
VALUES ('Educação Física', 'Licenciatura', 48, 6, 'Noturno', 3200, 'Presencial');
INSERT INTO Curso (nome_curso, tipo, duracao_meses, cod_departamento, turno, carga_horaria_total, modalidade)
VALUES ('Enfermagem', 'Bacharelado', 60, 9, 'Integral', 4000, 'Presencial');
INSERT INTO Curso (nome_curso, tipo, duracao_meses, cod_departamento, turno, carga_horaria_total, modalidade)
VALUES ('História', 'Licenciatura', 48, 2, 'Noturno', 3000, 'Presencial');
INSERT INTO Curso (nome_curso, tipo, duracao_meses, cod_departamento, turno, carga_horaria_total, modalidade)
VALUES ('Design Gráfico', 'Tecnólogo', 36, 4, 'Noturno', 2800, 'Presencial');
INSERT INTO Curso (nome_curso, tipo, duracao_meses, cod_departamento, turno, carga_horaria_total, modalidade)
VALUES ('Matemática', 'Licenciatura', 48, 1, 'Matutino', 3200, 'Presencial');
INSERT INTO Curso (nome_curso, tipo, duracao_meses, cod_departamento, turno, carga_horaria_total, modalidade)
VALUES ('Sistemas de Informação', 'Bacharelado', 48, 8, 'Noturno', 3600, 'Presencial');

-- Inserir Campos Disciplina
INSERT INTO Disciplina (nome_disciplina, ementa, cod_departamento, carga_horaria_total)
VALUES ('Algoritmos e Lógica de Programação', 'Estudo de algoritmos, lógica computacional e resolução de problemas com pseudocódigo.', 8, 60);
INSERT INTO Disciplina (nome_disciplina, ementa, cod_departamento, carga_horaria_total)
VALUES ('Banco de Dados I', 'Modelagem relacional, SQL, normalização e SGBDs.', 8, 60);
INSERT INTO Disciplina (nome_disciplina, ementa, cod_departamento, carga_horaria_total)
VALUES ('Cálculo Diferencial e Integral', 'Funções, limites, derivadas e integrais aplicadas.', 1, 80);
INSERT INTO Disciplina (nome_disciplina, ementa, cod_departamento, carga_horaria_total)
VALUES ('Fundamentos de Redes de Computadores', 'Protocolos, camadas de rede, topologias e segurança básica.', 8, 60);
INSERT INTO Disciplina (nome_disciplina, ementa, cod_departamento, carga_horaria_total)
VALUES ('Gestão de Projetos', 'Conceitos de planejamento, escopo, cronograma, riscos e PMBOK.', 7, 60);
INSERT INTO Disciplina (nome_disciplina, ementa, cod_departamento, carga_horaria_total)
VALUES ('Anatomia Humana', 'Estudo do corpo humano: sistemas e estruturas.', 9, 60);
INSERT INTO Disciplina (nome_disciplina, ementa, cod_departamento, carga_horaria_total)
VALUES ('Didática', 'Conceitos de ensino e aprendizagem para licenciaturas.', 2, 60);
INSERT INTO Disciplina (nome_disciplina, ementa, cod_departamento, carga_horaria_total)
VALUES ('Empreendedorismo', 'Formação empreendedora e desenvolvimento de negócios.', 7, 40);
INSERT INTO Disciplina (nome_disciplina, ementa, cod_departamento, carga_horaria_total)
VALUES ('Legislação Aplicada à TI', 'Leis e normas relacionadas à tecnologia da informação.', 8, 40);
INSERT INTO Disciplina (nome_disciplina, ementa, cod_departamento, carga_horaria_total)
VALUES ('Metodologia Científica', 'Elaboração de projetos, TCCs e pesquisa acadêmica.', 2, 40);

-- Inserir Campos Curso_Disciplina
INSERT INTO Curso_Disciplina (cod_curso, cod_disciplina, tipo_disciplina)
VALUES (1, 1, 'Obrigatória');
INSERT INTO Curso_Disciplina (cod_curso, cod_disciplina, tipo_disciplina)
VALUES (1, 2, 'Optativa');
INSERT INTO Curso_Disciplina (cod_curso, cod_disciplina, tipo_disciplina)
VALUES (2, 3, 'Obrigatória');
INSERT INTO Curso_Disciplina (cod_curso, cod_disciplina, tipo_disciplina)
VALUES (3, 4, 'Obrigatória');
INSERT INTO Curso_Disciplina (cod_curso, cod_disciplina, tipo_disciplina)
VALUES (4, 5, 'Optativa');
INSERT INTO Curso_Disciplina (cod_curso, cod_disciplina, tipo_disciplina)
VALUES (5, 6, 'Obrigatória');
INSERT INTO Curso_Disciplina (cod_curso, cod_disciplina, tipo_disciplina)
VALUES (6, 7, 'Optativa');
INSERT INTO Curso_Disciplina (cod_curso, cod_disciplina, tipo_disciplina)
VALUES (7, 8, 'Obrigatória');
INSERT INTO Curso_Disciplina (cod_curso, cod_disciplina, tipo_disciplina)
VALUES (8, 9, 'Optativa');
INSERT INTO Curso_Disciplina (cod_curso, cod_disciplina, tipo_disciplina)
VALUES (9, 10, 'Obrigatória');

-- Inserir Campos Disciplina_PreRequesito
INSERT INTO Disciplina_PreRequisito (cod_disciplina, cod_pre_requisito)
VALUES (2, 1); -- Banco de Dados I depende de Algoritmos
INSERT INTO Disciplina_PreRequisito (cod_disciplina, cod_pre_requisito)
VALUES (4, 1); -- Redes depende de Algoritmos
INSERT INTO Disciplina_PreRequisito (cod_disciplina, cod_pre_requisito)
VALUES (5, 2); -- Gestão de Projetos depende de Banco de Dados
INSERT INTO Disciplina_PreRequisito (cod_disciplina, cod_pre_requisito)
VALUES (6, 3); -- Anatomia depende de Cálculo
INSERT INTO Disciplina_PreRequisito (cod_disciplina, cod_pre_requisito)
VALUES (7, 5); -- Didática depende de Gestão
INSERT INTO Disciplina_PreRequisito (cod_disciplina, cod_pre_requisito)
VALUES (8, 5); -- Empreendedorismo depende de Gestão
INSERT INTO Disciplina_PreRequisito (cod_disciplina, cod_pre_requisito)
VALUES (9, 2); -- Legislação de TI depende de Banco de Dados
INSERT INTO Disciplina_PreRequisito (cod_disciplina, cod_pre_requisito)
VALUES (10, 7); -- Metodologia depende de Didática
INSERT INTO Disciplina_PreRequisito (cod_disciplina, cod_pre_requisito)
VALUES (10, 8); -- Metodologia depende de Empreendedorismo

-- Inserir Campos Aluno
INSERT INTO Aluno (ra_aluno, nome_aluno, sobrenome_aluno, data_nascimento, identificacao_genero, cpf, rg,
nacionalidade, estado_civil, naturalidade, deficiencia, data_ingresso,
email_pessoal, email_corporativo, status_aluno, nome_mae, nome_pai, cod_endereco, cod_curso)
VALUES (1000, 'Lucas', 'Almeida', '2000-01-01', 'Masculino', '123.456.789-00', 'MG-1234567',
'Brasileira', 'Solteiro', 'São Paulo - SP', 'Nenhuma', '2023-02-01',
'lucas.almeida@gmail.com', 'lucas.almeida@universidade.edu', 'Ativo', 'Maria Almeida', 'João Almeida', 1, 1);
INSERT INTO Aluno (ra_aluno, nome_aluno, sobrenome_aluno, data_nascimento, identificacao_genero, cpf, rg,
nacionalidade, estado_civil, naturalidade, deficiencia, data_ingresso,
email_pessoal, email_corporativo, status_aluno, nome_mae, nome_pai, cod_endereco, cod_curso)
VALUES (1001, 'Mariana', 'Oliveira', '1999-03-15', 'Feminino', '234.567.890-11', 'SP-2345678',
'Brasileira', 'Solteira', 'Campinas - SP', 'Nenhuma', '2022-08-01',
'mariana.oliveira@gmail.com', 'mariana.oliveira@universidade.edu', 'Ativo', 'Ana Oliveira', 'Carlos Oliveira', 2, 2);
INSERT INTO Aluno (ra_aluno, nome_aluno, sobrenome_aluno, data_nascimento, identificacao_genero, cpf, rg,
nacionalidade, estado_civil, naturalidade, deficiencia, data_ingresso,
email_pessoal, email_corporativo, status_aluno, nome_mae, nome_pai, cod_endereco, cod_curso)
VALUES (1002, 'Rafael', 'Souza', '1998-06-22', 'Masculino', '345.678.901-22', 'RJ-3456789',
'Brasileira', 'Casado', 'Rio de Janeiro - RJ', 'Auditiva', '2021-02-01',
'rafael.souza@gmail.com', 'rafael.souza@universidade.edu', 'Ativo', 'Patrícia Souza', 'Fernando Souza', 3, 3);
INSERT INTO Aluno (ra_aluno, nome_aluno, sobrenome_aluno, data_nascimento, identificacao_genero, cpf, rg,
nacionalidade, estado_civil, naturalidade, deficiencia, data_ingresso,
email_pessoal, email_corporativo, status_aluno, nome_mae, nome_pai, cod_endereco, cod_curso)
VALUES (1003, 'Bianca', 'Lima', '2001-09-10', 'Feminino', '456.789.012-33', 'SP-4567890',
'Brasileira', 'Solteira', 'Santos - SP', 'Nenhuma', '2022-02-01',
'bianca.lima@gmail.com', 'bianca.lima@universidade.edu', 'Ativo', 'Sandra Lima', 'Roberto Lima', 4, 4);
INSERT INTO Aluno (ra_aluno, nome_aluno, sobrenome_aluno, data_nascimento, identificacao_genero, cpf, rg,
nacionalidade, estado_civil, naturalidade, deficiencia, data_ingresso,
email_pessoal, email_corporativo, status_aluno, nome_mae, nome_pai, cod_endereco, cod_curso)
VALUES (1004, 'Diego', 'Ferreira', '1997-12-05', 'Masculino', '567.890.123-44', 'MG-5678901',
'Brasileira', 'Casado', 'Belo Horizonte - MG', 'Visual', '2020-02-01',
'diego.ferreira@gmail.com', 'diego.ferreira@universidade.edu', 'Ativo', 'Juliana Ferreira', 'Paulo Ferreira', 5, 5);
INSERT INTO Aluno (ra_aluno, nome_aluno, sobrenome_aluno, data_nascimento, identificacao_genero, cpf, rg,
nacionalidade, estado_civil, naturalidade, deficiencia, data_ingresso,
email_pessoal, email_corporativo, status_aluno, nome_mae, nome_pai, cod_endereco, cod_curso)
VALUES (1005, 'Aline', 'Santos', '2002-07-21', 'Feminino', '678.901.234-55', 'RJ-6789012',
'Brasileira', 'Solteira', 'Niterói - RJ', 'Nenhuma', '2023-02-01',
'aline.santos@gmail.com', 'aline.santos@universidade.edu', 'Ativo', 'Renata Santos', 'Cláudio Santos', 6, 6);
INSERT INTO Aluno (ra_aluno, nome_aluno, sobrenome_aluno, data_nascimento, identificacao_genero, cpf, rg,
nacionalidade, estado_civil, naturalidade, deficiencia, data_ingresso,
email_pessoal, email_corporativo, status_aluno, nome_mae, nome_pai, cod_endereco, cod_curso)
VALUES (1006, 'João', 'Pereira', '1999-05-30', 'Masculino', '789.012.345-66', 'RS-7890123',
'Brasileira', 'Divorciado', 'Porto Alegre - RS', 'Mental', '2021-08-01',
'joao.pereira@gmail.com', 'joao.pereira@universidade.edu', 'Ativo', 'Lúcia Pereira', 'Marcos Pereira', 7, 7);
INSERT INTO Aluno (ra_aluno, nome_aluno, sobrenome_aluno, data_nascimento, identificacao_genero, cpf, rg,
nacionalidade, estado_civil, naturalidade, deficiencia, data_ingresso,
email_pessoal, email_corporativo, status_aluno, nome_mae, nome_pai, cod_endereco, cod_curso)
VALUES (1007, 'Camila', 'Rodrigues', '2000-11-12', 'Feminino', '890.123.456-77', 'PR-8901234',
'Brasileira', 'Solteira', 'Curitiba - PR', 'Nenhuma', '2022-02-01',
'camila.rodrigues@gmail.com', 'camila.rodrigues@universidade.edu', 'Ativo', 'Teresa Rodrigues', 'Eduardo Rodrigues', 8, 8);
INSERT INTO Aluno (ra_aluno, nome_aluno, sobrenome_aluno, data_nascimento, identificacao_genero, cpf, rg,
nacionalidade, estado_civil, naturalidade, deficiencia, data_ingresso,
email_pessoal, email_corporativo, status_aluno, nome_mae, nome_pai, cod_endereco, cod_curso)
VALUES (1008, 'Vinícius', 'Barbosa', '2001-03-03', 'Masculino', '901.234.567-88', 'BA-9012345',
'Brasileira', 'Solteiro', 'Salvador - BA', 'Nenhuma', '2023-02-01',
'vinicius.barbosa@gmail.com', 'vinicius.barbosa@universidade.edu', 'Ativo', 'Gláucia Barbosa', 'José Barbosa', 9, 9);
INSERT INTO Aluno (ra_aluno, nome_aluno, sobrenome_aluno, data_nascimento, identificacao_genero, cpf, rg,
nacionalidade, estado_civil, naturalidade, deficiencia, data_ingresso,
email_pessoal, email_corporativo, status_aluno, nome_mae, nome_pai, cod_endereco, cod_curso)
VALUES (1009, 'Juliana', 'Martins', '1998-08-25', 'Feminino', '012.345.678-99', 'SC-0123456',
'Brasileira', 'Casada', 'Florianópolis - SC', 'Física', '2020-08-01',
'juliana.martins@gmail.com', 'juliana.martins@universidade.edu', 'Ativo', 'Elaine Martins', 'Alexandre Martins', 10, 10);

-- Inserir Campos Professor
INSERT INTO Professor (nome_professor, sobrenome_professor, data_nascimento, identificacao_genero, data_contratacao,
tipo_vinculo, cpf, rg, titulacao, email_pessoal, email_corporativo, cod_departamento,
status_professor, cod_endereco)
VALUES ('André', 'Silveira', '1975-04-22', 'Masculino', '2010-03-15', 'Efetivo', '111.222.333-44', 'SP-1234567', 'Doutorado', 'andre.silveira@gmail.com', 'asilveira@universidade.edu', 1, 'Ativo', 1);
INSERT INTO Professor (nome_professor, sobrenome_professor, data_nascimento, identificacao_genero, data_contratacao,
tipo_vinculo, cpf, rg, titulacao, email_pessoal, email_corporativo, cod_departamento,
status_professor, cod_endereco)
VALUES ('Fernanda', 'Costa', '1982-11-10', 'Feminino', '2012-06-01', 'Efetivo', '222.333.444-55', 'RJ-2345678', 'Mestrado', 'fernanda.costa@gmail.com', 'fcosta@universidade.edu', 2, 'Ativo', 2);
INSERT INTO Professor (nome_professor, sobrenome_professor, data_nascimento, identificacao_genero, data_contratacao,
tipo_vinculo, cpf, rg, titulacao, email_pessoal, email_corporativo, cod_departamento,
status_professor, cod_endereco)
VALUES ('Carlos', 'Menezes', '1978-09-30', 'Masculino', '2014-02-20', 'Substituto', '333.444.555-66', 'MG-3456789', 'Mestrado', 'carlos.menezes@gmail.com', 'cmenezes@universidade.edu', 3, 'Ativo', 3);
INSERT INTO Professor (nome_professor, sobrenome_professor, data_nascimento, identificacao_genero, data_contratacao,
tipo_vinculo, cpf, rg, titulacao, email_pessoal, email_corporativo, cod_departamento,
status_professor, cod_endereco)
VALUES ('Juliana', 'Rezende', '1985-07-18', 'Feminino', '2016-09-01', 'Efetivo', '444.555.666-77', 'SP-4567890', 'Doutorado', 'juliana.rezende@gmail.com', 'jrezende@universidade.edu', 4, 'Ativo', 4);
INSERT INTO Professor (nome_professor, sobrenome_professor, data_nascimento, identificacao_genero, data_contratacao,
tipo_vinculo, cpf, rg, titulacao, email_pessoal, email_corporativo, cod_departamento,
status_professor, cod_endereco)
VALUES ('Rodrigo', 'Barros', '1972-02-11', 'Masculino', '2008-05-10', 'Efetivo', '555.666.777-88', 'RS-5678901', 'Doutorado', 'rodrigo.barros@gmail.com', 'rbarros@universidade.edu', 5, 'Ativo', 5);
INSERT INTO Professor (nome_professor, sobrenome_professor, data_nascimento, identificacao_genero, data_contratacao,
tipo_vinculo, cpf, rg, titulacao, email_pessoal, email_corporativo, cod_departamento,
status_professor, cod_endereco)
VALUES ('Patrícia', 'Fernandes', '1980-08-25', 'Feminino', '2011-11-20', 'Efetivo', '666.777.888-99', 'BA-6789012', 'Mestrado', 'patricia.fernandes@gmail.com', 'pfernandes@universidade.edu', 6, 'Ativo', 6);
INSERT INTO Professor (nome_professor, sobrenome_professor, data_nascimento, identificacao_genero, data_contratacao,
tipo_vinculo, cpf, rg, titulacao, email_pessoal, email_corporativo, cod_departamento,
status_professor, cod_endereco)
VALUES ('Eduardo', 'Santos', '1983-03-14', 'Masculino', '2013-03-01', 'Substituto', '777.888.999-00', 'PE-7890123', 'Mestrado', 'eduardo.santos@gmail.com', 'esantos@universidade.edu', 7, 'Ativo', 7);
INSERT INTO Professor (nome_professor, sobrenome_professor, data_nascimento, identificacao_genero, data_contratacao,
tipo_vinculo, cpf, rg, titulacao, email_pessoal, email_corporativo, cod_departamento,
status_professor, cod_endereco)
VALUES ('Renata', 'Lima', '1979-12-05', 'Feminino', '2009-07-15', 'Efetivo', '888.999.000-11', 'CE-8901234', 'Doutorado', 'renata.lima@gmail.com', 'rlima@universidade.edu', 8, 'Ativo', 8);
INSERT INTO Professor (nome_professor, sobrenome_professor, data_nascimento, identificacao_genero, data_contratacao,
tipo_vinculo, cpf, rg, titulacao, email_pessoal, email_corporativo, cod_departamento,
status_professor, cod_endereco)
VALUES ('Marcelo', 'Teixeira', '1986-10-07', 'Masculino', '2018-01-10', 'Efetivo', '999.000.111-22', 'PR-9012345', 'Mestrado', 'marcelo.teixeira@gmail.com', 'mteixeira@universidade.edu', 9, 'Ativo', 9);
INSERT INTO Professor (nome_professor, sobrenome_professor, data_nascimento, identificacao_genero, data_contratacao,
tipo_vinculo, cpf, rg, titulacao, email_pessoal, email_corporativo, cod_departamento,
status_professor, cod_endereco)
VALUES ('Beatriz', 'Souza', '1981-06-19', 'Feminino', '2010-10-01', 'Efetivo', '000.111.222-33', 'SC-0123456', 'Doutorado', 'beatriz.souza@gmail.com', 'bsouza@universidade.edu', 10, 'Ativo', 10);

-- Inserir Campos Telefone_Aluno
INSERT INTO Telefone_Aluno (cod_telefone, ra_aluno, num_telefone, tipo_telefone)
VALUES (1, 1000, '(11) 98765-4321', 'Celular');
INSERT INTO Telefone_Aluno VALUES (2, 1001, '(11) 91234-5678', 'Celular');
INSERT INTO Telefone_Aluno VALUES (3, 1002, '(21) 99876-5432', 'Celular');
INSERT INTO Telefone_Aluno VALUES (4, 1003, '(31) 98765-1234', 'Celular');
INSERT INTO Telefone_Aluno VALUES (5, 1004, '(41) 97654-3210', 'Celular');
INSERT INTO Telefone_Aluno VALUES (6, 1005, '(71) 96543-2109', 'Celular');
INSERT INTO Telefone_Aluno VALUES (7, 1006, '(51) 95432-1098', 'Celular');
INSERT INTO Telefone_Aluno VALUES (8, 1007, '(61) 94321-0987', 'Celular');
INSERT INTO Telefone_Aluno VALUES (9, 1008, '(85) 93210-9876', 'Celular');
INSERT INTO Telefone_Aluno VALUES (10, 1009, '(48) 92109-8765', 'Celular');

-- Inserir Campos Telefone_Professor
INSERT INTO Telefone_Professor (cod_telefone_professor, cod_professor, num_telefone, tipo_telefone)
VALUES (1, 1, '(11) 98888-1122', 'Celular');
INSERT INTO Telefone_Professor VALUES (2, 2, '(21) 97777-2233', 'Celular');
INSERT INTO Telefone_Professor VALUES (3, 3, '(31) 96666-3344', 'Residencial');
INSERT INTO Telefone_Professor VALUES (4, 4, '(41) 95555-4455', 'Celular');
INSERT INTO Telefone_Professor VALUES (5, 5, '(71) 94444-5566', 'Residencial');
INSERT INTO Telefone_Professor VALUES (6, 6, '(51) 93333-6677', 'Celular');
INSERT INTO Telefone_Professor VALUES (7, 7, '(61) 92222-7788', 'Residencial');
INSERT INTO Telefone_Professor VALUES (8, 8, '(85) 91111-8899', 'Celular');
INSERT INTO Telefone_Professor VALUES (9, 9, '(48) 90000-9900', 'Celular');
INSERT INTO Telefone_Professor VALUES (10, 10, '(95) 98888-0011', 'Residencial');

-- Inserir Campos Professor_Disciplina
INSERT INTO Professor_Disciplina (cod_professor, cod_disciplina)
VALUES (1, 1);
INSERT INTO Professor_Disciplina VALUES (1, 2);
INSERT INTO Professor_Disciplina VALUES (2, 3);
INSERT INTO Professor_Disciplina VALUES (2, 4);
INSERT INTO Professor_Disciplina VALUES (3, 5);
INSERT INTO Professor_Disciplina VALUES (4, 6);
INSERT INTO Professor_Disciplina VALUES (5, 7);
INSERT INTO Professor_Disciplina VALUES (6, 8);
INSERT INTO Professor_Disciplina VALUES (7, 9);
INSERT INTO Professor_Disciplina VALUES (8, 10);
INSERT INTO Professor_Disciplina VALUES (9, 1);
INSERT INTO Professor_Disciplina VALUES (10, 2);

-- Inserir Campos Turma
INSERT INTO Turma (cod_curso, sala, ano, semestre, cod_disciplina, cod_professor, periodo, numero_alunos, data_inicio, data_fim)
VALUES (1, 'Sala 101', 2023, 1, 1, 1, 'Manhã', 30, '2023-02-01', '2023-06-30');
INSERT INTO Turma VALUES (2, 'Sala 102', 2023, 1, 2, 1, 'Tarde', 28, '2023-02-01', '2023-06-30');
INSERT INTO Turma VALUES (3, 'Sala 201', 2023, 2, 3, 2, 'Noite', 32, '2023-08-01', '2023-12-15');
INSERT INTO Turma VALUES (4, 'Sala 202', 2023, 2, 4, 2, 'Manhã', 25, '2023-08-01', '2023-12-15');
INSERT INTO Turma VALUES (5, 'Sala 301', 2024, 1, 5, 3, 'Noite', 27, '2024-02-01', '2024-06-30');
INSERT INTO Turma VALUES (6, 'Sala 302', 2024, 1, 6, 4, 'Tarde', 24, '2024-02-01', '2024-06-30');
INSERT INTO Turma VALUES (7, 'Sala 401', 2024, 2, 7, 5, 'Manhã', 29, '2024-08-01', '2024-12-10');
INSERT INTO Turma VALUES (8, 'Sala 402', 2024, 2, 8, 6, 'Noite', 26, '2024-08-01', '2024-12-10');
INSERT INTO Turma VALUES (9, 'Sala 501', 2025, 1, 9, 7, 'Tarde', 31, '2025-02-01', '2025-06-25');
INSERT INTO Turma VALUES (10, 'Sala 502', 2025, 1, 10, 8, 'Manhã', 33, '2025-02-01', '2025-06-25');

-- Inserir Campos Matricula
INSERT INTO Matricula (ra_aluno, cod_turma, data_matricula, data_cancelamento, motivo_cancelamento, status_matricula)
VALUES (1000, 1, '2023-02-01', NULL, NULL, 'Ativada');
INSERT INTO Matricula VALUES (1001, 2, '2023-02-02', NULL, NULL, 'Ativada');
INSERT INTO Matricula VALUES (1002, 3, '2023-08-01', NULL, NULL, 'Ativada');
INSERT INTO Matricula VALUES (1003, 4, '2023-08-05', NULL, NULL, 'Ativada');
INSERT INTO Matricula VALUES (1004, 5, '2024-02-01', NULL, NULL, 'Ativada');
INSERT INTO Matricula VALUES (1005, 6, '2024-02-10', NULL, NULL, 'Ativada');
INSERT INTO Matricula VALUES (1006, 7, '2024-08-01', NULL, NULL, 'Ativada');
INSERT INTO Matricula VALUES (1007, 8, '2024-08-03', NULL, NULL, 'Ativada');
INSERT INTO Matricula VALUES (1008, 9, '2025-02-01', NULL, NULL, 'Ativada');
INSERT INTO Matricula VALUES (1009, 10, '2025-02-04', NULL, NULL, 'Ativada');

-- Inserir Campos Historico
INSERT INTO Historico (cod_disciplina, ra_aluno, ano, semestre, nota, frequencia, situacao_historico)
VALUES (1, 1000, 2023, 1, 8.50, 95, 'Aprovado');
INSERT INTO Historico VALUES (2, 1001, 2023, 1, 7.20, 88, 'Aprovado');
INSERT INTO Historico VALUES (3, 1002, 2023, 2, 6.80, 84, 'Aprovado');
INSERT INTO Historico VALUES (4, 1003, 2023, 2, 9.00, 92, 'Aprovado');
INSERT INTO Historico VALUES (5, 1004, 2024, 1, 5.50, 78, 'Reprovado');
INSERT INTO Historico VALUES (6, 1005, 2024, 1, 8.00, 90, 'Aprovado');
INSERT INTO Historico VALUES (7, 1006, 2024, 2, 6.00, 85, 'Aprovado');
INSERT INTO Historico VALUES (8, 1007, 2024, 2, 4.50, 70, 'Reprovado');
INSERT INTO Historico VALUES (9, 1008, 2025, 1, 7.80, 93, 'Aprovado');
INSERT INTO Historico VALUES (10, 1009, 2025, 1, 9.50, 98, 'Aprovado');

-- Conferência dos dados inseridos
select*from Aluno
select*from Curso
select*from Curso_Disciplina
select*from Departamento
select*from Disciplina
select*from Disciplina_PreRequisito
select*from Endereco
select*from Historico
select*from Matricula
select*from Professor
select*from Professor_Disciplina
select*from Telefone_Aluno
select*from Telefone_Professor
select*from Turma

--EXERCÍCIOS
--1) Disciplinas cursadas por um aluno com suas respectivas notas.

SELECT
    a.ra_aluno,
    a.nome_aluno,
    a.sobrenome_aluno,
    d.nome_disciplina,
    h.ano,
    h.semestre,
    h.nota,
    h.frequencia,
    h.situacao_historico
FROM Historico h
JOIN Aluno a ON h.ra_aluno = a.ra_aluno
JOIN Disciplina d ON h.cod_disciplina = d.cod_disciplina
-- WHERE a.ra_aluno = 1000;
ORDER BY a.ra_aluno, h.ano, h.semestre;


--2) Professores que ministram determinada disciplina.

SELECT 
    p.cod_professor,
    p.nome_professor,
    p.sobrenome_professor,
    d.nome_disciplina
FROM Professor_Disciplina pd
JOIN Professor p ON pd.cod_professor = p.cod_professor
JOIN Disciplina d ON pd.cod_disciplina = d.cod_disciplina
WHERE d.cod_disciplina = 1002;

--3) Alunos matriculados em uma turma específica.

SELECT 
    a.ra_aluno,
    a.nome_aluno,
    a.sobrenome_aluno,
    t.cod_turma,
    t.ano,
    t.semestre,
	m.status_matricula,
	m.data_matricula
FROM Matricula m
JOIN Aluno a ON m.ra_aluno = a.ra_aluno
JOIN Turma t ON m.cod_turma = t.cod_turma
WHERE t.cod_turma = 1003;

--4) Disciplinas obrigatórias de um curso.

SELECT 
    c.cod_curso,
    c.nome_curso,
    d.cod_disciplina,
    d.nome_disciplina,
    cd.tipo_disciplina
FROM Curso_Disciplina cd
JOIN Curso c ON cd.cod_curso = c.cod_curso
JOIN Disciplina d ON cd.cod_disciplina = d.cod_disciplina
WHERE c.nome_curso = 'Engenharia de Computação'
  AND cd.tipo_disciplina = 'Obrigatória';

--5) Endereço completo de um aluno.

SELECT 
    a.ra_aluno,
    a.nome_aluno,
    a.sobrenome_aluno,
    e.nome_rua,
    e.numero,
    e.complemento,
    e.bairro,
    e.cidade,
    e.estado,
    e.cep
FROM Aluno a
JOIN Endereco e ON a.cod_endereco = e.cod_endereco
WHERE a.ra_aluno = 1005;

--6) Disciplinas que possuem pré-requisitos.

SELECT
	d.cod_disciplina,
	d.nome_disciplina,
	pr.cod_pre_requisito,
	dp.nome_disciplina as nome_pre_requisito
FROM Disciplina_PreRequisito pr
JOIN Disciplina d ON pr.cod_disciplina = d.cod_disciplina
JOIN Disciplina dp ON pr.cod_pre_requisito = dp.cod_disciplina
ORDER BY d.cod_disciplina;
