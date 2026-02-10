# 🔧 Finalizador de Processos Remotos – PowerShell

**Desenvolvido por Vinícius Pimentel**

Este projeto é um script em **PowerShell com interface gráfica (GUI)**, criado para auxiliar equipes de **Help Desk / Suporte Técnico** a **finalizar processos remotamente** em máquinas Windows, de forma rápida, prática e segura.

---

## 📌 Funcionalidades

✔ Buscar máquina **por nome** (prioritário)  
✔ Buscar máquina **por IP** (com aviso e suporte adicional)  
✔ Listar processos ativos da máquina remota  
✔ Finalizar processos remotamente  
✔ Atualizar lista de processos em tempo real  
✔ Interface gráfica moderna, amigável e intuitiva  
✔ Botões estilizados (hover, cursor em forma de mão, cores suaves)  
✔ Mensagens claras de erro e status  
✔ Compatível com ambientes corporativos  

---

## 🖥️ Interface

A interface foi pensada para ser **simples e funcional**, contendo apenas o essencial:

- Campo para **Nome ou IP da máquina**
- Botão para **Buscar processos**
- Lista de processos ativos
- Botão para **Finalizar processo**

---

## ⚠️ Importante sobre acesso por IP

O acesso remoto por **IP** pode exigir permissões administrativas adicionais devido a restrições do **WinRM / UAC / Políticas de Segurança**. O script prioriza o uso do **nome da máquina**.

---

## 🔐 Requisitos

- Windows 10 / 11 ou Windows Server
- PowerShell 5.1 ou superior
- Permissão administrativa na máquina de origem
- Acesso de rede à máquina de destino
- WinRM habilitado (para conexão por nome)
- SMB habilitado (Admin$ / C$)

---

## 🚀 Como usar

1. Baixe ou clone o repositório:
   ```bash
   git clone https://github.com/Ast0nish/Finalizar_Processo

2. Execute o script:

.\Finalizar_Processos.ps1

3. Informe:

- Nome ou IP da máquina

- Selecione o processo desejado

- Clique em Finalizar Processo

---

## 🧠 Observações Técnicas

O script utiliza PowerShell Remoting (WinRM) sempre que possível

Em ambientes com EDR/Antivírus corporativo, algumas ações podem ser bloqueadas

O PsExec (caso utilizado em versões anteriores) pode ser identificado como ferramenta administrativa e sofrer restrições

---

## 📄 Licença

Este projeto é de uso interno / educacional.
Sinta-se à vontade para adaptar e evoluir conforme a necessidade do seu ambiente.

---

## 🤝 Contribuições

Sugestões, melhorias e feedbacks são bem-vindos!
Abra uma issue ou envie um pull request 🚀
