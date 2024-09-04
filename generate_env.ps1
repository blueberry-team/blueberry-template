# PowerShell 스크립트로 .env 파일 생성

# 현재 작업 중인 디렉터리 경로 가져오기
$TargetDir = Get-Location

# .env 파일 내용
$envContent = @"
# please replace 'your_api_key_here' with your actual API key
GOOGLE_API_KEY=your_api_key_here
GPT_API_KEY=your_api_key_here
# Other environment variables can be added here
"@

# .env 파일 생성
$envFilePath = Join-Path -Path $TargetDir -ChildPath ".env"
Write-Output "Creating .env file at: $envFilePath"

# UTF-8 인코딩으로 파일 생성
$envContent | Out-File -FilePath $envFilePath -Encoding utf8