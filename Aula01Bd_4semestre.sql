Create table Proprietario
(
	Codigo integer,
	Nome   Varchar (100)not null,
	CPF Varchar (11) unique ,
	Sexo varchar (1) CHECK (sexo in ('F','f','M','m')),
	Idade integer CHECK (idade between 21 and 80),
	Telefone Numeric (15) not null,

	Constraint Pk_proprietario primary key (codigo),
	Constraint uk_Prop unique (CPF)
);
Create Table Imovel
(
	Codigo integer,
	Endereco Varchar (100) not null,
	Descricao Varchar (100) not null,
	Valor_Alugel numeric CHECK (Valor_Alugel >500),
	Tipo Varchar (11), Check (tipo in ('residencial','Comercial')),
	Status Varchar (10), Check (status in ('Alugado ','Livre','Em reforma')),
	Proprietario integer,
	Constraint Pk_Imovel primary key(Codigo),
	Constraint Fk_Imovel foreign Key (Proprietario) references Proprietario (Codigo) on Delete  Cascade on update Cascade
);

Create table Inquilino 
(
	Codigo integer,
	Nome Varchar (100) not null,
	CPF numeric unique,
	Sexo Varchar (1) CHECK (sexo in ('F','f','M','m')),
	Idade integer CHECK (idade between 21 and 80),
	telefone numeric (13) Not null,
	Constraint pk_Inquilino primary key (codigo)
);
Create table Corretor 
(
	Codigo integer,
	Nome Varchar not null,
	Cpf Varchar (15) ,
	Sexo Varchar (1) CHECK (Sexo in('F','f','M','m')),
	Dt_nascimento date,
	Telefone numeric (11) not null,
	Creci numeric (100) not null unique,

	Constraint Pk_Corretor primary key  (Codigo),
	Constraint uk_Cpf unique (Cpf)
	
);
Create Table Aluguel
(
	Imovel integer,
	inquilino integer,
	corretor integer,
	dat_aluguel date not null,
	dt_vencimento date not null,
	valor_final_aluguel numeric (10,2) check (valor_final_aluguel >600),
	Constraint pk_alu primary key (imovel,inquilino,corretor),
	Constraint Fk_alu_imovel foreign key  (imovel) references imovel (codigo) on delete cascade on update cascade,
	Constraint fk_alu_inq foreign key (inquilino) references inquilino (codigo) on delete no action on update set  null,
	Constraint Fk_alu_corretor foreign key (corretor) references Corretor (Codigo) on delete no action on update set null
);

Create sequence Codigo;
insert into Proprietario Values 
(Nextval ('codigo'),'Fulano','1111','M',35,1223 ),
(nextval ('codigo'),'Ciclana','15551','F',41,47474 ),
(nextval ('codigo'),'Jon Shlow','33311','M',35,1223 ),
(nextval ('codigo'),'Robb Stark','1110','M',35,1223 ),
(nextval ('codigo'),'Tyrion Lanister','19911','M',35,1223 );

Create sequence cod;
insert into Imovel Values
(nextval ('cod'),'Rua N° 0','80x50',1000,'residencial','Livre',(select codigo from Proprietario where nome = 'Fulano' ) ),
(nextval ('cod'),'Rua N° 0','60X60',600,'residencial','Alugado ',(select codigo from Proprietario where nome = 'Ciclana') ),
(nextval ('cod'),'Rua Av Paulista','50x20',3000,'residencial','Alugado ',(select codigo from Proprietario where nome = 'Jon Shlow' ) ),
(nextval ('cod'),'Rua Av Paulista','50x20',2000,'Comercial','Alugado ',(select codigo from Proprietario where nome = 'Robb Stark' ) ),
(nextval ('cod'),'Rua Av Jaão Moreira','50x20',900,'Comercial','Alugado ',(select codigo from Proprietario where nome = 'Tyrion Lanister' ) );

Create sequence Cont;
insert into Inquilino Values
(nextval ('Cont'),'Elena',388909,'f',28,981223),
(nextval ('Cont'),'Damon',3666909,'M',21,30999),
(nextval ('Cont'),'Alaric',111109,'M',25,22225),
(nextval ('Cont'),'Bone',0000909,'f',34,911113),
(nextval ('Cont'),'Caroline',209856,'f',28,12334);

Create sequence Contador
insert into Corretor Values
(nextval ('Contador'),'Dean',909,'m','20-12-1991',9870666,29000),
(nextval ('Contador'),'Sam',909551,'m','21-12-1991',9870081,21),
(nextval ('Contador'),'Castiél',9555,'m','20-12-1991',98,23),
(nextval ('Contador'),'Monica',2229,'f','20-12-1971',9800,262),
(nextval ('Contador'),'Cebolinha',11098623,'M','20-12-1972',998000,82);

Create sequence Cont_alu;
(nextval ('Cont_alu'),(select i.codigo from imovel as i, proprietario as p where i.codigo = p.codigo and p.nome = 'Ciclana' ),(select codigo from inquilino where nome ='Elena'),(select codigo from Corretor where nome ='Dean'),20-12-2009,'3-3-2010',9000),
