from pathlib import Path
import tkinter as tk
from pyswip import Prolog

# Garante que o Python ache o regras.pl na mesma pasta do main.py
caminho_pl = Path(__file__).parent / "regras.pl"

prolog = Prolog()
prolog.consult(caminho_pl.as_posix())


def consultar_especialista():
  escolha = opcao_usuario.get()

  # 1. Limpa fatos anteriores
  list(prolog.query("retractall(fato(_, _))"))

  # 2. Insere o fato (funciona tanto para o codigo pequeno quanto para o grande)
  prolog.assertz(f"fato(intencao, {escolha})")
  prolog.assertz(f"fato(intencao_aluno, {escolha})")

  # 3. Tenta consultar a regra do codigo GRANDE (definir_formato/3)
  #    Se nao existir, consulta a do codigo PEQUENO (avaliar_formato/1)
  try:
    resultado = list(prolog.query("definir_formato(Formato, Duracao, Desc)"))
    if resultado:
      r = resultado[0]
      texto = f"{r['Formato']}\nDuração: {r['Duracao']}\n{r['Desc']}"
      lbl_resultado.config(text=texto)
  except Exception:
    resultado = list(prolog.query("avaliar_formato(X)"))
    if resultado:
      lbl_resultado.config(text=resultado[0]["X"])


# --- Interface Grafica Simples (Tkinter) ---
janela = tk.Tk()
janela.title("SE UAI - Teste de Conexão")
janela.geometry("460x250")

tk.Label(
    janela, text="Qual o objetivo da sua aula?", font=("Arial", 11, "bold")
).pack(pady=5)

opcao_usuario = tk.IntVar(value=1)
tk.Radiobutton(
    janela, text="1 - Ensinar conceito teórico", variable=opcao_usuario, value=1
).pack(anchor="w", padx=80)
tk.Radiobutton(
    janela, text="2 - Mostrar meu workflow", variable=opcao_usuario, value=2
).pack(anchor="w", padx=80)
tk.Radiobutton(
    janela,
    text="3 - Prática passo a passo",
    variable=opcao_usuario,
    value=3,
).pack(anchor="w", padx=80)

tk.Button(
    janela, text="Consultar Prolog", command=consultar_especialista
).pack(pady=10)

lbl_resultado = tk.Label(
    janela,
    text="Clique no botão para gerar...",
    fg="blue",
    wraplength=420,
    justify="left",
)
lbl_resultado.pack(pady=5)

janela.mainloop()
