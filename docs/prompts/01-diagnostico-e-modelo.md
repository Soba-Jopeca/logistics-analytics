# Diagnóstico e modelo semântico

[Voltar ao índice](../prompts-e-skills.md)

Prompt usado nesta etapa. O caminho local da skill foi substituído pela invocação por nome.

```text
Use $dax-creation-expert para preparar do zero uma base logística no Power BI Desktop aberto.
Projeto Power BI: Logistics Analytics
Use a conexão MCP para trabalhar diretamente no Power BI aberto.
Nesta primeira etapa, faça somente diagnóstico, Power Query e modelagem.

1. Antes de alterar o projeto, inspecione o arquivo e apresente:
- planilhas ou tabelas encontradas;
- quantidade de linhas e colunas;
- granularidade real da base;
- chave do pedido e possível chave da linha/item;
- duplicidades na granularidade correta;
- colunas de data e função de cada data;
- dimensões disponíveis;
- métricas numéricas;
- tipos incorretos;
- valores nulos, vazios e erros;
- quantidade de pedidos ainda não entregues;
- possíveis inconsistências entre status e datas.
Não assuma que uma linha representa um pedido. Verifique se a base está no nível de pedido, item, ocorrência ou etapa.

2. Importe e trate a base no Power Query.
- Crie uma consulta de staging rastreável.
- Padronize nomes e tipos sem alterar o significado.
- Preserve todos os pedidos ainda não entregues.
- Não preencha artificialmente datas de entrega.
- Não exclua registros sem explicar e quantificar.
- Só remova duplicidades quando a equivalência estiver comprovada.
- Prefira flags de qualidade a apagar registros.
- Crie lead time ou dias de atraso somente se existirem as datas necessárias e a regra estiver comprovada.
- Registre a quantidade de linhas antes e depois do tratamento.

3. Crie um modelo estrela.
- Crie uma tabela fato na granularidade validada.
- Crie somente dimensões necessárias e sustentadas pela base.
- Considere, quando existirem campos compatíveis: transportadora, região de destino, modal, produto, categoria, cliente, origem e status.
- Garanta chave única no lado 1.
- Configure relacionamentos 1 para muitos.
- Use filtro em direção única da dimensão para a fato.
- Não crie relacionamentos bidirecionais ou muitos-para-muitos sem justificativa.
- Confirme que não há caminhos ambíguos.

4. Crie e marque uma dCalendario.
- Use um intervalo compatível com as datas da base.
- Crie os atributos necessários para análise temporal e ordenação.
- Defina e documente a data ativa principal.
- Para outras datas, use relacionamento inativo ou dimensão de papel quando necessário.
- Não deixe mais de um caminho ativo ambíguo.

5. Valide a modelagem.
- Reconcilie a quantidade de registros com a fonte.
- Verifique duplicidades na chave.
- Confirme a unicidade das dimensões.
- Teste se cada dimensão filtra a fato.
- Verifique registros órfãos.
- Confirme relacionamentos 1:\* e direção única.
- Confirme a marcação da dCalendario.
- Execute consultas de validação quando possível.

Não crie medidas DAX, JSON, HTML, CSS, JavaScript, KPIs ou visuais nesta etapa.

Ao final, apresente:
- diagnóstico da base;
- granularidade e chaves;
- tratamentos realizados;
- quantidade de registros antes e depois;
- fato e dimensões criadas;
- calendário e data ativa;
- relacionamentos configurados;
- problemas encontrados;
- regras de negócio ainda não confirmadas;
- limitações da modelagem.

Não salve nem sobrescreva o PBIX sem minha autorização.
```
