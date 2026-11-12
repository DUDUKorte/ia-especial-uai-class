from pathlib import Path
import tkinter as tk
from pyswip import Prolog


caminho_pl = Path(__file__).parent / "regras.pl"

prolog = Prolog()
prolog.consult(caminho_pl.as_posix())




def consultar_especialista():
  escolha = opcao_usuario.get()

  # limpa os fatos anteriores
  list(prolog.query("retractall(fato(_, _))"))

  # insere o fato
  prolog.assertz(f"fato(intencao, {escolha})")
  prolog.assertz(f"fato(intencao_aluno, {escolha})")

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



def perguntar(num_pergunta):
    consulta = list(
        prolog.query(f"pergunta({num_pergunta}, Atributo, Texto)")
    )

    if not consulta:
        return

    c = consulta[0]

    texto_pergunta = c["Texto"]
    atributo = c["Atributo"]

    tk.Label(
        janela,
        text=texto_pergunta,
        font=("Arial", 11, "bold")
    ).pack(pady=5)

    opcoes = list(
        prolog.query(f"opcao({num_pergunta}, Valor, Descricao)")
    )

    opcao_usuario = tk.IntVar(value=0)
    for op in opcoes:
        tk.Radiobutton(
            janela,
            text=f"{op['Valor']} - {op['Descricao']}",
            variable=opcao_usuario,
            value=op["Valor"]
        ).pack(anchor="w", padx=80)

    tk.Button(
        janela,
        text="Registrar resposta",
        command=lambda: registrar_resposta(atributo, opcao_usuario)
    ).pack(pady=10)


def registrar_resposta(atributo, opcao_usuario):
    escolha = opcao_usuario.get()

    if escolha == 0:
        print("Selecione uma opção!") # transformar em uma mensagem na tela!!
        return

    prolog.assertz(f"fato({atributo}, {escolha})")

    print(list(prolog.query("fato(Atributo, Valor)")))


# Interface
janela = tk.Tk()
janela.title("SE UAI")
janela.geometry("600x400")

# limpa os fatos anteriores
list(prolog.query("retractall(fato(_, _))"))
perguntar(1)

janela.mainloop()

