@echo off
git fetch --all
git reset --hard remotes/origin/master
for /F "tokens=2" %%i in ('date /t') do set opendate=%%i
set opentime=%time%
if exist save.lock (
	echo. "Save is currently in use"
	pause
	exit
) else (
	echo. "Locking save..."
	echo. Locked on %opendate% - %opentime% > save.lock
	git add .
	git commit -am "Locking save - %opendate% - %opentime%"
	git push
)
for /F %%I in ('curl ifconfig.me') do set externalIP=%%I
set discordURL=https://discord.com/api/webhooks/815122326520987679/BXMNpn8woJM5faksL_kcnpKNlwAu2xToLNNcXQjrO8UjTA86BIqoIAVR1mULCHmSiAfa
set onlineMessage="MC Server is live at %externalIP% - Come join!"
set offlineMessage="MC Server at %externalIP% is offline."
curl -X POST -d content=%onlineMessage% %discordURL%
call java -Xmx3G -Xms3G -jar server.jar /wait
curl -X POST -d content=%offlineMessage% %discordURL%
del save.lock
for /F "tokens=2" %%i in ('date /t') do set exitdate=%%i
set exittime=%time%
git add .
git commit -am "Server Upload - %exitdate% - %exittime%"
git push