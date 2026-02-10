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
   git clone https://github.com/SEU_USUARIO/NOME_DO_REPOSITORIO.git
