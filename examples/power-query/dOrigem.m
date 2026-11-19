Table.Distinct(Table.SelectColumns(Table.AddColumn(stgLogistica,"Chave_Destino",each [UF_Destino]&"|"&[Cidade_Destino],type text),{"CD_Origem", "Cidade_Origem", "UF_Origem", "Regiao_Origem"}))
