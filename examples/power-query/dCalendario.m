let
    Datas = List.RemoveNulls(List.Combine(Table.ToColumns(Table.SelectColumns(stgLogistica,{"Data_Pedido", "Data_Aprovacao", "Data_Expedicao", "Data_Prevista_Entrega", "Data_Entrega", "Data_Atualizacao", "Data_Devolucao"})))),
    Inicio = Date.StartOfYear(List.Min(Datas)),
    Fim = Date.EndOfYear(List.Max(Datas)),
    T = Table.FromColumns({List.Dates(Inicio,Duration.Days(Fim-Inicio)+1,#duration(1,0,0,0))},type table [Data=date]),
    A = Table.AddColumn(
        T,
        "Ano",
        each Date.Year([Data]),
        Int64.Type
    ),
    M = Table.AddColumn(
        A,
        "MesNumero",
        each Date.Month([Data]),
        Int64.Type
    ),
    N = Table.AddColumn(
        M,
        "Mes",
        each Date.MonthName([Data],"pt-BR"),
        type text
    ),
    Q = Table.AddColumn(
        N,
        "Trimestre",
        each Date.QuarterOfYear([Data]),
        Int64.Type
    ),
    AM = Table.AddColumn(
        Q,
        "AnoMes",
        each Date.ToText([Data],"yyyy-MM"),
        type text
    )
in
    AM
