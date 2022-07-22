create schema results;
create schema inputs;
create schema sqlmms;

# Verificando o conteúdo da tabela

select
	*
from
	inputs.train
Limit 100
;

# ou

use inputs;
select * from train Limit 100;

#Filtrando apenas as linhas que contêm indivíduos do sexo masculino.#

select * from inputs.train where Sex in ('male');

#Filtrando apenas as linhas que contêm indivíduos do sexo feminino e que tenham embarcado nos portos Q ou S.#

select * from inputs.train where Sex in ('female') and Embarked in ('Q', 'S');

#Filtrando linhas com indivíduos do sexo masculino, com idade entre 20 e 45 anos#
#e que tenham embarcado apenas no porto Q#

select
	*
from
	inputs.train
where Sex in ('male') and
Age between 20 and 45 and
Embarked in ('Q')
;

#Agregações#
#Idade média dos indivíduos que sobreviveram por classe#

Select
	PClass,
    round(avg(Age),0) as Idade_Media,
    count(*) as Quantidade_Sobreviventes
from
	inputs.train
where Survived = 1
group by PClass
order by PClass
;

#Cálculo do volume e a taxa de sobreviventes por porto de embarcação.#
#Considerando apenas os portos S, Q e C.#

select
	Embarked,
    count(*) as Volume,
    round(100*avg(Survived),1) as Taxa_Sobreviventes
from
	inputs.train
where Embarked in ('S', 'Q', 'C')
group by Embarked
;

#Estatística descritiva básica sobe os dados#

#Média de sobreviventes por Classe (PClass)#

Select
	Pclass,
    round(avg(Survived),2) as Medida_Sobreviventes_Classe
from
	inputs.train
group by Pclass
order by Pclass
;

#Média de sobreviventes por sexo.#

Select
	Sex,
    count(*) as Individuos,
    sum(Survived) as Sobreviventes,
    round(avg(Survived),2) as Medida_Sobrevivenes_sexo
from
	inputs.train
group by Sex
;

#Quantidade de sobreviventes por sexo#

Select
	Sex,
    count(*) as Sobreviventes
from
	inputs.train
where Survived = 1
group by Sex
;

#Média de sobreviventes por quantidade de parentes no navio (SibSp + Parch)#

Select
	(SibSp + Parch) as Tamanho_Familia,
	round(avg(Survived),2) as Media_Sobreviventes
from
	inputs.train
group by (SibSp + Parch)
;

#Média de sobreviventes para faixa etária abaixo de 10 anos#

Select
	round(avg(Survived),2) as Media_Sobreviventes_menor_10anos
from
	inputs.train
where Age < 10
;

#Quantidade de pessoas com menos de dez anos de idade.#
Select
	count(*) as Quantidade_pessoas_menor_10anos
from
	inputs.train
where Age < 10
;

#Quantiade de pessoas sobreviventes com menos de dez anos de idade#

Select
	sum(Survived) as Sobreviventes_menor_10anos
from
	inputs.train
where Age < 10
;

#Média de sobreviventes para faixa etária entre 30 e 45 anos.#

Select
	round(avg(Survived),2) as Media_Sobreviventes_entre_30_45_anos
from
	inputs.train
where Age between 30 and 45
;

#Indivíduos com idedade entre 30 e 45 anos#

Select
	count(*) as Individuos_idade_entre_30_45anos
from
	inputs.train
where Age between 30 and 45
;

#Sobreviventes com idade entre 30 e 45 anos#

Select
	sum(Survived) as Quantidade_individuos_idade_entre_30_45anos
from
	inputs.train
where Age between 30 and 45
;

#Calcule uma nova variável que vai representar o tamanho da família no navio
#A regra para construir esta variável é apenas a soma das variáveis SibSp e Parch. 
#Por fim vamos salvar a tabela resultante na schema resultados

Create table results.abt_01
Select
	*,
    SibSp + Parch as Tamanho_Familia
from
	inputs.train
;

Select * from results.abt_01;