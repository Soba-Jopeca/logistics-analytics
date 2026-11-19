Table.SelectColumns(
    Table.AddColumn(
        Table.AddColumn(
            stgLogistica,
            "Chave_Destino",
            each [UF_Destino]&"|"&[Cidade_Destino],
            type text
        ),
        "Flag_Devolucao_Futura",
        each [Data_Devolucao] <> null and [Data_Devolucao]>[Data_Atualizacao],
        type logical
    ),
    {
        "ID_Pedido", "Nota_Fiscal", "Data_Pedido", "Data_Aprovacao",
        "Data_Expedicao", "Data_Prevista_Entrega", "Data_Entrega", "Data_Atualizacao",
        "Canal_Venda", "SKU", "Quantidade_Pedida", "Quantidade_Entregue",
        "Peso_Total_kg", "Volume_Total_m3", "Valor_Pedido_R$", "Valor_Frete_R$",
        "Custo_Armazenagem_R$", "Custo_Separacao_R$", "Custo_Ultima_Milha_R$", "Custo_Logistico_Total_R$",
        "Frete_sobre_Venda_%", "Custo_Logistico_por_kg_R$", "CD_Origem", "Transportadora",
        "Modal", "Distancia_km", "Prazo_Prometido_Dias", "Tempo_Separacao_Horas",
        "Tempo_Transito_Dias", "Lead_Time_Total_Dias", "Dias_Atraso", "Entrega_No_Prazo",
        "Pedido_Completo", "OTIF", "Status_Entrega", "Tentativas_Entrega",
        "Tipo_Ocorrencia", "Motivo_Atraso", "Pedido_Avariado", "Pedido_Extraviado",
        "Devolucao", "Motivo_Devolucao", "Data_Devolucao", "Nota_Cliente",
        "Emissao_CO2_kg", "Faixa_Distancia", "Faixa_Peso", "Chave_Destino",
        "Flag_Devolucao_Futura"
    }
)
