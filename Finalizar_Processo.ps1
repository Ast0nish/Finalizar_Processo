Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ================= FUNÇÕES =================
function Eh-IP($valor) {
    return $valor -match '^\d{1,3}(\.\d{1,3}){3}$'
}

function Eh-Admin {
    $id = [Security.Principal.WindowsIdentity]::GetCurrent()
    $p  = New-Object Security.Principal.WindowsPrincipal($id)
    return $p.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Garantir-TrustedHost($ip) {
    if (-not (Eh-Admin)) {
        throw "Para conectar por IP, execute o PowerShell como ADMINISTRADOR."
    }

    $trusted = (Get-Item WSMan:\localhost\Client\TrustedHosts).Value

    if (-not $trusted) {
        Set-Item WSMan:\localhost\Client\TrustedHosts -Value $ip -Force
    }
    elseif ($trusted -notmatch $ip) {
        Set-Item WSMan:\localhost\Client\TrustedHosts -Value "$trusted,$ip" -Force
    }
}

function Atualizar-Processos($destino) {
    $lstProcessos.Items.Clear()

    $processos = Invoke-Command -ComputerName $destino -ScriptBlock {
        Get-Process | Sort-Object Name | Select-Object Name, Id
    }

    foreach ($p in $processos) {
        if ($p.Name -and $p.Id) {
            $lstProcessos.Items.Add("$($p.Name) [$($p.Id)]")
        }
    }
}

# ================= FORM =================
$form = New-Object System.Windows.Forms.Form
$form.Text = "Finalizar Processo Remoto"
$form.Size = New-Object System.Drawing.Size(560,600)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false
$form.BackColor = [System.Drawing.Color]::FromArgb(245,248,252)

# ================= HEADER =================
$panelHeader = New-Object System.Windows.Forms.Panel
$panelHeader.Size = New-Object System.Drawing.Size(560,70)
$panelHeader.BackColor = [System.Drawing.Color]::FromArgb(0,120,215)
$form.Controls.Add($panelHeader)

$lblTitle = New-Object System.Windows.Forms.Label
$lblTitle.Text = "Finalizar Processo Remoto"
$lblTitle.Font = New-Object System.Drawing.Font("Segoe UI",14,[System.Drawing.FontStyle]::Bold)
$lblTitle.ForeColor = 'White'
$lblTitle.AutoSize = $true
$lblTitle.Location = New-Object System.Drawing.Point(20,15)
$panelHeader.Controls.Add($lblTitle)

$lblDev = New-Object System.Windows.Forms.Label
$lblDev.Text = "Desenvolvido por Vinícius Pimentel"
$lblDev.Font = New-Object System.Drawing.Font("Segoe UI",9)
$lblDev.ForeColor = [System.Drawing.Color]::FromArgb(220,235,255)
$lblDev.AutoSize = $true
$lblDev.Location = New-Object System.Drawing.Point(22,42)
$panelHeader.Controls.Add($lblDev)

# ================= CARD CONEXÃO =================
$panelConn = New-Object System.Windows.Forms.Panel
$panelConn.Location = New-Object System.Drawing.Point(20,85)
$panelConn.Size = New-Object System.Drawing.Size(510,90)
$panelConn.BackColor = 'White'
$panelConn.BorderStyle = 'FixedSingle'
$form.Controls.Add($panelConn)

$lblComp = New-Object System.Windows.Forms.Label
$lblComp.Text = "Nome ou IP da máquina"
$lblComp.Font = New-Object System.Drawing.Font("Segoe UI",9,[System.Drawing.FontStyle]::Bold)
$lblComp.Location = New-Object System.Drawing.Point(15,15)
$lblComp.AutoSize = $true
$panelConn.Controls.Add($lblComp)

$txtComp = New-Object System.Windows.Forms.TextBox
$txtComp.Location = New-Object System.Drawing.Point(18,40)
$txtComp.Size = New-Object System.Drawing.Size(300,25)
$txtComp.Font = New-Object System.Drawing.Font("Segoe UI",9)
$panelConn.Controls.Add($txtComp)

$btnConectar = New-Object System.Windows.Forms.Button
$btnConectar.Text = "Conectar"
$btnConectar.Location = New-Object System.Drawing.Point(340,38)
$btnConectar.Size = New-Object System.Drawing.Size(140,30)
$btnConectar.FlatStyle = 'Flat'
$btnConectar.BackColor = [System.Drawing.Color]::FromArgb(0,120,215)
$btnConectar.ForeColor = 'White'
$btnConectar.Cursor = 'Hand'
$panelConn.Controls.Add($btnConectar)

# ================= LISTA PROCESSOS =================
$lstProcessos = New-Object System.Windows.Forms.ListBox
$lstProcessos.Location = New-Object System.Drawing.Point(20,190)
$lstProcessos.Size = New-Object System.Drawing.Size(510,280)
$lstProcessos.Font = New-Object System.Drawing.Font("Consolas",9)
$lstProcessos.BorderStyle = 'FixedSingle'
$form.Controls.Add($lstProcessos)

# ================= BOTÕES =================
$btnFinalizar = New-Object System.Windows.Forms.Button
$btnFinalizar.Text = "Finalizar Processo"
$btnFinalizar.Location = New-Object System.Drawing.Point(40,500)
$btnFinalizar.Size = New-Object System.Drawing.Size(200,40)
$btnFinalizar.FlatStyle = 'Flat'
$btnFinalizar.BackColor = [System.Drawing.Color]::FromArgb(220,53,69)
$btnFinalizar.ForeColor = 'White'
$btnFinalizar.Cursor = 'Hand'
$form.Controls.Add($btnFinalizar)

$btnAtualizar = New-Object System.Windows.Forms.Button
$btnAtualizar.Text = "Atualizar Lista"
$btnAtualizar.Location = New-Object System.Drawing.Point(300,500)
$btnAtualizar.Size = New-Object System.Drawing.Size(200,40)
$btnAtualizar.FlatStyle = 'Flat'
$btnAtualizar.BackColor = [System.Drawing.Color]::FromArgb(40,167,69)
$btnAtualizar.ForeColor = 'White'
$btnAtualizar.Cursor = 'Hand'
$form.Controls.Add($btnAtualizar)

# ================= EVENTOS =================
$btnConectar.Add_Click({
    try {
        $destino = $txtComp.Text.Trim()
        if (-not $destino) { return }

        if (-not (Test-Connection -ComputerName $destino -Count 1 -Quiet)) {
            throw "Máquina não encontrada."
        }

        if (Eh-IP $destino) {
            Garantir-TrustedHost $destino
        }

        Atualizar-Processos $destino
    } catch {
        [System.Windows.Forms.MessageBox]::Show($_.Exception.Message,"Erro")
    }
})

$btnAtualizar.Add_Click({
    if ($txtComp.Text) {
        Atualizar-Processos $txtComp.Text.Trim()
    }
})

$btnFinalizar.Add_Click({
    if (-not $lstProcessos.SelectedItem) { return }

    $destino = $txtComp.Text.Trim()
    $proc = ($lstProcessos.SelectedItem -split '\s+')[0]

    if (
        [System.Windows.Forms.MessageBox]::Show(
            "Deseja finalizar o processo '$proc'?",
            "Confirmação","YesNo","Warning"
        ) -eq "Yes"
    ) {
        Invoke-Command -ComputerName $destino -ScriptBlock {
            param($p) Stop-Process -Name $p -Force
        } -ArgumentList $proc

        Atualizar-Processos $destino
    }
})

# ================= SHOW =================
[void]$form.ShowDialog()
