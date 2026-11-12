% SISTEMA ESPECIALISTA: Gerador de Plano de Aula e Auditoria para Unreal Engine
% ALUNOS: Eduardo Nogueira Korte, Matheus Seghatti de Moraes, Thiago Oliveira Dupim, Vitor Krieser
% Representacao: Regras de Producao | Inferencia: Backward Chaining | Dedutivo


% determina que fato é dinamico e tem dois argumentos
:- dynamic fato/2.

iniciar :-
    % garante que o predicado inicie vazio
    retractall(fato(_, _)),

    writeln('=========================================================================='),
    writeln('   SISTEMA ESPECIALISTA AVANCADO - UNREAL AUTHORIZED INSTRUCTOR (UAI)     '),
    writeln('=========================================================================='),
    writeln('Responda as perguntas abaixo digitando apenas o NUMERO da opcao desejada.'),
    nl,
    coletar_dados,
    gerar_plano_completo.


% COLETANDO DADOS ATRAVÉS DE UM QUESTIONARIO INTERATIVO
coletar_dados :-
    % tema da aula
    writeln('--- [ETAPA 1: ESCOPO PEDAGOGICO E LEARNING OUTCOMES] ---'),
    writeln('1. Qual e o tema principal da sua aula na Unreal Engine?'),
    writeln('   1 - Blueprints e Logica de Gameplay'),
    writeln('   2 - Iluminacao (Lumen, Sky Light, Directional Light, Ray Tracing)'),
    writeln('   3 - Ambientes e Paisagens (Landscape, Foliage, Megascans)'),
    writeln('   4 - Cinematografia (Cine Camera Actor, Sequencer)'),
    writeln('   5 - Materiais, Texturas (Power of 2) e Fotogrametria'),
    perguntar(tema, 'Escolha (1 a 5): '),

    % tipo de verbo pensado pelo instrutor
    writeln('\n2. Como voce estruturou o verbo do seu Learning Outcome (Objetivo de Aprendizagem)?'),
    writeln('   1 - Usei verbos subjetivos/amplos (ex: "Entender...", "Aprender...", "Usar Blueprints")'),
    writeln('   2 - Combinei dois verbos na mesma frase (ex: "Explicar e aplicar...", "Entender e criar...")'),
    writeln('   3 - Usei um unico verbo cognitivo/teorico (ex: "Definir...", "Explicar...", "Comparar...")'),
    writeln('   4 - Usei um unico verbo pratico/construtivo (ex: "Criar...", "Montar...", "Aplicar...")'),
    perguntar(verbo_status, 'Escolha (1 a 4): '),

    % intencao pedagogica
    writeln('\n3. O que voce espera que o aluno faca ao assistir sua aula?'),
    writeln('   1 - Compreenda um conceito teorico, definicao ou comparativo rapido (sem abrir a engine)'),
    writeln('   2 - Veja os bastidores de como eu resolvi um problema complexo (foco em workflow/inspiracao)'),
    writeln('   3 - Siga cada clique na tela para construir o mesmo resultado do zero por conta propria'),
    perguntar(intencao_aluno, 'Escolha (1 a 3): '),

    %  estrategia de sequencia de gravacao
    writeln('\n--- [ETAPA 2: ROTEIRIZACAO E DIDATICA DE GRAVACAO] ---'),
    writeln('4. Em qual ordem voce pretende gravar os arquivos do video?'),
    writeln('   1 - Gravar a introducao e o contexto teorico primeiro, e depois gravar a pratica'),
    writeln('   2 - Gravar a pratica/demonstracao na Unreal primeiro, e gravar a introducao/conclusao por ultimo'),
    writeln('   3 - Gravar tudo em um unico take continuo (sem dividir em segmentos curtos)'),
    perguntar(ordem_gravacao, 'Escolha (1 a 3): '),

    % abordagem de erros e duvidas
    writeln('\n5. Como voce planeja lidar com erros ou passos dificeis durante a gravacao?'),
    writeln('   1 - Editar e cortar qualquer erro para parecer que fiz tudo perfeito de primeira'),
    writeln('   2 - Incluir/cometer um erro comum de proposito para ensinar o aluno a fazer troubleshooting'),
    writeln('   3 - Pular etapas basicas/repetitivas no video para economizar tempo'),
    perguntar(abordagem_erros, 'Escolha (1 a 3): '),

    % densidade dos slides
    writeln('\n--- [ETAPA 3: DESIGN DE SLIDES E APOIO VISUAL] ---'),
    writeln('6. Como estao formatados os textos nos seus slides de apoio?'),
    writeln('   1 - Nao utilizarei slides em nenhum momento (100% tela da Unreal Engine)'),
    writeln('   2 - Frases completas, explicacoes detalhadas e listas longas de numeros'),
    writeln('   3 - Topicos curtos (bullets concisos), palavras-chave e destaque nos key takeaways'),
    perguntar(texto_slides, 'Escolha (1 a 3): '),

    % visual dos slides
    writeln('\n7. Como esta o layout visual e grafico dos seus slides?'),
    writeln('   1 - Varios prints/imagens na mesma tela, fontes variadas ou efeitos visuais chamativos'),
    writeln('   2 - Padrao consistente de fontes/cores e apenas 1 visual representativo por slide'),
    writeln('   3 - Nao se aplica (sem slides) ou apenas texto em fundo solido'),
    perguntar(visual_slides, 'Escolha (1 a 3): '),

    % camera e presenca
    writeln('\n--- [ETAPA 4: HARDWARE, CENARIO E ILUMINACAO] ---'),
    writeln('8. Qual equipamento de camera voce vai utilizar?'),
    writeln('   1 - Nao vou aparecer (100% Voiceover / Narracao em off)'),
    writeln('   2 - Webcam embutida do próprio notebook'),
    writeln('   3 - Camera externa (USB/DSLR) posicionada na altura dos olhos'),
    perguntar(camera_tipo, 'Escolha (1 a 3): '),

    % cenario e iluminacao
    writeln('\n9. Como e o seu ambiente fisico de gravacao (fundo e luz)?'),
    writeln('   1 - Luz natural da janela e fundo movimentado (estante cheia, objetos, logos/marcas)'),
    writeln('   2 - Luz artificial controlada (Ring Light/Softbox), mas fundo com muitos objetos/livros'),
    writeln('   3 - Luz artificial controlada (sem sombras/reflexos) e fundo limpo/profissional'),
    perguntar(ambiente_luz, 'Escolha (1 a 3): '),

    % microfone
    writeln('\n10. Qual dispositivo de captura de audio voce vai utilizar?'),
    writeln('   1 - Microfone interno do notebook ou da webcam'),
    writeln('   2 - Fone de ouvido comum (TWS/Bluetooth ou fone simples de celular)'),
    writeln('   3 - Headset com microfone extensivel proximo a boca'),
    writeln('   4 - Microfone externo dedicado para voz (padrao cardioide em braco articulado/pedestal)'),
    perguntar(microfone_tipo, 'Escolha (1 a 4): '),

    % sistema operacional
    writeln('\n--- [ETAPA 5: SISTEMA OPERACIONAL E POS-PRODUCAO] ---'),
    writeln('11. Qual Sistema Operacional voce utiliza na maquina de gravacao?'),
    writeln('   1 - Windows 10'),
    writeln('   2 - Windows 11'),
    writeln('   3 - macOS (Mac)'),
    perguntar(sistema_op, 'Escolha (1 a 3): '),

    % preferencia de software de edicao
    writeln('\n12. Qual e a sua prioridade para o software de edicao de video?'),
    writeln('   1 - Gratuito, nativo e ultra simples (cortes basicos em videos de ate 30 min)'),
    writeln('   2 - Gratuito, mas profissional (exportacao ate 4K, correcao de cor, audio e Cut Page rapida)'),
    writeln('   3 - Pago/Licenca focada em educacao (gravar tela+camera juntos e arrastar efeitos facilmente)'),
    writeln('   4 - Assinatura profissional com IA (editar video cortando texto transcrito e limpar voz via IA)'),
    perguntar(perfil_edicao, 'Escolha (1 a 4): ').

perguntar(Atributo, Prompt) :-
    writeln(Prompt),
    read(Valor),
    assertz(fato(Atributo, Valor)).

% BASE DE CONHECIMENTO

% regras de classificacao do formato de aula
definir_formato('EXPLAINER (Video Explicativo Conceitual)',
                'Curta (5 a 8 minutos no total)',
                'Foco em conhecimento adquirido (definir termos com fontes e evitar scope creep).') :-
    fato(intencao_aluno, 1), !.

definir_formato('DEMO (Demonstracao de Workflow e Ferramentas)',
                'Media (10 a 15 minutos no total)',
                'Foco em mostrar como voce pensou e resolveu um problema (nao exige replica passo a passo).') :-
    fato(intencao_aluno, 2), !.

definir_formato('TUTORIAL (Pratica Passo a Passo Replicavel)',
                'Longa, mas dividida em partes menores (15 a 25 minutos)',
                'Foco em habilitar o aluno a reproduzir o processo sozinho sem pular etapas.') :-
    fato(intencao_aluno, _).

% regras de auditoria do learning outcome (resultado de aprendizagem)
auditar_verbo('REPROVADO (Verbo Vago/Escopo Gigante): O termo "Entender" ou escopos amplos nao podem ser medidos em um teste pratico. Troque por um verbo mensuravel.') :-
    fato(verbo_status, 1), !.
auditar_verbo('REPROVADO (Objetivo Duplo): Voce misturou dois verbos na mesma frase. Separe em 2 Learning Outcomes distintos (um conceitual e outro pratico).') :-
    fato(verbo_status, 2), !.
auditar_verbo('ALERTA DE INCONSISTENCIA: Voce escolheu um verbo puramente teorico (Definir/Explicar), mas quer fazer um Tutorial Pratico. Mude o verbo para Criar, Montar ou Aplicar.') :-
    fato(verbo_status, 3), fato(intencao_aluno, 3), !.
auditar_verbo('ALERTA DE INCONSISTENCIA: Voce escolheu um verbo pratico (Criar/Montar), mas sua aula e apenas um Explainer teorico. Mude o verbo para Definir, Explicar ou Comparar.') :-
    fato(verbo_status, 4), fato(intencao_aluno, 1), !.
auditar_verbo('APROVADO: O verbo escolhido e unico, mensuravel e esta perfeitamente alinhado com o formato da aula.').

% gerador de exemplo de learning outcome oficial por tema ---
sugerir_outcome('Teorico: "Explicar o fluxo de execucao de Eventos em Blueprints" | Pratico: "Criar a resposta de um personagem a um estimulo usando Blueprints".') :-
    fato(tema, 1), !.
sugerir_outcome('Teorico: "Definir Lumen na Unreal Engine" ou "Comparar os usos de Sky Lights e Directional Lights" | Pratico: "Aplicar ray tracing em uma cena especifica".') :-
    fato(tema, 2), !.
sugerir_outcome('Teorico: "Explicar os usos do Quixel Megascans" | Pratico: "Montar uma paisagem de floresta (forest landscape) na Unreal Engine".') :-
    fato(tema, 3), !.
sugerir_outcome('Teorico: "Explicar como usar um Cine Camera Actor para capturar uma cena" | Pratico: "Criar uma gravacao cinematica usando um Cine Camera Actor".') :-
    fato(tema, 4), !.
sugerir_outcome('Teorico: "Explicar por que dimensoes de textura em potencia de 2 (Power of 2) afetam o streaming de memoria" | Pratico: "Importar e configurar um modelo escaneado via fotogrametria na Unreal Engine".') :-
    fato(tema, _).

% Gerador da tabela de planejamento de 5 Colunas (padrao Unreal Academy)
gerar_tabela_segmentos([
    'SEG 1: Introducao         | On Camera      | Slides (Agenda + Learning Outcomes) | Apresentar credenciais e declarar meta da aula | 2 min',
    'SEG 2: Definicao de Termos| Voiceover      | Slides concisos + Fontes tecnicas   | Definir conceitos-chave sem fugir do escopo    | 3 min',
    'SEG 3: Analise Visual     | Voiceover      | Diagramas/Tabelas divididos em partes| Explicar arquitetura visual parte por parte    | 3 min',
    'SEG 4: Conclusao          | On Camera      | Slide de Resumo (Key Takeaways)     | Revisar o conceito aprendido e encerrar        | 1 min'
]) :- fato(intencao_aluno, 1), !.

gerar_tabela_segmentos([
    'SEG 1: Intro + Resultado  | On Camera/Tela | Video do projeto final rodando na UE| Mostrar resultado pronto para engajar o aluno  | 2 min',
    'SEG 2: Contexto do Projeto| Voiceover      | Slides rapidos de contexto          | Explicar qual problema precisava ser resolvido | 2 min',
    'SEG 3: Bastidores/Workflow| Ambos (Cam+UE) | Captura da Unreal (Janela reduzida) | Mostrar ferramentas usadas e o porque de cada  | 8 min',
    'SEG 4: Conclusao          | On Camera      | Captura final + Slide de Takeaways  | Repetir aprendizados-chave e incentivar testes | 2 min'
]) :- fato(intencao_aluno, 2), !.

gerar_tabela_segmentos([
    'SEG 1: Intro + Resultado  | On Camera/Tela | Preview do resultado final na Unreal| Mostrar onde o aluno vai chegar (sem detalhes) | 2 min',
    'SEG 2: Avisos e Obstaculos| Voiceover      | Slide de pontos criticos/armadilhas | Antecipar duvidas e evitar frustracao do aluno | 2 min',
    'SEG 3: Pratica Parte 1    | Voiceover + UE | Captura da Unreal (Ritmo lento)     | Executar etapa inicial explicando o que e por que| 7 min',
    'SEG 4: Pausa Conceitual   | Voiceover      | Slide explicativo fora da captura   | Destacar conceito vital fora do passo a passo  | 2 min',
    'SEG 5: Pratica Parte 2    | Voiceover + UE | Captura da Unreal + Troubleshooting | Finalizar construcao sem pular nenhuma etapa   | 8 min',
    'SEG 6: Conclusao          | On Camera      | Resultado final + Slide de Revisao  | Revisar etapas vencidas e convidar a praticar  | 2 min'
]) :- fato(intencao_aluno, _).

% regras de estrategia de gravacao e didatica
avaliar_sequencia_gravacao('OTIMA ESCOLHA (Contexto -> Pratica): Gravar o contexto primeiro ajuda a lembrar de integrar essa informacao durante o resto do video.') :-
    fato(ordem_gravacao, 1), !.
avaliar_sequencia_gravacao('OTIMA ESCOLHA (Pratica -> Contexto): Gravar a pratica primeiro ajuda a descobrir os principais takeaways para citar depois na introducao e conclusao.') :-
    fato(ordem_gravacao, 2), !.
avaliar_sequencia_gravacao('ALERTA DE RISCO (Take Unico): Gravar tudo em um take longo aumenta a chance de erro no final obrigar voce a regravar tudo do zero. Divida em segmentos curtos com checkpoints no projeto!') :-
    fato(ordem_gravacao, _).

avaliar_didatica_erros('RECOMENDACAO UAI: Nao tenha medo de errar! A Epic Games recomenda manter ou simular um erro de proposito para o aluno aprender vendo voce fazer troubleshooting.') :-
    fato(abordagem_erros, 1), !.
avaliar_didatica_erros('EXCELENTE (Troubleshooting Ativo): Mostrar a correcao de um erro quebra a barreira entre instrutor e aluno e ensina resolucao real de problemas.') :-
    fato(abordagem_erros, 2), !.
avaliar_didatica_erros('ERRO GRAVE DE DIDATICA: NUNCA pule etapas em um video de ensino! O aluno nao sabera por que voce pulou aquilo, gerando frustracao e abandono da aula.') :-
    fato(abordagem_erros, _).

% Regras de Auditoria de Slides
avaliar_slides('ALERTA DE PAUSA VISUAL: Em tutoriais longos, considere adicionar slides pontuais fora da captura de tela para sinalizar quando um ponto conceitual importante nao faz parte do clique a clique.') :-
    fato(texto_slides, 1), fato(intencao_aluno, 3), !.
avaliar_slides('Sem uso de slides: Certifique-se de usar zoom e destaques visuais (caixas e setas) na edicao.') :-
    fato(texto_slides, 1), !.
avaliar_slides('REPROVADO (Text-Heavy + Visual Poluido): Seus slides tem frases completas (que duplicam sua fala) e visuais baguncados. Reduza para bullets curtos, padronize fontes e deixe apenas 1 imagem por slide.') :-
    fato(texto_slides, 2), fato(visual_slides, 1), !.
avaliar_slides('ALERTA (Text-Heavy Formatting): Remova frases completas e excesso de numeros da tela! Use topicos curtos para sobrar espaco para voce elaborar falando.') :-
    fato(texto_slides, 2), !.
avaliar_slides('ALERTA (Inconsistent Graphics): Seus textos sao curtos, mas o visual esta confuso. Remova efeitos de imagem distrativos, padronize fontes/cores e use apenas 1 visual representativo.') :-
    fato(visual_slides, 1), !.
avaliar_slides('APROVADO (Concise & Consistent Formatting): Slides diretos ao ponto, relevantes, com destaque para key takeaways e 1 visual representativo.').

% equipamento (camera, luz, cenario e audio)
avaliar_camera_luz('MODO VOICEOVER: Como voce nao aparecera na camera, compense variando o ritmo e tom da voz (baixe o volume para criar atencao, acelere para mostrar empolgacao, fale devagar em pontos vitais).') :-
    fato(camera_tipo, 1), !.
avaliar_camera_luz('ALERTA DE CAMERA E LUZ: Webcam de notebook tem angulo ruim (eleve a tela!) e luz natural muda durante a gravacao. Feche a cortina, use luz frontal constante e aplique blur (desfoque) no fundo ocupado, removendo marcas/logos.') :-
    fato(camera_tipo, 2), fato(ambiente_luz, 1), !.
avaliar_camera_luz('AJUSTE DE CENARIO: Sua luz é controlada, mas o fundo distraira o aluno (especialmente estantes de livros). Aplique desfoque parcial (blur) no fundo, remova logos e cole um post-it ao lado da lente para manter contato visual (Regra 1:1).') :-
    fato(ambiente_luz, 2), !.
avaliar_camera_luz('ALERTA DE ILUMINACAO E FUNDO: Evite luz variavel e fundos com marcas/objetos distrativos. Use luminaria direcionavel ou Ring Light sem causar reflexos no fundo e aplique desfoque.') :-
    fato(ambiente_luz, 1), !.
avaliar_camera_luz('SETUP DE VIDEO APROVADO: Camera bem posicionada, luz consistente sem sombras e cenario profissional. Lembre-se da Regra 1:1 (olhar para a lente como se o aluno estivesse do outro lado da mesa).').

avaliar_audio('CRITICO (Audio de Baixa Qualidade): Microfones internos de notebook/webcam sao feitos para chamadas, nao para aulas. Eles captam eco e cliques do mouse/teclado. Faça um teste rigoroso ou troque por headset/mic externo.') :-
    fato(microfone_tipo, 1), !.
avaliar_audio('ALERTA (Fone Comum): Fones Bluetooth/celulares comprimem a voz. Faca uma gravacao de teste de 1 minuto antes de comecar e tome muito cuidado com o barulho de cliques do mouse e teclado.') :-
    fato(microfone_tipo, 2), !.
avaliar_audio('BOM (Headset Extensivel): Posicione a haste perto da boca (mas fora do sopro da respiracao) para isolar ruidos externos.') :-
    fato(microfone_tipo, 3), !.
avaliar_audio('EXCELENTE (Microfone Externo Cardioide): Foco total na voz! Ajuste a distancia no braco/pedestal e regule o ganho (gain) antes de gravar para nao estourar o audio (clipping).').

% regras combinadas de software (SO + perfil de edicao)
recomendar_stack_software('CAPTURA: Xbox Game Bar (Win+Alt+R - grava 1 janela por vez) + Camera App | EDICAO: Clipchamp (nativo, gratuito para videos de ate 30 min).') :-
    fato(sistema_op, 1), fato(perfil_edicao, 1), !.
recomendar_stack_software('CAPTURA: Snipping Tool (Win+Shift+S - grava janela ou area da tela) + Camera App | EDICAO: Clipchamp (nativo do Windows 11).') :-
    fato(sistema_op, 2), fato(perfil_edicao, 1), !.
recomendar_stack_software('CAPTURA: QuickTime Player ou Screenshot Toolbar (Shift+Cmd+5) | EDICAO: iMovie (gratuito nativo do macOS, integra com iPhone/iPad).') :-
    fato(sistema_op, 3), fato(perfil_edicao, 1), !.
recomendar_stack_software('CAPTURA: Ferramenta nativa do SO ou OBS | EDICAO: DaVinci Resolve (Gratuito ate 4K, use a aba "Cut Page" para prazos curtos e ferramentas profissionais de cor e audio).') :-
    fato(perfil_edicao, 2), !.
recomendar_stack_software('CAPTURA + EDICAO INTEGRADA: Camtasia (Grava tela e camera simultaneamente, edicao drag-and-drop rapida, efeitos visuais e limpeza de audio).') :-
    fato(perfil_edicao, 3), !.
recomendar_stack_software('EDICAO AVANCADA COM IA: Adobe Premiere Pro (Permite editar o video cortando e colando o texto da transcricao automatica e possui recurso de IA para clareza da fala).') :-
    fato(perfil_edicao, _).


% EXIBICAO DO PLANO DE AULA E RELATORIO TECNICO DO ESPECIALISTA
gerar_plano_completo :-
    nl,
    writeln('=========================================================================='),
    writeln('        PLANO DE AULA E AUDITORIA TECNICA - UNREAL ACADEMY (UAI)          '),
    writeln('=========================================================================='),

    % Secao 1: Learning Outcome e Formato
    definir_formato(Formato, Duracao, DescFormato),
    auditar_verbo(StatusVerbo),
    sugerir_outcome(ExemploOutcome),
    writeln('\n[1. DEFINICAO ESTRATEGICA E LEARNING OUTCOME]'),
    format(' * Formato da Aula: ~w~n', [Formato]),
    format(' * Duracao Recomendada: ~w~n', [Duracao]),
    format(' * Diretriz do Formato: ~w~n', [DescFormato]),
    format(' * Auditoria do seu Objetivo: ~w~n', [StatusVerbo]),
    format(' * Sugestao de Learning Outcome Oficial para seu Tema:~n   -> ~w~n', [ExemploOutcome]),

    % Secao 2: Tabela de Planejamento de 5 Colunas
    gerar_tabela_segmentos(LinhasTabela),
    writeln('\n[2. TABELA DE PLANEJAMENTO DE CONTEUDO (PADRAO 5 COLUNAS EPIC GAMES)]'),
    writeln('   SEGMENTO                | CAM/VOICEOVER  | VISUAIS NECESSARIOS                 | METAS / PONTOS PRINCIPAIS                      | DURACAO'),
    writeln('   -------------------------------------------------------------------------------------------------------------------------------------------'),
    listar_linhas(LinhasTabela),

    % Secao 3: Roteiro, Gravacao e Slides
    avaliar_sequencia_gravacao(AvalSeq),
    avaliar_didatica_erros(AvalErros),
    avaliar_slides(AvalSlides),
    writeln('\n[3. DIAGNOSTICO DE ROTEIRO, DIDATICA E SLIDES]'),
    format(' * Estrategia de Gravacao: ~w~n', [AvalSeq]),
    format(' * Abordagem de Erros/Passos: ~w~n', [AvalErros]),
    format(' * Auditoria de Slides: ~w~n', [AvalSlides]),
    writeln(' * Tecnica de Enfase Verbal: Use palavras-gatilho ("Importante", "Ponto-chave", "Vital") antes de mostrar uma diferenca na tela.'),

    % Secao 4: Equipamento e Software
    avaliar_camera_luz(AvalCam),
    avaliar_audio(AvalAud),
    recomendar_stack_software(StackSoft),
    writeln('\n[4. PRESCRICAO DE EQUIPAMENTO, AMBIENTE E SOFTWARE]'),
    format(' * Camera, Luz e Cenario: ~w~n', [AvalCam]),
    format(' * Captura de Audio: ~w~n', [AvalAud]),
    format(' * Stack de Gravacao e Edicao: ~w~n', [StackSoft]),

    % Secao 5: Checklist Operacional UAI
    writeln('\n[5. CHECKLIST OPERACIONAL OBRIGATORIO (PRE, DURANTE E POS-GRAVACAO)]'),
    writeln(' * [PRE] Diminuir o tamanho da janela da Unreal Engine para que os menus/textos fiquem legiveis no video.'),
    writeln(' * [PRE] Fechar programas pesados em 2o plano e desativar notificacoes pop-up.'),
    writeln(' * [PRE] Colocar os slides em Tela Cheia (Modo Apresentador) e checar todas as inputs no gravador.'),
    writeln(' * [DURANTE] Falar mais devagar que o normal e adicionar 0.5 segundo extra de pausa entre os segmentos.'),
    writeln(' * [DURANTE] Se errar (retake), ficar em silencio por alguns segundos antes de repetir a fala (facilita achar o corte na edicao) e voltar o projeto da Unreal ao checkpoint anterior.'),
    writeln(' * [DURANTE] Se lembrar de algo para a edicao (ex: "dar zoom aqui"), fale em voz alta para a camera e anote num arquivo paralelo.'),
    writeln(' * [POS] Assistir pelo menos 1 minuto do video gravado para checar audio e legibilidade da UI da Unreal.'),
    writeln(' * [POS] Exportar na qualidade maxima e nomear com Data_Modulo_Assunto (Ex: Nov15_M1_Blueprints).'),
    writeln('==========================================================================').

listar_linhas([]).
listar_linhas([H|T]) :-
    format('   ~w~n', [H]),
    listar_linhas(T).
    

% ESTRUTURA DO QUESTIONÁRIO
% etapa(Id, Nome).
    etapa(1, 'Escopo pedagogico e Learning Outcomes').
    etapa(2, 'Roteirizacao e didatica de gravacao').
    etapa(3, 'Design de slides e apoio visual').
    etapa(4, 'Hardware, cenario e iluminacao').
    etapa(5, 'Sistema operacional e pos-producao').

    % pergunta(Id, Etapa, Texto).
    pergunta(1, 1, 'Qual e o tema principal da sua aula na Unreal Engine?').
    pergunta(2, 1, 'Como voce estruturou o verbo do seu Learning Outcome?').
    pergunta(3, 1, 'O que voce espera que o aluno faca ao assistir sua aula?').
    pergunta(4, 2, 'Em qual ordem voce pretende gravar os arquivos do video?').
    pergunta(5, 2, 'Como voce planeja lidar com erros ou passos dificeis?').
    pergunta(6, 3, 'Como estao formatados os textos nos seus slides?').
    pergunta(7, 3, 'Como esta o layout visual e grafico dos seus slides?').
    pergunta(8, 4, 'Qual equipamento de camera voce vai utilizar?').
    pergunta(9, 4, 'Como e o seu ambiente fisico de gravacao?').
    pergunta(10, 4, 'Qual dispositivo de captura de audio voce vai utilizar?').
    pergunta(11, 5, 'Qual sistema operacional voce utiliza?').
    pergunta(12, 5, 'Qual e a sua prioridade para o software de edicao?').



    % opcao(IdPergunta, Valor, Descricao).

    opcao(1, 1, 'Blueprints e Logica de Gameplay').
    opcao(1, 2, 'Iluminacao (Lumen, Sky Light, Directional Light, Ray Tracing)').
    opcao(1, 3, 'Ambientes e Paisagens (Landscape, Foliage, Megascans)').
    opcao(1, 4, 'Cinematografia (Cine Camera Actor, Sequencer)').
    opcao(1, 5, 'Materiais, Texturas (Power of 2) e Fotogrametria').

    opcao(2, 1, 'Usei verbos subjetivos/amplos').
    opcao(2, 2, 'Combinei dois verbos na mesma frase').
    opcao(2, 3, 'Usei um unico verbo cognitivo/teorico').
    opcao(2, 4, 'Usei um unico verbo pratico/construtivo').

    opcao(3, 1, 'Compreenda um conceito teorico').
    opcao(3, 2, 'Veja os bastidores de como resolvi um problema complexo').
    opcao(3, 3, 'Siga cada clique para construir o resultado do zero').

    opcao(4, 1, 'Gravar introducao e teoria primeiro').
    opcao(4, 2, 'Gravar pratica primeiro e introducao por ultimo').
    opcao(4, 3, 'Gravar tudo em um unico take').

    opcao(5, 1, 'Editar e cortar qualquer erro').
    opcao(5, 2, 'Incluir um erro comum para ensinar troubleshooting').
    opcao(5, 3, 'Pular etapas basicas para economizar tempo').

    opcao(6, 1, 'Nao utilizarei slides').
    opcao(6, 2, 'Frases completas e explicacoes detalhadas').
    opcao(6, 3, 'Topicos curtos, palavras-chave e key takeaways').

    opcao(7, 1, 'Varios prints, fontes variadas e efeitos chamativos').
    opcao(7, 2, 'Padrao consistente e um visual por slide').
    opcao(7, 3, 'Sem slides ou apenas texto em fundo solido').

    opcao(8, 1, 'Voiceover / Narracao em off').
    opcao(8, 2, 'Webcam embutida do notebook').
    opcao(8, 3, 'Camera externa USB/DSLR').

    opcao(9, 1, 'Luz natural e fundo movimentado').
    opcao(9, 2, 'Luz artificial controlada e fundo com objetos').
    opcao(9, 3, 'Luz artificial controlada e fundo profissional').

    opcao(10, 1, 'Microfone interno do notebook ou webcam').
    opcao(10, 2, 'Fone de ouvido comum').
    opcao(10, 3, 'Headset com microfone extensivel').
    opcao(10, 4, 'Microfone externo dedicado').

    opcao(11, 1, 'Windows 10').
    opcao(11, 2, 'Windows 11').
    opcao(11, 3, 'macOS').

    opcao(12, 1, 'Gratuito, nativo e simples').
    opcao(12, 2, 'Gratuito, mas profissional').
    opcao(12, 3, 'Pago, focado em educacao').
    opcao(12, 4, 'Assinatura profissional com IA').

:- dynamic resposta/2.
    registrar_resposta(Id, Valor) :-
        retractall(resposta(Id, _)),
        assertz(resposta(Id, Valor)).