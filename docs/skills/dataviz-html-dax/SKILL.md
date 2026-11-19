---
name: dataviz-html-dax
description: Crie, reconstrua a partir de prints, revise e otimize visuais HTML gerados por medidas DAX no Power BI, incluindo dashboards executivos, filtros internos e gráficos com metas alimentados por uma medida JSON.
---

# Especialista em DataViz HTML DAX

Atue como especialista sênior em visualização de dados, UX analítico, Power BI, HTML, CSS, JavaScript e DAX JSON. Crie experiências analíticas modernas, limpas, responsivas e orientadas à decisão — não apenas visuais bonitos.

## Princípios

- Use a medida DAX JSON como fonte exclusiva dos dados do visual.
- Mantenha regras de negócio no modelo e em DAX; HTML, CSS e JavaScript são camadas de apresentação e interação.
- Não use bibliotecas externas, CDNs, APIs, imagens remotas ou chaves no front-end.
- Não invente campos: valide a estrutura do JSON antes de construir o visual.
- Preserve filtros externos do Power BI; o HTML consome o JSON já filtrado pelo relatório.
- Um filtro interno exige uma base granular que permita recalcular todos os elementos afetados.
- Trate JSON inválido, dados vazios e filtros sem resultado com mensagens amigáveis.
- Preserve medidas, seleções, filtros, interações e comportamento funcional ao redesenhar um visual existente.
- Não use uma grade uniforme de cards como resposta automática; escolha a estrutura pelo problema analítico.
- Defina tokens CSS antes de renderizar e não improvise cores, fontes, raios ou espaçamentos no meio do código.

## Arquitetura

```text
Modelo semântico e medidas DAX
            ↓
Medida DAX JSON Gold
            ↓
Medida DAX HTML
  ├─ HTML: estrutura
  ├─ CSS: identidade visual e responsividade
  └─ JavaScript: filtros internos e renderização
```

Não replique cálculos críticos em JavaScript se puderem permanecer em DAX. JavaScript só recalcula o subconjunto interno se `baseInterativa` contiver os campos necessários.

## Fluxo de trabalho

### 1. Validar o payload JSON

1. Leia a medida JSON e valide sua sintaxe.
2. Liste objetos disponíveis: `meta`, `kpis`, tendências, rankings e `baseInterativa`.
3. Identifique campos usados por filtros internos e confirme granularidade suficiente para cards, gráficos, rankings, tooltips e insights.
4. Confirme números crus com ponto decimal e respeito aos filtros externos.

Se faltar um campo necessário, solicite o ajuste da medida JSON antes de criar a interação.

### 2. Definir a narrativa executiva

Antes do layout, determine qual decisão o gestor deve tomar, quais KPIs mostram o estado atual, qual visual explica a variação e quais rankings permitem investigar causa, risco ou oportunidade.

Organize a página em: cabeçalho (contexto, período e escopo), filtros internos úteis, alertas/ticker, cards, tendência com insight e rankings/detalhamento. Remova elementos decorativos que não respondam a uma pergunta de negócio.

### 3. Fazer o preflight do visual

Antes de criar ou alterar HTML:

1. Leia a medida HTML atual, o JSON, as medidas dependentes e os campos realmente disponíveis.
2. Identifique prefixos CSS, tokens, paleta, tipografia, estrutura, interações e estados já implementados.
3. Declare o que será preservado e o que será alterado.
4. Em um redesign relevante, guarde a expressão original. Crie uma cópia oculta no modelo quando a edição do modelo estiver autorizada.
5. Não altere o modelo, o JSON ou regras de negócio quando o pedido estiver limitado à apresentação.

### 4. Escolher uma macroestrutura analítica

Escolha a forma da página antes das cores. Use a estrutura que melhor responde à decisão: prioridade executiva, scorecard, exceções, comparação, tendência, fluxo operacional, distribuição geográfica ou investigação detalhada.

Não repita automaticamente `hero → filtros → cinco cards iguais → três gráficos iguais → tabela`. Varie a estrutura, a hierarquia e a densidade conforme audiência, decisão, quantidade de métricas e tamanho do visual. Para criar, redesenhar ou auditar um dashboard, leia [references/design-quality-gates.md](references/design-quality-gates.md).

## Estrutura recomendada da medida HTML

```DAX
HTML Dashboard =
VAR _Raw = [JSON Gold Dashboard]
VAR _Json = SUBSTITUTE(_Raw, "<", "\u003C")
VAR _Css = "<style>...</style>"
VAR _Markup =
    "<div class='dv-root'>" &
        "<script type='application/json' class='dv-data'>" & _Json & "</script>" &
        "<section class='dv-hero'>...</section>" &
        "<section class='dv-filters' data-filters></section>" &
        "<section class='dv-cards'>...</section>" &
        "<section class='dv-panels'>...</section>" &
        "<div class='dv-tooltip' data-tooltip></div>" &
    "</div>"
VAR _Script = "<script>...</script>"
RETURN
    IF(ISBLANK(_Raw), BLANK(), _Css & _Markup & _Script)
```

Confirme se o visual hospedeiro permite scripts antes de depender de JavaScript. Quando o hospedeiro bloquear scripts, gere o conteúdo estático na medida HTML e use os filtros externos. Insira rótulos dinâmicos via textContent ou escape-os para o contexto HTML correspondente.

Use classes prefixadas com `dv-` para evitar conflitos com outros visuais.

## UX, design e responsividade

- Dê maior destaque aos KPIs e à decisão principal.
- Use neutros, uma cor primária e cores semânticas; explique quando uma alta não significar melhora.
- Prefira espaço em branco, contraste e alinhamento; evite excesso de sombras, bordas e gradientes.
- Use `display: grid`, `minmax()` e media queries; não fixe larguras importantes.
- Use uma cor somente quando ela codificar identidade, seleção, status ou hierarquia.
- Evite cards aninhados, centralização de tudo, gradiente decorativo, badges em excesso e ícones sem função.
- Todo valor de cor, fonte, raio, sombra e espaçamento recorrente deve vir de um token CSS nomeado.

## Animações seguras em HTML DAX

Use animações apenas quando reforçarem leitura e hierarquia, sem competir com a decisão executiva. Em visuais HTML renderizados por medidas DAX no Power BI, prefira CSS puro e curto:

- barras de gráficos com `transform: scaleY()` e `transform-origin: bottom`;
- barras de ranking/progresso com `transform: scaleX()` e `transform-origin: left`;
- cards ou seções com entrada discreta por `opacity` e `translateY`;
- durações entre 450ms e 900ms, sem loops infinitos;
- `@media (prefers-reduced-motion: reduce)` para desligar animações;
- evitar `setInterval`, animações pesadas em JavaScript, canvas ou dependências externas.

As animações devem preservar os valores calculados pelo DAX/JSON. Nunca altere a regra de negócio, a largura/altura final ou o filtro interno apenas para produzir efeito visual.

```CSS
.dv-cards { display: grid; grid-template-columns: repeat(5, minmax(0, 1fr)); gap: 10px; }
@media (max-width: 780px) {
  .dv-cards { grid-template-columns: repeat(2, minmax(0, 1fr)); }
  .dv-grid { grid-template-columns: 1fr; }
}
```

Para reconstrução por print ou gráficos com faixas e popovers, consulte [Reconstrução e faixas](references/reconstrucao-e-faixas.md).

## Filtros internos

Um filtro interno só pode existir se `baseInterativa` permitir recalcular cards, gráficos, ticker, rankings, tabela, tooltips e insight. A base deve trazer, conforme a necessidade, período (`m`), região (`r`), transportadora (`t`), modal (`o`), categoria (`c`), produto (`pr`) e métricas cruas como quantidade (`qt`), pedidos (`p`), OTIF (`q`), custo (`cp`), lead time (`lt`), atraso (`at`) e emissões (`co`).

1. Crie opções dos selects a partir da própria base.
2. Armazene as escolhas atuais.
3. Filtre registros em memória.
4. Recalcule todos os componentes afetados.
5. Chame `render()` na carga e em cada `change`.

```JavaScript
const fields = [['m', 'Mês'], ['r', 'Região'], ['t', 'Transportadora'], ['o', 'Modal'], ['c', 'Categoria']];
const filteredRows = () => {
  const choice = Object.fromEntries(fields.map(([key]) => [key, root.querySelector(`[data-filter=${key}]`).value]));
  return base.filter(row => fields.every(([key]) => !choice[key] || row[key] === choice[key]));
};
```

Nunca atualize apenas gráficos: filtros internos devem atualizar todos os componentes dependentes.

## Indicadores, tendência e tooltips

Para variação mensal, preserve a regra acordada para o KPI, compare os dois últimos meses disponíveis, apresente mês de referência e trate ausência de mês anterior.

```JavaScript
const delta = (current, previous) => previous ? (current - previous) / Math.abs(previous) : null;
```

Ordene meses por `AAAA-MM`, nunca pelo rótulo. Use barras para volume e linhas para percentuais/nível de serviço. Cada gráfico relevante deve ter tooltip com contexto decisório: mês, pedidos, OTIF, custo, lead time e indicadores pertinentes.

Use ticker apenas para informação operacional útil: derive-o de `baseInterativa`, ordene por relevância, mostre poucos itens, pause no hover e recalcule após filtros.

## Insights e erros

O insight executivo deve responder o que exige atenção, onde está o principal problema e qual ação priorizar. Use dados filtrados e não afirme causalidade sem evidência.

Sempre trate JSON ausente/inválido, `baseInterativa` vazia, filtro sem registros, métrica sem mês anterior e campos opcionais ausentes.

```JavaScript
try {
  const data = JSON.parse(root.querySelector('.dv-data').textContent);
  if (Array.isArray(data.baseInterativa) && !data.baseInterativa.length) throw new Error('Sem dados para o recorte atual.');
} catch (error) {
  root.innerHTML = "<div class='dv-empty'>Não foi possível processar os dados do dashboard.</div>";
}
```

## Validação

1. Confirme renderização sem erros.
2. Compare cartões com medidas DAX/nativos temporários.
3. Teste sem filtros e com filtro externo do Power BI.
4. Teste cada filtro interno e confirme atualização de todos os componentes.
5. Teste cenários com um mês e sem registros.
6. Confirme rótulos de mês, tooltip e responsividade.
7. Quando houver print de referência, faça uma comparação visual renderizada: hierarquia, proporções, alinhamentos, faixas, cores, rótulos e estado interativo.
8. Teste popovers nas barras centrais e nas extremidades para confirmar que não são cortados.
9. Confirme navegação por teclado, contraste e comunicação de status além da cor.
10. Não declare o visual concluído apenas porque o DAX compilou; faça ao menos uma validação visual no navegador ou no visual HTML compatível.
11. Confirme que não foram inventados métricas, metas, comparações, depoimentos ou evidências.
12. Compare o visual com outros dashboards recentes e elimine repetição estrutural sem justificativa.
13. Verifique se cada painel responde a uma pergunta e se cada elemento decorativo merece ocupar espaço.
14. Confirme que não há valores de cor ou fonte improvisados fora do bloco de tokens.
15. Faça a autocrítica descrita em `references/design-quality-gates.md`; qualquer eixo abaixo de 3 exige revisão.

## Forma de entrega

Informe componentes criados/alterados, campos JSON usados por interação, filtros internos disponíveis, validações e resultados, limitações de performance/granularidade e próximo passo recomendado. Nunca declare o dashboard pronto sem validar renderização e atualização dos filtros.
