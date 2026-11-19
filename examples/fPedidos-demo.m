let
    Fonte = #table(
        type table [
            ID_Pedido = text,
            Data_Pedido = date,
            Data_Entrega = nullable date,
            Status_Entrega = text,
            Entrega_No_Prazo = text,
            Pedido_Completo = text,
            #"Custo_Logistico_Total_R$" = number,
            Lead_Time_Total_Dias = nullable number
        ],
        {
            {"DEMO-001", #date(2026, 6, 2), #date(2026, 6, 5), "Entregue", "Sim", "Sim", 45, 3},
            {"DEMO-002", #date(2026, 6, 4), #date(2026, 6, 9), "Entregue", "Não", "Sim", 58, 5},
            {"DEMO-003", #date(2026, 6, 8), #date(2026, 6, 12), "Entregue", "Sim", "Não", 61, 4},
            {"DEMO-004", #date(2026, 7, 1), #date(2026, 7, 3), "Entregue", "Sim", "Sim", 40, 2},
            {"DEMO-005", #date(2026, 7, 2), null, "Atrasado", "Pendente", "Pendente", 49, 7},
            {"DEMO-006", #date(2026, 7, 3), null, "Em trânsito", "Pendente", "Pendente", 35, 6},
            {"DEMO-007", #date(2026, 7, 3), null, "Atrasado", "Pendente", "Pendente", 51, 6},
            {"DEMO-008", #date(2026, 7, 5), null, "Cancelado", "Não aplicável", "Não aplicável", 0, null}
        }
    )
in
    Fonte
