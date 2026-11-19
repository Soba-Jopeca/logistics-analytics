Table.Distinct(Table.SelectColumns(Table.AddColumn(stgLogistica,"Chave_Destino",each [UF_Destino]&"|"&[Cidade_Destino],type text),{"SKU", "Produto", "Categoria_Produto"}))
