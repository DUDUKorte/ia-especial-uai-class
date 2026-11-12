from pathlib import Path
import tkinter as tk
from tkinter import ttk
import tkinter.font as tkfont
from pyswip import Prolog

# ─── Prolog setup ────────────────────────────────────────────────────────────
caminho_pl = Path(__file__).parent / "regras.pl"
prolog = Prolog()
prolog.consult(caminho_pl.as_posix())

# ─── Paleta de cores (Tema moderno UAI / Unreal Engine em #26bbff) ──────────
CORES = {
    "bg_dark":        "#0a0b0e",   # Fundo ultra dark moderno
    "bg_card":        "#121319",   # Card inativo
    "bg_card_sel":    "#0d1824",   # Card selecionado com leve tom azul
    "bg_card2":       "#171922",   # Fundo secundário / hover
    "bg_box":         "#1d1f28",   # Quadrado das letras inativas
    "accent":         "#26bbff",   # Ciano / Azul elétrico UAI
    "accent_dim":     "#0f5577",   # Versão escura para bordas sutis
    "accent_hover":   "#52caff",   # Hover luminoso
    "text_primary":   "#ffffff",   # Branco
    "text_secondary": "#9fa5b8",   # Cinza moderno
    "text_muted":     "#686d80",   # Cinza mudo para metadados
    "border":         "#1e202a",   # Borda suave
    "border_card":    "#222430",   # Borda normal de cards
    "success":        "#10b981",   # Verde aprovação
    "warning":        "#f5a623",   # Âmbar alerta
    "danger":         "#ef4444",   # Vermelho reprovação
    "step_active":    "#26bbff",   # Círculo ativo
    "step_done":      "#26bbff",   # Círculo concluído
    "step_pending":   "#171821",   # Círculo pendente
}

TOTAL_PERGUNTAS = 12

ETAPAS = [
    (1,  ""),
    (2,  ""),
    (3,  ""),
    (4,  ""),
    (5,  ""),
]

ETAPA_POR_PERGUNTA = {1: 1, 2: 1, 3: 1, 4: 2, 5: 2, 6: 3, 7: 3,
                      8: 4, 9: 4, 10: 4, 11: 5, 12: 5}

# ─── Estado global ────────────────────────────────────────────────────────────
pergunta_atual = 1


# ─── Helpers visuais ─────────────────────────────────────────────────────────

def limpar_frame(frame):
    for widget in frame.winfo_children():
        widget.destroy()


def criar_separador(parent, cor=None, pady=0):
    cor = cor or CORES["border"]
    tk.Frame(parent, height=1, bg=cor).pack(fill="x", padx=0, pady=pady)


def animar_hover(btn, cor_normal, cor_hover):
    btn.bind("<Enter>", lambda e: btn.config(bg=cor_hover))
    btn.bind("<Leave>", lambda e: btn.config(bg=cor_normal))


# ─── Widget: Barra de Etapas (Stepper superior idêntico ao anexo) ─────────────

def desenhar_barra_etapas(parent, pergunta_num):
    etapa_atual = ETAPA_POR_PERGUNTA.get(pergunta_num, 1)

    container = tk.Frame(parent, bg=CORES["bg_dark"], pady=0)
    container.pack(fill="x", padx=48, pady=(16, 12))

    # Grid de 5 colunas com linha de conexão contínua
    stepper_box = tk.Frame(container, bg=CORES["bg_dark"])
    stepper_box.pack(fill="x")

    for i, (etapa_id, etapa_nome) in enumerate(ETAPAS):
        col = tk.Frame(stepper_box, bg=CORES["bg_dark"])
        col.pack(side="left", expand=True, fill="x")

        is_active = (etapa_id == etapa_atual)
        is_done = (etapa_id < etapa_atual)

        # Linha conectora e círculo
        circle_row = tk.Frame(col, bg=CORES["bg_dark"])
        circle_row.pack(fill="x")

        # Linha esquerda
        linha_esq = tk.Frame(
            circle_row,
            height=2,
            bg=CORES["accent"] if is_done or is_active else CORES["border"] if i > 0 else CORES["bg_dark"],
        )
        linha_esq.pack(side="left", expand=True, fill="x", pady=13)

        # Círculo
        circulo_bg = CORES["accent"] if is_active else ("#1b2735" if is_done else "#171821")
        circulo_fg = "#ffffff" if is_active else (CORES["accent"] if is_done else "#686d80")
        circulo_borda = CORES["accent"] if is_active else ("#253648" if is_done else "#252733")

        circulo = tk.Label(
            circle_row,
            text=str(etapa_id),
            bg=circulo_bg,
            fg=circulo_fg,
            font=("Segoe UI", 9, "bold"),
            width=3,
            height=1,
            relief="solid",
            bd=1,
            highlightbackground=circulo_borda,
            padx=2,
            pady=3,
        )
        circulo.pack(side="left")

        # Linha direita
        linha_dir = tk.Frame(
            circle_row,
            height=2,
            bg=CORES["accent"] if is_done else CORES["border"] if i < len(ETAPAS) - 1 else CORES["bg_dark"],
        )
        linha_dir.pack(side="left", expand=True, fill="x", pady=13)

        # Rótulo abaixo do círculo
        label_fg = "#ffffff" if is_active else "#686d80"
        label_font = ("Segoe UI", 7, "bold")

        tk.Label(
            col,
            text=etapa_nome,
            bg=CORES["bg_dark"],
            fg=label_fg,
            font=label_font,
            justify="center",
            anchor="center",
        ).pack(pady=(4, 0))


# ─── Tela inicial (Idêntica ao anexo da Home) ────────────────────────────────

def mostrar_tela_inicial():
    limpar_frame(frame_conteudo)

    root = tk.Frame(frame_conteudo, bg=CORES["bg_dark"])
    root.pack(expand=True, fill="both")

    # Coluna centralizada com conteúdo
    centro = tk.Frame(root, bg=CORES["bg_dark"])
    centro.place(relx=0.5, rely=0.5, anchor="center")

    # ── 1. Título Impactante (Hero) ──
    linha_titulo1 = tk.Frame(centro, bg=CORES["bg_dark"])
    linha_titulo1.pack(pady=(0, 2))

    tk.Label(
        linha_titulo1,
        text="AUDITORIA ",
        bg=CORES["bg_dark"],
        fg="#ffffff",
        font=("Segoe UI", 32, "bold"),
    ).pack(side="left")

    tk.Label(
        linha_titulo1,
        text="PEDAGÓGICA",
        bg=CORES["bg_dark"],
        fg=CORES["accent"],
        font=("Segoe UI", 32, "bold"),
    ).pack(side="left")

    tk.Label(
        centro,
        text="E PLANEJAMENTO DE AULAS",
        bg=CORES["bg_dark"],
        fg="#e0e3ed",
        font=("Segoe UI", 18, "bold"),
    ).pack(pady=(0, 14))

    # ── 2. Subtítulo ──
    tk.Label(
        centro,
        text="Sistema especialista para validação de escopo, infraestrutura técnica e aderência\naos padrões recomendados pela Epic Games.",
        bg=CORES["bg_dark"],
        fg=CORES["text_secondary"],
        font=("Segoe UI", 10),
        justify="center",
    ).pack(pady=(0, 28))

    # ── 3. Grid dos 5 Módulos Horizontais (Cards Lado a Lado) ──
    cards_frame = tk.Frame(centro, bg=CORES["bg_dark"])
    cards_frame.pack(pady=(0, 32))

    modulos = [
        ("🎯", "01", "ESCOPO\nPEDAGÓGICO"),
        ("▶",  "02", "ROTEIRIZAÇÃO\nDIDÁTICA"),
        ("🗂", "03", "DESIGN DE APOIO\nVISUAL"),
        ("🎙", "04", "INFRAESTRUTURA"),
        ("⚙",  "05", "PÓS-PRODUÇÃO"),
    ]

    for icone, num, nome in modulos:
        card = tk.Frame(
            cards_frame,
            bg=CORES["bg_card"],
            highlightbackground=CORES["border_card"],
            highlightthickness=1,
            width=135,
            height=100,
        )
        card.pack(side="left", padx=5)
        card.pack_propagate(False)

        # Topo do card: Ícone azul à esquerda, número transparente à direita
        topo_card = tk.Frame(card, bg=CORES["bg_card"])
        topo_card.pack(fill="x", padx=10, pady=(10, 0))

        tk.Label(
            topo_card,
            text=icone,
            bg=CORES["bg_card"],
            fg=CORES["accent"],
            font=("Segoe UI", 13, "bold"),
            anchor="w",
        ).pack(side="left")

        tk.Label(
            topo_card,
            text=num,
            bg=CORES["bg_card"],
            fg="#222532",
            font=("Segoe UI", 16, "bold"),
            anchor="e",
        ).pack(side="right")

        # Base do card: Nome do módulo
        tk.Label(
            card,
            text=nome,
            bg=CORES["bg_card"],
            fg="#ffffff",
            font=("Segoe UI", 7, "bold"),
            justify="left",
            anchor="sw",
        ).pack(side="bottom", fill="x", padx=10, pady=(0, 10))

    # ── 5. Botão Centralizado ──
    btn_iniciar = tk.Button(
        centro,
        text="INICIAR AUDITORIA TÉCNICA  >",
        bg=CORES["accent"],
        fg="#0a0b0e",
        font=("Segoe UI", 10, "bold"),
        relief="flat",
        bd=0,
        padx=32,
        pady=11,
        cursor="hand2",
        command=iniciar_questionario,
    )
    btn_iniciar.pack()
    animar_hover(btn_iniciar, CORES["accent"], CORES["accent_hover"])


# ─── Tela de pergunta (Idêntica ao anexo de Perguntas) ─────────────────────────

def mostrar_pergunta(num_pergunta):
    global pergunta_atual
    pergunta_atual = num_pergunta

    limpar_frame(frame_cabecalho)
    limpar_frame(frame_conteudo)

    # ── Cabeçalho com o Stepper ──
    desenhar_barra_etapas(frame_cabecalho, num_pergunta)
    criar_separador(frame_cabecalho, cor=CORES["border"], pady=(0, 6))

    # Busca dados do Prolog
    consulta = list(prolog.query(f"pergunta({num_pergunta}, Etapa, Texto)"))
    if not consulta:
        return

    c = consulta[0]
    texto_pergunta = c["Texto"]
    etapa_id = c["Etapa"]
    etapa_nome = next((n for eid, n in ETAPAS if eid == etapa_id), "")

    opcoes = list(prolog.query(f"opcao({num_pergunta}, Valor, Descricao)"))

    # ── Container da Pergunta ──
    wrapper = tk.Frame(frame_conteudo, bg=CORES["bg_dark"])
    wrapper.pack(expand=True, fill="both", padx=64, pady=10)

    # Título da Pergunta
    tk.Label(
        wrapper,
        text=texto_pergunta,
        bg=CORES["bg_dark"],
        fg="#ffffff",
        font=("Segoe UI", 18, "bold"),
        wraplength=720,
        justify="left",
        anchor="w",
    ).pack(fill="x", pady=(8, 20))

    # 3. Lista de Opções (Cards clicáveis idênticos ao anexo)
    opcao_var = tk.IntVar(value=0)
    card_opcoes = []

    opcoes_frame = tk.Frame(wrapper, bg=CORES["bg_dark"])
    opcoes_frame.pack(fill="x")

    def selecionar(valor, card_frame, box_letra, label_letra, label_texto, icone_check):
        opcao_var.set(valor)
        # Reset de todos os cards
        for cf, bl, ll, lt, ic, v in card_opcoes:
            cf.config(bg=CORES["bg_card"], highlightbackground=CORES["border_card"], highlightthickness=1)
            bl.config(bg=CORES["bg_box"])
            ll.config(bg=CORES["bg_box"], fg=CORES["text_muted"])
            lt.config(bg=CORES["bg_card"], fg=CORES["text_secondary"], font=("Segoe UI", 10))
            ic.config(text="", bg=CORES["bg_card"])

        # Destaca o card selecionado com #26bbff
        card_frame.config(bg=CORES["bg_card_sel"], highlightbackground=CORES["accent"], highlightthickness=2)
        box_letra.config(bg=CORES["accent"])
        label_letra.config(bg=CORES["accent"], fg="#0a0b0e")
        label_texto.config(bg=CORES["bg_card_sel"], fg="#ffffff", font=("Segoe UI", 10, "bold"))
        icone_check.config(text="✓", fg=CORES["accent"], bg=CORES["bg_card_sel"])

    letras = "ABCDE"
    for i, op in enumerate(opcoes):
        letra = letras[i] if i < len(letras) else str(i + 1)
        val = op["Valor"]
        desc = op["Descricao"]

        card = tk.Frame(
            opcoes_frame,
            bg=CORES["bg_card"],
            cursor="hand2",
            highlightbackground=CORES["border_card"],
            highlightthickness=1,
        )
        card.pack(fill="x", pady=5, ipady=4)

        inner = tk.Frame(card, bg=CORES["bg_card"])
        inner.pack(fill="x", padx=10, pady=4)

        # Quadrado da letra (vira #26bbff ao selecionar)
        box_letra = tk.Frame(inner, bg=CORES["bg_box"], width=34, height=34)
        box_letra.pack(side="left", padx=(0, 14))
        box_letra.pack_propagate(False)

        lbl_letra = tk.Label(
            box_letra,
            text=letra,
            bg=CORES["bg_box"],
            fg=CORES["text_muted"],
            font=("Segoe UI", 10, "bold"),
        )
        lbl_letra.place(relx=0.5, rely=0.5, anchor="center")

        # Texto da opção
        lbl_texto = tk.Label(
            inner,
            text=desc,
            bg=CORES["bg_card"],
            fg=CORES["text_secondary"],
            font=("Segoe UI", 10),
            anchor="w",
            justify="left",
        )
        lbl_texto.pack(side="left", fill="x", expand=True)

        # Ícone de checkmark à direita
        lbl_check = tk.Label(
            inner,
            text="",
            bg=CORES["bg_card"],
            fg=CORES["accent"],
            font=("Segoe UI", 12, "bold"),
            width=3,
        )
        lbl_check.pack(side="right", padx=(4, 8))

        card_opcoes.append((card, box_letra, lbl_letra, lbl_texto, lbl_check, val))

        # Clique
        for widget in [card, inner, box_letra, lbl_letra, lbl_texto, lbl_check]:
            widget.bind(
                "<Button-1>",
                lambda e, v=val, c=card, bl=box_letra, ll=lbl_letra, lt=lbl_texto, ic=lbl_check:
                selecionar(v, c, bl, ll, lt, ic)
            )

        # Hover
        def on_enter(e, c=card, lt=lbl_texto, v=val, ic=lbl_check):
            if opcao_var.get() != v:
                c.config(bg="#161822")
                lt.config(bg="#161822")
                ic.config(bg="#161822")

        def on_leave(e, c=card, lt=lbl_texto, v=val, ic=lbl_check):
            if opcao_var.get() != v:
                c.config(bg=CORES["bg_card"])
                lt.config(bg=CORES["bg_card"])
                ic.config(bg=CORES["bg_card"])

        for widget in [card, inner, box_letra, lbl_letra, lbl_texto, lbl_check]:
            widget.bind("<Enter>", on_enter)
            widget.bind("<Leave>", on_leave)

    # 4. Mensagem de validação
    msg_var = tk.StringVar(value="")
    lbl_msg = tk.Label(
        wrapper,
        textvariable=msg_var,
        bg=CORES["bg_dark"],
        fg=CORES["warning"],
        font=("Segoe UI", 9),
    )
    lbl_msg.pack(pady=(6, 0))

    # Mapeamento de atributos
    ATRIBUTOS = {
        1: "tema", 2: "verbo_status", 3: "intencao_aluno",
        4: "ordem_gravacao", 5: "abordagem_erros",
        6: "texto_slides", 7: "visual_slides",
        8: "camera_tipo", 9: "ambiente_luz",
        10: "microfone_tipo", 11: "sistema_op", 12: "perfil_edicao",
    }
    atributo = ATRIBUTOS.get(num_pergunta, f"q{num_pergunta}")

    # ── 5. Rodapé de Navegação (Separador + Botões Voltar e Próxima) ──
    nav_box = tk.Frame(wrapper, bg=CORES["bg_dark"])
    nav_box.pack(fill="x", side="bottom", pady=(16, 0))

    criar_separador(nav_box, cor=CORES["border"], pady=(0, 16))

    linha_botoes = tk.Frame(nav_box, bg=CORES["bg_dark"])
    linha_botoes.pack(fill="x")

    def avancar():
        escolha = opcao_var.get()
        if escolha == 0:
            msg_var.set("⚠  Selecione uma opção para continuar.")
            return
        msg_var.set("")
        prolog.assertz(f"fato({atributo}, {escolha})")

        if num_pergunta < TOTAL_PERGUNTAS:
            mostrar_pergunta(num_pergunta + 1)
        else:
            mostrar_resultado()

    if num_pergunta > 1:
        btn_voltar = tk.Button(
            linha_botoes,
            text="<  VOLTAR",
            bg=CORES["bg_card"],
            fg=CORES["text_muted"],
            font=("Segoe UI", 9, "bold"),
            relief="solid",
            bd=1,
            highlightbackground=CORES["border_card"],
            padx=18,
            pady=8,
            cursor="hand2",
            command=lambda: voltar_pergunta(num_pergunta),
        )
        btn_voltar.pack(side="left")
        animar_hover(btn_voltar, CORES["bg_card"], CORES["bg_card2"])

    label_btn = "PRÓXIMA  >" if num_pergunta < TOTAL_PERGUNTAS else "FINALIZAR  ✓"
    btn_avancar = tk.Button(
        linha_botoes,
        text=label_btn,
        bg=CORES["accent"],
        fg="#0a0b0e",
        font=("Segoe UI", 10, "bold"),
        relief="flat",
        bd=0,
        padx=26,
        pady=8,
        cursor="hand2",
        command=avancar,
    )
    btn_avancar.pack(side="right")
    animar_hover(btn_avancar, CORES["accent"], CORES["accent_hover"])


def voltar_pergunta(num_atual):
    # Retira o fato registrado da pergunta atual para não duplicar
    ATRIBUTOS = {
        1: "tema", 2: "verbo_status", 3: "intencao_aluno",
        4: "ordem_gravacao", 5: "abordagem_erros",
        6: "texto_slides", 7: "visual_slides",
        8: "camera_tipo", 9: "ambiente_luz",
        10: "microfone_tipo", 11: "sistema_op", 12: "perfil_edicao",
    }
    atributo = ATRIBUTOS.get(num_atual - 1, f"q{num_atual - 1}")
    list(prolog.query(f"retractall(fato({atributo}, _))"))
    mostrar_pergunta(num_atual - 1)


# ─── Tela de resultado ────────────────────────────────────────────────────────

def mostrar_resultado():
    limpar_frame(frame_cabecalho)
    limpar_frame(frame_conteudo)

    # Cabeçalho
    cabecalho = tk.Frame(frame_cabecalho, bg=CORES["bg_dark"], pady=16)
    cabecalho.pack(fill="x", padx=32)

    tk.Label(cabecalho, text="✓  Diagnóstico Concluído",
             bg=CORES["bg_dark"], fg=CORES["success"],
             font=("Segoe UI", 11, "bold")).pack(side="left")

    btn_reiniciar = tk.Button(
        cabecalho,
        text="⟳  Novo Diagnóstico",
        bg=CORES["bg_card"],
        fg=CORES["text_secondary"],
        font=("Segoe UI", 9),
        relief="flat", bd=0,
        padx=12, pady=6,
        cursor="hand2",
        command=reiniciar,
    )
    btn_reiniciar.pack(side="right")
    animar_hover(btn_reiniciar, CORES["bg_card"], CORES["bg_card2"])

    criar_separador(frame_cabecalho, pady=0)

    # Scroll para o resultado
    canvas = tk.Canvas(frame_conteudo, bg=CORES["bg_dark"], highlightthickness=0)
    scrollbar = ttk.Scrollbar(frame_conteudo, orient="vertical", command=canvas.yview)
    scroll_frame = tk.Frame(canvas, bg=CORES["bg_dark"])

    scroll_frame.bind(
        "<Configure>",
        lambda e: canvas.configure(scrollregion=canvas.bbox("all"))
    )

    canvas.create_window((0, 0), window=scroll_frame, anchor="nw")
    canvas.configure(yscrollcommand=scrollbar.set)

    canvas.pack(side="left", fill="both", expand=True)
    scrollbar.pack(side="right", fill="y")

    # Scroll com mousewheel
    def _on_mousewheel(event):
        canvas.yview_scroll(int(-1 * (event.delta / 120)), "units")
    canvas.bind_all("<MouseWheel>", _on_mousewheel)

    pad = tk.Frame(scroll_frame, bg=CORES["bg_dark"])
    pad.pack(fill="x", padx=40, pady=20)

    def secao(titulo, icone=""):
        f = tk.Frame(pad, bg=CORES["bg_dark"])
        f.pack(fill="x", pady=(16, 4))
        tk.Label(f, text=f"{icone}  {titulo}",
                 bg=CORES["bg_dark"], fg=CORES["accent"],
                 font=("Segoe UI", 10, "bold"), anchor="w").pack(fill="x")
        tk.Frame(pad, height=1, bg=CORES["accent_dim"]).pack(fill="x", pady=(0, 8))
        return f

    def item(texto, destaque=False):
        cor = CORES["text_primary"] if destaque else CORES["text_secondary"]
        tk.Label(pad, text=texto, bg=CORES["bg_dark"], fg=cor,
                 font=("Segoe UI", 9),
                 wraplength=640, justify="left", anchor="w",
                 padx=12).pack(fill="x", pady=1)

    def item_status(texto):
        """Exibe item com cor baseada no conteúdo (APROVADO/ALERTA/REPROVADO/etc)."""
        cor = CORES["text_secondary"]
        if "APROVADO" in texto or "EXCELENTE" in texto or "OTIMA" in texto or "BOM" in texto:
            cor = CORES["success"]
        elif "ALERTA" in texto or "RECOMENDACAO" in texto or "AJUSTE" in texto:
            cor = CORES["warning"]
        elif "REPROVADO" in texto or "CRITICO" in texto or "ERRO GRAVE" in texto:
            cor = "#e05252"
        tk.Label(pad, text=f"  {texto}", bg=CORES["bg_dark"], fg=cor,
                 font=("Segoe UI", 9),
                 wraplength=640, justify="left", anchor="w",
                 padx=12).pack(fill="x", pady=2)

    # ── Consultas Prolog ──
    def q(consulta):
        try:
            r = list(prolog.query(consulta))
            return r[0] if r else {}
        except Exception:
            return {}

    # Seção 1
    secao("1. Definição Estratégica e Learning Outcome", "🎯")
    res_fmt = q("definir_formato(Formato, Duracao, Desc)")
    if res_fmt:
        item(f"Formato da aula:  {res_fmt['Formato']}", destaque=True)
        item(f"Duração recomendada:  {res_fmt['Duracao']}")
        item(f"Diretriz:  {res_fmt['Desc']}")

    res_verbo = q("auditar_verbo(Status)")
    if res_verbo:
        item_status(res_verbo["Status"])

    res_outcome = q("sugerir_outcome(Exemplo)")
    if res_outcome:
        item(f"💡 Sugestão de Learning Outcome:  {res_outcome['Exemplo']}")

    # Seção 2 — Tabela de Segmentos
    secao("2. Tabela de Planejamento de Conteúdo (5 Colunas Epic)", "📋")
    res_tabela = q("gerar_tabela_segmentos(Linhas)")
    if res_tabela:
        for linha in res_tabela.get("Linhas", []):
            item(f"▸  {linha}")

    # Seção 3 — Roteiro e Didática
    secao("3. Diagnóstico de Roteiro, Didática e Slides", "✏️")
    res_seq = q("avaliar_sequencia_gravacao(Aval)")
    if res_seq:
        item_status(res_seq["Aval"])

    res_erros = q("avaliar_didatica_erros(Aval)")
    if res_erros:
        item_status(res_erros["Aval"])

    res_slides = q("avaliar_slides(Aval)")
    if res_slides:
        item_status(res_slides["Aval"])

    item('Técnica de Ênfase Verbal: Use palavras-gatilho ("Importante", '
         '"Ponto-chave", "Vital") antes de mostrar uma diferença na tela.')

    # Seção 4 — Equipamento
    secao("4. Prescrição de Equipamento, Ambiente e Software", "🎙️")
    res_cam = q("avaliar_camera_luz(Aval)")
    if res_cam:
        item_status(res_cam["Aval"])

    res_audio = q("avaliar_audio(Aval)")
    if res_audio:
        item_status(res_audio["Aval"])

    res_soft = q("recomendar_stack_software(Stack)")
    if res_soft:
        item(f"Stack recomendado:  {res_soft['Stack']}", destaque=True)

    # Seção 5 — Checklist
    secao("5. Checklist Operacional Obrigatório", "✅")
    checklist = [
        ("[PRÉ] Diminuir a janela da Unreal Engine para menus/textos legíveis no vídeo."),
        ("[PRÉ] Fechar programas pesados em 2º plano e desativar notificações pop-up."),
        ("[PRÉ] Colocar slides em Tela Cheia e checar todas as inputs no gravador."),
        ("[DURANTE] Falar mais devagar e adicionar 0,5 s extra de pausa entre segmentos."),
        ("[DURANTE] Se errar, fazer silêncio por alguns segundos antes de repetir a fala."),
        ("[DURANTE] Falar em voz alta para a câmera lembretes de edição e anotar num arquivo paralelo."),
        ("[PÓS] Assistir pelo menos 1 minuto do vídeo para checar áudio e legibilidade."),
        ("[PÓS] Exportar na qualidade máxima e nomear: Data_Módulo_Assunto (ex: Nov15_M1_Blueprints)."),
    ]
    for c in checklist:
        item(f"☐  {c}")

    tk.Frame(pad, height=24, bg=CORES["bg_dark"]).pack()


# ─── Fluxo de controle ────────────────────────────────────────────────────────

def iniciar_questionario():
    list(prolog.query("retractall(fato(_, _))"))
    mostrar_pergunta(1)


def reiniciar():
    list(prolog.query("retractall(fato(_, _))"))
    limpar_frame(frame_cabecalho)
    mostrar_tela_inicial()


# ─── Janela principal ─────────────────────────────────────────────────────────

janela = tk.Tk()
janela.title("UAI · Unreal Authorized Instructor")
janela.geometry("880x660")
janela.minsize(820, 600)
janela.configure(bg=CORES["bg_dark"])

# Estilo ttk para scrollbar
style = ttk.Style()
style.theme_use("clam")
style.configure("Vertical.TScrollbar",
                background=CORES["bg_card2"],
                troughcolor=CORES["bg_dark"],
                arrowcolor=CORES["text_muted"],
                bordercolor=CORES["bg_dark"],
                lightcolor=CORES["bg_card2"],
                darkcolor=CORES["bg_card2"])

# ── Barra de título customizada ──
barra_titulo = tk.Frame(janela, bg=CORES["accent_dim"], height=4)
barra_titulo.pack(fill="x", side="top")

# ── Frame do cabeçalho (barra de etapas, etc.) ──
frame_cabecalho = tk.Frame(janela, bg=CORES["bg_dark"])
frame_cabecalho.pack(fill="x", side="top")

# ── Frame de conteúdo principal ──
frame_conteudo = tk.Frame(janela, bg=CORES["bg_dark"])
frame_conteudo.pack(fill="both", expand=True, side="top")

# ── Rodapé ──
rodape = tk.Frame(janela, bg=CORES["bg_card"], height=28)
rodape.pack(fill="x", side="bottom")
rodape.pack_propagate(False)
tk.Label(
    rodape,
    text="SE UAI  ·  Sistema Especialista para Instrutores Unreal Academy",
    bg=CORES["bg_card"],
    fg=CORES["text_muted"],
    font=("Segoe UI", 7),
).pack(side="left", padx=12)

# ── Inicia na tela inicial ──
mostrar_tela_inicial()

janela.mainloop()
