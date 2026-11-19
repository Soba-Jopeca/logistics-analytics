# Consultas Power Query do modelo

[Voltar ao guia de construção](../../docs/construcao-e-validacao.md)

Estas consultas M vieram das partições do modelo aberto, lidas por MCP. Na consulta de staging, o caminho absoluto da máquina original foi substituído pelo parâmetro `pCaminhoBase`.

1. Baixe a [planilha completa](../../docs/base/base_logistica_simulada_brasil.xlsx).
2. No Editor do Power Query, crie o parâmetro de texto `pCaminhoBase` com o caminho completo do arquivo `.xlsx` no seu computador.
3. Crie uma Consulta em Branco com o nome `stgLogistica` e cole o conteúdo de [stgLogistica.m](stgLogistica.m) no Editor Avançado. Ela lê `TabelaBaseLogistica`. Desative **Habilitar carga** para o staging.
4. Crie as consultas abaixo, com os nomes exatos, e habilite a carga para a fato e dimensões.
5. Aplique as alterações e configure as relações conforme o [modelo semântico](../../docs/modelo-e-medidas.md). Marque `dCalendario` como tabela de datas.

| Consulta | Papel |
| --- | --- |
| [fPedidos](fPedidos.m) | Um registro por pedido e chaves analíticas. |
| [dProduto](dProduto.m) | SKU, produto e categoria. |
| [dOrigem](dOrigem.m) | Centro de distribuição de origem. |
| [dDestino](dDestino.m) | Cidade, UF e região do destino. |
| [dTransportadora](dTransportadora.m) | Transportadora do pedido. |
| [dModal](dModal.m) | Modal registrado. |
| [dStatus](dStatus.m) | Status de entrega. |
| [dCanal](dCanal.m) | Canal de venda. |
| [dCalendario](dCalendario.m) | Calendário contínuo calculado a partir das datas da fonte. |

Para replicar a organização, adicione uma tabela de suporte chamada `Medidas`, oculte sua coluna técnica e crie nela as [medidas de negócio e apresentação](../../assets/medidas/README.md), respeitando as dependências.
