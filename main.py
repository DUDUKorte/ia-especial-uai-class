from pathlib import Path
import tkinter as tk
from tkinter import ttk
from pyswip import Prolog

# Conexão com a base de conhecimento Prolog
prolog = Prolog()
prolog.consult((Path(__file__).parent / "regras.pl").as_posix())

CORES = {
    "bg":          "#0a0b0e",
    "card":        "#121319",
    "card_sel":    "#0d1824",
    "card_hover":  "#161822",
    "box_letra":   "#1d1f28",
    "border":      "#1e202a",
    "border_card": "#222430",
    "accent":      "#26bbff",
    "text":        "#ffffff",
    "text_dim":    "#9fa5b8",
    "text_muted":  "#686d80",
    "success":     "#10b981",
    "warning":     "#f5a623",
    "danger":      "#ef4444",
}

ATRIBUTOS = (
    "tema", "verbo_status", "intencao_aluno",
    "ordem_gravacao", "abordagem_erros",
    "texto_slides", "visual_slides",
    "camera_tipo", "ambiente_luz",
    "microfone_tipo", "sistema_op", "perfil_edicao",
)
TOTAL_PERGUNTAS = len(ATRIBUTOS)


def limpar(container):
    for w in container.winfo_children():
        w.destroy()


def desenhar_stepper(parent, etapa_atual):
    container = tk.Frame(parent, bg=CORES["bg"])
    container.pack(fill="x", padx=48, pady=(16, 12))

    linha_stepper = tk.Frame(container, bg=CORES["bg"])
    linha_stepper.pack(fill="x")

    for i in range(1, 6):
        col = tk.Frame(linha_stepper, bg=CORES["bg"])
        col.pack(side="left", expand=True, fill="x")

        row = tk.Frame(col, bg=CORES["bg"])
        row.pack(fill="x")

        # Conector esquerdo
        cor_esq = CORES["accent"] if i <= etapa_atual else (CORES["border"] if i > 1 else CORES["bg"])
        tk.Frame(row, height=2, bg=cor_esq).pack(side="left", expand=True, fill="x", pady=12)

        # Círculo com o número da etapa
        ativo = (i == etapa_atual)
        concluido = (i < etapa_atual)
        c_bg = CORES["accent"] if ativo else ("#1b2735" if concluido else "#171821")
        c_fg = "#ffffff" if ativo else (CORES["accent"] if concluido else "#686d80")

        lbl = tk.Label(
            row, text=str(i), bg=c_bg, fg=c_fg,
            font=("Segoe UI", 9, "bold"), width=3, height=1,
            relief="solid", bd=1, highlightbackground=CORES["accent"] if ativo else "#252733",
            padx=2, pady=3,
        )
        lbl.pack(side="left")

        # Conector direito
        cor_dir = CORES["accent"] if i < etapa_atual else (CORES["border"] if i < 5 else CORES["bg"])
        tk.Frame(row, height=2, bg=cor_dir).pack(side="left", expand=True, fill="x", pady=12)


def mostrar_tela_inicial():
    limpar(frame_cabecalho)
    limpar(frame_conteudo)

    centro = tk.Frame(frame_conteudo, bg=CORES["bg"])
    centro.place(relx=0.5, rely=0.5, anchor="center")

    # Título principal
    linha_tit = tk.Frame(centro, bg=CORES["bg"])
    linha_tit.pack(pady=(0, 2))
    tk.Label(linha_tit, text="AUDITORIA ", bg=CORES["bg"], fg="#ffffff", font=("Segoe UI", 32, "bold")).pack(side="left")
    tk.Label(linha_tit, text="PEDAGÓGICA", bg=CORES["bg"], fg=CORES["accent"], font=("Segoe UI", 32, "bold")).pack(side="left")

    tk.Label(centro, text="E PLANEJAMENTO DE AULAS", bg=CORES["bg"], fg="#e0e3ed", font=("Segoe UI", 18, "bold")).pack(pady=(0, 14))
    tk.Label(
        centro,
        text="Sistema especialista para validação de escopo, infraestrutura técnica e aderência\naos padrões recomendados pela Epic Games.",
        bg=CORES["bg"], fg=CORES["text_dim"], font=("Segoe UI", 10), justify="center",
    ).pack(pady=(0, 28))

    # Cards horizontais dos módulos
    cards_frame = tk.Frame(centro, bg=CORES["bg"])
    cards_frame.pack(pady=(0, 32))

    modulos = [
        ("🎯", "01", "ESCOPO\nPEDAGÓGICO"),
        ("▶",  "02", "ROTEIRIZAÇÃO\nDIDÁTICA"),
        ("🗂", "03", "DESIGN DE APOIO\nVISUAL"),
        ("🎙", "04", "INFRAESTRUTURA"),
        ("⚙",  "05", "PÓS-PRODUÇÃO"),
    ]

    for icone, num, nome in modulos:
        card = tk.Frame(cards_frame, bg=CORES["card"], highlightbackground=CORES["border_card"], highlightthickness=1, width=135, height=100)
        card.pack(side="left", padx=5)
        card.pack_propagate(False)

        topo = tk.Frame(card, bg=CORES["card"])
        topo.pack(fill="x", padx=10, pady=(10, 0))
        tk.Label(topo, text=icone, bg=CORES["card"], fg=CORES["accent"], font=("Segoe UI", 13, "bold")).pack(side="left")
        tk.Label(topo, text=num, bg=CORES["card"], fg="#222532", font=("Segoe UI", 16, "bold")).pack(side="right")

        tk.Label(card, text=nome, bg=CORES["card"], fg="#ffffff", font=("Segoe UI", 7, "bold"), justify="left").pack(side="bottom", fill="x", padx=10, pady=(0, 10))

    btn = tk.Button(
        centro, text="INICIAR AUDITORIA TÉCNICA  >",
        bg=CORES["accent"], fg="#0a0b0e", font=("Segoe UI", 10, "bold"),
        relief="flat", bd=0, padx=32, pady=11, cursor="hand2",
        command=lambda: [list(prolog.query("retractall(fato(_, _))")), mostrar_pergunta(1)],
    )
    btn.pack()


def mostrar_pergunta(num):
    limpar(frame_cabecalho)
    limpar(frame_conteudo)

    consulta = list(prolog.query(f"pergunta({num}, Etapa, Texto)"))
    if not consulta:
        return

    pergunta = consulta[0]
    etapa = pergunta["Etapa"]
    texto = pergunta["Texto"]
    opcoes = list(prolog.query(f"opcao({num}, Valor, Descricao)"))
    atributo = ATRIBUTOS[num - 1]

    # Stepper e separador
    desenhar_stepper(frame_cabecalho, etapa)
    tk.Frame(frame_cabecalho, height=1, bg=CORES["border"]).pack(fill="x", pady=(0, 6))

    wrapper = tk.Frame(frame_conteudo, bg=CORES["bg"])
    wrapper.pack(expand=True, fill="both", padx=64, pady=10)

    tk.Label(wrapper, text=texto, bg=CORES["bg"], fg="#ffffff", font=("Segoe UI", 18, "bold"), wraplength=720, justify="left", anchor="w").pack(fill="x", pady=(8, 20))

    opcao_var = tk.IntVar(value=0)
    cards_ui = []

    opcoes_box = tk.Frame(wrapper, bg=CORES["bg"])
    opcoes_box.pack(fill="x")

    def selecionar(val, c_card, c_box, c_letra, c_texto, c_check):
        opcao_var.set(val)
        for card, box, lbl_l, lbl_t, lbl_c, _ in cards_ui:
            card.config(bg=CORES["card"], highlightbackground=CORES["border_card"], highlightthickness=1)
            box.config(bg=CORES["box_letra"])
            lbl_l.config(bg=CORES["box_letra"], fg=CORES["text_muted"])
            lbl_t.config(bg=CORES["card"], fg=CORES["text_dim"], font=("Segoe UI", 10))
            lbl_c.config(text="", bg=CORES["card"])

        c_card.config(bg=CORES["card_sel"], highlightbackground=CORES["accent"], highlightthickness=2)
        c_box.config(bg=CORES["accent"])
        c_letra.config(bg=CORES["accent"], fg="#0a0b0e")
        c_texto.config(bg=CORES["card_sel"], fg="#ffffff", font=("Segoe UI", 10, "bold"))
        c_check.config(text="✓", fg=CORES["accent"], bg=CORES["card_sel"])

    letras = "ABCDE"
    for i, op in enumerate(opcoes):
        letra = letras[i] if i < len(letras) else str(i + 1)
        val = op["Valor"]
        desc = op["Descricao"]

        card = tk.Frame(opcoes_box, bg=CORES["card"], cursor="hand2", highlightbackground=CORES["border_card"], highlightthickness=1)
        card.pack(fill="x", pady=5, ipady=4)

        inner = tk.Frame(card, bg=CORES["card"])
        inner.pack(fill="x", padx=10, pady=4)

        box = tk.Frame(inner, bg=CORES["box_letra"], width=34, height=34)
        box.pack(side="left", padx=(0, 14))
        box.pack_propagate(False)

        lbl_letra = tk.Label(box, text=letra, bg=CORES["box_letra"], fg=CORES["text_muted"], font=("Segoe UI", 10, "bold"))
        lbl_letra.place(relx=0.5, rely=0.5, anchor="center")

        lbl_desc = tk.Label(inner, text=desc, bg=CORES["card"], fg=CORES["text_dim"], font=("Segoe UI", 10), anchor="w")
        lbl_desc.pack(side="left", fill="x", expand=True)

        lbl_chk = tk.Label(inner, text="", bg=CORES["card"], fg=CORES["accent"], font=("Segoe UI", 12, "bold"), width=3)
        lbl_chk.pack(side="right", padx=(4, 8))

        cards_ui.append((card, box, lbl_letra, lbl_desc, lbl_chk, val))

        for w in (card, inner, box, lbl_letra, lbl_desc, lbl_chk):
            w.bind("<Button-1>", lambda e, v=val, c=card, b=box, l=lbl_letra, t=lbl_desc, k=lbl_chk: selecionar(v, c, b, l, t, k))

    msg_var = tk.StringVar(value="")
    tk.Label(wrapper, textvariable=msg_var, bg=CORES["bg"], fg=CORES["warning"], font=("Segoe UI", 9)).pack(pady=(6, 0))

    # Rodapé de navegação
    nav = tk.Frame(wrapper, bg=CORES["bg"])
    nav.pack(fill="x", side="bottom", pady=(16, 0))
    tk.Frame(nav, height=1, bg=CORES["border"]).pack(fill="x", pady=(0, 16))

    botoes = tk.Frame(nav, bg=CORES["bg"])
    botoes.pack(fill="x")

    def avancar():
        escolha = opcao_var.get()
        if escolha == 0:
            msg_var.set("⚠  Selecione uma opção para continuar.")
            return
        prolog.assertz(f"fato({atributo}, {escolha})")
        if num < TOTAL_PERGUNTAS:
            mostrar_pergunta(num + 1)
        else:
            mostrar_resultado()

    def voltar():
        list(prolog.query(f"retractall(fato({ATRIBUTOS[num - 2]}, _))"))
        mostrar_pergunta(num - 1)

    if num > 1:
        tk.Button(
            botoes, text="<  VOLTAR", bg=CORES["card"], fg=CORES["text_muted"],
            font=("Segoe UI", 9, "bold"), relief="solid", bd=1, highlightbackground=CORES["border_card"],
            padx=18, pady=8, cursor="hand2", command=voltar,
        ).pack(side="left")

    tk.Button(
        botoes, text="PRÓXIMA  >" if num < TOTAL_PERGUNTAS else "FINALIZAR  ✓",
        bg=CORES["accent"], fg="#0a0b0e", font=("Segoe UI", 10, "bold"),
        relief="flat", bd=0, padx=26, pady=8, cursor="hand2", command=avancar,
    ).pack(side="right")


def mostrar_resultado():
    limpar(frame_cabecalho)
    limpar(frame_conteudo)

    top = tk.Frame(frame_cabecalho, bg=CORES["bg"], pady=16)
    top.pack(fill="x", padx=32)

    tk.Label(top, text="✓  Diagnóstico Concluído", bg=CORES["bg"], fg=CORES["success"], font=("Segoe UI", 11, "bold")).pack(side="left")
    tk.Button(
        top, text="⟳  Novo Diagnóstico", bg=CORES["card"], fg=CORES["text_dim"],
        font=("Segoe UI", 9), relief="flat", bd=0, padx=12, pady=6, cursor="hand2",
        command=lambda: [list(prolog.query("retractall(fato(_, _))")), mostrar_tela_inicial()],
    ).pack(side="right")

    tk.Frame(frame_cabecalho, height=1, bg=CORES["border"]).pack(fill="x")

    canvas = tk.Canvas(frame_conteudo, bg=CORES["bg"], highlightthickness=0)
    scrollbar = ttk.Scrollbar(frame_conteudo, orient="vertical", command=canvas.yview)
    scroll_frame = tk.Frame(canvas, bg=CORES["bg"])

    scroll_frame.bind("<Configure>", lambda e: canvas.configure(scrollregion=canvas.bbox("all")))
    canvas.create_window((0, 0), window=scroll_frame, anchor="nw")
    canvas.configure(yscrollcommand=scrollbar.set)
    canvas.pack(side="left", fill="both", expand=True)
    scrollbar.pack(side="right", fill="y")
    canvas.bind_all("<MouseWheel>", lambda e: canvas.yview_scroll(int(-1 * (e.delta / 120)), "units"))

    pad = tk.Frame(scroll_frame, bg=CORES["bg"])
    pad.pack(fill="x", padx=40, pady=20)

    def secao(titulo, icone=""):
        f = tk.Frame(pad, bg=CORES["bg"])
        f.pack(fill="x", pady=(16, 4))
        tk.Label(f, text=f"{icone}  {titulo}", bg=CORES["bg"], fg=CORES["accent"], font=("Segoe UI", 10, "bold"), anchor="w").pack(fill="x")
        tk.Frame(pad, height=1, bg="#127ba8").pack(fill="x", pady=(0, 8))

    def item(texto, destaque=False):
        tk.Label(pad, text=texto, bg=CORES["bg"], fg=CORES["text"] if destaque else CORES["text_dim"], font=("Segoe UI", 9), wraplength=700, justify="left", anchor="w", padx=12).pack(fill="x", pady=1)

    def item_status(texto):
        cor = CORES["text_dim"]
        if any(w in texto for w in ("APROVADO", "EXCELENTE", "OTIMA", "BOM")):
            cor = CORES["success"]
        elif any(w in texto for w in ("ALERTA", "RECOMENDACAO", "AJUSTE")):
            cor = CORES["warning"]
        elif any(w in texto for w in ("REPROVADO", "CRITICO", "ERRO GRAVE")):
            cor = CORES["danger"]
        tk.Label(pad, text=f"  {texto}", bg=CORES["bg"], fg=cor, font=("Segoe UI", 9), wraplength=700, justify="left", anchor="w", padx=12).pack(fill="x", pady=2)

    def q(consulta):
        try:
            r = list(prolog.query(consulta))
            return r[0] if r else {}
        except Exception:
            return {}

    # Seção 1: Formato e Objetivos
    secao("1. Definição Estratégica e Learning Outcome", "🎯")
    fmt = q("definir_formato(Formato, Duracao, Desc)")
    if fmt:
        item(f"Formato da aula:  {fmt['Formato']}", destaque=True)
        item(f"Duração recomendada:  {fmt['Duracao']}")
        item(f"Diretriz:  {fmt['Desc']}")

    verbo = q("auditar_verbo(Status)")
    if verbo:
        item_status(verbo["Status"])

    outcome = q("sugerir_outcome(Exemplo)")
    if outcome:
        item(f"💡 Sugestão de Learning Outcome:  {outcome['Exemplo']}")

    # Seção 2: Tabela de 5 Colunas
    secao("2. Tabela de Planejamento de Conteúdo (5 Colunas Epic)", "📋")
    tabela = q("gerar_tabela_segmentos(Linhas)")
    if tabela:
        for linha in tabela.get("Linhas", []):
            item(f"▸  {linha}")

    # Seção 3: Roteiro e Slides
    secao("3. Diagnóstico de Roteiro, Didática e Slides", "✏️")
    seq = q("avaliar_sequencia_gravacao(Aval)")
    if seq:
        item_status(seq["Aval"])

    erros = q("avaliar_didatica_erros(Aval)")
    if erros:
        item_status(erros["Aval"])

    slides = q("avaliar_slides(Aval)")
    if slides:
        item_status(slides["Aval"])

    item('Técnica de Ênfase Verbal: Use palavras-gatilho ("Importante", "Ponto-chave", "Vital") antes de mostrar uma diferença na tela.')

    # Seção 4: Hardware e Software
    secao("4. Prescrição de Equipamento, Ambiente e Software", "🎙️")
    cam = q("avaliar_camera_luz(Aval)")
    if cam:
        item_status(cam["Aval"])

    aud = q("avaliar_audio(Aval)")
    if aud:
        item_status(aud["Aval"])

    soft = q("recomendar_stack_software(Stack)")
    if soft:
        item(f"Stack recomendado:  {soft['Stack']}", destaque=True)

    # Seção 5: Checklist
    secao("5. Checklist Operacional Obrigatório", "✅")
    checklist = [
        "[PRÉ] Diminuir a janela da Unreal Engine para menus/textos legíveis no vídeo.",
        "[PRÉ] Fechar programas pesados em 2º plano e desativar notificações pop-up.",
        "[PRÉ] Colocar slides em Tela Cheia e checar todas as inputs no gravador.",
        "[DURANTE] Falar mais devagar e adicionar 0,5 s extra de pausa entre segmentos.",
        "[DURANTE] Se errar, fazer silêncio por alguns segundos antes de repetir a fala.",
        "[DURANTE] Falar em voz alta para a câmera lembretes de edição e anotar num arquivo paralelo.",
        "[PÓS] Assistir pelo menos 1 minuto do vídeo para checar áudio e legibilidade.",
        "[PÓS] Exportar na qualidade máxima e nomear: Data_Módulo_Assunto (ex: Nov15_M1_Blueprints).",
    ]
    for c in checklist:
        item(f"☐  {c}")

    tk.Frame(pad, height=24, bg=CORES["bg"]).pack()


# Janela principal
janela = tk.Tk()
janela.title("UAI · Unreal Authorized Instructor")
janela.geometry("880x660")
janela.minsize(820, 600)
janela.configure(bg=CORES["bg"])

style = ttk.Style()
style.theme_use("clam")
style.configure("Vertical.TScrollbar", background="#171922", troughcolor=CORES["bg"], bordercolor=CORES["bg"])

frame_cabecalho = tk.Frame(janela, bg=CORES["bg"])
frame_cabecalho.pack(fill="x", side="top")

frame_conteudo = tk.Frame(janela, bg=CORES["bg"])
frame_conteudo.pack(fill="both", expand=True, side="top")

rodape = tk.Frame(janela, bg=CORES["card"], height=28)
rodape.pack(fill="x", side="bottom")
rodape.pack_propagate(False)
tk.Label(rodape, text="SE UAI · Sistema Especialista para Instrutores Unreal Academy", bg=CORES["card"], fg=CORES["text_muted"], font=("Segoe UI", 7)).pack(side="left", padx=12)

mostrar_tela_inicial()
janela.mainloop()
