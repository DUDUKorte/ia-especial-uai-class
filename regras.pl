% Trabalho de Inteligencia Artificial - Implementacao de Sistema Especialista
% Dominio: Planejamento e auditoria de aulas para instrutores da Unreal Engine (UAI)
% Alunos: Eduardo Nogueira Korte, Matheus Seghatti de Moraes, Thiago Oliveira Dupim, Vitor Krieser

:- encoding(utf8).
:- dynamic fato/2.
:- dynamic resposta/2.

iniciar :-
    retractall(fato(_, _)),
    writeln('----------------------------------------------------------------------'),
    writeln(' Sistema Especialista - Planejamento de Aulas Unreal Engine (UAI)'),
    writeln('----------------------------------------------------------------------'),
    writeln('Informe o numero correspondente a cada opcao.'),
    nl,
    coletar_dados,
    gerar_plano_completo.


% --- Coleta de dados via terminal ---

coletar_dados :-
    writeln('--- [ETAPA 1: ESCOPO PEDAGOGICO E LEARNING OUTCOMES] ---'),
    writeln('1. Qual e o tema principal da sua aula na Unreal Engine?'),
    writeln('   1 - Blueprints e Logica de Gameplay'),
    writeln('   2 - Iluminacao (Lumen, Sky Light, Directional Light, Ray Tracing)'),
    writeln('   3 - Ambientes e Paisagens (Landscape, Foliage, Megascans)'),
    writeln('   4 - Cinematografia (Cine Camera Actor, Sequencer)'),
    writeln('   5 - Materiais, Texturas (Power of 2) e Fotogrametria'),
    perguntar(tema, 'Escolha (1 a 5): '),

    writeln('\n2. Como voce estruturou o verbo do seu Learning Outcome (Objetivo de Aprendizagem)?'),
    writeln('   1 - Usei verbos subjetivos/amplos (ex: "Entender...", "Aprender...", "Usar Blueprints")'),
    writeln('   2 - Combinei dois verbos na mesma frase (ex: "Explicar e aplicar...", "Entender e criar...")'),
    writeln('   3 - Usei um unico verbo cognitivo/teorico (ex: "Definir...", "Explicar...", "Comparar...")'),
    writeln('   4 - Usei um unico verbo pratico/construtivo (ex: "Criar...", "Montar...", "Aplicar...")'),
    perguntar(verbo_status, 'Escolha (1 a 4): '),

    writeln('\n3. O que voce espera que o aluno faca ao assistir sua aula?'),
    writeln('   1 - Compreenda um conceito teorico, definicao ou comparativo rapido (sem abrir a engine)'),
    writeln('   2 - Veja os bastidores de como resolvi um problema complexo (foco em workflow)'),
    writeln('   3 - Siga cada passo na tela para construir o mesmo resultado do zero'),
    perguntar(intencao_aluno, 'Escolha (1 a 3): '),

    writeln('\n--- [ETAPA 2: ROTEIRIZACAO E DIDATICA DE GRAVACAO] ---'),
    writeln('4. Em qual ordem voce pretende gravar os arquivos do video?'),
    writeln('   1 - Gravar a introducao e o contexto teorico primeiro, e depois gravar a pratica'),
    writeln('   2 - Gravar a pratica na Unreal primeiro, e gravar a introducao/conclusao por ultimo'),
    writeln('   3 - Gravar tudo em um unico take continuo (sem dividir em segmentos curtos)'),
    perguntar(ordem_gravacao, 'Escolha (1 a 3): '),

    writeln('\n5. Como voce planeja lidar com erros ou passos dificeis durante a gravacao?'),
    writeln('   1 - Editar e cortar qualquer erro da gravacao final'),
    writeln('   2 - Manter ou simular um erro comum para demonstrar o troubleshooting'),
    writeln('   3 - Pular etapas basicas/repetitivas no video para reduzir o tempo'),
    perguntar(abordagem_erros, 'Escolha (1 a 3): '),

    writeln('\n--- [ETAPA 3: DESIGN DE SLIDES E APOIO VISUAL] ---'),
    writeln('6. Como estao formatados os textos e conteudos nos seus slides de apoio?'),
    writeln('   1 - Nao utilizarei slides (apenas captura de tela da Unreal Engine)'),
    writeln('   2 - Frases completas, explicacoes detalhadas e listas longas de numeros'),
    writeln('   3 - Topicos curtos (bullets concisos), palavras-chave e destaque nos pontos principais'),
    writeln('   4 - Slides visuais com diagramas, fluxogramas ou tabelas comparativas'),
    perguntar(texto_slides, 'Escolha (1 a 4): '),

    writeln('\n7. Como esta o layout visual e grafico dos seus slides?'),
    writeln('   1 - Varios prints/imagens na mesma tela, fontes variadas ou efeitos visuais'),
    writeln('   2 - Padrao consistente de fontes/cores e apenas 1 visual representativo por slide'),
    writeln('   3 - Nao se aplica (sem slides) ou apenas texto em fundo solido'),
    perguntar(visual_slides, 'Escolha (1 a 3): '),

    writeln('\n--- [ETAPA 4: HARDWARE, CENARIO E ILUMINACAO] ---'),
    writeln('8. Qual configuracao de camera e microfone voce vai utilizar na gravacao?'),
    writeln('   1 - Sem camera (Apenas Microfone / Narracao em off)'),
    writeln('   2 - Camera embutida do notebook + Microfone'),
    writeln('   3 - Camera externa (USB/DSLR) na altura dos olhos + Microfone'),
    perguntar(camera_tipo, 'Escolha (1 a 3): '),

    writeln('\n9. Como e o seu ambiente fisico de gravacao (fundo e luz)?'),
    writeln('   1 - Luz natural da janela e fundo movimentado (estante cheia, logos/marcas)'),
    writeln('   2 - Luz artificial controlada (Ring Light/Softbox), mas fundo com muitos objetos/livros'),
    writeln('   3 - Luz artificial controlada e fundo com objetos simples/organizados'),
    writeln('   4 - Luz artificial controlada (sem sombras/reflexos) e fundo liso/uniforme'),
    perguntar(ambiente_luz, 'Escolha (1 a 4): '),

    writeln('\n10. Qual dispositivo de captura de audio voce vai utilizar?'),
    writeln('   1 - Microfone interno do notebook ou da webcam'),
    writeln('   2 - Fone de ouvido comum (Bluetooth ou fone simples de celular)'),
    writeln('   3 - Headset com microfone extensivel proximo a boca'),
    writeln('   4 - Microfone externo dedicado para voz (padrao cardioide em pedestal ou braco)'),
    perguntar(microfone_tipo, 'Escolha (1 a 4): '),

    writeln('\n--- [ETAPA 5: SISTEMA OPERACIONAL E POS-PRODUCAO] ---'),
    writeln('11. Qual Sistema Operacional voce utiliza na maquina de gravacao?'),
    writeln('   1 - Windows 10'),
    writeln('   2 - Windows 11'),
    writeln('   3 - macOS'),
    perguntar(sistema_op, 'Escolha (1 a 3): '),

    writeln('\n12. Qual e a sua prioridade para o software de edicao de video?'),
    writeln('   1 - Gratuito, nativo e simples (cortes basicos em videos de ate 30 min)'),
    writeln('   2 - Gratuito, mas completo (exportacao ate 4K, correcao de cor/audio e Cut Page)'),
    writeln('   3 - Licenca paga focada em videoaulas (gravar tela+camera juntos e edicao direta)'),
    writeln('   4 - Suite profissional com IA (edicao por transcricao de texto e limpeza de voz)'),
    perguntar(perfil_edicao, 'Escolha (1 a 4): ').

perguntar(Atributo, Prompt) :-
    writeln(Prompt),
    read(Valor),
    assertz(fato(Atributo, Valor)).


% --- Base de Conhecimento ---

% Classificacao do formato de aula
definir_formato('EXPLAINER (Video Explicativo Conceitual)',
                'Curta (5 a 8 minutos)',
                'Foco na transmissao de conceitos teoricos, definindo termos com fontes e mantendo o escopo restrito.') :-
    fato(intencao_aluno, 1), !.

definir_formato('DEMO (Demonstracao de Workflow e Ferramentas)',
                'Media (10 a 15 minutos)',
                'Foco em demonstrar o raciocinio e as ferramentas aplicadas na solucao de um problema, sem exigir replica passo a passo.') :-
    fato(intencao_aluno, 2), !.

definir_formato('TUTORIAL (Pratica Passo a Passo Replicavel)',
                'Longa, dividida em segmentos menores (15 a 25 minutos)',
                'Foco em orientar o aluno etapa por etapa para que ele reproduza o mesmo processo no proprio projeto.') :-
    fato(intencao_aluno, _).

% Auditoria do Learning Outcome (Verde: APROVADO | Amarelo: ALERTA | Vermelho: REPROVADO)
auditar_verbo('REPROVADO (Verbo Vago/Escopo Amplo): Termos como "Entender" nao permitem avaliacao direta. Substitua por um verbo de acao mensuravel.') :-
    fato(verbo_status, 1), !.
auditar_verbo('REPROVADO (Objetivo Duplo): Dois verbos na mesma frase misturam metas distintas. Divida em 2 Learning Outcomes separados (um teorico e um pratico).') :-
    fato(verbo_status, 2), !.
auditar_verbo('ALERTA DE INCONSISTENCIA: O verbo escolhido e teorico (Definir/Explicar), mas a aula e um Tutorial pratico. Altere o verbo para Criar, Montar ou Aplicar.') :-
    fato(verbo_status, 3), fato(intencao_aluno, 3), !.
auditar_verbo('ALERTA DE INCONSISTENCIA: O verbo escolhido e pratico (Criar/Montar), mas a aula e apenas um Explainer teorico. Altere o verbo para Definir, Explicar ou Comparar.') :-
    fato(verbo_status, 4), fato(intencao_aluno, 1), !.
auditar_verbo('APROVADO: O verbo escolhido e unico, mensuravel e coerente com o formato da aula.').

% Exemplos de Learning Outcome por tema
sugerir_outcome('Teorico: "Explicar o fluxo de execucao de Eventos em Blueprints" | Pratico: "Criar a resposta de um personagem a um estimulo usando Blueprints".') :-
    fato(tema, 1), !.
sugerir_outcome('Teorico: "Definir Lumen na Unreal Engine" ou "Comparar os usos de Sky Lights e Directional Lights" | Pratico: "Aplicar ray tracing em uma cena especifica".') :-
    fato(tema, 2), !.
sugerir_outcome('Teorico: "Explicar os usos do Quixel Megascans" | Pratico: "Montar uma paisagem de floresta utilizando a ferramenta de Landscape".') :-
    fato(tema, 3), !.
sugerir_outcome('Teorico: "Explicar como usar um Cine Camera Actor para capturar uma cena" | Pratico: "Criar uma gravacao cinematica usando um Cine Camera Actor".') :-
    fato(tema, 4), !.
sugerir_outcome('Teorico: "Explicar por que dimensoes de textura em potencia de 2 (Power of 2) afetam o streaming de memoria" | Pratico: "Importar e configurar um modelo escaneado via fotogrametria na Unreal Engine".') :-
    fato(tema, _).

% Tabela de planejamento de 5 colunas
gerar_tabela_segmentos([
    'SEG 1: Introducao         | Camera + Mic   | Slides (Agenda + Learning Outcomes) | Apresentar credenciais e declarar meta da aula | 2 min',
    'SEG 2: Definicao de Termos| Sem Camera     | Slides concisos + Fontes tecnicas   | Definir conceitos-chave sem fugir do escopo    | 3 min',
    'SEG 3: Analise Visual     | Sem Camera     | Diagramas/Tabelas divididos em partes| Explicar arquitetura visual parte por parte    | 3 min',
    'SEG 4: Conclusao          | Camera + Mic   | Slide de Resumo (Key Takeaways)     | Revisar o conceito aprendido e encerrar        | 1 min'
]) :- fato(intencao_aluno, 1), !.

gerar_tabela_segmentos([
    'SEG 1: Intro + Resultado  | Camera + Tela  | Video do projeto final rodando na UE| Mostrar resultado pronto para contextualizar   | 2 min',
    'SEG 2: Contexto do Projeto| Sem Camera     | Slides rapidos de contexto          | Explicar qual problema precisava ser resolvido | 2 min',
    'SEG 3: Bastidores/Workflow| Camera + Tela  | Captura da Unreal (Janela reduzida) | Mostrar ferramentas usadas e o motivo de cada  | 8 min',
    'SEG 4: Conclusao          | Camera + Mic   | Captura final + Slide de Takeaways  | Repetir aprendizados-chave e incentivar testes | 2 min'
]) :- fato(intencao_aluno, 2), !.

gerar_tabela_segmentos([
    'SEG 1: Intro + Resultado  | Camera + Tela  | Preview do resultado final na Unreal| Mostrar onde o aluno vai chegar (sem detalhes) | 2 min',
    'SEG 2: Avisos e Obstaculos| Sem Camera     | Slide de pontos criticos/armadilhas | Antecipar duvidas e evitar frustracao do aluno | 2 min',
    'SEG 3: Pratica Parte 1    | Sem Cam + Tela | Captura da Unreal (Ritmo lento)     | Executar etapa inicial explicando a logica     | 7 min',
    'SEG 4: Pausa Conceitual   | Sem Camera     | Slide explicativo fora da captura   | Destacar conceito importante fora da pratica   | 2 min',
    'SEG 5: Pratica Parte 2    | Sem Cam + Tela | Captura da Unreal + Troubleshooting | Finalizar construcao sem pular nenhuma etapa   | 8 min',
    'SEG 6: Conclusao          | Camera + Mic   | Resultado final + Slide de Revisao  | Revisar etapas concluidas e encerrar           | 2 min'
]) :- fato(intencao_aluno, _).

% Regras de sequencia de gravacao e didatica
avaliar_sequencia_gravacao('OTIMA ESCOLHA (Contexto -> Pratica): Gravar o contexto primeiro auxilia a manter essa informacao integrada durante o restante do video.') :-
    fato(ordem_gravacao, 1), !.
avaliar_sequencia_gravacao('OTIMA ESCOLHA (Pratica -> Contexto): Gravar a pratica primeiro facilita identificar os pontos principais para mencionar depois na introducao e na conclusao.') :-
    fato(ordem_gravacao, 2), !.
avaliar_sequencia_gravacao('ALERTA DE RISCO (Take Unico): Gravar tudo em um take longo dificulta correcoes caso ocorra um erro no final. Divida em segmentos curtos com checkpoints no projeto.') :-
    fato(ordem_gravacao, _).

avaliar_didatica_erros('RECOMENDACAO UAI: Evite cortar todos os imprevistos. Manter ou demonstrar um erro comum permite que o aluno acompanhe o processo de troubleshooting.') :-
    fato(abordagem_erros, 1), !.
avaliar_didatica_erros('EXCELENTE (Troubleshooting Ativo): Demonstrar a correcao de um erro aproxima o instrutor do aluno e ensina resolucao pratica de problemas.') :-
    fato(abordagem_erros, 2), !.
avaliar_didatica_erros('ERRO GRAVE DE DIDATICA: Nao pule etapas em um video instrucional. O aluno perde a referencia do processo, o que gera frustracao e dificulta a reproducao.') :-
    fato(abordagem_erros, _).

% Auditoria de slides
avaliar_slides('ALERTA DE PAUSA VISUAL: Em tutoriais longos, convem inserir slides pontuais fora da captura de tela para separar explicacoes conceituais do passo a passo.') :-
    fato(texto_slides, 1), fato(intencao_aluno, 3), !.
avaliar_slides('APROVADO (Sem uso de slides): Utilize recursos de zoom e destaques visuais (caixas e setas) na edicao para guiar a atencao na interface.') :-
    fato(texto_slides, 1), !.
avaliar_slides('REPROVADO (Text-Heavy + Visual Poluido): Frases completas concorrem com a fala e multiplos elementos visuais confundem a leitura. Use topicos curtos, padronize fontes e limite a 1 imagem por slide.') :-
    fato(texto_slides, 2), fato(visual_slides, 1), !.
avaliar_slides('ALERTA (Text-Heavy Formatting): Remova frases completas e excesso de numeros da tela. Utilize topicos concisos e desenvolva a explicacao verbalmente.') :-
    fato(texto_slides, 2), !.
avaliar_slides('ALERTA (Inconsistent Graphics): Os textos estao curtos, mas o layout visual precisa de padronizacao. Remova efeitos distrativos, unifique fontes/cores e use apenas 1 visual representativo.') :-
    fato(visual_slides, 1), !.
avaliar_slides('APROVADO COM DIRETRIZ VISUAL (Diagramas/Tabelas): Ao utilizar diagramas ou tabelas nos slides, apresente e explique cada parte separadamente (piece by piece), evitando exibir tudo de uma vez.') :-
    fato(texto_slides, 4), !.
avaliar_slides('APROVADO (Concise & Consistent Formatting): Slides objetivos, padronizados, com destaque para os pontos principais e 1 visual representativo.').

% Avaliacao de camera, luz, cenario e audio
avaliar_camera_luz('RECOMENDACAO (Modo Sem Camera): Como nao havera imagem do instrutor, compense variando o ritmo e a entonacao da voz (reduza o volume para gerar foco e diminua a velocidade em explicacoes importantes).') :-
    fato(camera_tipo, 1), !.
avaliar_camera_luz('ALERTA DE CAMERA E LUZ: Eleve a camera do notebook para a altura dos olhos, substitua a luz natural variavel por iluminacao frontal constante e aplique desfoque (blur) no fundo, removendo marcas visiveis.') :-
    fato(camera_tipo, 2), fato(ambiente_luz, 1), !.
avaliar_camera_luz('AJUSTE DE CENARIO: A iluminacao e controlada, mas o excesso de objetos no fundo pode distrair o aluno. Aplique desfoque parcial (blur) no fundo, remova logos e mantenha o olhar na lente (Regra 1:1).') :-
    fato(ambiente_luz, 2), !.
avaliar_camera_luz('ALERTA DE ILUMINACAO E FUNDO: Evite luz natural variavel e fundos com marcas ou objetos distrativos. Utilize fonte de luz artificial sem causar reflexos e aplique desfoque no cenario.') :-
    fato(ambiente_luz, 1), !.
avaliar_camera_luz('CENARIO EQUILIBRADO APROVADO (Objetos Simples): Fundo organizado e profissional. Verifique apenas se nao ha marcas/logos visiveis ou reflexos da iluminacao nos objetos.') :-
    fato(ambiente_luz, 3), !.
avaliar_camera_luz('SETUP DE VIDEO APROVADO: Camera bem posicionada, iluminacao consistente sem sombras e cenario adequado. Mantenha o contato visual com a lente (Regra 1:1).').

avaliar_audio('CRITICO (Audio de Baixa Qualidade): Microfones internos captam eco e cliques de perifericos. OBS DE TESTE: Grave um teste falando em diferentes entonacoes (baixo, normal e enfatico) para verificar ruidos.') :-
    fato(microfone_tipo, 1), !.
avaliar_audio('ALERTA (Fone Comum): Fones simples costumam comprimir a voz. OBS DE TESTE: Grave 1 minuto testando entonacoes diferentes (voz baixa, pausada e mais alta) e verifique se cliques do mouse nao vazam no audio.') :-
    fato(microfone_tipo, 2), !.
avaliar_audio('BOM (Headset Extensivel): Posicione a haste fora do eixo da respiracao. OBS DE TESTE: Grave um teste com entonacoes variadas (volume baixo e alto para enfase) garantindo que o audio nao distorca.') :-
    fato(microfone_tipo, 3), !.
avaliar_audio('EXCELENTE (Microfone Externo Cardioide): Captura direcionada para a voz. OBS DE TESTE: Ajuste o ganho (gain) gravando testes com entonacoes diferentes (fala suave, ritmo rapido e enfase) para evitar clipping nos picos.') :-
    fato(microfone_tipo, _).

% Recomendacao de software (SO + perfil de edicao)
recomendar_stack_software('CAPTURA: Xbox Game Bar (Win+Alt+R - grava 1 janela por vez) + Camera App | EDICAO: Clipchamp (nativo, gratuito para videos de ate 30 min).') :-
    fato(sistema_op, 1), fato(perfil_edicao, 1), !.
recomendar_stack_software('CAPTURA: Snipping Tool (Win+Shift+S - grava janela ou area da tela) + Camera App | EDICAO: Clipchamp (nativo do Windows 11).') :-
    fato(sistema_op, 2), fato(perfil_edicao, 1), !.
recomendar_stack_software('CAPTURA: QuickTime Player ou Screenshot Toolbar (Shift+Cmd+5) | EDICAO: iMovie (gratuito e nativo do macOS).') :-
    fato(sistema_op, 3), fato(perfil_edicao, 1), !.
recomendar_stack_software('CAPTURA: Gravador nativo do SO ou OBS | EDICAO: DaVinci Resolve (Gratuito ate 4K, inclui aba "Cut Page" para edicao agil e ferramentas de cor e audio).') :-
    fato(perfil_edicao, 2), !.
recomendar_stack_software('CAPTURA + EDICAO INTEGRADA: Camtasia (Grava tela e camera simultaneamente, edicao drag-and-drop, destaques visuais e limpeza de audio).') :-
    fato(perfil_edicao, 3), !.
recomendar_stack_software('EDICAO AVANCADA COM IA: Adobe Premiere Pro (Edicao baseada em transcricao de texto e recurso de aprimoramento de fala).') :-
    fato(perfil_edicao, _).


% --- Exibicao do relatorio final ---

gerar_plano_completo :-
    nl,
    writeln('=========================================================================='),
    writeln('        PLANO DE AULA E AUDITORIA TECNICA - UNREAL ACADEMY (UAI)          '),
    writeln('=========================================================================='),

    definir_formato(Formato, Duracao, DescFormato),
    auditar_verbo(StatusVerbo),
    sugerir_outcome(ExemploOutcome),
    writeln('\n[1. DEFINICAO ESTRATEGICA E LEARNING OUTCOME]'),
    format(' * Formato da Aula: ~w~n', [Formato]),
    format(' * Duracao Recomendada: ~w~n', [Duracao]),
    format(' * Diretriz do Formato: ~w~n', [DescFormato]),
    format(' * Auditoria do seu Objetivo: ~w~n', [StatusVerbo]),
    format(' * Sugestao de Learning Outcome Oficial para seu Tema:~n   -> ~w~n', [ExemploOutcome]),

    gerar_tabela_segmentos(LinhasTabela),
    writeln('\n[2. TABELA DE PLANEJAMENTO DE CONTEUDO (PADRAO 5 COLUNAS EPIC GAMES)]'),
    writeln('   SEGMENTO                | CAMERA / MIC   | VISUAIS NECESSARIOS                 | METAS / PONTOS PRINCIPAIS                      | DURACAO'),
    writeln('   -------------------------------------------------------------------------------------------------------------------------------------------'),
    listar_linhas(LinhasTabela),

    avaliar_sequencia_gravacao(AvalSeq),
    avaliar_didatica_erros(AvalErros),
    avaliar_slides(AvalSlides),
    writeln('\n[3. DIAGNOSTICO DE ROTEIRO, DIDATICA E SLIDES]'),
    format(' * Estrategia de Gravacao: ~w~n', [AvalSeq]),
    format(' * Abordagem de Erros/Passos: ~w~n', [AvalErros]),
    format(' * Auditoria de Slides: ~w~n', [AvalSlides]),
    writeln(' * Tecnica de Enfase Verbal: Use palavras-gatilho ("Importante", "Ponto-chave", "Essencial") antes de mostrar uma diferenca na tela.'),

    avaliar_camera_luz(AvalCam),
    avaliar_audio(AvalAud),
    recomendar_stack_software(StackSoft),
    writeln('\n[4. PRESCRICAO DE EQUIPAMENTO, AMBIENTE E SOFTWARE]'),
    format(' * Camera, Luz e Cenario: ~w~n', [AvalCam]),
    format(' * Captura de Audio: ~w~n', [AvalAud]),
    format(' * Stack de Gravacao e Edicao: ~w~n', [StackSoft]),

    writeln('\n[5. CHECKLIST OPERACIONAL OBRIGATORIO (PRE, DURANTE E POS-GRAVACAO)]'),
    writeln(' * [PRE] Diminuir o tamanho da janela da Unreal Engine para que os menus/textos fiquem legiveis no video.'),
    writeln(' * [PRE] Fechar programas pesados em 2o plano e desativar notificacoes pop-up.'),
    writeln(' * [PRE] Colocar os slides em Tela Cheia (Modo Apresentador) e checar todas as inputs no gravador.'),
    writeln(' * [DURANTE] Falar mais devagar que o normal e adicionar 0.5 segundo extra de pausa entre os segmentos.'),
    writeln(' * [DURANTE] Se errar (retake), ficar em silencio por alguns segundos antes de repetir a fala e voltar o projeto da Unreal ao checkpoint anterior.'),
    writeln(' * [DURANTE] Se lembrar de algo para a edicao (ex: "dar zoom aqui"), falar durante a gravacao e anotar em um arquivo auxiliar.'),
    writeln(' * [POS] Assistir pelo menos 1 minuto do video gravado para checar audio e legibilidade da UI da Unreal.'),
    writeln(' * [POS] Exportar na qualidade maxima e nomear com Data_Modulo_Assunto (Ex: Nov15_M1_Blueprints).'),
    writeln('==========================================================================').

listar_linhas([]).
listar_linhas([H|T]) :-
    format('   ~w~n', [H]),
    listar_linhas(T).


% --- Estrutura do questionario para integracao com a interface ---

etapa(1, 'Escopo pedagogico e Learning Outcomes').
etapa(2, 'Roteirizacao e didatica de gravacao').
etapa(3, 'Design de slides e apoio visual').
etapa(4, 'Hardware, cenario e iluminacao').
etapa(5, 'Sistema operacional e pos-producao').

pergunta(1, 1, 'Qual e o tema principal da sua aula na Unreal Engine?').
pergunta(2, 1, 'Como voce estruturou o verbo do seu Learning Outcome?').
pergunta(3, 1, 'O que voce espera que o aluno faca ao assistir sua aula?').
pergunta(4, 2, 'Em qual ordem voce pretende gravar os arquivos do video?').
pergunta(5, 2, 'Como voce planeja lidar com erros ou passos dificeis?').
pergunta(6, 3, 'Como estao formatados os textos nos seus slides?').
pergunta(7, 3, 'Como esta o layout visual e grafico dos seus slides?').
pergunta(8, 4, 'Qual equipamento de camera voce vai utilizar?').
pergunta(9, 4, 'Como e o seu ambiente fisico de gravacao (fundo e luz)?').
pergunta(10, 4, 'Qual dispositivo de captura de audio voce vai utilizar?').
pergunta(11, 5, 'Qual sistema operacional voce utiliza?').
pergunta(12, 5, 'Qual e a sua prioridade para o software de edicao?').

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
opcao(6, 4, 'Slides visuais com diagramas, fluxogramas ou tabelas').

opcao(7, 1, 'Varios prints, fontes variadas e efeitos chamativos').
opcao(7, 2, 'Padrao consistente e um visual por slide').
opcao(7, 3, 'Sem slides ou apenas texto em fundo solido').

opcao(8, 1, 'Sem camera (Apenas Microfone)').
opcao(8, 2, 'Camera embutida do notebook + Microfone').
opcao(8, 3, 'Camera externa (USB/DSLR) + Microfone').

opcao(9, 1, 'Luz natural e fundo movimentado').
opcao(9, 2, 'Luz artificial controlada e fundo muito carregado').
opcao(9, 3, 'Luz artificial controlada e fundo com objetos simples').
opcao(9, 4, 'Luz artificial controlada e fundo liso/uniforme').

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

mapa_pergunta(1, tema).
mapa_pergunta(2, verbo_status).
mapa_pergunta(3, intencao_aluno).
mapa_pergunta(4, ordem_gravacao).
mapa_pergunta(5, abordagem_erros).
mapa_pergunta(6, texto_slides).
mapa_pergunta(7, visual_slides).
mapa_pergunta(8, camera_tipo).
mapa_pergunta(9, ambiente_luz).
mapa_pergunta(10, microfone_tipo).
mapa_pergunta(11, sistema_op).
mapa_pergunta(12, perfil_edicao).

registrar_resposta(Id, Valor) :-
    retractall(resposta(Id, _)),
    assertz(resposta(Id, Valor)),
    (mapa_pergunta(Id, Atributo) ->
        retractall(fato(Atributo, _)),
        assertz(fato(Atributo, Valor))
    ; true).

resetar_sistema :-
    retractall(fato(_, _)),
    retractall(resposta(_, _)).
    