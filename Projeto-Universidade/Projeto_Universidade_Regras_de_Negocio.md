Projeto Prático: Apresentação e Regras do Negócio
Apresentação
Banco de Dados para Gerenciamento de uma Universidade.

Objetivos do Banco de Dados:
Realizar controle centralizado de alunos, professores, cursos,
disciplinas, histórico escolar e turmas.

Fases do Projeto:
• Levantamento dos Requisitos
• Identificação de Entidades e Relacionamentos
• Modelo E-R
• Diagrama E-R
• Dicionário de Dados Normalização
• Implementação
• Testes Básicos

Regras do Negócio:

1. Um aluno só pode estar matriculado em um curso por vez. (Se o aluno estiver matriculado em ADS, ele não pode estar matriculado também no curso de Logística).
2. Alunos possuem um código de identificação (RA). (Precisamos definir o padrão se é letra, número ou os dois). 
3. Cursos são compostos por várias disciplinas. Exemplo: ADS (Banco de Dados, Raciocínio lógico etc.)
4. Cada disciplina terá no máximo 28 alunos por turma. (Se tivermos mais de 28 alunos matriculados por turma, precisaremos abrir uma nova turma.)
5. As disciplinas podem ser obrigatórias ou optativas, dependendo do curso. (Exemplo: no curso de Matemática, Cálculo I, II e III é obrigatório porém, a disciplina Estatística Computacional é opcional).
6. As disciplinas pertencem a departamentos específicos. (Exemplo: Um departamento de Ciências da Computação, um departamento de Matemática e assim sucessivamente).
7. Cada disciplina possui um código de identificação. (Também não foi definido o padrão).
8. Alunos podem trancar matrícula, não estando então matriculados em nenhuma disciplina no semestre. (Se o aluno trancar a matrícula, não pode estar matriculado em nenhuma disciplina).
9. Em cada semestre, cada aluno pode se matricular em no máximo 8 disciplinas. (Se ficar de DP em várias disciplinas e ultrapassar as 8 disciplinas, precisará fazer no próximo semestre.)
10. O aluno só pode ser reprovado no máximo 3 vezes na mesma disciplina. (Se o aluno reprovar mais de 3 vezes na mesma disciplina ele perde o curso).
11. A universidade terá no máximo 2.000 alunos matriculados simultaneamente, em 8 cursos distintos. (Compreende-se que é uma universidade de porte médio, com uma oferta acadêmica diversificada e um foco na qualidade do ensino).
12. Entram 200 alunos novos por ano. (Seja por meio de vestibular ou transferência).
13. Existem 64 disciplinas no total disponíveis.
14. Um Histórico Escolar traz todas as disciplinas cursadas por um aluno, incluindo nota final, frequência e período do curso realizado.
15. Professores podem ser cadastrados mesmo sem lecionar disciplinas. (Isso evita que um professor não possa lecionar uma determinada disciplina no futuro).
16. Existem 30 professores trabalhando na escola.
17. Cada professor irá lecionar no máximo 3 disciplinas diferentes.
18. Cada professor é vinculado a um departamento. (A vinculação de cada professor a um departamento é fundamental para a organização, gestão e desenvolvimento das atividades acadêmicas em uma universidade.
Troca de conhecimentos: A vinculação a um departamento promove a troca de conhecimentos e experiências entre os professores, o que pode levar a novas ideias e projetos de pesquisa.)
19. Professores são identificados por um código de professor. (Não foi definido o padrão).

Identificando as Entidades:
> Aluno
> Histórico
> Professor
> Disciplina
> Curso
> Departamento
> Turma

Identificando os Relacionamentos
> Aluno está Matriculado em Curso
> Disciplina Pertence a Curso
> Aluno Cursa Disciplina
> Departamento é Responsável por Disciplina
> Histórico contém as disciplinas
> Histórico pertence aos alunos
> Professor Ministra Disciplina
> Professor Pertence a Departamento
> Departamento Controla Curso
> Disciplina Depende de Disciplina
> Aluno Pertence a Turma
> Curso Gera Turma

Identificando os Atributos - Aluno
> RA_Aluno (PK)
> Nome_Aluno
> Sobrenome_Aluno
> Data_Nascimento
> Identificacao_Gênero
> CPF
> RG
> Nacionalidade
> Estado_Civil
> Naturalidade
> Deficiência
> Data_Ingresso
> Rua
> Número
> Bairro
> Cidade
> Estado
> CEP
> Telefone_Celular
> Telefone_Residencial
> Telefone_Comercial
> Telefone_Recado
> E-mail_Pessoal
> E-mail_Corporativo
> Status_Aluno (ativo, formado, trancado etc)
> Nome_Mãe
> Nome_Pai

Identificando os Atributos - Professor
> Cod_Professor (PK) - Um professor só pode pertencer a um departamento
> Nome_Professor
> Sobrenome_Professor
> Data_Nascimento
> Identificação_Gênero
> Data_Contratação
> Tipo_Vinculo(Efetivo, Substituto...)
> CPF
> RG
> Titulação (Graduado, Mestre, Doutor...).
> Rua
> Numero
> Bairro
> Cidade
> Estado
> CEP
> Telefone_Celular
> Telefone_Residencial
> Telefone_Comercial
> Telefone_Recado
> E-mail_Pessoal
> E-mail_Corporativo
> Cod_Departamento (FK) - (Um professor só pode pertencer a um departamento)
> Status_Professor (ativo, inativo, licenciado...)

Identificando os Atributos - Curso
> Cod_Curso (PK)
> Nome_Curso
> Tipo (Bacharelado, Licenciatura, Tecnólogo)
> Duração_Meses
> Cod_Departamento(FK)
> Turno (Matutino, Vespertino...)
> Carga_Horária_Total
> Modalidade (Presencial, EAD...)
> Cod_Prof_Coordenador (FK) (Que vai coordenar o curso)

Identificando os Atributos - Histórico
> Cod_Histórico
> Cod_Disciplina
> RA_Aluno (FK)
> Ano
> Semestre
> Nota
> Frequência
> Situação (aprovado, reprovado, trancado)

Identificando os Atributos - Disciplina
> Cod_Disciplina (PK)
> Nome_Disciplina
> Pré_Requisitos
> Ementa
> Cod_Departamento (FK)
> Carga_Horaria
> Cod_Curso (FK)

Identificando os Atributos - Departamento
> Cod_Departamento (PK)
> Nome_Departamento

Identificando os Atributos - Turma
> Cod_Turma (PK)
> Cod_Curso (FK)
> Sala
> Ano
> Semestre
> Cod_Disciplina (FK)
> Cod_Professor (FK)
> Período
> Num_Alunos
> Data_Início
> Data_Fim

Identificando os Atributos - Matrícula
> Cod_Matrícula
> RA_Aluno (FK)
> Cod_Turma (PK)
> Data_Matrícula
> Data_Cancelamento
> Status_Matrícula (ativo, inativa, trancada...)

