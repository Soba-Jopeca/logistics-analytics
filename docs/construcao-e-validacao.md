# Construção e validação

[Voltar ao README](../README.md)

## 1. Diagnosticar a fonte e montar o modelo

O arquivo original é `base_logistica_simulada_brasil.xlsx`. A tabela Excel `TabelaBaseLogistica` tem 1.000 registros e 58 colunas. O arquivo também contém dicionário, premissas e guia de análise. A [base simulada completa](base/README.md) está disponível para reproduzir o caso. A amostra mínima abaixo permite experimentar as regras com oito registros. A implementação visual pode ser consultada no relatório público.

Use as [consultas M exportadas](../examples/power-query/README.md) para reproduzir o modelo com os mesmos campos. O único ajuste de origem é definir o caminho local da planilha.

1. Leia a tabela com `Excel.Workbook(File.Contents(...), null, true)`. Use um parâmetro local para a origem ao compartilhar o projeto.
2. Crie `stgLogistica` com tipos explícitos. Trate IDs como texto, datas como data e métricas conforme o tipo da fonte. Preserve as 50 entregas em branco. O diagnóstico confirmou 1.000 chaves distintas e zero duplicidades em `ID_Pedido`.
3. Use `fPedidos` com **uma linha por pedido**. Separe atributos de produto, geografia e transporte nas dimensões. Preserve datas de eventos na fato e crie flags de qualidade quando aplicável.
4. Relacione dimensões à fato em **1:*** com filtro unidirecional. Valide unicidade, chaves órfãs e propagação de filtros antes de escrever medidas.

Use a [referência de relacionamentos](modelo-e-medidas.md) para configurar chaves e papéis de data. A chave `Chave_Destino` combina UF e cidade. Marque a `dCalendario` como tabela de datas e configure `Data_Pedido` como relação ativa.

**Experimento mínimo.** Crie uma consulta em branco no Power Query e cole [fPedidos-demo.m](../examples/fPedidos-demo.m) no Editor Avançado. Nomeie a tabela `fPedidos` e carregue-a. Execute [kpis-demo.dax](../examples/kpis-demo.dax) na Exibição de consulta DAX. Você deve obter 8 pedidos, 4 elegíveis, 2 OTIF e 3 em carteira. A amostra demonstra o conceito com valores próprios. Para reconstruir todas as páginas, use uma fonte com os campos do modelo e as etapas deste guia.

## 2. Calcular primeiro com medidas DAX

As 53 medidas ativas estão no [catálogo de medidas](../assets/medidas/README.md), com as expressões exportadas do modelo aberto. As pastas incluem Base, Serviço, Qualidade, Derivada, Temporal, Gold e Apresentação.

Use `DISTINCTCOUNT` para pedidos, `DIVIDE` para taxas e `KEEPFILTERS` em condições que devem cruzar o filtro do relatório. A contagem de elegíveis e a de sucessos ficam separadas.

```dax
Pedidos OTIF =
CALCULATE(
    [Total de pedidos],
    KEEPFILTERS(fPedidos[Entrega_No_Prazo] = "Sim"),
    KEEPFILTERS(fPedidos[Pedido_Completo] = "Sim")
)

OTIF % =
DIVIDE([Pedidos OTIF], [Pedidos elegíveis para OTIF])
```

A medida de elegibilidade exige valores `Sim` ou `Não` nas **duas** flags. Pedido pendente permanece na fato. Uma taxa com denominador vazio fica em branco. Confira [a definição dos indicadores](caso-de-negocio.md#regras-que-sustentam-a-leitura) antes de codificar.

## 3. Entregar dados estruturados ao HTML

A capa e a estratégia usam `[JSON Gold Dashboard Logistica]`. A operação usa `[JSON Gold Operacao Logistica]` porque a fila precisa da granularidade de pedido. A base agregada da estratégia preserva o contexto e evita levar o ID para um visual que não o utiliza.

| Camada | Contrato |
| --- | --- |
| Gold estratégico | `meta`, `kpis`, `series`, `rankings`, `baseInterativa` e `baseComparacao`. |
| Base interativa | Grupos por mês, dia do pedido e dimensões analíticas. Campos como `p` (pedidos), `q` (pedidos OTIF), `pe` (elegíveis), `cp` (custo), `lt` (soma dos lead times válidos) e `ln` (contagem de observações). |
| Comparação | `calendarioComparavel` indica dias cobertos no mês corrente. `baseComparacao` fornece o mês anterior quando o recorte externo o exclui ou o cobre de forma parcial. |
| Gold operacional | Data de referência e pedidos com status Atrasado ou Em trânsito. A fila usa ID, status, transportadora, região, cidade, UF, previsão e motivo de atraso, quando informado. |

Para filtros internos, some numeradores e denominadores antes de dividir. No recorte filtrado, OTIF é `Σq / Σpe` e lead time é `Σlt / Σln`. O HTML consome somente as linhas que o Power BI entregou à medida. A base de comparação é usada para o badge temporal e nunca somada ao total exibido.

Em um mês parcial, compare os mesmos dias disponíveis. Em julho de 2026, a comparação de pedidos usa 1–10 de julho contra 1–10 de junho. Guarde a janela e os denominadores junto ao resultado. Use JSON válido, ponto decimal e escape para aspas, barras e quebras de linha. Antes de inserir JSON em uma tag `script` de dados, escape `<` para proteger o contexto HTML.

## 4. Montar as páginas no Power BI

| Página | Medida de apresentação |
| --- | --- |
| Capa | `HTML Capa Logistica` |
| Estratégia | `HTML Dashboard Logistica` |
| Operação | `HTML Operacao Logistica` |

Adicione o visual personalizado **HTML Content, edição Regular** em cada página e coloque a medida correspondente em **Values**. O projeto usa JavaScript local para filtros, tooltips, ordenação e movimento reduzido. A edição Secure tem restrições de scripts. Confira no Desktop e na versão publicada antes de divulgar. [Visual HTML Content](https://marketplace.microsoft.com/en-us/product/wa200001930?tab=overview) · [Função Values](https://html-content.com/docs/data-roles) · [Scripts na edição Regular](https://html-content.com/docs/scripting)

A publicação deste caso foi feita no Power BI Service. O [iframe de exemplo](../examples/powerbi-embed.html) usa o link público fornecido para o projeto. O README usa imagem e link. O iframe se destina a uma página HTML. [Publicar na Web](https://learn.microsoft.com/en-us/power-bi/collaborate-share/service-publish-to-web)

## 5. Conferir os resultados

| Camada | Evidência verificada |
| --- | --- |
| Fonte e modelo | 1.000 linhas, 1.000 IDs, sem perda de pedidos sem entrega. Dimensões com chave única e relacionamentos ativos sem órfãos na validação. |
| DAX | Totais reconciliados com o Excel. Testes por mês, região, transportadora, modal, categoria e status. |
| JSON | Parse válido, números brutos, recortes vazios, comparação parcial e reconciliação com as medidas nativas. |
| Canvas | Estratégia e Operação renderizadas no visual incorporado. Filtros e alternância da tendência conferidos no Desktop. |
| Navegador | Layout desktop e 390 px, filtros, estados vazios, ordenação e interação. As três páginas do link público foram abertas e conferidas. |

Execute [validacao.dax](../examples/validacao.dax) na Exibição de consulta DAX ou pela ferramenta MCP. As consultas são para leitura e pressupõem o **modelo completo** do caso. Em uma base diferente, reconcilie os números com a própria fonte.
