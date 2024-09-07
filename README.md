
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


<div style="text-align: center;">

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

##  5.1 Ciclo 1 - Modelo RFM e Métricas de Validação de Cluster

**1.    Tratativas iniciais dos dados**

*   Foram desconsideradas colunas com dados faltantes para customer_id, bem como também foram desconsideradas entradas com valor de preço (_unit_price_) e quantidade(_quantity_) negativos. Tal decisão foi pautada na escolha de realizar esse ciclo com a finalidade de observar o comportamento da maior parte da base de dados original.
*  A coluna _invoice_date_ teve seu tipo alterado de _object_ para _datetime64_ seguindo formato 'Y%-m%-d%'. **Essa alteração será adotada como padrão para os ciclos de desenvolvimento posteriores.** 


**2.  Modelo RFM - Feature Engineering**

O primeiro ciclo do projeto foi desenvolvido com o objetivo de obter maior clareza quanto a visualização da disposição inicial de dados. Para tanto, criou-se uma nova base de dados a partir dos dados númericos da base original (_Quantity_ e _UnitPrice_) de acordo com a técnica RFM, isto é, com a definição das características de **Recência, Frequência e retorno Monetário**, cada qual agora **agrupada por cada cliente**. Dessa forma, o _feature engineering_ é definido:

-   Recency (Recência de compra → Valor determinado a partir da diferença entre a data de compra mais recente e o valor de cada compra)
-   Frequency (Frequencia de compra realizada por um mesmo comprador)
-   Monetização ( Indicado na nova base como _revenue_ -> Receita total gerada por um cliente e Ticket Médio de compra de um cliente)

**3.    Clusterização Inicial (KMeans) e métricas do modelo**

Foi feita a aplicação da base de dados RFM em um modelo de clusterização (KMeans), de forma a observar as métricas iniciais para avaliação da clusterização, a saber:

-   WSS (Within-Cluster Sum of Squares) → Medida que indica a coesão dos Clusters
-   Silhouette Score →Medida que indica a coesão intra clusters e a distância inter-cluster(Compreende valores entre 0 e 1 -> Quanto mais próximo de 1, mais coeso internamente é um cluster, bem como mais separado este cluster está em relação a outro.).
-   Silhouette analysis → Análise de silhueta da disposição de cada cluster

Optou-se por priorizar a Silhouette Score como a métrica de avaliação do modelo a ser usada devido a maior abrangência de informações que seu valor expressa. Inicialmente, o modelo obteve uma clusterização de 0.95 para um agrupamento de k=3 grupos.

<div align="center">

  !['Silhouette Score'](img/kmeans_ss_cycle01.png "Silhouette Score - Cycle01")
  
</div>

A primeira vista, esse valor obtido de SS = 0.95 parece ótimo, entretanto, é mandatório ressaltar que **a análise de um modelo de clusterização jamais deve ser baseada exclusivamente em suas métricas de performance, uma vez que não há um erro associado.** Para ter certeza da qualidade da separação para os fins do negócio, sempre faz-se necessária uma  posterior **Análise de Clusters**.

**4.    Análise de Clusters**

- 'O valor de silhouette score (SS=0.95) retornado é alto; Isto significa que o modelo retornou bons agrupamentos da base de dados?'

A resposta para a pergunta acima é: Nem Sempre! O Silhouette Score é uma métrica que indica apenas a o quão bem separados estão os grupos que o modelo atribuiu, e não que foi feito um bom agrupamento para negócio, conforme veremos a seguir.

-   Análise Visual

Para a visualização da disposição dos clusters em um espaço bidimensional, faz-se necessário o uso de técnicas da Álgebra linear para redução de dimensionalidade.
Neste ciclo, fez-se a aproximação de 3 dimensões (Recência, Frequência e retorno Monetário) para uma projeção em 2 dimensões, agora visível em uma plotagem em gráfico com eixos xy. 
A técnica utilizada nesse ciclo e ao longo do projeto foi o algoritmo **UMAP (Uniform Manifold Aproximation and Projection)** que nos retorna a seguinte projeção dos dados já categorizados em clusters pra 2 dimensões:

<div align="center">

  !['Clusterização - Ciclo 01'](img/cycle01_clusters.png "Clusterização - Ciclo 01")
  
</div>

Nota-se que de fato os grupos definidos estão bem separados; entretanto, a diferenciação de volume (quantidade de entradas) entre os clusters é muito acentuada e ainda retorna pouco valor como resposta ao problema de negócio.

- Cluster Profile → Descrição de Clusters a partir dos valores de cada centroíde
 
Junto à visualização gráfica, também descreve-se cada cluster a partir das médias de cada variável contabilizadas para o total de entradas em cada grupo.
O resultado obtido na clusterização desse ciclo segue:

<div align="center">

  !['luster Profile - Ciclo 01'](img/cluster_profile01.png "Cluster Profile - Ciclo 01")
  
</div>

A diminuição da grande diferença observada no número de entradas caracterizadas em cada agrupamento será então objetivo dos próximos ciclos de desenvolvimento, com maior enfâse na limpeza e preparação dos dados,além do ganho de informação com mais etapas de feature engineering.

## 5.2 Ciclo 2 - Limpeza de Dados e Análise Descritiva

Partindo da base de dados original, novas alterações foram feitas:

**1.    Limpeza(pré-tratamento) dos dados**
-   **Dados Numéricos**
    -   Entradas com valores de _unit_price_ abaixo de $0.01 foram descartadas;
    -   O Dataset foi dividido em ‘Dataset de compra’ e ‘Dataset de entradas canceladas’, mediante verificação dos valores negativos para _quantity_, sempre correspondentes com chamados de código com padrão Cxxxxxx, que para este ciclo, foram descartadas.
-   **Dados Categóricos**
    -   Entradas com _stock_product_ contendo valor em string (código que não identifica compra de um produto; ['POST' 'D' 'M' 'PADS' 'DOT' 'CRUK']), foram descartadas;
    -   Entradas com países não específicados foram descartadas;
    -   Coluna _Description_ foi desconsiderada.  

**2. Feature Engineering**

 Repetiu-se o uso da adoção do modelo RFM para a base de dados, com a criação das features para recência (_recency_), frequência(_frequency_) e retorno Monetário (_revenue_), dessa vez aplicada somente a base designada anteriormente como 'dataset de compra'.
 
 **3. Preparação dos Dados**
 
 Foi feita uma **reescala** a partir dos valores mínimo e máximo de cada coluna _(MinMaxScaler)_ que assume 0 para valores mais próximos do mínimo de cada coluna e 1 para valores mais próximos ao valor máximo.

 Essa forma de reescala de dados permite manter a proporção de distâncias entre valores de uma coluna, ao passo em que viabiliza cálculos baseados em distância com outras váriaveis reescalados na mesma proporção para aplicação em modelos de machine learning que baseiam seus cálculos nessa métrica, como o KMeans utilizado em nosso projeto.

 É importante notar que para distribuição não normal dos dados, tal qual observado pelo _problema de cauda longa_ comumente associado à bases de dados de e-commerce onde as features apresentam grande concentração de entradas nos valores mais baixos e outliers esparsos para valores mais altos, a escolha do _MinMaxScaler_ foi tomada como padrão para a reescala de variáveis que apresentam esse comportamento.

 A figura a seguir exemplifica uma distribuição típica do problema de cauda longa para a váriavel _revenue_, ou seja, a receita média gerada por cada cliente:
 
  <div align="center">

  !['Cauda Longa - Exemplo'](img/cauda_longa_ex.png "Cauda longa - Exemplo")
  
</div>
 
 **4. Aplicação e Avaliação da Clusterização**
 
 A aplicação do KMeans para a separação em grupos do nosso conjunto de dados atualizado nos retorna um _silhouette score_ de 0.59 para um número igual de 3 grupos(SS = 0.59, k=3).
 Em comparação ao primeiro ciclo, esse score nos aponta pra um conjunto de dados com grupos menos separados entre si, que pode ser verificado visualmente pela projeção dos clusters para duas dimensões:
 
 <div align="center">

  !['Clusterização - Ciclo 02'](img/cycle02_clusters.png "Clusterização - Ciclo 02")
  
</div>

A descrição de cada cluster a partir do valor médio de cada variável nos mostra, entretanto, que obtivemos uma separação mais aplicável ao nosso contexto de negócio, ao passo em que a limpeza dos dados diminuiu em parte a larga diferença no número de integrantes de cada cluster:

<div align="center">

  !['Cluster Profile - Ciclo 02'](img/cluster_profile02.png "Cluster Profile - Ciclo 02")
  
</div>
 
##  5.3 Ciclo 3 - Feature Engineering, EDA e Testagem de Modelos de Clusterização
 
 **1.   Limpeza de Dados e Feature Engineering**
 A principal alteração em comparação ao ciclo anterior foi o preenchimento dos dados faltantes para a coluna _customer_id_. O preenchimento foi feito individualmente, iniciando uma contagem com valores de 19000 em diante.
 Com esse acréscimo de novos dados a base de dados do ciclo anterior, seguem as tratativas dos dados:
 
*   **Premissas Adotadas**
    *   As tratativas para remoção de dados inconsistentes (_invoice_no_ com string no padrão CXXXXXX foram separados num dataset a parte, com os dados indicando entradas canceladas(dataset com transações de retorno de compras); entradas com unit_price < 0 removidas);
    *   Entradas em string para _stock_product_ que não identificam compra de um produto foram descartadas ([ ‘POST’, ‘D’, ‘DOT’, ‘M’, ‘S’, ‘AMAZONFEE’, ‘m’, ‘DCGSSBOY’, ‘DCGSSGIRL’, ‘PADS’, ‘B’, ‘CRUK’]).
*   **Feature Engineering**

    Foi feito novamente procedimento semelhante aos ciclos anteriores: Fez-se um agrupamento dos dados para cada cliente, aos quais além das features do modelo RFM(_recency_, _frequency_ e _revenue_) temos a criação de novas variáveis a partir da inferência de informações existentes na base de dados inicial, a saber:

    *   _avg_recency_days_: Média de dias decorridos para o retorno de um cliente;
    *   _total_purchases_: Número total de compras realizadas por um cliente;
    *   _basket_size_: Média do número de produtos por compra efetuada de um cliente;
    *   _unique_basket_size_: Médio do número de produtos distintos por compra efetuada de um cliente;
    *   _returned_: Número total de produtos retornados por cliente (Soma das entradas com valor de quantity negativo para dado cliente)

**2. Análise Exploratória de Dados** 
 
O objetivo com a análise das features é identificar quais introduzem maior variabilidade e ganho de informação para a aplicação em nosso modelo de clusterização.

*  **Análise Univariada**

    *   Análise de métricas de tendência central (Média e Mediana) para verificação de outliers → **Valores muito distantes dessas métricas ( assumida maior que 2.5x a distância interquartil), foram analisados e, quando necessário, eliminados**;
    *   Análise de métricas de dispersão (Range, Desvio padrão, Variância, Coeficiente de Variação) para a análise de variabiliade dentro da escala da variável → Objetiva-se manter features com alta variância/Coef de variação.
        
*   **Análise Bivariada**

    É inspecionado o comportamento da correlação entre as variáveis par a par, de forma a verificar plotagens que apresentam pouca variação visual (similares a outras variáveis) para exclusão de dada feature do modelo (Pouca Variabilidade).
    Foi possível observar que alguns grupos de features apresentam comportamento semelhante, a saber:
    
    *   _basket_size_ vs _unique_basket_size_
    *   _total_purchases_ vs _total_products_ vs _distinct_stock_code_
    *   _recency_ vs _average_recency_days_
    
    Dessa forma, váriaveis que envolvem a agregação de outras variáveis em média (_average_recency_days_) tiveram seu uso no modelo descartado.
    Nota-se também pouca variabilidade quando da plotagem da variável _frequency_ com as demais do banco de dados.
    Abaixo, a plotagem das váriaveis par a par:
    
<div align="center">

  !['Análise Bivariada - Ciclo 03'](img/bivariative_analysis_cycle03.png "Análise Bivariada - Ciclo 03")
  
</div>
    
**3.    Preparação dos Dados**

Novamente, o comportamento da distribuição dos dados observado em cada variável foi não-normal, semelhante ao visto no _problema de cauda longa_, justificando a aplicação da reescala a partir dos valores mínimos e máximos (_MinMaxScaler_).

**4.    Estudo do Espaço de Dados**

Objetivando obter clara representação dos dados em alta dimensionalidade foram testados diferentes **espaços de dados** para visualização de suas projeções para 2 dimensões, feitas pelos seguintes algortimos, a saber: _UMAP_, _t-SNE_ e _espaço formado por Árvores de Decisão + UMAP_. A estes novos espaços de dados obtidos, damos o nome de **espaço de embedding.**
O comparativo da reorganização da base de dados de acordo com a redução de dimensionalidade feita por cada um dos algoritmos (_UMAP_, _t-SNE_ e _espaço formado por Árvores de Decisão + UMAP_, respectivamente da esquerda pra direita), segue:

<div style="display: flex; justify-content: space-between;">

  <img src="img/embedd_UMAP_cycle03.png" alt="UMAP Embedd" style="width: 33%;"/>
  <img src="img/embedd_tsne_cycle03.png" alt="t-SNE Embedd" style="width: 33%;"/>
  <img src="img/embedd_tree_cycle03.png" alt="Árvores de decisão + UMAP" style="width: 33%;"/>
  
</div>

A partir da inspeção visual, podemos confirmar que o espaço reorganizado pelo conjunto de aplicação da _Árvore de Decisão + UMAP_ retorna uma plotagem com maior clareza na distinção de grupos feitos pela separação da nossa base de dados.

Tal fato era esperado pois um modelo baseado em árvores de decisão possui **baixo viés**, e portanto, consegue capturar padrões mais amplos de um conjunto de dados não linear ao invés de detalhes específicos e potencialmente ruidosos. A aplicação conjunta com maior número de árvores (Floresta de decisão) também colabora para tornar a representação dos dados mais robusta a Outliers, mitigando sua propensão ao overfitting (alta variância).

Desta forma, a aplicação da nossa base de dados (espaço original de features) em uma Floresta de Decisão para regressão, faz com que cada cliente designado na base retorne o valor(index) da última folha da árvore ao qual foi feita uma separação de dados para dada instância. 

Para 'n' estimadores em uma floresta de decisão(no projeto definido n=100), a escolha aleatória do modelo para os separadores de cada folha deverá produzir n=100 pontos distintos para a formação de um **vetor de distância** representativo de cada cliente.

Esses vetores então serão reduzidos através da aplicação do _UMAP_, mostrando-nos então a projeção final dos nossos dados para duas dimensões, ao qual deverão ser aplicados os modelos de clusterização.

**5.    Aplicação aos Modelos de Clusterização**

Foram testados novos modelos de clusterização, com observação de seus resultados quanto a Silhouette Score para cada valor 'k' de clusters, a saber:

*   **KMeans**
    Modelo que baseia a separação das instâncias através de métricas que calculam a distância entre o centro de clusters;

*   **GMM (Gaussian Mixture Models)**
    Modelo que baseia a separação dos clusters através da probabilidade do pertencimento de dado ponto a um determinado cluster, dado pela disposição espacial da distribuição gaussiana (normal) de cada feature no espaço;

*   **Hierarquical Clustering**
    O algoritmo de clusterização hierárquico (HClustering) baseia-se na formação dos clusters através da hierarquia dos pontos presentes no espaço.
    Tal processo de formação de clusters pode ocorrer de duas formas:

    1. **Associativa** : baixo pra cima → Clusters se formam a partir de um único ponto aleatório no espaço que se associa aos mais próximos conforme eleva-se um grau na hierarquia.
    2. **Dissociativa**: Cima pra baixo → Clusters são definidos através da *divisão* do conjunto total de pontos no espaço até o grau hierárquico desejado.

*   **Density Based Scan (DBSCAN)**
    O modelo de clusterização Density Based Scan (DBSCAN) baseia a formação dos clusters de acordo com a densidade de pontos em dada região do espaço amostral.

Ao término dos testes, optou-se pela escolha do modelo KMeans pela melhor performance quanto ao Silhouette Score para aplicação da divisão dos clusters do **espaço de embedding designado pela Floresta de Decisão+UMAP.**
Tal fato também é esperado devido ao funcionamento do modelo, que baseia sua separação através de distâncias (tal qual o vetor anteriormente estabelecido pela random forest), assumindo clusters de formas circulares.

## 5.4 Ciclo 4 - Validação de Clusters - Local (Espaço Original de Features vs Espaço de Embedding)

Neste ciclo do projeto foram criados dois notebooks com a finalidade de comparar os resultados da clusterização realizada sobre o espaço original de features vs espaço de embedding.

**1.    Tratamento de Dados, Feature Engineering, EDA e Preparação dos Dados**

Foram mantidas as etapas de tratamento de dados e criação de features do último ciclo de projeto, agora com uma filtragem de variáveis/features de forma a manter apenas aquelas que trazem maior variabilidade e ganho de informação para o funcionamento dos modelos. As variáveis remanescentes aplicadas aos modelos de clusterização foram: _revenue_, _recency_, _distinct_stock_code_, _basket_size_, _returned_

**2.    Aplicação ao Modelo de Clusterização KMeans**

*   **Espaço de Features Original**
    Observou-se uma separabilidade maior para a separação em poucos clusters, determinada pelo Silhouette Score otimizado para ‘k’ clusters igual a 3. (SS = 0.63)

<div align="center">

!['Clusterização Original - Ciclo 04'](img/cycle04_original_clusters.png "Clusterização Original - Ciclo 04")

!['Cluster Profile Original- Ciclo 04'](img/cluster_profile04_original.png "Clusterização Original - Ciclo 04")
  
 </div>
 
 *  **Espaço de Embedding - Árvores de Decisão + UMAP**
    Observou-se uma separabilidade maior para a separação em números maiores de clusters, determinado pelo Silhouette Score otimizado para ‘k’ clusters igual a 10. (SS = 0.57)

    O Projeto seguiu com a escolha da base de dados reagrupada no espaço pela Árvore de Decisão (Espaço de Embedding), uma vez que a classificação das entradas da base com um número elevado de classificadores (árvores) permite uma segmentação mais variada que viabiliza a diferenciação de um maior número de clusters, mais escalável para a diferenciação dos grupos para a tomada de decisões comerciais pelo time de negócios.

    Os resultados obtidos após o término do ciclo realizado localmente foram:
 
<div align="center">

!['Clusterização Embedd - Ciclo 04'](img/cycle04_embedd_clusters.png "Clusterização Embedd - Ciclo 04")

!['Cluster Profile Embedd Insiders- Ciclo 04'](img/cluster_profile04_embedd1.png "Clusterização Embedd Insiders - Ciclo 04")

!['Cluster Profile Embedd Viability Analysis- Ciclo 04'](img/cluster_profile04_embedd2.png "Clusterização Embedd grupo de análise - Ciclo 04")

!['Cluster Profile Embedd Não Selecionados- Ciclo 04'](img/cluster_profile04_embedd3.png "Clusterização Embedd Não Selecionados - Ciclo 04")
  
 </div>

#   5.5 Ciclo 5 - Implementação do Modelo em Produção, Análise de Clusters(EDA) e Visualização Final

Neste ciclo de finalização do projeto, fez-se inicialmente uma **testagem local** do funcionamento do projeto, de forma a verificar o funcionamento de todas as etapas realizadas em conjunto e da arquitetura do projeto desde o carregamento inicial dos dados até a sua visualização final.

Garantido o funcionamento local, foi feita a implementação de cada funcionalidade do projeto em ferramentas de computação em nuvem (Amazon AWS), com a finalidade de executar uma **testagem remota** para escalar a implementação do modelo para qualquer computador com permissões de acesso verificadas.

1.  **Testagem Local**

    O Fluxo de Dados segue:

    - **Local Folder** → Pasta local com a base de dados (em arquivo .csv) original a ser carregada pelo arquivo do projeto (Jupyter Notebook).
    - **Jupyter Notebook** → Arquivo onde se carrega os dados e é executado todo o projeto, passando pelas etapas de limpeza e pré processamento dos dados, feature engineering, análise exploratória, preparação e aplicação aos modelos de Machine Learning e análise dos resultados obtidos.
    Ao final das etapas deste projeto, foi obtida uma tabela com a listagem de todos os clientes contendo sua respectiva classificação de elegibilidade ao grupo Insiders de acordo com o cluster classificado. Esta tabela foi então salva em um banco de dados para aplicação em uma ferramenta de visualização
    
        - **Cronjob - Papermill** → Aplicações responsáveis por executar periodicamente o arquivo de projeto em linha de comando. Tais execuções são responsáveis por atualizar o banco de dados, caso novos dados sejam adicionados em produção.
    - **Banco de Dados (SQLite)** → Banco de Dados local (SQLite) escolhido para armazenar a tabela final salva obtida pelo projeto.
    - **Dataviz (Metabase/Power BI) →** Ferramenta de visualização final dos dados. Recebe dados salvos no banco SQLite e são usados na demonstração de um dashboard com insights dos grupos de dados classificados, dinâmicamente atualizados de acordo com a atualização do banco de dados em produção.

<div align="center">

  !['Local Deploy'](img/deploy_infra_v1.png "Local Deploy")
  
</div>

2.  **Testagem Remota**

    O Fluxo de dados segue:

    - **Amazon S3 Bucket** → Drive de Armazenamento em nuvem. Usado para Carregamento de artefatos, isto é, arquivos que não sofrem alteração ao longo do projeto. Ex: Database inicial do projeto (arquivo .csv), transformações de variáveis e modelos de machine learning em serializações binárias (arquivos .pkl).
    - **Local Notebook** → Arquivo onde se carrega os dados e é executado todo o projeto, passando pelas etapas de limpeza e pré processamento dos dados, feature engineering, análise exploratória, preparação e aplicação aos modelos de Machine Learning e análise dos resultados obtidos.

        Ao final das etapas deste projeto, foi obtida uma tabela com a listagem de todos os clientes contendo sua respectiva classificação de elegibilidade ao grupo Insiders de acordo com o cluster classificado. 
    
        Esta tabela foi então salva em um banco de dados para aplicação em uma ferramenta de visualização

        *Diferenças da versão em Nuvem*: Agora o notebook é alimentado de um dispositivo de armazenamento externo (Amazon S3) que guarda a database .csv, bem como também efetua o salvamento da serialização de novas features em produção diretamente no mesmo dispositivo. Notar que a task de sincronização de execução do projeto não mais é feita localmente.
    
    - **Git (Repositório Local)** → Versionador de código, responsável por manter salvo localmente os estados dos arquivos de projeto (notebook) em um repositório local.
    - **Github (Repositório Remoto)** → Repositório remoto online, atualizado conforme as alterações feitas localmente via git, viabilizando a divulgação do projeto e atualizações de seu funcionamento para aplicações em nuvem.
    - **EC2 Deploy Notebook** → Cópia do notebook local de projeto, com suas dependências instaladas em um servidor linux remoto Amazon EC2, viabilizando a aplicação online do projeto de forma a garantir a atualização do banco de dados conforme execução sincronizada pelo cronjob.
        - **Cronjob - Papermill** → Aplicações responsáveis por executar periodicamente o arquivo de projeto em linha de comando. Tais execuções são responsáveis por atualizar o banco de dados, caso novos dados sejam adicionados em produção.
    - **Banco de Dados(Postgres) →** Banco de dados remoto (Amazon RDS - PostgreSQL) que recebe e armazena a tabela final obtida pela execução do notebook de projeto em produção, contendo a classificação do agrupamento de clientes.
    - **Dataviz (Metabase/Power BI) →** Ferramenta de visualização final dos dados. Recebe dados salvos no banco remoto PostgreSQL que são usados na demonstração de um dashboard com insights dos grupos de dados classificados, dinâmicamente atualizados de acordo com a atualização do banco de dados em produção.

    *Nota Importante*: A ferramenta de visualização pode ser implementada localmente ou em nuvem, a depender dos critérios de acesso e rentabilidade para sua aplicação que a empresa dispõe.

<div align="center">

  !['Cloud Deploy'](img/deploy_infra_v2.png "Cloud Deploy")
  
</div>
 
 Por fim, obtemos os resultados finais após a execução do pipeline em produção:
 
 <div align="center">

!['Clusterização Embedd - Ciclo 05'](img/cycle05_deploy_clusters.png "Clusterização Embedd - Ciclo 05")

!['Cluster Profile Embedd Insiders- Ciclo 05'](img/cluster_profile05_deploy1.png "Clusterização Embedd Insiders - Ciclo 05")

!['Cluster Profile Embedd Viability Analysis- Ciclo 05'](img/cluster_profile05_deploy2.png "Clusterização Embedd grupo de análise - Ciclo 05")

!['Cluster Profile Embedd Não Selecionados- Ciclo 05'](img/cluster_profile05_deploy3.png "Clusterização Embedd Não Selecionados - Ciclo 05")
  
 </div>
 
Finalizando o ciclo, foi feita uma análise exploratória (EDA) sobre os clusters obtidos e da visualização do dashboard de Insights, de forma a validar hipóteses sobre as diferenças de comportamento entre um cliente pertencente ao grupo insiders de um não pertencente. Estudados os comportamentos pelas hipóteses, respondeu-se então as perguntas de negócio que integraram o relatório a ser entregue.
Destacam-se os insights:

**H1. Clientes do Grupo Insiders apresentam índice de maior variedade na compra de produtos de 10% ou mais quando em comparação a não-insiders.**

_VERDADEIRO_: Insiders apresentam maior variação na compra de produtos com um índice em média 73% maior.

**H2. Clientes do Grupo Insiders consituem mais da metade da renda de todos os clientes da base de dados.**

_VERDADEIRO_: O Grupo insiders soma até 86.76% de toda a receita da base de dados, enquanto constituem aproximadamente 51.11% de todos os clientes da base (Mais da Metade dos Clientes da base de dados).

**H3.Clientes do Grupo Insiders tem em média 10% menos produtos retornados que a média observada para clientes não-insiders.**

_FALSO_: Clientes insiders retornam/cancelam a compra de produtos 2x mais do que a média global.
 
 Por fim, temos as respostas que integrarão o relatório solicitado no problema de negócios:

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

# 6. Top 3 Data Insights

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
 
Tais resultados foram possíveis após a realização de 5 ciclos de projetos, cada qual com suas alterações e respectivos resultados conforme documentado _[neste link.](LINK)_
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

