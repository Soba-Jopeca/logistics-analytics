# Página de análise em HTML DAX

[Voltar ao índice](../prompts-e-skills.md)

Prompt usado nesta etapa. O caminho local da skill foi substituído pela invocação por nome.

```text
Use $dataviz-html-dax para criar a página principal de análise do dashboard logístico.
Use a conexão MCP para trabalhar diretamente no Power BI aberto.
A única fonte de dados do visual deve ser:
[JSON Gold Dashboard Logistica]

Antes de criar o HTML:
1. Leia e valide o JSON Gold.
2. Liste meta, KPIs, séries, rankings e campos da baseInterativa.
3. Confirme quais filtros internos podem ser recalculados com segurança.
4. Confirme que o JSON respeita os filtros externos do Power BI.
5. Não altere medidas de negócio, modelo, relacionamentos ou JSON nesta etapa.
6. Se a medida HTML já existir, crie backup oculto antes de atualizá-la.

Crie uma medida chamada:
HTML Dashboard Logistica
Construa uma página executiva, com foco em exploração e tomada de decisão.

Estrutura principal:
- header executivo com nome do painel, fonte e data/hora da atualização;
- seletor Dark/Light;
- filtros internos de mês, região e categoria;
- inclua transportadora e modal se existirem na baseInterativa;
- botão Limpar filtros;
- faixa reservada para ticker;
- cards de pedidos, OTIF, custo logístico, lead time e emissões;
- gráfico mensal com barras de pedidos e linha de OTIF;
- painel de leitura executiva;
- OTIF por transportadora;
- custo por região;
- risco por modal;
- tabela comparativa de transportadoras.

Filtros internos:
- Construa as opções a partir da própria baseInterativa.
- Os filtros devem funcionar em conjunto.
- Mantenha as escolhas atuais.
- Recalcule todos os cards, gráficos, rankings, ticker, tabela, tooltips e análises.
- Não atualize somente uma parte do dashboard.
- O botão Limpar filtros deve redefinir apenas os filtros internos.
- Preserve filtros externos do relatório.
- Mostre estado vazio quando a seleção não retornar dados.

Design:
- Use classes CSS prefixadas, como ld-.
- Defina todos os tokens visuais antes dos componentes.
- Crie modo Light limpo e modo Dark no estilo central de controle tecnológico.
- Use neon apenas como acento.
- Garanta contraste de textos, barras e eixos.
- Não use bibliotecas externas, CDNs, imagens remotas ou APIs.
- Preserve português e acentuação em UTF-8.
- Crie responsividade sem rolagem horizontal acidental.

Validação:
- JSON válido;
- renderização sem erros;
- estado Ready da medida;
- teste sem filtros;
- teste de cada filtro isoladamente;
- teste combinando mês, região e categoria;
- teste do botão Limpar filtros;
- totais iguais às medidas nativas;
- estado sem registros;
- alternância Light/Dark;
- responsividade;
- consulta DAX de validação;
- validação visual no navegador ou visual HTML compatível.

Se a conexão MCP não permitir inserir o visual na página, crie e valide a medida e informe exatamente qual visual nativo/customizado deve receber a medida.
Não salve nem sobrescreva o PBIX sem minha autorização.
```
