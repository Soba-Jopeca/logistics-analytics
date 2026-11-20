# Conectar o Codex ao Power BI Desktop no Windows

[Voltar ao README](../README.md) · [Skills e prompts](prompts-e-skills.md)

Este guia reproduz o caminho usado neste projeto. O **Power BI Authoring MCP**, da Microsoft, foi instalado pelo Visual Studio Code. Seu executável local foi registrado no **Codex** para consultar o modelo aberto no **Power BI Desktop**. O primeiro cadastro usa somente leitura. A autorização para editar o modelo é uma etapa separada.

## 1. Instalar o Codex e preparar o Power BI

1. Baixe e instale o **aplicativo oficial da OpenAI** para Windows. Na distribuição atual, a experiência Codex está disponível dentro do aplicativo ChatGPT para desktop. Entre com a sua conta e selecione **Codex**. [Download oficial](https://openai.com/codex/) · [Aplicativo de desktop](https://help.openai.com/en/articles/20001276-moving-to-the-new-chatgpt-desktop-app)
2. Tenha **Visual Studio Code** e **Power BI Desktop** instalados. Abra o PBIX de trabalho no Power BI Desktop, no mesmo Windows em que o Codex e o servidor MCP serão executados.

## 2. Instalar o Power BI Authoring MCP pelo VS Code

1. Abra **Extensões** no VS Code com `Ctrl+Shift+X`.
2. Procure por **Power BI Authoring MCP Server**. Confira o ID `analysis-services.powerbi-modeling-mcp` e instale a extensão oficial. [Extensão no Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=analysis-services.powerbi-modeling-mcp)
3. No Explorador de Arquivos do Windows, digite `%USERPROFILE%\.vscode\extensions` na barra de endereço. Localize a pasta que começa com `analysis-services.powerbi-modeling-mcp-` e abra a subpasta `server`.
4. Localize o arquivo **`powerbi-modeling-mcp.exe`** e use **Copiar como caminho**. O executável é iniciado pelo Codex quando o servidor é usado. A extensão serve para instalar o binário e pode ficar fechada durante o trabalho no Codex.

A versão encontrada neste projeto foi **1.0.1 para Windows x64**. Use a pasta que realmente aparece no seu computador.

```text
C:\Users\SEU_USUARIO\.vscode\extensions\analysis-services.powerbi-modeling-mcp-1.0.1-win32-x64\server\powerbi-modeling-mcp.exe
```

## 3. Registrar o executável nas configurações do Codex

No aplicativo de desktop, abra **Configurações → MCP servers → Add server** (os rótulos dependem do idioma). Use **STDIO** e preencha os campos abaixo. [Configuração MCP no aplicativo desktop](https://learn.chatgpt.com/docs/extend/mcp?surface=desktop#configure-in-the-chatgpt-desktop-app)

| Campo | Preenchimento |
| --- | --- |
| Nome | `powerbi-authoring-local` |
| Transporte | `STDIO` |
| Comando | Caminho completo de `powerbi-modeling-mcp.exe` copiado no Explorador |
| Argumento 1 | `--start` |
| Argumento 2 | `--readonly` |

**No campo Comando, use só uma barra invertida `\` por separador**, como no exemplo acima. Remova as aspas externas se o Explorador as incluiu. Insira os argumentos em entradas separadas. Salve o servidor e selecione **Restart**. No compositor, digite `/mcp` para conferir se ele aparece. [Configuração oficial do Codex](https://developers.openai.com/codex/mcp)

<details>
<summary>Equivalente para editar o config.toml manualmente</summary>

A configuração local do Codex costuma ficar em `%USERPROFILE%\.codex\config.toml`. Use este bloco como alternativa à interface. Aspas simples no TOML preservam as barras invertidas literalmente.

```toml
[mcp_servers.powerbi-authoring-local]
command = 'C:\Users\SEU_USUARIO\.vscode\extensions\analysis-services.powerbi-modeling-mcp-1.0.1-win32-x64\server\powerbi-modeling-mcp.exe'
args = ["--start", "--readonly"]
```

Em **JSON**, uma barra literal é escrita como `\\` porque o formato faz escape. Isso continua representando uma única barra no caminho real. O trecho abaixo explica a diferença ao ler um cadastro JSON. A interface do Codex recebe somente o caminho puro, e o formato nativo de configuração do Codex é TOML.

```json
{
  "powerbi-authoring-local": {
    "command": "C:\\Users\\SEU_USUARIO\\.vscode\\extensions\\analysis-services.powerbi-modeling-mcp-1.0.1-win32-x64\\server\\powerbi-modeling-mcp.exe",
    "args": [
      "--start",
      "--readonly"
    ]
  }
}
```

</details>

## 4. Autorizar a licença e testar a conexão

Leia os termos do servidor e conclua o aceite se o cliente solicitar. Use `--accepteula` em execução sem interação depois de concordar com os termos. A versão 1.0.1 também reconhece `--accept-eula`. [Termos da Microsoft](https://go.microsoft.com/fwlink/?LinkId=2381247) · [Opções de aceite no servidor](https://github.com/microsoft/powerbi-modeling-mcp#accept-the-eula)

Com o relatório aberto, comece pelo teste abaixo. Depois de validar a conexão, use o [prompt de diagnóstico do projeto](prompts/01-diagnostico-e-modelo.md) para inspecionar a fonte e planejar o modelo.

```text
Use o servidor powerbi-authoring-local. Liste as instâncias do Power BI Desktop,
conecte ao relatório aberto e confirme seu nome. Liste as tabelas e medidas.
Execute EVALUATE ROW("Conexao", 1). Se fPedidos já existir, consulte também
a contagem de linhas e de IDs distintos. Faça apenas leitura.
```

O teste deve retornar uma linha com `Conexao = 1` no modelo selecionado. No caso documentado, a descoberta automática falhou dentro do sandbox. A conexão ocorreu pelo MCP local usando o endpoint da sessão no formato `Data Source=localhost:<porta-da-sessão>`, após a autorização de acesso ao processo local. A porta é dinâmica. [Conexão local do Power BI Authoring MCP](https://learn.microsoft.com/en-us/power-bi/developer/mcp/power-bi-authoring-mcp#connect-to-a-semantic-model)

## 5. Criar ou reutilizar as skills

Depois de validar a conexão, abra o seletor de skills no Codex e use o **Skill Creator**, a ferramenta integrada de criação de skills. Também é possível invocá-lo digitando `$skill-creator`. Descreva a finalidade, quando usar a skill e como validar o resultado. Para reproduzir a metodologia deste projeto, forneça os dois arquivos reais e seus recursos de apoio. [Criação de skills no Codex](https://learn.chatgpt.com/docs/build-skills#create-a-skill)

- [`dax-creation-expert`](skills/dax-creation-expert/SKILL.md) para modelagem e validação DAX.
- [`dataviz-html-dax`](skills/dataviz-html-dax/SKILL.md) para DataViz, JSON e HTML no Power BI.

Para usar as versões publicadas diretamente, copie a pasta inteira de cada skill de `docs/skills/` para `.agents/skills/` no seu projeto. Inclua `references/` quando existir. Abra o projeto no Codex e escolha a skill no seletor ou invoque pelo nome no prompt. [Locais de descoberta de skills](https://learn.chatgpt.com/docs/build-skills#where-codex-loads-local-skills)

## 6. Liberar a autoria quando o escopo estiver aprovado

Depois de confirmar a instância e os resultados da consulta, use uma cópia de trabalho e troque `--readonly` por `--readwrite` para o período de edição autorizado. Reinicie o servidor. Trabalhe por etapas, compare as consultas antes e depois e faça backup das medidas que serão substituídas. No caso, o MCP trabalhou no modelo em memória. A associação das medidas aos visuais no canvas e a publicação foram feitas no Power BI.

## Diagnóstico rápido

| Sintoma | O que verificar |
| --- | --- |
| Servidor não aparece | Confira o nome, transporte STDIO e o caminho do executável. Use Restart após salvar. |
| Caminho não existe | Confira a pasta da extensão instalada. A versão e a arquitetura podem mudar o nome da pasta. |
| Falha de licença | Leia os termos e conclua o aceite autorizado no cliente. |
| Nenhuma instância encontrada | Abra o Power BI Desktop com o relatório carregado e confira o host local e as permissões do cliente. |
| Consulta funciona, edição falha | Confira o modo `--readonly`, a permissão de gravação e o modelo de destino. |
| Medida Ready, visual vazio | Confira a edição do visual HTML Content, o campo `Values` e a renderização do JavaScript. |

O servidor local usa as permissões do modelo. Metadados e resultados de consulta podem entrar no contexto do cliente e do provedor de IA configurado. Trabalhe com dados simulados ou aprovados, e mantenha credenciais e configurações privadas fora do Git. [Privacidade no MCP da Microsoft](https://github.com/microsoft/powerbi-modeling-mcp#data-privacy-and-llm-providers)
