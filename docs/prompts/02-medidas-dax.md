# Criação e validação das medidas DAX

[Voltar ao índice](../prompts-e-skills.md)

Prompt usado nesta etapa. O caminho local da skill foi substituído pela invocação por nome.

```text
Use $dax-creation-expert para criar e validar as medidas DAX do modelo logístico preparado na etapa anterior.
Use a conexão MCP para trabalhar diretamente no Power BI aberto.

Antes de criar medidas:
1. Leia o modelo atual.
2. Liste a tabela fato, dimensões, colunas, medidas e relacionamentos.
3. Confirme a granularidade da fato.
4. Confirme a chave usada para contar pedidos.
5. Confirme a data ligada ativamente à dCalendario.
6. Verifique se valores financeiros estão repetidos em linhas de item.
7. Liste quais KPIs podem ser criados com segurança.
8. Liste quais KPIs dependem de regra ou campo ausente.
9. Crie uma tabela de medidas.
Não invente tabelas, campos, status, metas, limiares ou regras.

Crie as medidas na tabela de medidas em camadas e organize-as em pastas de exibição.

Camada Base, quando houver campos compatíveis:
- Total de pedidos;
- Quantidade de itens;
- Receita ou valor dos pedidos;
- Frete;
- Custo logístico;
- Emissões de CO₂;
- quantidade de avaliações válidas.

Camada de Serviço:
- Pedidos entregues;
- Pedidos elegíveis para OTIF;
- Pedidos On Time;
- Pedidos In Full;
- Pedidos OTIF;
- OTIF percentual;
- Pedidos atrasados;
- Percentual de pedidos atrasados;
- Lead time médio;
- Quantidade de lead times válidos;
- Atraso médio;
- Quantidade de atrasos válidos.

Camada de Qualidade:
- Pedidos ou itens com devolução;
- Devoluções percentual;
- Pedidos ou itens com avaria;
- Avarias percentual;
- Pedidos ou itens extraviados;
- Extravios percentual;
- Nota média do cliente.

Camada Derivada:
- Custo logístico por pedido;
- Custo logístico como percentual da receita;
- quantidade média por pedido;
- custo médio por transportadora ou região somente por meio do contexto de filtro, sem fixar dimensões na medida.

Camada Temporal para os principais KPIs:
- valor do mês anterior;
- variação absoluta;
- variação percentual;
- mediana mensal do OTIF;
- tendência mensal de pedidos, OTIF, custo, lead time e emissões.

Regras obrigatórias:
- Use DISTINCTCOUNT para pedidos quando a fato estiver no nível de item.
- Use DIVIDE para percentuais.
- Preserve os filtros externos.
- Não use ALL() ou REMOVEFILTERS() sem justificativa.
- OTIF exige On Time e In Full no mesmo pedido.
- Se a fato estiver no nível de item, consolide o OTIF por pedido.
- Pedidos pendentes devem permanecer na fato.
- Não inclua entrega vazia no lead time de entregas concluídas.
- Não classifique pendentes como atrasados usando TODAY() sem regra confirmada.
- Confirme se atraso médio considera apenas atrasados ou todos os entregues.
- Confirme se devolução, avaria e extravio contam pedidos, itens ou ocorrências.
- Não crie uma métrica que não possa ser sustentada com segurança.

Valide antes de concluir:
- compare com uma tabela detalhada;
- teste sem filtros;
- teste com filtro de data;
- teste com região;
- teste com transportadora;
- teste com modal e categoria;
- valide totais, denominadores e percentuais;
- confirme que percentuais aplicáveis ficam entre 0% e 100%;
- confirme que pedidos OTIF não superam pedidos elegíveis;
- confirme que pedidos elegíveis não superam o total de pedidos;
- teste cenário sem entregues;
- teste cenário sem mês anterior;
- teste denominador zero;
- execute consultas DAX de validação.

No final, apresente:
- medidas criadas por camada;
- regra de negócio de cada medida;
- numerador e denominador;
- campos utilizados;
- data usada;
- comportamento para pendentes e valores vazios;
- testes executados;
- resultados das reconciliações;
- medidas não criadas e motivo;
- limitações ainda dependentes de validação do negócio.

Não crie JSON, HTML, CSS, JavaScript ou visuais nesta etapa.
Não salve nem sobrescreva o PBIX sem minha autorização.
```
