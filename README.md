# Sistema Especialista: Planejamento e Auditoria de Aulas (UAI)

---

## 1. Pré-requisitos

Antes de executar ou compilar o projeto, certifique-se de instalar as duas ferramentas abaixo na máquina:

1. **SWI-Prolog (Obrigatório):**
   - Download oficial: [https://www.swi-prolog.org/download/stable](https://www.swi-prolog.org/download/stable)
   - **IMPORTANTE:** Durante a instalação no Windows, marque a opção **"Add swipl to the system PATH for all users"** (ou para o usuário atual) para que a biblioteca `pyswip` consiga localizar o motor do Prolog automaticamente.

2. **Python (3.10 ou superior):**
   - Download oficial: [https://www.python.org/downloads/](https://www.python.org/downloads/)
   - Marque a opção **"Add Python to PATH"** no instalador.

---

## 2. Como executar o projeto pelo Código-Fonte

Abra o terminal na pasta raiz do projeto e siga os passos abaixo:

### Passo 1: Criar o ambiente virtual (`.venv`)
```bash
python -m venv .venv
```

### Passo 2: Ativar o ambiente virtual
No Windows:
```bash
.venv\Scripts\activate
```

### Passo 3: Instalar as dependências do projeto
```bash
pip install -r requirements.txt
```

### Passo 4: Executar a aplicação
```bash
python main.py
```

---

## 3. Como gerar o executável (`.exe`) com PyInstaller

Caso deseje compilar o projeto novamente em um arquivo executável independente:

### Passo 1: Instalar o PyInstaller (dentro da `.venv` ativada)
```bash
pip install pyinstaller
```

### Passo 2: Gerar a build do executável
Execute o comando abaixo no terminal:
```bash
pyinstaller --noconsole --onefile --add-data "regras.pl;." main.py
```

### Passo 3: Localizar o executável gerado
- O arquivo `main.exe` será criado dentro da pasta **`dist/`**.
