@@:: This prolog allows a PowerShell script to be embedded in a .CMD file.


@@:: Any non-PowerShell content must be preceeded by "@@"


@@setlocal


@@set POWERSHELL_BAT_ARGS=%*


@@if defined POWERSHELL_BAT_ARGS set POWERSHELL_BAT_ARGS=%POWERSHELL_BAT_ARGS:"=\"%


@@PowerShell -Command Invoke-Expression $('$args=@(^&{$args} %POWERSHELL_BAT_ARGS%);'+[String]::Join(';',$((Get-Content '%~f0') -notmatch '^^@@'))) & pause & goto :EOF

Set-ExecutionPolicy Bypass -Scope Process -Force

"Commencing Reset!"
ForEach ($Profile_Dir in $(Get-ChildItem -filter Profile*)) { 
	"Purging $Profile_Dir ..."
	try{
		Remove-Item -Recurse $Profile_Dir\* -ErrorAction Stop
	}catch{
		$error[0].Exception.Message
	}
	"Reseeding $Profile_Dir ..."
	try{
		Copy-Item -Recurse "Default\*" "$Profile_Dir\" -ErrorAction Stop
	}catch{
		$error[0].Exception.Message
	}	
}

"Done!"

