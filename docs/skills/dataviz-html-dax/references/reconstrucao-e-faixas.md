## Reconstrução a partir de print ou referência visual

Quando o usuário fornecer uma imagem de referência, trate-a como especificação de composição e comportamento, não como fonte de dados.

1. Inspecione a imagem antes de escrever HTML.
2. Decomponha o visual em contêiner, cabeçalho, subtítulo, badge comparativo, legenda, área de plotagem, rótulos, estados semânticos e interação.
3. Identifique proporções, alinhamentos, hierarquia, densidade, raios, sombras, espaçamento e paleta aproximada.
4. Reproduza o padrão de leitura e a experiência, adaptando textos, métricas, metas e cores ao contexto do modelo.
5. Não copie dados exibidos no print nem suponha limites de desempenho. Obtenha valores, metas, período anterior e sentido do indicador do JSON ou de regras confirmadas.
6. Se a referência conflitar com legibilidade, acessibilidade ou responsividade, preserve a intenção visual e corrija o problema de UX.

Use variáveis CSS para tornar o estilo ajustável:

```CSS
.dv-root {
  --dv-primary: #142044;
  --dv-good: #2da44e;
  --dv-warn: #ff7a18;
  --dv-bad: #ef2027;
  --dv-line: #dce3ee;
  --dv-radius: 16px;
}
```

Evite replicação pixel a pixel rígida. O visual precisa continuar legível quando mudar a quantidade de categorias, o tamanho dos rótulos ou a dimensão do contêiner.

## Padrão de conformidade com faixas e popover analítico

Para visuais como “conformidade por área”, “atingimento por unidade” ou “SLA por operação”, use este padrão quando o JSON contiver valor atual, comparação e limites confirmados:

- cartão externo branco, borda sutil e cantos arredondados;
- título e subtítulo à esquerda;
- badge de variação ou comparação no canto superior direito;
- legenda compacta descrevendo os limites;
- gráfico de colunas com rótulo de valor acima da barra;
- variação mensal logo abaixo do valor;
- zonas horizontais de fundo para saudável, atenção e crítico;
- linhas de corte alinhadas aos limites da legenda;
- popover flutuante ao passar o mouse ou receber foco;
- cores da barra derivadas do status, sem depender apenas da cor para comunicar o resultado.

### Contrato mínimo de dados

Antes de construir, confirme no JSON:

- categoria ou área;
- valor atual;
- valor do período anterior ou variação pronta;
- unidade e escala;
- limites das faixas ou meta;
- direção do indicador: maior é melhor ou menor é melhor;
- período de referência;
- campos usados no detalhamento do popover.

Se limites, direção ou comparação não existirem, não os deduza do print. Ajuste o JSON ou solicite a regra mínima necessária.

### Faixas semânticas

Calcule a geometria com a mesma escala das barras. Para um indicador em que maior é melhor:

```JavaScript
const status = value =>
  value >= thresholds.healthy ? 'healthy' :
  value >= thresholds.warning ? 'warning' : 'critical';
```

Para indicadores em que menor é melhor, inverta explicitamente a regra. Centralize essa decisão em uma função; não espalhe comparações diferentes pelo código.

As faixas de fundo devem ter baixa saturação. Use a cor mais intensa na barra, no marcador e no badge de status. Inclua texto, ícone ou rótulo para que o estado não dependa somente de verde, laranja ou vermelho.

### Popover contextual

O popover deve ampliar a leitura da categoria selecionada e pode conter:

- nome da categoria;
- badge de status;
- valor atual;
- valor anterior;
- variação mensal;
- meta ou distância até a faixa seguinte, se disponível.

Posicione-o próximo à barra ativa, mas limite sua posição ao contêiner para evitar corte nas bordas. Use `mouseenter`, `mousemove` e `mouseleave`, além de `focus` e `blur` quando o elemento puder receber teclado. Destaque a barra ativa e mantenha as demais legíveis.

```JavaScript
const placePopover = (event, popover, container) => {
  const box = container.getBoundingClientRect();
  const width = popover.offsetWidth;
  const x = Math.min(Math.max(event.clientX - box.left + 12, 8), box.width - width - 8);
  popover.style.left = `${x}px`;
};
```

Use o popover para detalhes sob demanda. Valores essenciais, como o indicador principal e o status, devem continuar visíveis sem interação.
