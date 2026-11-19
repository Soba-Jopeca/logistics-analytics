# Revisões que aconteceram no projeto

[Voltar ao índice](../prompts-e-skills.md)

As mensagens abaixo mostram como o painel evoluiu depois da primeira versão. Foram mantidos os textos de solicitação. Identificadores de arquivos locais e anexos de referência ficaram fora desta transcrição.

## Inserir sparklines

```text
Quero adicionar sparklines aos cards de KPI já existentes, sem alterar a estrutura geral, as dimensões, a identidade visual ou a disposição atual dos elementos.

Os cards atuais possuem:
- Título do indicador no topo.
- Valor principal em destaque.
- Texto auxiliar abaixo do valor.
- Badge de variação em relação ao mês anterior.
- Uma linha colorida fina na base de alguns cards.
- Fundo branco, bordas arredondadas e sombra discreta.

Faça apenas uma evolução visual cuidadosa.
Adicione um sparkline horizontal na parte inferior de cada card, entre o texto auxiliar e o badge de variação, ocupando aproximadamente 75% a 85% da largura disponível.

Diretrizes:
- Não aumente significativamente a altura dos cards.
- Preserve o valor principal como elemento de maior destaque.
- Não mova nem remova os textos atuais.
- Não altere os números, indicadores ou cálculos existentes.
- Não coloque o gráfico atrás do texto.
- O sparkline deve ser discreto, com altura aproximada entre 24 e 32 px.
- Não exiba eixo, legenda, grade, título ou rótulos.
- Utilize linha fina, entre 1,5 e 2 px.
- Use curvas levemente suavizadas.
- Adicione um preenchimento em degradê muito sutil abaixo da linha.
- Utilize a cor principal do dashboard, em azul-petróleo, para a linha.
- Nos indicadores negativos, não é necessário deixar toda a linha vermelha. Mantenha o sparkline na cor principal e preserve o vermelho apenas no badge de variação.
- Destaque somente o último ponto da série com um pequeno círculo.
- Mantenha boa margem entre o sparkline, o texto auxiliar e o badge.
- O gráfico deve respeitar o recorte e os filtros aplicados no dashboard.
- O período representado deve ser o mesmo para todos os cards, preferencialmente os últimos 12 meses ou os períodos disponíveis no filtro atual.
- O resultado deve ser minimalista, corporativo e coerente com o design atual.

Ajuste sugerido para a organização interna de cada card:
1. Título.
2. Valor principal.
3. Texto auxiliar.
4. Sparkline.
5. Badge de comparação com o mês anterior.

Nos cards de Pedidos, OTIF, Custo Logístico, Lead Time e Emissões, crie uma série temporal específica para cada indicador.

Não redesenhe completamente os cards. Apenas insira os sparklines de maneira harmoniosa e mantenha todas as funcionalidades existentes.
```

## Revisar narrativa e boas práticas antes de editar

```text
Agora para validação, antes das minhas considerações, fazendo uma analise no no dashboard criado que está aberto no Power BI, de acordo com as boas praticas de dados, story telling com dados, visualização, que alterações achas que devem ser feitas, apenas faça analise geral e tarag as alterações necessárias, sem altera-las ainda
```

## Autorizar a revisão com backup

```text
faça todas essas alterações que vou avaliar, deixa o atual em um backup interno que posso pedir um rollback
```

## Ajustar badges e ranking pelas referências visuais

```text
ficou otimo, vamos a algumas alterações mais
a comparação mensal nos cards deve ser parecida a esta da foto
O rankin na tabela deve aparecer desta forma também conforme a imagem
```

## Avaliar a separação entre Estratégia e Operação

```text
Perfeito, vamos melhorando aos poucos, agora com base nas perguntas do negocio, na necessidade de ser data driven estrategica e operacionalmente. Analisando o painel a página de análise, não está muito poluida com muita informação, se tivesse que ter uma página mais estrategica e uma outra mais operacional, trazendo dados e análises necessárias? Lembrando que menos é mais, faça essa analise sem fazer quaisquer alterações
```

## Implementar a separação

```text
Perfeito vamos seguir com essas alterações sem distorcer nada o obejtivo é trazer clareza e direcionamento para tomada de decisão, melhoria e evolução do negocio. deixe o atual como backup caso eu precise fazer rollback, já criei a página **Operação**   que está em branco
```
