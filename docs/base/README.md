# Base simulada para reprodução

[Voltar ao README](../../README.md) · [Construção do modelo](../construcao-e-validacao.md)

**[Baixar a base em Excel](base_logistica_simulada_brasil.xlsx)**

A planilha completa foi incluída para que o leitor possa reproduzir os volumes, recortes e denominadores do dashboard. A aba **Premissas** identifica os dados como **100% simulados** e as transportadoras como fictícias. A cópia publicada preserva tabelas, fórmulas e dados do arquivo de origem. A cópia remove apenas metadados do último editor e do caminho local salvo pelo Excel. A revisão não encontrou conexões externas ou abas ocultas.

| Aba | Uso |
| --- | --- |
| `Base_Logistica` | Fonte do modelo. A tabela Excel `TabelaBaseLogistica` tem 1.000 linhas e 58 colunas. |
| `Dicionario_Dados` | Definição dos campos e unidades. Consulte antes de criar medidas. |
| `Guia_Dashboard` | Ideias de análise presentes no material de origem. |
| `Premissas` | Natureza simulada, cobertura e restrições de interpretação. |

## Abrir no Power BI

Baixe o arquivo e, no Power BI Desktop, use **Obter dados → Pasta de trabalho do Excel**. Escolha **`TabelaBaseLogistica`** no Navegador. Use os campos de `Data_Pedido` e `Data_Atualizacao` separadamente. A cobertura dos pedidos vai de 01/07/2025 a 10/07/2026, e a data de referência da base é 15/07/2026.

A reconstrução do modelo está no [guia de construção](../construcao-e-validacao.md). Para experimentar os cálculos antes de montar dimensões, há também uma [amostra M de oito registros](../../examples/fPedidos-demo.m) e uma [consulta DAX de demonstração](../../examples/kpis-demo.dax).
