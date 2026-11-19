# Camada JSON Gold

[Voltar ao índice](../prompts-e-skills.md)

Prompt usado nesta etapa. O caminho local da skill foi substituído pela invocação por nome.

```text
Use $dax-creation-expert para criar a camada Gold do dashboard logístico.
Use a conexão MCP para trabalhar diretamente no Power BI aberto.

Antes de criar o JSON:
1. Leia o modelo e todas as medidas validadas.
2. Confirme que as medidas nativas reconciliam com a base.
3. Liste as métricas e dimensões realmente disponíveis.
4. Confirme a granularidade necessária para os futuros filtros internos.
5. Não recrie no JavaScript ou no JSON regras já existentes como medidas.
6. Se houver uma versão anterior da medida, crie backup oculto antes de alterá-la.

Crie uma medida chamada exatamente:
JSON Gold Dashboard Logistica
Ela será a única fonte de dados das futuras medidas HTML DAX.

Estrutura obrigatória, somente quando os dados existirem:

1. meta
- período analisado;
- data inicial;
- data final;
- quantidade de meses;
- descrição objetiva do contexto filtrado;
- fonte dos dados, se disponível no modelo.

2. kpis
- pedidos;
- quantidade de itens;
- receita;
- custo logístico;
- custo por pedido;
- custo como percentual da receita;
- pedidos entregues;
- pedidos atrasados;
- percentual de atrasados;
- pedidos OTIF;
- OTIF percentual;
- lead time médio;
- atraso médio;
- devoluções;
- avarias;
- extravios;
- emissões de CO₂;
- nota média do cliente;
- variações contra o mês anterior dos principais KPIs.

3. séries e rankings
- tendência mensal de pedidos, OTIF, custo, lead time e emissões;
- desempenho por transportadora;
- desempenho por região;
- desempenho por modal;
- desempenho por categoria;
- principais produtos;
- principais motivos de atraso;
- status de entrega, quando disponível.

4. baseInterativa
Inclua somente os campos necessários para que o futuro HTML aplique filtros internos e recalcule todos os componentes.
Use nomes curtos e documentados, quando existirem:
- m: mês no padrão YYYY-MM;
- r: região;
- t: transportadora;
- o: modal;
- c: categoria;
- pr: produto;
- qt: quantidade;
- p: contagem ou indicador de pedido;
- q: pedidos OTIF ou indicador OTIF consolidado;
- cp: custo;
- lt: soma do lead time válido;
- ln: quantidade de observações válidas de lead time;
- co: emissões de CO₂;
- at: soma dos dias de atraso válidos;
- an: quantidade de observações válidas de atraso;
- dv: devoluções;
- av: avarias;
- ex: extravios.

Atenção à granularidade:
- Se a fato estiver no nível de item, não use p=1 em todas as linhas.
- Evite duplicar pedidos por produto ou categoria.
- Pré-agregue por pedido e pelas dimensões necessárias quando isso preservar os cálculos.
- Não envie identificadores pessoais ou campos sem uso.
- Se o payload ficar excessivo, proponha pré-agregação antes de continuar.

Regras obrigatórias:
- Gere JSON válido.
- Use ponto como separador decimal nos números crus.
- Não coloque aspas em números usados para cálculo.
- Escape aspas, barras, retorno de carro e quebra de linha.
- Preserve filtros externos.
- Não use ALL(fato) para construir rankings ou séries.
- Use medidas validadas para KPIs.
- Omita métricas não disponíveis em vez de retornar dados fictícios.
- Não inclua HTML, CSS ou JavaScript.
- Não dependa de APIs, CDNs ou fontes externas.

Valide:
1. sem filtros;
2. com filtro de mês;
3. com filtro de região;
4. com filtro de transportadora;
5. com filtro de categoria;
6. em contexto sem registros;
7. início com { e término com };
8. parse válido;
9. números crus com ponto decimal;
10. totais do JSON iguais às medidas nativas;
11. estrutura e campos da baseInterativa;
12. tamanho usando LEN([JSON Gold Dashboard Logistica]);
13. escape de textos com aspas, barras e quebras de linha;
14. consulta DAX de validação.

Ao final, apresente:
- estrutura final do JSON;
- medidas utilizadas;
- arrays criados;
- campos da baseInterativa e significado;
- granularidade escolhida;
- testes e reconciliações;
- tamanho da medida;
- limitações;
- confirmação de que nenhuma medida HTML foi criada.

Não salve nem sobrescreva o PBIX sem minha autorização.
```
