# Mensagens de melhoria para reutilizar

[Voltar ao índice](../prompts-e-skills.md)

Os exemplos abaixo são modelos de revisão. Adapte a métrica, o recorte e o critério de aceite ao seu projeto.

## Auditar antes de mudar

```text
Leia a página atual e consulte o modelo em modo somente leitura.
Liste três problemas de decisão ou interpretação, com exemplos do painel.
Classifique por impacto e indique como você verificaria cada ajuste.
Não altere medidas, visuais nem o arquivo nesta etapa.
```

## Corrigir comparação de mês parcial

```text
Investigue a comparação de julho com junho. Julho tem cobertura até o dia 10.
Compare os mesmos dias efetivamente disponíveis nos dois meses. Mantenha
o KPI principal no contexto atual e identifique o período do badge.
Mostre os dois totais e o denominador do OTIF. Valide com consulta DAX
e com filtro de região antes de alterar a apresentação.
```

## Refinar um visual sem mudar o cálculo

```text
Altere somente a medida de apresentação deste visual. Preserve o JSON,
os denominadores, os filtros externos e a ordenação. Crie uma cópia oculta
com nome único antes de substituir o DAX. Valide total, recorte regional,
estado vazio e navegação por teclado. Não salve o PBIX sem autorização.
```

## Separar decisão estratégica de execução operacional

```text
Reduza a página estratégica a quatro indicadores, uma tendência e até
duas prioridades. Na operação, mostre somente os status confirmados da
carteira e uma lista de pedidos. Não converta um status observado em
novo SLA. Traga evidências de que contagens, taxas e filtros reconciliam.
```

## Solicitar rollback

```text
Confirme o nome e a data do backup antes de restaurá-lo. Mostre quais
objetos dependem dessa versão e quais voltariam juntos. Após a restauração
autorizada, execute a consulta de conferência e abra os visuais afetados.
```
