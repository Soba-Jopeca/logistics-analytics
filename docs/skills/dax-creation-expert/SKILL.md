---
name: dax-creation-expert
description: Crie, revise, corrija, explique e otimize medidas, colunas e tabelas DAX no Power BI, Fabric e Analysis Services. Use para KPIs em modelos semânticos, contexto de filtro, inteligência de tempo, relacionamentos, totais incorretos, desempenho e validação de DAX.
---

# Especialista em criação de DAX

## Diagnóstico e regra de negócio

Inspecione o modelo semântico quando houver acesso. Identifique as tabelas fato, dimensões, colunas e medidas relevantes. Verifique granularidade, chaves, cardinalidade, direção de filtro e caminhos ambíguos. Para análises temporais, confirme a data que governa o cálculo, sua relação com o calendário e se a tabela de datas está marcada. Use apenas objetos confirmados. Se uma lacuna impedir a solução, peça o mínimo necessário.

Antes do código, explique o que a métrica representa, a população incluída, o período, o numerador e o denominador, quando aplicáveis. Especifique quais filtros devem ser preservados, removidos ou adicionados e o resultado esperado sem dados.

## Implementação

Prefira medidas para cálculos sensíveis aos filtros do relatório. Use colunas calculadas para atributos linha a linha e tabelas calculadas quando a regra exigir materializar um conjunto de linhas. Reutilize medidas base nas medidas condicionais, derivadas e temporais. Separe cálculos de negócio, formatação, textos executivos e apresentação.

Os exemplos abaixo ilustram definições independentes. Adapte cada uma ao esquema e às regras confirmadas.

```dax
Pedidos =
DISTINCTCOUNT(fPedidos[ID_Pedido])

Pedidos Atrasados =
CALCULATE(
    [Pedidos],
    KEEPFILTERS(fPedidos[Dias_Atraso] > 0)
)

OTIF % =
DIVIDE([Pedidos OTIF], [Pedidos])

Pedidos Entregues =
CALCULATE(
    [Pedidos],
    KEEPFILTERS(fPedidos[Status_Entrega] = "Entregue")
)

Participação da Região % =
DIVIDE(
    [Custo Logístico],
    CALCULATE([Custo Logístico], REMOVEFILTERS(dRegiao[Regiao]))
)
```

Confirme se IDs em branco devem entrar na contagem e, em fatos por item, se basta uma linha atrasada para classificar o pedido. Use `KEEPFILTERS` quando a condição deve se cruzar com a seleção existente. No exemplo de participação, o denominador remove apenas o filtro da coluna de região. Ao usar `ALL` ou `REMOVEFILTERS`, explique o alcance e o motivo. Só aplique `DATEADD` ou funções similares após confirmar o calendário.

Use `DIVIDE` quando o denominador puder ser zero. Preserve o resultado em branco por padrão e retorne zero quando essa for a regra de negócio.

## Depuração, desempenho e JSON

Para resultados inesperados, verifique duplicação na granularidade da fato, propagação dos filtros, contexto de linha e de filtro, datas e brancos. Em totais, confira se a regra pede recalcular a métrica no contexto do total ou agregar os resultados de cada grupo. Para percentuais, compare o total com a divisão entre numerador e denominador totais.

Prefira agregações diretas e filtros simples em `CALCULATE`. Use iteradores sobre fatos grandes quando a regra exigir cálculo por linha. Se a causa estiver na modelagem, indique a correção no modelo.

Para visuais HTML ou payloads JSON, mantenha medidas de negócio, serialização e visual em camadas. Preserve filtros externos, escape textos e emita números JSON sem aspas, sem separadores de milhar e com ponto decimal. Verifique se o payload pode ser lido por um parser JSON.

## Validação e resposta

Confirme as referências do modelo e compare o resultado com uma tabela detalhada na granularidade da regra. Teste sem filtros, com um período e com uma dimensão. Confira totais, subtotais, denominadores, percentuais e brancos. Quando houver acesso, execute uma consulta de validação adaptada às medidas existentes, como a seguinte.

```dax
EVALUATE
ROW(
    "Pedidos", [Pedidos],
    "OTIF", [OTIF %],
    "Custo", [Custo Logístico],
    "Lead Time", [Lead Time Médio]
)
```

Responda em português claro e técnico. Para solicitações relevantes, apresente nesta ordem:

1. Interpretação de negócio.
2. Dependências do modelo.
3. DAX recomendado.
4. Explicação do contexto de filtro.
5. Validação realizada ou testes recomendados. Identifique quais testes foram executados e seus resultados.
6. Riscos, limitações e próximo passo.
