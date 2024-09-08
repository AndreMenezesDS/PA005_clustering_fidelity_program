
# 'ALL IN ONE PLACE' ECOMMERCE - AGRUPAMENTO DE CLIENTES(CLUSTERIZAÇÃO)

<div align="center">
  
  ![E-Commerce Logo](img/ecommerce.jpg "E-Commerce Logo")
  
</div>

_A demonstração detalhada do código pode ser encontrada [neste link.](https://github.com/AndreMenezesDS/PA005_clustering_fidelity_program/blob/main/src/models/pa005_05_deploy_cloud_2.ipynb)_

# 1. RESUMO

___

A empresa ‘All in One Place’ é uma outlet multimarcas, ou seja, comercializa produtos de segunda mão de várias marcas a um preço menor, através de um e-commerce.

Em pouco mais de 1 ano de operação, o time de marketing percebeu que alguns clientes de sua base compram produtos mais caros, com maior frequência e acabam contribuindo com uma parcela significativa do faturamento da empresa.

Baseado nessa percepção, o time de marketing vai lançar um programa de fidelidade para os melhores clientes da base -chamado Insiders- Entretanto, o time não tem um conhecimento avançado em análise de dados para eleger os participantes do programa.

Por esse motivo, o time de marketing requisitou ao time de dados uma seleção de clientes elegíveis ao programa, usando técnicas avançadas de manipulação de dados.

__*Este é um projeto fictício. A empresa, o contexto e as perguntas de negócios não são reais.__

# 2. O PROBLEMA DE NEGÓCIO

___

## 2.1 Descrição do Problema
Em vias de obter vantagem competitiva no setor de E-commerce, a 'All in One Place' entendeu que seria interessante ter maior compreensão do comportamento dos clientes através do estudo dos dados de suas transações (compras) feitas com a empresa, coletadas durante um ano de operação.

O time de negócios então optou pela separação em grupos dos clientes da base de dados da empresa, onde as características de cada agrupamento iria pautar as tomadas de decisões personalizadas e exclusivas para incentivar a fidelidade de cada comprador, e mais importante, o aumento do faturamento da empresa. Para isso, incubiu ao time de cientistas de dados que determinasse o método para realização desse agrupamento (clusterização) e retornasse uma lista contendo a classificação final do grupo pertencente a cada cliente.

De posse dessa lista, o conjunto de grupos com maior representatividade no faturamento da empresa seria escolhido para integrar um grupo especial de beneficiados em ações da empresa (denominado 'Insiders'). Além dessa classificação, determinou-se que deveria ser apresentado um relatório contendo as respostas para as seguintes perguntas:

1. Quem são as pessoas elegíveis para participar do programa de Insiders?
2. Quantos clientes farão parte do grupo?
3. Quais são as principais características desses clientes?
4. Qual a porcentagem de contribuição do faturamento vinda do grupo de Insiders?
5. Quais as condições para uma pessoa ser elegível ao Insiders?
6. Quais ações o time de marketing pode realizar para aumentar o faturamento?

## 2.2 Proposta de Solução

Dado o problema de negócio, Eu (Cientista de Dados) propus uma solução: Retornar à empresa um modelo de aprendizado de máquina capaz de realizar uma classificação automática de cada cliente a medida que novos dados sejam adicionados a base de dados, ou seja, após uma classificação inicial e caracterização do que determina cada cluster, novos dados aplicados sobre o modelo seriam classificados de acordo com a maior proximidade a um dos grupos (clusters) estabelecidos.

A definição desses clusters então, seria apenas alterada caso novas características de transações fossem adicionadas ao problema (novas variavéis/features), já em ciclos posteriores de uso do modelo.

Para além do tabela contendo a classificação de cada cliente, as respostas exigidas em relatório ao término do projeto foram também apresentadas através de uma ferramenta de BI (Metabase/Power BI) com um dashboard atualizado em tempo real conforme mudanças na base de dados, facilitando o storytelling e demonstração de insights sobre a classificação realizada sobre os clientes.
A imagem abaixo é uma demonstração do dashboard ao término do atual ciclo de desenvolvimento:

<div align="center">

![Dashboard - deploy](img/dashboard_deploy.png "Dashboard - Deploy")

</div>

## 2.3 Premissas de Negócio

*   Clientes determinados como 'Insiders' deverão ser aqueles que representam maior parte do faturamento da empresa.
*   A prática de ações de negócios (oferecimento de descontos, cross-sell, marketing direcionado, recomendações) deverão aumentar a fidelidade cliente-empresa.
*   A aprendizagem não supervisionada obtida pela clusterização de clientes poderá também ser incorporada em outros processos/modelos de machine learning da empresa.
*   Uma dada classificação será considerada satisfatória apenas se, para além do score de funcionamento do modelo (separabilidade de grupos, sinalizada pela métrica Silhouette Score), fizer sentido para a aplicação e aumento de rendimento do time de negócios.

# 3. METODOLOGIA APLICADA

___

A criação desse projeto se deu com base no processo produtivo _CRISP-DM (Cross Industry Standard Proccess to Data Mining)_, que refere-se à aplicação de um modelo cíclico para o curso de desenvolvimento e entrega do modelo de _aprendizagem de máquina (Machine Learning)_ posto em produção.
A adoção deste modelo nos permite rapidez na entrega de valor bem como uma estruturação sólida para a tomada de decisões, garantindo a evolução nos resultados observados a cada ciclo.

<div align="center">

![CRISP-DM BR](img/crisp_dm_br.png "CRISP-DM BR")

</div>

**IMPORTANTE:** Diferente de modelos de aprendizagem de máquina supervisionados, o modelo de clusterização desse projeto **não** contém uma métrica de erro associada ao seu funcionamento por se tratar de um aprendizado _não supervisionado_. Dessa forma, foi realizada a iteração de vários ciclos do CRISP-DM antes de sua primeira implementação em produção, uma vez que fez-se necessária a validação de cada alteração na base de dados com a proposta de negócio para determinar se a separação resultante proposta pelo modelo era satisfatória ou não.

# 4.0 DESCRIÇÃO INICIAL DOS DADOS

____

Inicialmente, o conjunto de dados que representam o contexto foi disponibilizado em servidor privado através de um arquivo .csv. Este arquivo foi então carregado localmente durante o desenvolvimento do projeto.

## 4.1 Dimensão dos Dados

Esse conjunto de dados contém inicialmente informações de cadastro de **541909 transações (linhas)** de acordo com **8 características individuais (colunas)**. Serão estes os dados usados para o desenvolvimento das hipóteses de projeto.

## 4.2 Descrição dos Atributos


<div align="center" >

| Atributos             | Significado|
| ----------------------------- | ------------------------------------------------- |
| InvoiceNo                     | Identificador único de cada transação             |
| StockCode                     | Código de identificação do item comprado          |
| Description                   | Nome e Descrição do item comprado                 |
| Quantity                      | Quantidade adquirida do item comprado             |
| InvoiceDate                   | O dia em que a transação ocorreu                  |
| UnitPrice                     | Preço unitário do produto comprado                |
| CustomerID                    | identificador único do cliente comprador          |
| Country                       | País onde foi realizada a transação               |


</div>

### 4.2.1 Tipos de Dados

<div align="center">

  !['Tipos de Dados'](img/data_types.png "Tipos de Dados")
  
</div>

Temos um dataset com maior parte das informações do tipo texto (Tipo _object_, conforme as colunas _InvoiceNo, StockCode, Description, InvoiceDate e Country_), o que constitui numa dificuldade inicial para a definição de um espaço de dados mensurável. Nota-se também inconsistência na base de dados, que apresenta muitos dados faltantes.
Os ciclos de desenvolvimento se iniciam como etapas de tratamento de dados e feature engineering a partir das variáveis numéricas (_Quantity e UnitPrice_) de forma a ter as primeiras visualizações da disposição dos dados para posterior aplicação dos modelos de clusterização.

#   5.0 CICLOS DE DESENVOLVIMENTO

____

Para manuntenção da fácil legibilidade e compreensão desse documento de apresentação, optou-se em seguir a apresentação com os insights, resultados e etapas de destaque provenientes do projeto.

Para entendimento do detalhamento extensivo das alterações realizadas em cada ciclo, estes podem ser encontrados _[neste link.](https://github.com/AndreMenezesDS/PA005_clustering_fidelity_program/blob/main/ciclos_desenvolvimento.md)_

# 6. TOP 3 DATA INSIGHTS

_____

**H1. Clientes do Grupo Insiders apresentam índice de maior variedade na compra de produtos de 10% ou mais quando em comparação a não-insiders.**

_VERDADEIRO_: Insiders apresentam maior variação na compra de produtos com um índice em média 73% maior.

**H2. Clientes do Grupo Insiders consituem mais da metade da renda de todos os clientes da base de dados.**

_VERDADEIRO_: O Grupo insiders soma até 86.76% de toda a receita da base de dados, enquanto constituem aproximadamente 51.11% de todos os clientes da base (Mais da Metade dos Clientes da base de dados).

**H3.Clientes do Grupo Insiders tem em média 10% menos produtos retornados que a média observada para clientes não-insiders.**

_FALSO_: Clientes insiders retornam/cancelam a compra de produtos 2x mais do que a média global.

# 7. PERFORMANCE FINAL DO MODELO DE MACHINE LEARNING

___

Após a execução do pipeline do projeto em servidor remoto, obteve-se a separação final dos dados com a seguinte designação de clusters:

<div align="center">

!['Clusterização Embedd - Ciclo 05'](img/cycle05_deploy_clusters.png "Clusterização Embedd - Ciclo 05")

!['Cluster Profile Embedd Insiders- Ciclo 05'](img/cluster_profile05_deploy1.png "Clusterização Embedd Insiders - Ciclo 05")

!['Cluster Profile Embedd Viability Analysis- Ciclo 05'](img/cluster_profile05_deploy2.png "Clusterização Embedd grupo de análise - Ciclo 05")

!['Cluster Profile Embedd Não Selecionados- Ciclo 05'](img/cluster_profile05_deploy3.png "Clusterização Embedd Não Selecionados - Ciclo 05")
  
</div>
 
Tais resultados foram possíveis após a realização de 5 ciclos de projetos, cada qual com suas alterações e respectivos resultados conforme documentado _[neste link.](https://github.com/AndreMenezesDS/PA005_clustering_fidelity_program/blob/main/ciclos_desenvolvimento.md)_

_
Elencando de forma resumida as técnicas utilizadas para reorganização e agrupamento dos dados, temos:

1.    **Tratamento de Dados**

        Limpeza realizada no ínicio de cada ciclo, visando estabelecer maior integridade aos dados que posteriormente serão usados. Compreende processos de remoção/preenchimento de dados faltantes, tipagem das variáveis, remoção de duplicatas e correção de dados inconsistentes.       

2.    **Feature Engineering**

        Criação e seleção de variavéis a partir da inferência dos dados e informações inicialmente dispostos pelo problema de negócio, com objetivo de obter ganho de informação sobre o evento estudado.

3.    **Análise Exploratória dos Dados**

        Objetiva examinar quais das variavéis selecionadas trazem ganho de informação para a aplicação do modelo, determinadas através de análises de métricas que expressam a _variabilidade_ da distribuição de uma variável isoladamente (Ex:Range, Desvio padrão, Variância, Coeficiente de Variação) ou em análise conjunta com outras variáveis (Analisadas em plotagens por pares).
        É também analisada a presença de outliers nos dados, fazendo-se um estudo da anormalidade do seu comportamente e eliminando tais dados quando necessário.

4.    **Preparação dos Dados e Aplicação ao Modelo de Machine Learning**

        Etapa de padronização/reescala para preparação dos dados, tornando-os aplicavéis para a execução de cálculos do modelo.
        Neste projeto, foi também realizada uma etapa de estudo do espaço dos dados, de maneira a otimizar a separação automatica efetuada pelo modelo de clusterização escolhido (KMeans).

5.    **Análise dos Resultados**

        A Análise dos Resultados foi feita não somente pela métrica de funcionamento do modelo (Silhouette Score), como também foram observados o perfil (profiling) de cada cluster formado a partir de suas métricas de têndencia central (médias), que definem o centroíde de cada cluster no espaço.
        A partir desses valores obtidos, foram feitas observações individualizadas para cada cluster, gerando vantagem na tomada de decisões por parte do time de negócios.


# 8. RESULTADOS DE NEGÓCIO

_____

Como forma de fácil visualização, foi feito um dashboard contendo os insights mais interessantes, que então responde as perguntas propostas inicialmente pelo problema de negócios:

<div align="center">

![Dashboard - deploy](img/dashboard_deploy.png "Dashboard - Deploy")

</div>

1.    **Quais os clientes elegíveis a fazer parte de grupo Insiders?**

        Clientes categorizados dentro dos grupos(clusters) 1,4,5 e 8 após a aplicação do modelo de machine learning. 

2.    **Quantos Clientes foram selecionados?**

        Foram selecionados 2910 clientes distintos(customer_id)

3.    **Quais as características(features) que mais impactam na escolha de um cliente para integrar o grupo Insiders?**

        As features escolhidas para a aplicação no modelo foram: _revenue_(Retorno Monetário), _distinct_stock_code_(Contagem de produtos distintos comprados pelo cliente), _basket_size_(Número médio de itens por transação efetuada pelo cliente), _returned_(Contagem de produtos retornados pelo cliente)        

4.    **Qual a porcentagem de contribuição do faturamento vinda do grupo Insiders?**

        O Grupo Insiders representa 86.76% do total faturamento da empresa.

5.    **Quais as principais condições que tornam um cliente elegível ao grupo Insiders?**

        A escolha dos integrantes do Grupo Insiders pode ser observada entre os clientes que possuem tendência a apresentar maiores valores para _revenue, distinct_stock_code e basket_size_, além de valores baixos para _recency e returned_.

6.    **Quais ações o time de marketing pode realizar para aumentar o faturamento?**

        Cada um dos 10 clusters recebeu uma recomendação exclusiva com o intuito de aproximar, na medida do possível, a rentabilidade dos clientes da base de dados para se aproximar do comportamento dos clusters que constituem o grupo Insiders.
        Alguns exemplos citados foram a prática de cross-selling, promoções e marketing direcionado, viabilidade de mais métodos de pagamento,etc.


# 9. CONCLUSÕES

_____

A particularidade observada para a resolução de um problema que envolve o uso do aprendizado de máquina não supervisionado reside no fato destes algoritmos não possuírem alguma métrica que expressa a eficácia do agrupamento feito mediante a alguma métrica que informe uma margem de erro.

Isso provoca uma alteração na forma de monitoramento dos resultados: Ainda que a sequência global de etapas propostas pelo CRISP-DS continue válida, muitas vezes faz-se necessária a verificação imediata do impacto direto que cada alteração na base provoca quando da organização dos dados ao qual o algoritmo de clusterização realiza o agrupamento.

Dessa forma, pode-ser observado nos primeiros ciclos a supressão/simplificação de algumas das etapas de forma a obter maior clareza e validação da natureza dos dados junto ao problema de negócios, para apenas posteriormente implementar etapas adicionais, até a viabilidade de execução de um pipeline completo conforme proposto pelo CRISP-DS.



# 10. LIÇÕES APRENDIDAS

_____

A maior parte dos ganhos de performance quando da separação das entradas da base de dados em grupos distintos foram provenientes da definição de um **espaço de dados consistente**.

Mais importante do que a complexidade do modelo a ser utilizado, a identificação de padrões de forma precisa e eficiente em uma base de dados passa por sua integridade e ganho de informação que suas variáveis proporcionam; não obstante, a grande maioria dos procedimentos realizados nesse projeto foram esforços no sentido de estudar a natureza de cada variável(dimensão) e suas distribuições.

# 11. PRÓXIMOS PASSOS

_____

-   Procurar incluir novos padrões a partir dos dados categóricos (tipo texto) da base de dados original, desconsiderados nos primeiros ciclos do projeto;
-   Estudar o comportamento de diferentes espaços de dados, procurando reorganizá-los com outros algoritmos além da Random Forest;
-   Testagem de algoritmos diferentes para redução de dimensionalidade, comparando os resultados com o _UMAP_ aplicado neste projeto.

# 12. FERRAMENTAS E TÉCNICAS UTILIZADAS

_____

-   Backend & Data Science: [![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)](https://www.python.org/downloads/release/python-380/)  ![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white) [![Linux Server](https://img.shields.io/badge/-Linux%20Server-FCC624?logo=linux&logoColor=black&style=for-the-badge)](https://www.redhat.com/pt-br/topics/linux/linux-server) [![Ubuntu](https://img.shields.io/badge/-Ubuntu-E95420?logo=ubuntu&logoColor=white&style=for-the-badge)](https://ubuntu.com/)
-   Apresentação & Frontend : ![HTML5](https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white) [![Markdown](https://img.shields.io/badge/markdown-%23000000.svg?style=for-the-badge&logo=markdown&logoColor=white)](https://www.markdownguide.org/) [![Metabase](https://img.shields.io/badge/-Metabase-509EE3?logo=metabase&logoColor=white&style=for-the-badge)](https://www.metabase.com/) [![Power BI](https://img.shields.io/badge/-Power%20BI-FCC624?style=for-the-badge)](https://www.microsoft.com/pt-br/power-platform/products/power-bi)
-   SQL & Databases: [![SQLite](https://img.shields.io/badge/-SQLite-003B57?logo=sqlite&logoColor=white&style=for-the-badge)](https://www.sqlite.org/) [![Postgres](https://img.shields.io/badge/postgresql-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
-  Machine Learning & Análise de Dados: [![Pandas](https://img.shields.io/badge/pandas-%23150458.svg?style=for-the-badge&logo=pandas&logoColor=white)](https://pandas.pydata.org/)  [![NumPy](https://img.shields.io/badge/numpy-%23013243.svg?style=for-the-badge&logo=numpy&logoColor=white)](https://numpy.org/)  [![Matplotlib](https://img.shields.io/badge/Matplotlib-%23ffffff.svg?style=for-the-badge&logo=Matplotlib&logoColor=black)](https://matplotlib.org/)  [![scikit-learn](https://img.shields.io/badge/scikit--learn-%23F7931E.svg?style=for-the-badge&logo=scikit-learn&logoColor=white)](https://scikit-learn.org/stable/)   [![Plotly](https://img.shields.io/badge/-Plotly-3F4F75?logo=plotly&logoColor=white&style=for-the-badge)](https://plotly.com/)  [![Scipy](https://img.shields.io/badge/-Scipy-8CAAE6?logo=scipy&logoColor=white&style=for-the-badge)](https://scipy.org/)
-  Deploy Hosting: [![Amazon Web Services](https://img.shields.io/badge/-Amazon%20Web%20Services-232F3E?logo=amazonwebservices&logoColor=yellow&style=for-the-badge)](https://aws.amazon.com/pt/?nc2=h_lg)  [![Amazon S3](https://img.shields.io/badge/-Amazon%20S3-569A31?logo=amazons3&logoColor=white&style=for-the-badge)](https://aws.amazon.com/pt/s3/) [![Amazon RDS](https://img.shields.io/badge/-Amazon%20RDS-527FFF?logo=amazonrds&logoColor=white&style=for-the-badge)](https://aws.amazon.com/pt/rds/) [![Amazon EC2](https://img.shields.io/badge/-Amazon%20EC2-FF9900?logo=amazonec2&logoColor=black&style=for-the-badge)](https://aws.amazon.com/pt/ec2/) 
- Editores & IDEs : [![VIM](https://img.shields.io/badge/-Vim-019733?logo=vim&logoColor=white&style=for-the-badge)](https://vimbook.site/) [![Jupyter Notebook](https://img.shields.io/badge/jupyter%20notebook-%23FA0F00.svg?style=for-the-badge&logo=jupyter&logoColor=white)](https://jupyter.org/)  [![Google Colab](https://img.shields.io/badge/-Google%20Colab-F9AB00?logo=googlecolab&logoColor=black&style=for-the-badge)](https://code.visualstudio.com/) [![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)](https://colab.research.google.com/)
- Versionamento de Código: [![Git](https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white)](https://git-scm.com/) [	![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)](https://github.com/)
- [Análise Exploratória de Dados](!https://www.ibm.com/br-pt/cloud/learn/exploratory-data-analysis)


#   13. CONTATOS    

_____

- [![Gmail](https://img.shields.io/badge/-Gmail-EA4335?logo=Gmail&logoColor=white&style=for-the-badge)](andre.menezes@unesp.br) ou [![Gmail](https://img.shields.io/badge/-Gmail-EA4335?logo=Gmail&logoColor=white&style=for-the-badge)](andalves994@gmail.com)
- [![LinkedIn](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/andremenezesds/)
- [![Telegram](https://img.shields.io/badge/-Telegram-26A5E4?logo=Telegram&logoColor=white&style=for-the-badge)](https://t.me/andre_menezes_94)

