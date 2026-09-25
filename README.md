# Template de tese de doutoramento — ICS-ULisboa

Template LaTeX para teses de doutoramento em Ciência Política,
especialidade em Política Comparada, do Instituto de Ciências Sociais da
Universidade de Lisboa.

> **Este template não é oficial**, mas pode ser útil a doutorandos em
> Política Comparada. Implementa as regras de estilo publicadas em
> <https://www.ics.ulisboa.pt/trabalho-final>, embora a responsabilidade
> pela conformidade do documento entregue seja de quem o entrega. Em caso
> de divergência entre este template e o regulamento, é o regulamento que
> vale. Verifique a versão em vigor das regras: foram atualizadas pela
> última vez em **setembro de 2026**.

---

## Começar

### No Overleaf

1. Descarregue este repositório como ZIP e faça *New Project → Upload
   Project* no Overleaf.
2. Carregue em *Recompile*. O template precisa de XeLaTeX, por causa das
   fontes, mas não é preciso mudar nada: o Overleaf abre os projetos com
   pdfLaTeX e o `latexmkrc` incluído chama o XeLaTeX no lugar dele. Se
   apagar o `latexmkrc`, mude o compilador à mão em *Menu → Compiler →
   XeLaTeX*.
3. Edite `Variables/Variables.tex` e comece a escrever.

Para manter o Overleaf sincronizado com o GitHub, use *Menu → GitHub* no
projeto Overleaf e ligue-o ao seu *fork* deste repositório.

### Localmente

```bash
git clone https://github.com/hugoferrinholopes/ics-ulisboa-thesis.git
cd ics-ulisboa-thesis
latexmk -xelatex main.tex
```

O `latexmkrc` incluído já configura XeLaTeX e biber, também quando se
corre `latexmk -pdf`. Precisa de uma distribuição TeX completa (TeX Live
2023 ou posterior). Numa instalação mínima (BasicTeX, TinyTeX), instale
também os pacotes que a classe usa, entre os quais `biblatex-apa`,
`siunitx`, `pgfplots`, `tex-gyre`, `carlito` e `lato`.

---

## Opções da classe

Definem-se na primeira linha de `main.tex`:

```latex
\documentclass[en,articles,provisional,times,12pt]{icsthesis}
```

| Opção | Alternativas | O que faz |
|---|---|---|
| `en` | `pt` | Língua da tese. Traduz todas as rubricas automaticamente e, em `pt`, usa vírgula decimal nos quadros e gráficos. |
| `articles` | `monograph` | Formato. Nos dois casos, cada estudo é um capítulo numerado normal, como o regulamento prevê para teses por compilação de trabalhos (numeração árabe, estatuto de capítulo). `articles` apenas ativa `\studynote{}` e `\chapterabstract{}`, que imprimem à cabeça de um estudo a nota de coautoria e publicação e um resumo próprio; em `monograph` os dois comandos são ignorados, pelo que pode mudar de formato sem mexer no texto. |
| `provisional` | `final` | Fase de entrega. Com `provisional`, a folha de rosto imprime a marca de documento provisório. |
| `times` | `arial`, `calibri` | Tipo de letra do corpo. |
| `12pt` | `11pt` | Corpo de letra. Arial e Calibri são forçados a 11pt, porque é o único tamanho permitido para essas fontes. |
| — | `silentblanks` | Páginas em branco sem a nota *"esta página foi intencionalmente deixada em branco"*. |

### Fontes

As três fontes permitidas pelo ICS são proprietárias e podem não estar
instaladas (no Overleaf, por exemplo). O template deteta se estão e,
quando não estão, usa a substituta livre com as mesmas larguras de
caracteres. O aviso aparece no *log*, não no documento.

| Pedido | Substituta |
|---|---|
| Times New Roman | TeX Gyre Termes |
| Arial | TeX Gyre Heros |
| Calibri | Carlito |

A capa e a folha de rosto usam Lato, que vem com o TeX Live e o Overleaf.

---

## Estrutura

```
icsthesis.cls          a classe: toda a formatação vive aqui
main.tex               o documento: inclui os ficheiros e define a ordem
latexmkrc              configuração de compilação
LICENSE                texto integral da LPPL 1.3c
NOTICE                 direitos de autor, manutenção e nota de derivação
CHANGELOG.md           histórico de versões
Variables/
  Variables.tex        título, autor, orientação, grau, financiamento
Matter/
  00-Cover.tex             capa
  01-TitlePage.tex         folha de rosto (antes das provas)
  02-TitlePage-PostViva.tex folha de rosto definitiva, com o júri
  03-Dedication.tex        dedicatória (sem número de página)
  04-Acknowledgements.tex  agradecimentos
  05-Funding.tex           fontes de financiamento
  06-Abstract.tex          resumo na língua da tese (máx. 300 palavras)
  07-Resumo.tex            resumo em português (máx. 300 palavras)
  08-ResumoAlargado.tex    resumo alargado (1200–1500 palavras)
  09-Acronyms.tex          lista de siglas
Chapters/
  01-Introduction.tex
  02-Study-One.tex         estudo com nota de coautoria, resumo, nota de rodapé, equação
  03-Study-Two.tex         estudo com citação em bloco
  04-Conclusion.tex
  Appendix-A.tex           apêndice com quadro
  Appendix-B.tex           apêndice com listagem de código
Examples/
  00-How-To-Use.tex        manual (ver abaixo)
Bibliography/
  references.bib           obras reais como exemplo, mais marcadores para tese e dados
Figures/
  example-figure.pdf       figura neutra usada nos exemplos
  Theme/logo-ics.png       logótipo ULisboa + ICS da capa
  Theme/logo-ics-bw.png    versão a preto e branco (não usada por defeito)
```

O capítulo `Examples/00-How-To-Use.tex` é um manual que compila dentro do
próprio documento, antes da bibliografia. Mostra: quadros simples, com
`tabularx`, com notas e fonte, de regressão (colunas alinhadas pela
vírgula decimal, modelos agrupados, erros-padrão e estrelas), quadros
vindos de R ou Stata, quadros longos que passam de página e quadros em
página de paisagem; figuras a partir de PDF, com painéis e com nota de
fonte, e um gráfico de coeficientes desenhado em `pgfplots`; hipóteses
numeradas; equações de uma e de várias linhas; notas de rodapé com
citações; citações curtas e passagens noutra língua; os comandos de
citação e os tipos de entrada; remissões; listas; e código.

---

## O que a classe trata sozinha

Nada disto precisa de ser feito à mão:

- Margens de 2,5 cm nos quatro lados.
- Espaçamento de 1,5, texto justificado, sem espaçamento adicional entre
  parágrafos.
- Entrada de parágrafo de 0,7 cm, suprimida no primeiro parágrafo depois
  de cada título.
- Número de página no canto inferior exterior, a 1,25 cm do fim da página.
- Numeração romana minúscula até ao início do texto e árabe a partir daí.
- Todos os elementos pré-textuais, capítulos, bibliografia e apêndices a
  começar em página ímpar, com as páginas em branco geradas
  automaticamente. O contador de páginas acompanha sempre a página física:
  a capa é a página i, o verso fica em branco e a folha de rosto cai na
  página iii. Assim, a tese impressa em frente e verso tem cada capítulo
  numa página da direita e cada número no canto de fora.
- Dedicatória sem número de página.
- Legendas de quadros por cima e de figuras por baixo e centradas.
- Notas de rodapé um ponto abaixo do corpo, espaçamento 1, entrada de
  0,4 cm a partir da segunda linha, numeradas continuamente.
- Bibliografia APA com espaçamento 1 e entrada de 0,7 cm.
- Apêndices identificados por letras maiúsculas.
- Números nos quadros e gráficos na fonte do corpo e com o separador
  decimal da língua da tese.
- Aviso no *log* se o documento passar das 350 páginas.

Comandos que a classe acrescenta:

| Comando | Para quê |
|---|---|
| `\guidenote{...}` | Caixa com orientação de escrita. Apague-a quando escrever o texto. |
| `\studynote{...}` | Nota de coautoria e estado de publicação à cabeça de um estudo (só com `articles`). |
| `\chapterabstract{...}` | Resumo de um estudo (só com `articles`). |
| `\begin{hypotheses}` | Lista de hipóteses numeradas H1, H2…, referidas com `\cref`. |
| `\shorttitleheader{...}` | Cabeçalho corrido com o título abreviado. |

---

## O que tem de fazer

**Substituir os marcadores.** Todo o texto entre parênteses retos —
`[Title]`, `[Full name]`, `[Position, institution]` — é para substituir.
Comece por `Variables/Variables.tex`, depois percorra os ficheiros de
`Matter/`.

**Apagar as notas de orientação.** Cada secção do pré-textual traz uma
caixa `\guidenote{}` a explicar o que ali deve constar. Apague cada uma ao
escrever o texto que a substitui.

**Confirmar a capa contra o modelo oficial.** O ICS publica modelos em
`.docx` por curso e por fase, em
<https://www.ics.ulisboa.pt/trabalho-final>. Este template reproduz o
modelo de Política Comparada, mas os modelos são revistos periodicamente;
compare antes de entregar.

**Contar as palavras dos resumos.** Os limites — 300 palavras para cada
resumo, 1200 a 1500 para o resumo alargado — são verificados nos serviços
académicos. `texcount -sum ficheiro.tex` no terminal, ou o contador do
Overleaf.

**Apagar os exemplos.** Quando começar a escrever a sério, retire a linha
`\include{Examples/00-How-To-Use}` de `main.tex` e apague a pasta.

---

## Trocas frequentes

**APA para Chicago author-date.** Em `icsthesis.cls`, na secção
`BIBLIOGRAPHY`, comente todo o bloco APA (incluindo as duas linhas
`\DeclareLanguageMapping`) e descomente a linha do `biblatex-chicago`
logo abaixo. As duas normas são aceites pelo ICS; nenhuma outra é.

**Numeração de figuras e quadros.** Por defeito é contínua ao longo do
documento (Figura 1, Figura 2, …). Para numeração por capítulo
(Figura 2.1, 2.2, …), que muitas teses por compilação preferem, comente as
duas linhas `\counterwithout` na secção `CAPTIONS` da classe.

**Cabeçalho corrido com o título abreviado.** Permitido pelo ponto 2.6 do
regulamento, desligado por defeito. Descomente a linha
`\shorttitleheader{\shortname}` em `main.tex`.

**Folha de rosto definitiva.** Depois das provas, troque as duas linhas
`\include` na secção do pré-textual de `main.tex` e mude a opção da classe
de `provisional` para `final`.

**Tese em português.** Mude a opção para `pt` e comente a linha
`\include{Matter/08-ResumoAlargado}` em `main.tex`: o resumo alargado só é
obrigatório quando a tese é escrita noutra língua.

---

## Limitações

- O `sectsty`, de que a classe precisa, escreve dois avisos inofensivos no
  *log* (`Command \underline has changed`, `Command \underbar has
  changed`). Não afetam o documento.
- As equações usam a fonte matemática por omissão (Computer Modern), que
  não é Times. Para uma tese com muita matemática, pode carregar
  `unicode-math` com `TeX Gyre Termes Math`.
- Num quadro longo, não deixe espaço nem mudança de linha entre
  `\caption{...}`, `\label{...}` e `\\`: um espaço desloca a legenda para
  o lado (o exemplo mostra a forma certa).

---

## Licença e créditos

Distribuído sob a **LaTeX Project Public License, versão 1.3c** ou
posterior. O texto da licença está em `LICENSE`; os direitos de autor, o
estado de manutenção e a nota de derivação estão em `NOTICE`. Os
logótipos da ULisboa e do ICS em `Figures/Theme/` são marcas dos seus
titulares e não estão abrangidos pela licença.

Esta classe é um derivado substancialmente modificado do template
**IPLeiria Thesis** v2.1.0, de José António Portela Areia
(<https://github.com/joseareia/ipleiria-thesis>), também sob LPPL-1.3c.
Como a licença exige, o ficheiro de classe foi renomeado e a autoria
original é mantida no cabeçalho de `icsthesis.cls` e em `NOTICE`; os
exemplos de quadros adaptados do tutorial original estão assinalados no
cabeçalho de `Examples/00-How-To-Use.tex`. O autor original não é
responsável por este derivado nem o subscreve.

Se este template lhe for útil, um *issue* ou um *pull request* com
correções é bem-vindo — sobretudo se o regulamento do ICS mudar.