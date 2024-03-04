. "cen_scripts\fileDownloader.ps1"

$config = Get-Content cen_config.ini | ConvertFrom-StringData

$authorFileUrl = [regex]::matches($config.author_url_files, '(?<=\").+?(?=\")').Value
$journalFileUrl = [regex]::matches($config.ciencia_e_natura_url_files, '(?<=\").+?(?=\")').Value

$downloader = [FileDownloader]::new()
$downloader.downloadFile($authorFileUrl, "author_files")
$downloader.downloadFile($journalFileUrl, "ciencia_e_natura_images")

function cleanupFiles {
    Remove-Item -Path "*.blg","*.log","*.spl","*.aux","*.out","*.bbl" -Force
}

pdflatex paper.tex
bibtex paper
pdflatex paper.tex
pdflatex paper.tex

cleanupFiles
