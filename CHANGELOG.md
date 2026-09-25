# Changelog

## v1.0 — 2026-09-25

Primeira versão pública.

- Classe `icsthesis.cls`, derivada do template IPLeiria Thesis v2.1.0 e reescrita para as regras de estilo do ICS-ULisboa.
- Opções de língua (`en`/`pt`), formato (`articles`/`monograph`), fase (`provisional`/`final`), tipo de letra (`times`/`arial`/`calibri`), corpo (`11pt`/`12pt`) e `silentblanks`.
- Deteção automática das fontes permitidas, com substitutas livres carregadas por nome de ficheiro (funcionam em qualquer TeX Live) e versaletes dos títulos sempre retiradas da família TeX Gyre.
- Paginação frente e verso verificada pela página física: a capa tem verso em branco, a folha de rosto e todos os elementos que abrem em página ímpar caem numa página da direita, e o número fica sempre no canto de fora. Todas as páginas em branco têm o mesmo aspeto.
- Margem de texto exatamente a 2,5 cm dos quatro lados e número de página a 1,25 cm do fim da folha, incluindo páginas com quadros longos.
- Capa, folha de rosto pré-provas e folha de rosto definitiva com júri, em Lato.
- Pré-textual completo, incluindo resumo alargado em português.
- Bibliografia APA com `biblatex` e `biber`; Chicago author-date (`biblatex-chicago`) incluída como alternativa comentada. URLs e DOIs partem em qualquer carácter.
- Números nos quadros (`siunitx`) e nos gráficos (`pgfplots`) na fonte do corpo e com o separador decimal da língua da tese.
- Lista `hypotheses` para hipóteses numeradas (H1, H2, …) referidas com `\cref`.
- Capítulo-manual, antes da bibliografia, com exemplos de quadros (simples, com notas e fonte, de regressão, longos, em paisagem), figuras (PDF, painéis, `pgfplots`), hipóteses, equações, notas de rodapé, citações, outras línguas, listas e código.
- Marcadores entre parênteses retos em vez de nomes fictícios, notas de orientação por secção e texto de preenchimento neutro (`blindtext`).
- Títulos de capítulo e de secção no desenho original do autor.
- Compila no Overleaf sem mudar o compilador: o `latexmkrc` chama o XeLaTeX mesmo com pdfLaTeX selecionado.
- Licença LPPL 1.3c: texto integral em `LICENSE` (reconhecido pelo GitHub), direitos de autor e nota de derivação em `NOTICE`.
