create table estado( 
	cd_id serial,
	nm_nome character varying,
	ds_sigla char(2),

	CONSTRAINT pk_estado PRIMARY KEY (cd_id)  
);

create table municipio(
	cd_id serial,
	nm_nome character varying,
	cd_estado integer,

	CONSTRAINT pk_municipio PRIMARY KEY (cd_id),
	CONSTRAINT fk_municipio_01 FOREIGN KEY (cd_estado) REFERENCES estado (cd_id)
);

create table bairro( 
	cd_id serial,
	nm_nome character varying,
	cd_municipio integer,

	CONSTRAINT pk_bairro PRIMARY KEY (cd_id),
	CONSTRAINT fk_bairro_01 FOREIGN KEY (cd_municipio) REFERENCES municipio(cd_id)
);

create table endereco(
	cd_id serial,
	ds_endereco character varying,
	nu_cep bigint,
	ds_complemento character varying,
	nu_numero character varying,
	cd_bairro integer,

	CONSTRAINT pk_endereco PRIMARY KEY (cd_id),
	CONSTRAINT fk_endereco_01 FOREIGN KEY (cd_bairro) REFERENCES bairro(cd_id)
);

CREATE TABLE cliente(
	cd_id serial,
	nm_cliente character varying NOT NULL,
	nu_cpf bigint,
	nu_rg bigint,
	dt_nascimento DATE,
	ds_sexo char(1),
	ds_naturalidade character varying,
	nm_mae character varying,
	nm_pai character varying,
	ds_telefone character varying,
	ds_celular character varying,
	ds_email character varying,
	ds_observacao character varying,
	cd_endereco integer, 

	CONSTRAINT pk_cliente PRIMARY KEY (cd_id ),
	CONSTRAINT fk_cliente_01 FOREIGN KEY (cd_endereco) REFERENCES endereco(cd_id)
);

create table empresa(
	cd_id serial,
	nm_nome character varying,
	nm_fantasia character varying,
	ds_telefone character varying,
	nu_cnpj bigint,
	nu_inscricao_Estadual bigint,
	cd_endereco integer,

	CONSTRAINT pk_empresa PRIMARY KEY (cd_id),
	CONSTRAINT fk_empresa_01 FOREIGN KEY (cd_endereco) REFERENCES endereco(cd_id)
);

create table veiculo(
	cd_id serial,
	cd_cliente integer,
	nm_marca character varying, /* atributo ou tabela? */
	nm_modelo character varying, /* atributo ou tabela? */
	nu_ano int,
	ds_cor character varying,
	ds_observacao character varying,
	ds_pl character varying,
	
	CONSTRAINT pk_veiculo PRIMARY KEY (cd_id),
	CONSTRAINT fk_veiculo_01 FOREIGN KEY (cd_cliente) REFERENCES cliente(cd_id),
	CONSTRAINT uq_veiculo_01 UNIQUE (ds_placa)
);

CREATE TABLE peca(
	cd_id serial,
	nm_nome character varying,
	ds_descricao character varying,
	nm_marca character varying,
	/* Adicionar mais dados a tabela de peça */

	CONSTRAINT pk_produto PRIMARY KEY (cd_id)
);

CREATE TABLE entrada_produto(
	cd_id serial,
	cd_peca integer,
	cd_fornecedor integer,
	nu_quantidade integer,
	nu_valor double precision,
	dt_compra DATE,
	nu_porcentagem_venda double precision,
	
	CONSTRAINT pk_entrada PRIMARY KEY (cd_id),
	CONSTRAINT fk_entrada_01 FOREIGN KEY (cd_fornecedor) REFERENCES empresa(cd_id),
	CONSTRAINT fk_entrada_02 FOREIGN KEY (cd_peca) REFERENCES peca(cd_id) 
);

create table manutencao(
	cd_id serial,
	cd_veiculo integer,
	dt_entrada DATE,
	dt_prevista DATE,
	ds_observacao character varying,

	CONSTRAINT pk_manutencao PRIMARY KEY (cd_id),
	CONSTRAINT fk_manutencao_01 FOREIGN KEY (cd_veiculo) REFERENCES veiculo(cd_id)
);


create table mao_obra(
	cd_id serial,
	cd_manutencao integer,
	nu_valor_mao_obra double precision,
	ds_observacao character varying,
	
	CONSTRAINT pk_mao_obra PRIMARY KEY (cd_id),
	CONSTRAINT fk_mao_obra_01 FOREIGN KEY (cd_manutencao) REFERENCES manutencao(cd_id)
);

/* Tabela relacional entre mao de obra e peças, pois 1 serviço pode ter mais de 1 peça troca */
create table mao_obra_peca(
	cd_id serial,
	cd_mao_obra integer,
	cd_peca integer,
	nu_qtde_peca integer,

	CONSTRAINT pk_mao_obra_peca PRIMARY KEY (cd_id),
	CONSTRAINT fk_mao_obra_peca_01 FOREIGN KEY (cd_mao_obra) REFERENCES mao_obra(cd_id),
	CONSTRAINT fk_mao_obra_peca_02 FOREIGN KEY (cd_peca) REFERENCES peca(cd_id)
);

CREATE TABLE saida_veiculo( 
	cd_id serial,
	cd_mao_obra integer,
	dt_saida DATE,
	fg_tipo_pagamento integer,

	CONSTRAINT pk_saida_veiculo PRIMARY KEY (cd_id),
	CONSTRAINT fk_saida_veiculo_01 FOREIGN KEY (cd_mao_obra) REFERENCES mao_obra(cd_id)	
);

/*
CREATE TABLE USUARIO (

ID_ATENDENTE INT

FUNCAO VARCHAR(30),

NIVELFUNC NUMERIC(1),

DATAVALIDADE date,

BLOQUEIOUSUARIO CHAR*/