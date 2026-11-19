# Modelo semântico e medidas

[Voltar ao README](../README.md)

O [diagrama dimensional](../README.md#modelo-dimensional) mostra as oito relações ativas. A tabela abaixo inclui também as cinco relações inativas do calendário, conforme a leitura do modelo pelo Power BI Authoring MCP. Todas têm cardinalidade de **um para muitos**, com filtro da dimensão para `fPedidos`.

A `dCalendario` está marcada como tabela de datas. A coluna `Data_Atualizacao` registra a posição da fonte e fica na fato.

## Relacionamentos

| Dimensão e chave | Coluna em `fPedidos` | Estado |
| --- | --- | --- |
| `dProduto[SKU]` | `SKU` | Ativo |
| `dOrigem[CD_Origem]` | `CD_Origem` | Ativo |
| `dDestino[Chave_Destino]` | `Chave_Destino` | Ativo |
| `dTransportadora[Transportadora]` | `Transportadora` | Ativo |
| `dModal[Modal]` | `Modal` | Ativo |
| `dStatus[Status_Entrega]` | `Status_Entrega` | Ativo |
| `dCanal[Canal_Venda]` | `Canal_Venda` | Ativo |
| `dCalendario[Data]` | `Data_Pedido` | Ativo |
| `dCalendario[Data]` | `Data_Aprovacao` | Inativo |
| `dCalendario[Data]` | `Data_Expedicao` | Inativo |
| `dCalendario[Data]` | `Data_Prevista_Entrega` | Inativo |
| `dCalendario[Data]` | `Data_Entrega` | Inativo |
| `dCalendario[Data]` | `Data_Devolucao` | Inativo |

## Pastas de medidas

![Imagem da organização das medidas](../assets/organizacao-medidas.svg)

O agrupamento reflete as pastas do modelo. As expressões e as instruções de reutilização estão no [catálogo das 53 medidas](../assets/medidas/README.md).
