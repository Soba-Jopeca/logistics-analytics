# Skills e prompts usados no projeto

[Voltar ao README](../README.md) · [Conexão MCP](conexao-mcp.md)

As duas skills abaixo são as versões usadas no projeto, incluindo os arquivos de referência disponíveis. Os prompts de desenvolvimento foram recuperados do trabalho original. Os links para caminhos pessoais foram substituídos pelo nome da skill e as quebras de linha foram normalizadas para leitura no GitHub.

| Skill | Em que etapa entrou | Arquivo |
| --- | --- | --- |
| `dax-creation-expert` | Diagnóstico, modelo semântico, definição e validação de medidas. | [SKILL.md](skills/dax-creation-expert/SKILL.md) |
| `dataviz-html-dax` | Contrato JSON, construção de visual, filtros internos e revisão de renderização. | [SKILL.md](skills/dataviz-html-dax/SKILL.md) · [Referências](skills/dataviz-html-dax/references/) |

Para recriar uma skill com o assistente, abra o **Skill Creator** no seletor de skills do Codex ou invoque `$skill-creator` e forneça o arquivo de referência. Para reutilizar a versão publicada, copie a pasta completa para `.agents/skills/` no seu projeto, como descrito no [guia de conexão](conexao-mcp.md#5-criar-ou-reutilizar-as-skills).

O **MCP** disponibiliza operações. A **skill** define um método reaplicável. O **prompt** define o objetivo, o escopo e o que deve ser demonstrado na tarefa atual.

## Prompts de desenvolvimento

| Etapa | Prompt | O que conferir |
| --- | --- | --- |
| 1. Fonte e modelo | [Diagnóstico e modelagem](prompts/01-diagnostico-e-modelo.md) | Uma linha por pedido, 1.000 IDs distintos, calendário e relacionamentos consistentes. |
| 2. Medidas | [Criação e validação DAX](prompts/02-medidas-dax.md) | 827 pedidos OTIF de 955 elegíveis. Separação entre atraso histórico e status pendente. |
| 3. Contrato de dados | [JSON Gold](prompts/03-json-gold.md) | Totais reconciliados, filtro preservado e bases suficientes para taxas e médias. |
| 4. Visual principal | [HTML da análise](prompts/04-html-analise.md) | Filtros, estados vazios e diferenças entre renderização no navegador e no canvas. |
| 5. Investigação | [Refinamento analítico](prompts/05-refinamento-analitico.md) | Priorização por impacto e taxa, leitura proporcional a cada recorte. |
| 6. Acabamento | [Capa e acabamento](prompts/06-capa-e-acabamento.md) | Animação acessível, versão final do OTIF e navegação no Power BI. |

Os prompts registram o objetivo de cada etapa, inclusive requisitos que passaram por revisão. Consulte a [construção e validação](construcao-e-validacao.md) e o [catálogo de medidas](../assets/medidas/README.md) para ver a composição final, com a separação entre Estratégia e Operação.

## Mensagens para iterar com segurança

- [Revisões que aconteceram no projeto](prompts/07-revisoes-do-projeto.md)
- [Exemplos de mensagens de melhoria](prompts/08-mensagens-de-melhoria.md)

Antes de enviar uma revisão, indique **qual objeto pode mudar**, **qual cálculo deve ser preservado** e **como validar o resultado**. Um ajuste visual, por exemplo, deve preservar os 827 pedidos OTIF, os 955 elegíveis e o comportamento por recorte.
