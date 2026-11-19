# Capa e acabamento do dashboard

[Voltar ao índice](../prompts-e-skills.md)

Prompt usado nesta etapa. O caminho local da skill foi substituído pela invocação por nome.

```text
Use $dataviz-html-dax para finalizar o dashboard logístico e criar sua página de capa.
Use a conexão MCP no Power BI aberto.

Trabalhe em duas medidas:
- HTML Dashboard Logistica;
- HTML Capa Logistica.

Antes de alterar qualquer medida:
- leia a versão atual;
- crie backup oculto com nome único;
- preserve JSON Gold, filtros, temas, cálculos, tooltips, tabela, ordenação e análises;
- não salve o PBIX.

Parte 1 — Acabamento da página de análise

1. Header logístico
- crie uma estrada tecnológica no header;
- inclua pequenos carros ou marcadores semelhantes a veículos em movimento;
- use somente CSS/HTML local;
- marque elementos decorativos como aria-hidden;
- use pointer-events: none;
- não permita que a estrada cubra título, fonte, filtros ou botões.

2. Ticker de produtos
- use os produtos e quantidades existentes na baseInterativa;
- mostre poucos produtos mais vendidos;
- numere o ranking;
- recalcule conforme filtros;
- use contraste forte nos modos Light e Dark;
- pause no hover e no foco;
- evite deslocamento do layout.

3. Movimento e interação
- anime a entrada das barras e linhas uma vez por renderização;
- permita leve expansão ou destaque no hover;
- use movimento discreto nos cards;
- traga variações % nos cards principais indicando com cores verde para crescimento e vermelha quando houver queda;
- faça apenas o mini-card de variação negativa ou alerta crítico pulsar de forma leve e finita;
- não faça o card inteiro piscar;
- não use setInterval para count-up;
- respeite prefers-reduced-motion;
- preserve os valores finais exatos do JSON.

4. Tooltips
- mantenha tooltip HTML própria;
- evite title redundante que acione tooltip nativa;
- esconda tooltip ao sair, perder foco ou usar teclado;
- limite seu posicionamento ao contêiner;
- não cubra eixos e rótulos.

Parte 2 — Construção da capa

Crie a medida:
HTML Capa Logistica

A capa deve usar [JSON Gold Dashboard Logistica] como única fonte de dados.

Estrutura:
- fundo Dark semelhante a uma central de controle moderna;
- identidade "Logística Brasil";
- frase principal de impacto sobre logística e tomada de decisão;
- efeito de digitação leve, executado uma vez por renderização;
- prévia executiva do OTIF global;
- anel de progresso do OTIF;
- percentual carregando de zero até o valor final;
- anel e número sincronizados;
- pequena tendência mensal do OTIF;
- variação contra o mês anterior;
- pedidos analisados;
- lead time médio;
- período disponível;
- fonte e atualização no horário Brasil/BR;
- estrada com carros em movimento;
- área reservada no canto inferior direito para um botão nativo do Power BI.

Regras da animação do OTIF:
- use requestAnimationFrame;
- não altere o cálculo do KPI;
- limite o resultado entre 0% e 100%;
- finalize com o número exato formatado em pt-BR;
- mostre o valor final imediatamente quando prefers-reduced-motion estiver ativo;
- não use loop infinito;
- documente que o Power BI pode repetir a entrada quando recriar o visual.

Use prefixos diferentes para evitar conflito:
- ld- para a página de análise;
- cp- para a capa.

Validação final:
- acentuação UTF-8;
- medidas em estado Ready;
- consultas DAX;
- JSON preservado;
- renderização Light e Dark;
- movimento desligado em reduced-motion;
- filtros atualizando ticker e análises;
- tabela mantendo ordenação;
- tooltip sem duplicidade;
- capa sem sobrepor o espaço do botão;
- teste em largura desktop e responsiva;
- estado vazio e erro;
- ausência de APIs, CDNs e dependências externas;
- comparação visual com a referência do projeto Teste Logística.

Se o MCP não puder criar a navegação nativa, deixe o espaço preparado e informe que o botão "Ir para Análise" deve ser inserido manualmente no Power BI.

Ao final, liste tudo que foi criado, alterado, preservado e validado.

Não salve nem sobrescreva o PBIX sem minha autorização.
```
