# Conectar o OpenAI Codex ao Power BI Desktop via MCP

[Voltar ao README](../README.md)

## Quem faz o quê

O **Codex** interpreta o objetivo, chama ferramentas e verifica a saída. O **Power BI Authoring MCP** é o servidor da Microsoft que expõe operações sobre o modelo semântico. O **Power BI Desktop** hospeda o modelo local. As **skills** descrevem o método que o agente segue. Prompts definem a tarefa, o escopo e os critérios de aceitação daquela execução.

Neste projeto, o servidor já estava instalado pela extensão de Power BI no VS Code. O Codex iniciou o executável local com transporte **stdio** e se conectou ao modelo Desktop em `localhost`. O caminho abaixo por instalação npm é uma alternativa documentada para reproduzir a conexão. [Servidor oficial da Microsoft](https://github.com/microsoft/powerbi-modeling-mcp)

## Pré-requisitos

- Windows com Power BI Desktop e o arquivo de trabalho aberto na mesma máquina que executa o servidor local.
- Codex com suporte a servidores MCP locais. Para a instalação por npm, ter Node.js e `npx` disponíveis no terminal.
- Acesso autorizado ao arquivo e ao modelo. Para escrita, usar uma cópia de trabalho e conferir a conexão em modo somente leitura primeiro.

## 1. Registrar o servidor no Codex

Adicione o bloco abaixo ao arquivo de configuração do usuário, normalmente `%USERPROFILE%\.codex\config.toml` no Windows. Preserve as configurações existentes. `cmd.exe` permite chamar o launcher do npm no Windows.

```toml
[mcp_servers.powerbi_local]
command = "cmd.exe"
args = ["/c", "npx", "-y", "@microsoft/powerbi-modeling-mcp", "--start", "--readonly"]
startup_timeout_sec = 60
tool_timeout_sec = 120
```

A primeira ativação pode exigir aceite dos termos do servidor. Leia a licença e faça o aceite pelo fluxo disponível no cliente. Em execução sem interação, o servidor documenta `--accept-eula` ou `PBI_MODELING_MCP_ACCEPT_EULA=true`. Use esses parâmetros somente após o aceite explícito. [Licença do servidor](https://go.microsoft.com/fwlink/?LinkId=2381247) · [Opções de inicialização](https://github.com/microsoft/powerbi-modeling-mcp)

A instalação pela extensão do VS Code também inclui o executável. Nesse caso, substitua `command` pelo caminho do executável e use `args = ["--start", "--readonly"]`. O caminho real depende da instalação. A extensão fornece o binário. A configuração MCP do Codex é feita separadamente.

```powershell
codex mcp list
```

O comando confirma o cadastro do servidor. A prova da conexão acontece quando o agente consegue listar as tabelas do modelo aberto. Abra uma nova sessão após alterar a configuração, se necessário. [Configuração de MCP no Codex](https://developers.openai.com/codex/mcp)

## 2. Confirmar o modelo com uma consulta somente leitura

```text
Use o servidor powerbi_local. Liste as instâncias do Power BI Desktop.
Conecte ao projeto Logistics Analytics. Confirme o nome do modelo e liste
tabelas, colunas e relacionamentos. Execute uma consulta DAX para contar
as linhas de fPedidos e os IDs de pedido distintos. Faça apenas leitura.
```

O fluxo normalmente usa `connection_operations` com `ListLocalInstances` e `ConnectToPowerBIDesktop`, seguido das ferramentas de tabelas, medidas, relacionamentos e consultas DAX. Se a descoberta não funcionar, identifique o endpoint local aberto e use uma conexão explícita no formato `Data Source=localhost:<porta-da-sessão>`. A porta muda entre sessões. Se o sandbox bloquear acesso ao processo local, trate a restrição pelo mecanismo de permissões do cliente. [Conexão com o Desktop](https://learn.microsoft.com/en-us/power-bi/developer/mcp/power-bi-authoring-mcp)

## 3. Autorizar a autoria em uma cópia de trabalho

Troque `--readonly` por `--readwrite` depois de conferir o modelo e autorizar a edição. Separe as mudanças em lotes e reconcilie a saída com consultas antes e depois. Antes de alterar uma medida existente, copie sua expressão para um backup oculto com nome único. Backups feitos no modelo em memória dependem do salvamento da cópia de trabalho para persistir ao fechar o Desktop.

Neste caso, o MCP foi usado para alterar o modelo e as medidas. A instalação utilizada não expôs as operações de canvas necessárias para montar os visuais. A inserção do visual personalizado e a vinculação das medidas foram feitas no Power BI. As capacidades podem variar entre versões e superfícies.

## Diagnóstico rápido

| Sintoma | Verificação |
| --- | --- |
| Servidor não aparece | Confirme instalação, caminho do executável e configuração MCP do Codex. |
| Mensagem de licença | Revise os termos e conclua o aceite autorizado. |
| Nenhuma instância encontrada | Verifique se o Desktop está aberto, se o servidor roda no mesmo Windows e se o ambiente permite conexão ao processo local. |
| Leitura funciona, escrita falha | Confirme modo `--readwrite` e permissão no modelo de destino. |
| Medida Ready, visual vazio | Confira a função `Values` e a edição do visual. Execute DAX e teste o HTML renderizado no canvas. |
| Arquivo publicado desatualizado | Compare a versão salva do PBIX com a publicação, a data da fonte e os filtros do serviço. |

**Governança.** Um servidor local pode enviar metadados e resultados ao cliente MCP, que pode encaminhar contexto ao provedor de IA configurado. Use dados simulados ou aprovados para esse fluxo. Mantenha credenciais, caminhos pessoais e configurações com segredos fora do Git. [Considerações de privacidade do MCP da Microsoft](https://github.com/microsoft/powerbi-modeling-mcp#data-privacy-and-llm-providers)
