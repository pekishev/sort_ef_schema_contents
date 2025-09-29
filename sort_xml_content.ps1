param(
    [Parameter(Mandatory=$true)]
    [string]$xmlPath
)

# Устанавливаем кодировку для консольного вывода
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 > $null

# Проверяем существование файла
if (-not (Test-Path $xmlPath)) {
    Write-Error "Файл не найден: $xmlPath"
    exit 1
}

# Загружаем XML файл с правильной кодировкой
$xml = New-Object System.Xml.XmlDocument
$xml.PreserveWhitespace = $true
$xml.Load($xmlPath)

# Получаем отсортированные списки content и link
$sortedContent = $xml.schema.content | Sort-Object { [int]$_.id }
$sortedLinks = $xml.schema.link | Sort-Object { [int]$_.id }
$contentCount = $sortedContent.Count
$linkCount = $sortedLinks.Count

Write-Host "Найдено элементов content: $contentCount"
Write-Host "Найдено элементов link: $linkCount"

# Создаем новый документ
$newXml = New-Object System.Xml.XmlDocument
$newXml.PreserveWhitespace = $true
$newXml.AppendChild($newXml.ImportNode($xml.FirstChild, $true))  # XML declaration
$newSchema = $newXml.CreateElement("schema")

# Копируем атрибуты schema
foreach ($attr in $xml.schema.Attributes) {
    $newSchema.SetAttribute($attr.Name, $attr.Value)
}
$newXml.AppendChild($newSchema)

# Проходим по всем узлам исходной schema
$addedContent = 0
$addedLinks = 0
$lastLinkId = $null
$skipNext = $false

foreach ($node in $xml.schema.ChildNodes) {
    if ($node.NodeType -eq [System.Xml.XmlNodeType]::Comment -or $node.NodeType -eq [System.Xml.XmlNodeType]::Whitespace) {
        # Копируем комментарии и пробелы как есть
        if (-not $skipNext) {
            $newSchema.AppendChild($newXml.ImportNode($node, $true))
        }
        $skipNext = $false
    }
    elseif ($node.LocalName -eq "content") {
        $newSchema.AppendChild($newXml.ImportNode($sortedContent[$addedContent], $true))
        $addedContent++
        $skipNext = $false
    }
    elseif ($node.LocalName -eq "link") {
        $currentLinkId = $sortedLinks[$addedLinks].id
        if ($currentLinkId -ne $lastLinkId) {
            $newSchema.AppendChild($newXml.ImportNode($sortedLinks[$addedLinks], $true))
            $lastLinkId = $currentLinkId
            $skipNext = $false
        }
        else {
            $skipNext = $true
        }
        $addedLinks++
    }
    else {
        $newSchema.AppendChild($newXml.ImportNode($node, $true))
        $skipNext = $false
    }
}

# Сохраняем результат с правильной кодировкой
$settings = New-Object System.Xml.XmlWriterSettings
$settings.Indent = $true
$settings.IndentChars = "  "
$settings.Encoding = [System.Text.Encoding]::UTF8

$writer = [System.Xml.XmlWriter]::Create($xmlPath, $settings)
$newXml.Save($writer)
$writer.Close()

Write-Host "Успешно отсортировано $addedContent элементов content и $addedLinks элементов link"
