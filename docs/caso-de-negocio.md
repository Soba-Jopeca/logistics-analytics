# Caso de negócio

[Voltar ao README](../README.md)

## Contexto e escopo

O estudo representa a gestão de uma operação logística brasileira com pedidos, fornecedores de transporte, centros de distribuição e destinos simulados. O público estratégico precisa decidir onde melhorar nível de serviço e uso de recursos. O público operacional precisa enxergar a fila da data de referência e investigar os atrasos registrados.

A base contém 1.000 pedidos únicos. Cada registro contém um pedido e um SKU, com quantidade pedida e entregue. A data principal para a análise temporal é **Data_Pedido**. A cobertura começa em 01/07/2025 e termina em 10/07/2026. A data de referência da fonte é **15/07/2026**. O horário de geração do painel é exibido separadamente.

## Perguntas de negócio

| Pergunta | Como responder | Decisão apoiada |
| --- | --- | --- |
| Os pedidos chegam no prazo e completos? | OTIF total, denominador de elegíveis e evolução por mês do pedido. | Investigar mudanças no serviço antes de definir ações. |
| Onde o nível de serviço é pior? | OTIF por região e contagem de elegíveis. | Direcionar diagnóstico para regiões com maior proporção de falhas. |
| Onde uma ação pode reduzir mais falhas? | Número de pedidos elegíveis fora de OTIF por região ou transportadora. | Priorizar alcance em volume. |
| Quanto custa atender cada pedido? | Custo logístico total dividido pela contagem de pedidos no mesmo filtro. | Comparar eficiência entre períodos e recortes. |
| Quanto tempo leva uma entrega concluída? | Lead time médio e quantidade de entregas com valor válido. | Avaliar a experiência de entrega com a população adequada. |
| Qual fila exige atenção agora? | Pedidos com status registrado Atrasado ou Em trânsito. | Priorizar atrasados pela previsão de entrega mais antiga. |
| Onde se concentram os atrasos da carteira? | Contagem de pedidos com status Atrasado por transportadora, região ou motivo informado. | Escolher o grupo a investigar e localizar os pedidos na fila. |

## Regras que sustentam a leitura

| Indicador | Definição no caso | Cuidado de interpretação |
| --- | --- | --- |
| Pedidos | Contagem distinta de `ID_Pedido`. | A quantidade de unidades vem de `Quantidade_Pedida`. |
| OTIF | Pedidos ao mesmo tempo no prazo e completos / pedidos com resultado Sim ou Não em ambas as flags. | Os 5 extravios com resultado definido entram como falhas. Pedidos com flags pendentes e cancelados não aplicáveis ficam fora do denominador. |
| Custo por pedido | Soma de `Custo_Logistico_Total_R$` / pedidos do recorte. | Custo total e custo unitário podem se mover em direções diferentes. |
| Lead time | Média de `Lead_Time_Total_Dias` com entrega registrada e valor informado. | A fonte também informa tempo decorrido para alguns pedidos em aberto. A média de entregas concluídas exclui esses registros. |
| Atraso em entrega concluída | `Data_Entrega` preenchida e `Dias_Atraso > 0`. | A amostra tem 115 entregas concluídas com atraso. |
| Carteira ativa | Status de origem Atrasado ou Em trânsito na data de referência. | A fila tem 24 pedidos. O status vem do arquivo e a página não reclassifica usando `TODAY()`. |
| Valor dos pedidos | Soma do valor de venda simulado registrado na fonte. | Reconhecimento contábil de receita exige dados e regra adicionais. |

## Da leitura à ação

- **Estratégia.** OTIF de 86,60% com 128 falhas. Sudeste concentra 61 falhas em 471 elegíveis enquanto Norte registra 13 em 50. Investigar volume e recorrência em trilhas distintas.
- **Comparação mensal.** Julho de 2026 está coberto até o dia 10. Comparar 25 pedidos com os 33 de 1 a 10 de junho resulta em **−24,2%**. A variação de OTIF nessa janela é **+3,33 p.p.**, de 27/30 para 14/15. As amostras aparecem junto ao indicador.
- **Operação.** Separar a carteira ativa do histórico de atrasos. Na fila, começar pelos pedidos atrasados com previsão mais antiga e verificar motivo, destino e transportadora.
- **Qualidade dos dados.** A base preserva 50 pedidos sem data de entrega. Um registro de devolução tem data posterior à referência da base e recebeu sinalização para investigação.

## Limites

O relatório é um **estudo de caso com dados simulados**. Concentração de falhas orienta investigação e não comprova causa. A base não define SLA, metas de OTIF, faixas de criticidade, receita contábil ou responsabilidade por ocorrência. A comparação usa grupos de pedidos definidos pela **data do pedido**. Avaliar entregas efetivamente ocorridas num mês exige um recorte temporal próprio.
