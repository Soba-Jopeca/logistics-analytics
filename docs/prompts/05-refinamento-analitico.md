# Refinamento analítico e visual

[Voltar ao índice](../prompts-e-skills.md)

Prompt usado nesta etapa. O caminho local da skill foi substituído pela invocação por nome.

```text
Use $dataviz-html-dax para evoluir a medida HTML Dashboard Logistica criada na etapa anterior.
Use a conexão MCP no Power BI aberto.

Antes de alterar:
- leia a medida atual e o JSON Gold;
- crie um backup oculto da medida funcional;
- preserve todos os filtros, temas, cálculos, tooltips e elementos já funcionais;
- altere apenas a camada HTML, CSS e JavaScript;
- não modifique regras de negócio ou o JSON sem demonstrar que falta um campo indispensável.

Inclua análises dinâmicas orientadas à decisão:

1. Leitura executiva
- identifique a principal transportadora que exige atenção;
- identifique a região de maior risco ou pior serviço;
- mostre atraso médio, principal motivo de atraso e indicadores de qualidade;
- recalcule o texto conforme todos os filtros;
- use linguagem como "requer atenção" ou "concentra ocorrências";
- não afirme causalidade não comprovada.

2. Gráfico mensal
- barras para pedidos;
- linha para OTIF;
- eixos nomeados;
- linha tracejada para a mediana mensal do OTIF;
- mediana recalculada conforme filtros;
- tooltip própria com mês, pedidos, OTIF, custo e lead time;
- informe de maneira sutil se o OTIF do mês está acima ou abaixo da média do contexto;
- trate cenário com um único mês.

3. Rankings
- OTIF por transportadora, do menor para o maior;
- custo por região;
- principais produtos;
- motivos de atraso, quando disponíveis;
- tooltips com contexto útil;
- barras com espaço suficiente para leitura.

4. Risco por modal
- mostre pedidos, OTIF e lead time;
- classifique status somente usando limites confirmados no JSON ou na regra de negócio;
- aplique fundo semântico para saudável, atenção e crítico;
- inclua um alerta com a quantidade de modais críticos;
- mantenha espaço entre os cards.

5. Comparativo das transportadoras
- use título e subtítulo compreensíveis para usuários não técnicos;
- permita ordenação ao clicar nos títulos das colunas;
- inclua estado visual de ordenação crescente e decrescente;
- atualize aria-sort;
- ordene por transportadora, pedidos, OTIF, prazo e custo;
- recalcule a tabela conforme filtros.

Valide:
- leitura executiva em diferentes filtros;
- mediana sem filtro e com região;
- tooltip em meses centrais e nas extremidades;
- filtros de mês, região, categoria, transportadora e modal;
- totais e percentuais;
- ordenação de todas as colunas;
- navegação por teclado;
- comunicação de status além da cor;
- estados vazio e erro;
- ausência de erros JavaScript;
- consulta DAX e renderização visual.

Não salve nem sobrescreva o PBIX sem minha autorização.
```
