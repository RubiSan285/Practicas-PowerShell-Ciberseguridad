#Editado por Rub� Santiesteban el 12/03/2026
$Puertos = @()
$IPs = @()
$Continuar = "S"

Write-Host "Ingrese los puertos a verificar"
do {
$Puerto = Read-Host "Ingrese un puerto (1 - 65535)"

if($Puerto -match '^\d+$' -and [int]$Puerto -ge 1 -and [int]$Puerto -le 65535) {
$Puertos += [int]$Puerto
Write-Host "Puerto Agregado"
}
else {
Write-Host "Puerto inválido. Debe de ser un número entre 1 y 65535"
}
$Continuar = (Read-Host "¿Desea agregar otro puerto? (S/N)").ToUpper()
} until ($Continuar -ne "S")

$Continuar = "S"
Write-Host "Ingrese las IPs a verificar"

do {
$IP = Read-Host "Ingrese una IP"

if([System.Net.IPAddress]::TryParse($IP, [ref]$null)) {
$IPs += $IP
Write-Host "IP agregada"
}
else {
Write-Host "IP inválida"
}

$Continuar = (Read-Host "¿Desea agregar otra IP? (S/N)").ToUpper()
} until ($Continuar -ne "S")

Write-Host "`n=== RESULTADOS ==="

foreach ($IP in $IPs) {
Write-Host "Verificando IP: $IP"

foreach ($Puerto in $Puertos) {
$Resultado = Test-NetConnection -ComputerName $IP -Port $Puerto -InformationLevel Quiet

if ($Resultado) {
Write-Host " Puerto $Puerto ABIERTO en $IP"
}
else {
Write-Host " Puerto $Puerto CERRADO en $IP"
}
}
}
