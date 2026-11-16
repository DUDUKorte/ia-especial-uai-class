% Trabalho de Inteligência Artificial - Implementação de Sistema Especialista
% Domínio: Planejamento e auditoria de aulas para instrutores da Unreal Engine (UAI)
% Alunos: Eduardo Nogueira Korte, Matheus Seghatti de Moraes, Thiago Oliveira Dupim, Vitor Krieser

:- encoding(utf8).
:- dynamic fato/2.
:- dynamic resposta/2.

iniciar :-
    retractall(fato(_, _)),
    writeln('----------------------------------------------------------------------'),
    writeln(' Sistema Especialista - Planejamento de Aulas Unreal Engine (UAI)'),
    writeln('----------------------------------------------------------------------'),
    writeln('Informe o número correspondente a cada opção.'),
    nl,
    coletar_dados,
    gerar_plano_completo.

% --- Coleta de dados via terminal ---

coletar_dados :-
    writeln('--- [ETAPA 1: ESCOPO PEDAGÓGICO E LEARNING OUTCOMES] ---'),
    writeln('1. Qual é o tema principal da sua aula na Unreal Engine?'),
    writeln('   1 - Blueprints e Lógica de Gameplay'),
    writeln('   2 - Iluminação (Lumen, Sky Light, Directional Light, Ray Tracing)'),
    writeln('   3 - Ambientes e Paisagens (Landscape, Foliage, Megascans)'),
    writeln('   4 - Cinematografia (Cine Camera Actor, Sequencer)'),
    writeln('   5 - Materiais, Texturas (Power of 2) e Fotogrametria'),
    perguntar(tema, 'Escolha (1 a 5): '),

    writeln('\n2. Como você estruturou o verbo do seu Learning Outcome (Objetivo de Aprendizagem)?'),
    writeln('   1 - Usei verbos subjetivos/amplos (ex: "Entender...", "Aprender...", "Usar Blueprints")'),
    writeln('   2 - Combinei dois verbos na mesma frase (ex: "Explicar e aplicar...", "Entender e criar...")'),
    writeln('   3 - Usei um único verbo cognitivo/teórico (ex: "Definir...", "Explicar...", "Comparar...")'),
    writeln('   4 - Usei um único verbo prático/construtivo (ex: "Criar...", "Montar...", "Aplicar...")'),
    perguntar(verbo_status, 'Escolha (1 a 4): '),

    writeln('\n3. O que você espera que o aluno faça ao assistir sua aula?'),
    writeln('   1 - Compreenda um conceito teórico, definição ou comparativo rápido (sem abrir a engine)'),
    writeln('   2 - Veja os bastidores de como resolvi um problema complexo (foco em workflow)'),
    writeln('   3 - Siga cada passo na tela para construir o mesmo resultado do zero'),
    perguntar(intencao_aluno, 'Escolha (1 a 3): '),

    writeln('\n--- [ETAPA 2: ROTEIRIZAÇÃO E DIDÁTICA DE GRAVAÇÃO] ---'),
    writeln('4. Em qual ordem você pretende gravar os arquivos do vídeo?'),
    writeln('   1 - Gravar a introdução e o contexto teórico primeiro, e depois gravar a prática'),
    writeln('   2 - Gravar a prática na Unreal primeiro, e gravar a introdução/conclusão por último'),
    writeln('   3 - Gravar tudo em um único take contínuo (sem dividir em segmentos curtos)'),
    perguntar(ordem_gravacao, 'Escolha (1 a 3): '),

    writeln('\n5. Como você planeja lidar com erros ou passos difíceis durante a gravação?'),
    writeln('   1 - Editar e cortar qualquer erro da gravação final'),
    writeln('   2 - Manter ou simular um erro comum para demonstrar o troubleshooting'),
    writeln('   3 - Pular etapas básicas/repetitivas no vídeo para reduzir o tempo'),
    perguntar(abordagem_erros, 'Escolha (1 a 3): '),

    writeln('\n--- [ETAPA 3: DESIGN DE SLIDES E APOIO VISUAL] ---'),
    writeln('6. Como estão formatados os textos e conteúdos nos seus slides de apoio?'),
    writeln('   1 - Não utilizarei slides (apenas captura de tela da Unreal Engine)'),
    writeln('   2 - Frases completas, explicações detalhadas e listas longas de números'),
    writeln('   3 - Tópicos curtos (bullets concisos), palavras-chave e destaque nos pontos principais'),
    writeln('   4 - Slides visuais com diagramas, fluxogramas ou tabelas comparativas'),
    perguntar(texto_slides, 'Escolha (1 a 4): '),

    writeln('\n7. Como está o layout visual e gráfico dos seus slides?'),
    writeln('   1 - Vários prints/imagens na mesma tela, fontes variadas ou efeitos visuais'),
    writeln('   2 - Padrão consistente de fontes/cores e apenas 1 visual representativo por slide'),
    writeln('   3 - Não se aplica (sem slides) ou apenas texto em fundo sólido'),
    perguntar(visual_slides, 'Escolha (1 a 3): '),

    writeln('\n--- [ETAPA 4: HARDWARE, CENÁRIO E ILUMINAÇÃO] ---'),
    writeln('8. Qual configuração de câmera e microfone você vai utilizar na gravação?'),
    writeln('   1 - Sem câmera (Apenas Microfone / Narração em off)'),
    writeln('   2 - Câmera embutida do notebook + Microfone'),
    writeln('   3 - Câmera externa (USB/DSLR) na altura dos olhos + Microfone'),
    perguntar(camera_tipo, 'Escolha (1 a 3): '),

    writeln('\n9. Como é o seu ambiente físico de gravação (fundo e luz)?'),
    writeln('   1 - Luz natural da janela e fundo movimentado (estante cheia, logos/marcas)'),
    writeln('   2 - Luz artificial controlada (Ring Light/Softbox), mas fundo com muitos objetos/livros'),
    writeln('   3 - Luz artificial controlada e fundo com objetos simples/organizados'),
    writeln('   4 - Luz artificial controlada (sem sombras/reflexos) e fundo liso/uniforme'),
    perguntar(ambiente_luz, 'Escolha (1 a 4): '),

    writeln('\n10. Qual dispositivo de captura de áudio você vai utilizar?'),
    writeln('   1 - Microfone interno do notebook ou da webcam'),
    writeln('   2 - Fone de ouvido comum (Bluetooth ou fone simples de celular)'),
    writeln('   3 - Headset com microfone extensível próximo à boca'),
    writeln('   4 - Microfone externo dedicado para voz (padrão cardióide em pedestal ou braço)'),
    perguntar(microfone_tipo, 'Escolha (1 a 4): '),

    writeln('\n--- [ETAPA 5: SISTEMA OPERACIONAL E PÓS-PRODUÇÃO] ---'),
    writeln('11. Qual Sistema Operacional você utiliza na máquina de gravação?'),
    writeln('   1 - Windows 10'),
    writeln('   2 - Windows 11'),
    writeln('   3 - macOS'),
    perguntar(sistema_op, 'Escolha (1 a 3): '),

    writeln('\n12. Qual é a sua prioridade para o software de edição de vídeo?'),
    writeln('   1 - Gratuito, nativo e simples (cortes básicos em vídeos de até 30 min)'),
    writeln('   2 - Gratuito, mas completo (exportação até 4K, correção de cor/áudio e Cut Page)'),
    writeln('   3 - Licença paga focada em videoaulas (gravar tela+câmera juntos e edição direta)'),
    writeln('   4 - Suíte profissional com IA (edição por transcrição de texto e limpeza de voz)'),
    perguntar(perfil_edicao, 'Escolha (1 a 4): ').

perguntar(Atributo, Prompt) :-
    writeln(Prompt),
    read(Valor),
    assertz(fato(Atributo, Valor)).

% --- Base de Conhecimento ---

% Classificação do formato de aula
definir_formato('EXPLAINER (Vídeo Explicativo Conceitual)',
                'Curta (5 a 8 minutos)',
                'Foco na transmissão de conceitos teóricos, definindo termos com fontes e mantendo o escopo restrito.') :-
    fato(intencao_aluno, 1), !.

definir_formato('DEMO (Demonstração de Workflow e Ferramentas)',
                'Média (10 a 15 minutos)',
                'Foco em demonstrar o raciocínio e as ferramentas aplicadas na solução de um problema, sem exigir réplica passo a passo.') :-
    fato(intencao_aluno, 2), !.

definir_formato('TUTORIAL (Prática Passo a Passo Replicável)',
                'Longa, dividida em segmentos menores (15 a 25 minutos)',
                'Foco em orientar o aluno etapa por etapa para que ele reproduza o mesmo processo no próprio projeto.') :-
    fato(intencao_aluno, _).

% Auditoria do Learning Outcome (Verde: APROVADO | Amarelo: ALERTA | Vermelho: REPROVADO)
    auditar_verbo('REPROVADO (Verbo Vago/Escopo Amplo): Termos como "Entender" não permitem avaliação direta. Substitua por um verbo de ação mensurável.') :-
    fato(verbo_status, 1), !.
    auditar_verbo('REPROVADO (Objetivo Duplo): Dois verbos na mesma frase misturam metas distintas. Divida em 2 Learning Outcomes separados (um teórico e um prático).') :-
    fato(verbo_status, 2), !.
    auditar_verbo('ALERTA DE INCONSISTÊNCIA: O verbo escolhido é teórico (Definir/Explicar), mas a aula é um Tutorial prático. Altere o verbo para Criar, Montar ou Aplicar.') :-
    fato(verbo_status, 3), fato(intencao_aluno, 3), !.
    auditar_verbo('ALERTA DE INCONSISTÊNCIA: O verbo escolhido é prático (Criar/Montar), mas a aula é apenas um Explainer teórico. Altere o verbo para Definir, Explicar ou Comparar.') :-
    fato(verbo_status, 4), fato(intencao_aluno, 1), !.
    auditar_verbo('APROVADO: O verbo escolhido é único, mensurável e coerente com o formato da aula.').

% Exemplos de Learning Outcome por tema
    sugerir_outcome('Teórico: "Explicar o fluxo de execução de Eventos em Blueprints" | Prático: "Criar a resposta de um personagem a um estímulo usando Blueprints".') :-
    fato(tema, 1), !.
    sugerir_outcome('Teórico: "Definir Lumen na Unreal Engine" ou "Comparar os usos de Sky Lights e Directional Lights" | Prático: "Aplicar ray tracing em uma cena específica".') :-
    fato(tema, 2), !.
    sugerir_outcome('Teórico: "Explicar os usos do Quixel Megascans" | Prático: "Montar uma paisagem de floresta utilizando a ferramenta de Landscape".') :-
    fato(tema, 3), !.
    sugerir_outcome('Teórico: "Explicar como usar um Cine Camera Actor para capturar uma cena" | Prático: "Criar uma gravação cinemática usando um Cine Camera Actor".') :-
    fato(tema, 4), !.
    sugerir_outcome('Teórico: "Explicar por que dimensões de textura em potência de 2 (Power of 2) afetam o streaming de memória" | Prático: "Importar e configurar um modelo escaneado via fotogrametria na Unreal Engine".') :-
    fato(tema, _).

% Tabela de planejamento de 5 colunas
gerar_tabela_segmentos([
    'SEG 1: Introdução         | Câmera + Mic   | Slides (Agenda + Learning Outcomes) | Apresentar credenciais e declarar meta da aula | 2 min',
    'SEG 2: Definição de Termos| Sem Câmera     | Slides concisos + Fontes técnicas   | Definir conceitos-chave sem fugir do escopo    | 3 min',
    'SEG 3: Análise Visual     | Sem Câmera     | Diagramas/Tabelas divididos em partes| Explicar arquitetura visual parte por parte    | 3 min',
    'SEG 4: Conclusão          | Câmera + Mic   | Slide de Resumo (Key Takeaways)     | Revisar o conceito aprendido e encerrar        | 1 min'
]) :- fato(intencao_aluno, 1), !.

gerar_tabela_segmentos([
    'SEG 1: Intro + Resultado  | Câmera + Tela  | Vídeo do projeto final rodando na UE| Mostrar resultado pronto para contextualizar   | 2 min',
    'SEG 2: Contexto do Projeto| Sem Câmera     | Slides rápidos de contexto          | Explicar qual problema precisava ser resolvido | 2 min',
    'SEG 3: Bastidores/Workflow| Câmera + Tela  | Captura da Unreal (Janela reduzida) | Mostrar ferramentas usadas e o motivo de cada  | 8 min',
    'SEG 4: Conclusão          | Câmera + Mic   | Captura final + Slide de Takeaways  | Repetir aprendizados-chave e incentivar testes | 2 min'
]) :- fato(intencao_aluno, 2), !.

gerar_tabela_segmentos([
    'SEG 1: Intro + Resultado  | Câmera + Tela  | Preview do resultado final na Unreal| Mostrar onde o aluno vai chegar (sem detalhes) | 2 min',
    'SEG 2: Avisos e Obstáculos| Sem Câmera     | Slide de pontos críticos/armadilhas | Antecipar dúvidas e evitar frustração do aluno | 2 min',
    'SEG 3: Prática Parte 1    | Sem Cam + Tela | Captura da Unreal (Ritmo lento)     | Executar etapa inicial explicando a lógica     | 7 min',
    'SEG 4: Pausa Conceitual   | Sem Câmera     | Slide explicativo fora da captura   | Destacar conceito importante fora da prática   | 2 min',
    'SEG 5: Prática Parte 2    | Sem Cam + Tela | Captura da Unreal + Troubleshooting | Finalizar construção sem pular nenhuma etapa   | 8 min',
    'SEG 6: Conclusão          | Câmera + Mic   | Resultado final + Slide de Revisão  | Revisar etapas concluídas e encerrar           | 2 min'
]) :- fato(intencao_aluno, _).

% Regras de sequencia de gravação e didática
    avaliar_sequencia_gravacao('ÓTIMA ESCOLHA (Contexto -> Prática): Gravar o contexto primeiro auxilia a manter essa informação integrada durante o restante do vídeo.') :-
    fato(ordem_gravacao, 1), !.
    avaliar_sequencia_gravacao('ÓTIMA ESCOLHA (Prática -> Contexto): Gravar a prática primeiro facilita identificar os pontos principais para mencionar depois na introdução e na conclusão.') :-
    fato(ordem_gravacao, 2), !.
    avaliar_sequencia_gravacao('ALERTA DE RISCO (Take Único): Gravar tudo em um take longo dificulta correções caso ocorra um erro no final. Divida em segmentos curtos com checkpoints no projeto.') :-
    fato(ordem_gravacao, _).

    avaliar_didatica_erros('RECOMENDAÇÃO UAI: Evite cortar todos os imprevistos. Manter ou demonstrar um erro comum permite que o aluno acompanhe o processo de troubleshooting.') :-
    fato(abordagem_erros, 1), !.
    avaliar_didatica_erros('EXCELENTE (Troubleshooting Ativo): Demonstrar a correção de um erro aproxima o instrutor do aluno e ensina resolução prática de problemas.') :-
    fato(abordagem_erros, 2), !.
    avaliar_didatica_erros('ERRO GRAVE DE DIDÁTICA: Não pule etapas em um vídeo instrucional. O aluno perde a referência do processo, o que gera frustração e dificulta a reprodução.') :-
    fato(abordagem_erros, _).

% Auditoria de slides
    avaliar_slides('ALERTA DE PAUSA VISUAL: Em tutoriais longos, convém inserir slides pontuais fora da captura de tela para separar explicações conceituais do passo a passo.') :-
    fato(texto_slides, 1), fato(intencao_aluno, 3), !.
    avaliar_slides('APROVADO (Sem uso de slides): Utilize recursos de zoom e destaques visuais (caixas e setas) na edição para guiar a atenção na interface.') :-
    fato(texto_slides, 1), !.
    avaliar_slides('REPROVADO (Text-Heavy + Visual Poluído): Frases completas concorrem com a fala e múltiplos elementos visuais confundem a leitura. Use tópicos curtos, padronize fontes e limite a 1 imagem por slide.') :-
    fato(texto_slides, 2), fato(visual_slides, 1), !.
    avaliar_slides('ALERTA (Text-Heavy Formatting): Remova frases completas e excesso de números da tela. Utilize tópicos concisos e desenvolva a explicação verbalmente.') :-
    fato(texto_slides, 2), !.
    avaliar_slides('ALERTA (Inconsistent Graphics): Os textos estão curtos, mas o layout visual precisa de padronização. Remova efeitos distrativos, unifique fontes/cores e use apenas 1 visual representativo.') :-
    fato(visual_slides, 1), !.
    avaliar_slides('APROVADO COM DIRETRIZ VISUAL (Diagramas/Tabelas): Ao utilizar diagramas ou tabelas nos slides, apresente e explique cada parte separadamente (piece by piece), evitando exibir tudo de uma vez.') :-
    fato(texto_slides, 4), !.
    avaliar_slides('APROVADO (Concise & Consistent Formatting): Slides objetivos, padronizados, com destaque para os pontos principais e 1 visual representativo.').

% Avaliação de câmera, luz, cenário e áudio
    avaliar_camera_luz('RECOMENDAÇÃO (Modo Sem Câmera): Como não haverá imagem do instrutor, compense variando o ritmo e a entonação da voz (reduza o volume para gerar foco e diminua a velocidade em explicações importantes).') :-
    fato(camera_tipo, 1), !.
    avaliar_camera_luz('ALERTA DE CÂMERA E LUZ: Eleve a câmera do notebook para a altura dos olhos, substitua a luz natural variável por iluminação frontal constante e aplique desfoque (blur) no fundo, removendo marcas visíveis.') :-
    fato(camera_tipo, 2), fato(ambiente_luz, 1), !.
    avaliar_camera_luz('AJUSTE DE CENÁRIO: A iluminação é controlada, mas o excesso de objetos no fundo pode distrair o aluno. Aplique desfoque parcial (blur) no fundo, remova logos e mantenha o olhar na lente (Regra 1:1).') :-
    fato(ambiente_luz, 2), !.
    avaliar_camera_luz('ALERTA DE ILUMINAÇÃO E FUNDO: Evite luz natural variável e fundos com marcas ou objetos distrativos. Utilize fonte de luz artificial sem causar reflexos e aplique desfoque no cenário.') :-
    fato(ambiente_luz, 1), !.
    avaliar_camera_luz('CENÁRIO EQUILIBRADO APROVADO (Objetos Simples): Fundo organizado e profissional. Verifique apenas se não há marcas/logos visíveis ou reflexos da iluminação nos objetos.') :-
    fato(ambiente_luz, 3), !.
    avaliar_camera_luz('SETUP DE VÍDEO APROVADO: Câmera bem posicionada, iluminação consistente sem sombras e cenário adequado. Mantenha o contato visual com a lente (Regra 1:1).').

    avaliar_audio('CRÍTICO (Áudio de Baixa Qualidade): Microfones internos captam eco e cliques de periféricos. OBS DE TESTE: Grave um teste falando em diferentes entonações (baixo, normal e enfático) para verificar ruídos.') :-
    fato(microfone_tipo, 1), !.
    avaliar_audio('ALERTA (Fone Comum): Fones simples costumam comprimir a voz. OBS DE TESTE: Grave 1 minuto testando entonações diferentes (voz baixa, pausada e mais alta) e verifique se cliques do mouse não vazam no áudio.') :-
    fato(microfone_tipo, 2), !.
    avaliar_audio('BOM (Headset Extensível): Posicione a haste fora do eixo da respiração. OBS DE TESTE: Grave um teste com entonações variadas (volume baixo e alto para ênfase) garantindo que o áudio não distorça.') :-
    fato(microfone_tipo, 3), !.
    avaliar_audio('EXCELENTE (Microfone Externo Cardióide): Captura direcionada para a voz. OBS DE TESTE: Ajuste o ganho (gain) gravando testes com entonações diferentes (fala suave, ritmo rápido e ênfase) para evitar clipping nos picos.') :-
    fato(microfone_tipo, _).

% Recomendação de software (SO + perfil de edição)
    recomendar_stack_software('CAPTURA: Xbox Game Bar (Win+Alt+R - grava 1 janela por vez) + Camera App | EDIÇÃO: Clipchamp (nativo, gratuito para vídeos de até 30 min).') :-
    fato(sistema_op, 1), fato(perfil_edicao, 1), !.
    recomendar_stack_software('CAPTURA: Snipping Tool (Win+Shift+S - grava janela ou área da tela) + Camera App | EDIÇÃO: Clipchamp (nativo do Windows 11).') :-
    fato(sistema_op, 2), fato(perfil_edicao, 1), !.
    recomendar_stack_software('CAPTURA: QuickTime Player ou Screenshot Toolbar (Shift+Cmd+5) | EDIÇÃO: iMovie (gratuito e nativo do macOS).') :-
    fato(sistema_op, 3), fato(perfil_edicao, 1), !.
    recomendar_stack_software('CAPTURA: Gravador nativo do SO ou OBS | EDIÇÃO: DaVinci Resolve (Gratuito até 4K, inclui aba "Cut Page" para edição ágil e ferramentas de cor e áudio).') :-
    fato(perfil_edicao, 2), !.
    recomendar_stack_software('CAPTURA + EDIÇÃO INTEGRADA: Camtasia (Grava tela e câmera simultaneamente, edição drag-and-drop, destaques visuais e limpeza de áudio).') :-
    fato(perfil_edicao, 3), !.
    recomendar_stack_software('EDIÇÃO AVANÇADA COM IA: Adobe Premiere Pro (Edição baseada em transcrição de texto e recurso de aprimoramento de fala).') :-
    fato(perfil_edicao, _).

% --- Exibição do relatório final ---

gerar_plano_completo :-
    nl,
    writeln('=='),
    writeln('        PLANO DE AULA E AUDITORIA TÉCNICA - UNREAL ACADEMY (UAI)          '),
    writeln('=='),

    definir_formato(Formato, Duracao, DescFormato),
    auditar_verbo(StatusVerbo),
    sugerir_outcome(ExemploOutcome),
    writeln('\n[1. DEFINIÇÃO ESTRATÉGICA E LEARNING OUTCOME]'),
    format(' * Formato da Aula: ~w~n', [Formato]),
    format(' * Duração Recomendada: ~w~n', [Duracao]),
    format(' * Diretriz do Formato: ~w~n', [DescFormato]),
    format(' * Auditoria do seu Objetivo: ~w~n', [StatusVerbo]),
    format(' * Sugestão de Learning Outcome Oficial para seu Tema:~n   -> ~w~n', [ExemploOutcome]),

    gerar_tabela_segmentos(LinhasTabela),
    writeln('\n[2. TABELA DE PLANEJAMENTO DE CONTEÚDO (PADRÃO 5 COLUNAS EPIC GAMES)]'),
    writeln('   SEGMENTO                | CÂMERA / MIC   | VISUAIS NECESSÁRIOS                 | METAS / PONTOS PRINCIPAIS                      | DURAÇÃO'),
    writeln('   -------------------------------------------------------------------------------------------------------------------------------------------'),
    listar_linhas(LinhasTabela),

    avaliar_sequencia_gravacao(AvalSeq),
    avaliar_didatica_erros(AvalErros),
    avaliar_slides(AvalSlides),
    writeln('\n[3. DIAGNÓSTICO DE ROTEIRO, DIDÁTICA E SLIDES]'),
    format(' * Estratégia de Gravação: ~w~n', [AvalSeq]),
    format(' * Abordagem de Erros/Passos: ~w~n', [AvalErros]),
    format(' * Auditoria de Slides: ~w~n', [AvalSlides]),
    writeln(' * Técnica de Ênfase Verbal: Use palavras-gatilho ("Importante", "Ponto-chave", "Essencial") antes de mostrar uma diferença na tela.'),

    avaliar_camera_luz(AvalCam),
    avaliar_audio(AvalAud),
    recomendar_stack_software(StackSoft),
    writeln('\n[4. PRESCRIÇÃO DE EQUIPAMENTO, AMBIENTE E SOFTWARE]'),
    format(' * Câmera, Luz e Cenário: ~w~n', [AvalCam]),
    format(' * Captura de Áudio: ~w~n', [AvalAud]),
    format(' * Stack de Gravação e Edição: ~w~n', [StackSoft]),

    writeln('\n[5. CHECKLIST OPERACIONAL OBRIGATÓRIO (PRÉ, DURANTE E PÓS-GRAVAÇÃO)]'),
    writeln(' * [PRÉ] Diminuir o tamanho da janela da Unreal Engine para que os menus/textos fiquem legíveis no vídeo.'),
    writeln(' * [PRÉ] Fechar programas pesados em 2o plano e desativar notificações pop-up.'),
    writeln(' * [PRÉ] Colocar os slides em Tela Cheia (Modo Apresentador) e checar todas as inputs no gravador.'),
    writeln(' * [DURANTE] Falar mais devagar que o normal e adicionar 0.5 segundo extra de pausa entre os segmentos.'),
    writeln(' * [DURANTE] Se errar (retake), ficar em silêncio por alguns segundos antes de repetir a fala e voltar o projeto da Unreal ao checkpoint anterior.'),
    writeln(' * [DURANTE] Se lembrar de algo para a edição (ex: "dar zoom aqui"), falar durante a gravação e anotar em um arquivo auxiliar.'),
    writeln(' * [PÓS] Assistir pelo menos 1 minuto do vídeo gravado para checar áudio e legibilidade da UI da Unreal.'),
    writeln(' * [PÓS] Exportar na qualidade máxima e nomear com Data_Modulo_Assunto (Ex: Nov15_M1_Blueprints).'),
    writeln('==========================================================================').

listar_linhas([]).
listar_linhas([H|T]) :-
    format('   ~w~n', [H]),
    listar_linhas(T).

% --- Estrutura do questionário para integração com a interface ---

etapa(1, 'Escopo pedagógico e Learning Outcomes').
etapa(2, 'Roteirização e didática de gravação').
etapa(3, 'Design de slides e apoio visual').
etapa(4, 'Hardware, cenário e iluminação').
etapa(5, 'Sistema operacional e pós-produção').

pergunta(1, 1, 'Qual é o tema principal da sua aula na Unreal Engine?').
pergunta(2, 1, 'Como você estruturou o verbo do seu Learning Outcome?').
pergunta(3, 1, 'O que você espera que o aluno faça ao assistir sua aula?').
pergunta(4, 2, 'Em qual ordem você pretende gravar os arquivos do vídeo?').
pergunta(5, 2, 'Como você planeja lidar com erros ou passos difíceis?').
pergunta(6, 3, 'Como estão formatados os textos nos seus slides?').
pergunta(7, 3, 'Como está o layout visual e gráfico dos seus slides?').
pergunta(8, 4, 'Qual equipamento de câmera você vai utilizar?').
pergunta(9, 4, 'Como é o seu ambiente físico de gravação (fundo e luz)?').
pergunta(10, 4, 'Qual dispositivo de captura de áudio você vai utilizar?').
pergunta(11, 5, 'Qual sistema operacional você utiliza?').
pergunta(12, 5, 'Qual é a sua prioridade para o software de edição?').

opcao(1, 1, 'Blueprints e Lógica de Gameplay').
opcao(1, 2, 'Iluminação (Lumen, Sky Light, Directional Light, Ray Tracing)').
opcao(1, 3, 'Ambientes e Paisagens (Landscape, Foliage, Megascans)').
opcao(1, 4, 'Cinematografia (Cine Camera Actor, Sequencer)').
opcao(1, 5, 'Materiais, Texturas (Power of 2) e Fotogrametria').

opcao(2, 1, 'Usei verbos subjetivos/amplos').
opcao(2, 2, 'Combinei dois verbos na mesma frase').
opcao(2, 3, 'Usei um único verbo cognitivo/teórico').
opcao(2, 4, 'Usei um único verbo prático/construtivo').

opcao(3, 1, 'Compreenda um conceito teórico').
opcao(3, 2, 'Veja os bastidores de como resolvi um problema complexo').
opcao(3, 3, 'Siga cada clique para construir o resultado do zero').

opcao(4, 1, 'Gravar introdução e teoria primeiro').
opcao(4, 2, 'Gravar prática primeiro e introdução por último').
opcao(4, 3, 'Gravar tudo em um único take').

opcao(5, 1, 'Editar e cortar qualquer erro').
opcao(5, 2, 'Incluir um erro comum para ensinar troubleshooting').
opcao(5, 3, 'Pular etapas básicas para economizar tempo').

opcao(6, 1, 'Não utilizarei slides').
opcao(6, 2, 'Frases completas e explicações detalhadas').
opcao(6, 3, 'Tópicos curtos, palavras-chave e key takeaways').
opcao(6, 4, 'Slides visuais com diagramas, fluxogramas ou tabelas').

opcao(7, 1, 'Vários prints, fontes variadas e efeitos chamativos').
opcao(7, 2, 'Padrão consistente e um visual por slide').
opcao(7, 3, 'Sem slides ou apenas texto em fundo sólido').

opcao(8, 1, 'Sem câmera (Apenas Microfone)').
opcao(8, 2, 'Câmera embutida do notebook + Microfone').
opcao(8, 3, 'Câmera externa (USB/DSLR) + Microfone').

opcao(9, 1, 'Luz natural e fundo movimentado').
opcao(9, 2, 'Luz artificial controlada e fundo muito carregado').
opcao(9, 3, 'Luz artificial controlada e fundo com objetos simples').
opcao(9, 4, 'Luz artificial controlada e fundo liso/uniforme').

opcao(10, 1, 'Microfone interno do notebook ou webcam').
opcao(10, 2, 'Fone de ouvido comum').
opcao(10, 3, 'Headset com microfone extensível').
opcao(10, 4, 'Microfone externo dedicado').

opcao(11, 1, 'Windows 10').
opcao(11, 2, 'Windows 11').
opcao(11, 3, 'macOS').

opcao(12, 1, 'Gratuito, nativo e simples').
opcao(12, 2, 'Gratuito, mas profissional').
opcao(12, 3, 'Pago, focado em educação').
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
retractall(fato(_, *)),
retractall(resposta(*, _)).