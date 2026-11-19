# Skills e prompts reutilizáveis

[Voltar ao README](../README.md) · [Conexão MCP](conexao-mcp.md)

O trabalho foi conduzido em etapas curtas com evidência de aceitação. A skill **`dax-creation-expert`** orientou diagnóstico, granularidade, contexto de filtro e validação. A skill **`dataviz-html-dax`** orientou a passagem DAX → JSON → HTML, os filtros internos e os testes de renderização. Os prompts abaixo são versões condensadas para reprodução do processo.

## Skill, prompt e ferramenta

| Peça | Responsabilidade |
| --- | --- |
| MCP | Expõe ferramentas para ler ou alterar o modelo e executar consultas. |
| Skill | Define um método reaplicável, como validar granularidade antes de calcular taxas. |
| Prompt | Fixa o objetivo, os dados de entrada, as decisões autorizadas e as evidências da etapa atual. |

No Codex, uma skill tem uma pasta e um arquivo `SKILL.md` com metadados YAML. Para compartilhar no repositório, coloque-a sob `.agents/skills/<nome>/SKILL.md`. Em seguida, invoque a skill pelo seletor ou por nome no prompt. [Skills no Codex](https://developers.openai.com/codex/skills)

### Exemplo adaptável de SKILL.md

```markdown
---
name: revisao-bi-logistico
description: Use ao modelar ou validar pedidos, OTIF, atraso e custo em Power BI com MCP.
---

Leia o modelo e confirme a granularidade, a chave e a data ativa.
Confirme o numerador, o denominador e o tratamento de casos vazios.
Preserve filtros externos. Relate ambiguidade antes de inventar uma regra.
Valide medidas em DAX no total, em um período e em uma dimensão.
Ao revisar HTML, preserve medidas e compare o resultado no canvas.
```

## Sequência de prompts

### 1. Diagnóstico e modelo

```text
Use o Power BI Authoring MCP no arquivo aberto. Primeiro leia a fonte.
Quantifique linhas, colunas, chaves, duplicidades, nulos e pedidos sem
entrega. Confirme se a granularidade é pedido ou item. Depois proponha
staging, fato, dimensões e calendário. Preserve cada pedido e não impute
datas de entrega. Valide chaves, relações e contagem antes e depois.
```

### 2. Medidas DAX e critérios de aceite

```text
Leia o modelo e use a skill dax-creation-expert. Crie as medidas a partir
dos campos confirmados. Para OTIF, registre a população elegível, a
interseção entre prazo e completude e a taxa. Separe atraso em entrega
concluída de status Atrasado na carteira. Valide total, mês, dimensões,
denominador zero e mês sem dados. Mostre os valores encontrados.
```

### 3. JSON Gold e comparação mensal

```text
Crie uma medida JSON com metadados, KPIs, séries e base interativa.
Reutilize medidas validadas. Para taxas e médias exporte numeradores
e denominadores. Preserve filtros do Power BI. Compare dias
equivalentes em meses parciais. Teste o parse e reconcilie cada total.
```

### 4. Visual e narrativa

```text
Use a skill dataviz-html-dax. Separe Estratégia e Operação. Na primeira
página mostre um resumo com até duas prioridades, quatro KPIs e uma
tendência alternável. Na Operação mostre a posição da carteira e ordene
a fila por status e previsão. Não introduza metas, faixas de risco nem
causas que não estejam demonstradas. Use o JSON como fonte do visual.
```

### 5. Revisão antes de salvar e publicar

```text
Verifique o modelo aberto via MCP. Crie uma cópia oculta de qualquer
medida existente antes da alteração. Execute consultas DAX e confira
os visuais no canvas. Teste filtros, recortes vazios, teclado e largura
reduzida. Registre o que foi aprovado e o que ficou pendente. Aguarde
autorização para salvar ou publicar.
```

## Para obter uma resposta verificável

Dê ao agente o **nome do arquivo**, o **escopo permitido**, uma **regra de negócio confirmada** e uma **consulta ou resultado esperado**. Um critério concreto neste caso é **827 pedidos OTIF de 955 elegíveis no total**. Uma alteração estética deve preservar esses números e a população em cada recorte. Se o agente não consegue observar o resultado ou o canvas, peça que diferencie execução, verificação e pendência.
