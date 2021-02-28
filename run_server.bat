@echo off
FOR /F %%I IN ('curl ifconfig.me') DO SET externalIP=%%I
set discordURL=https://discord.com/api/webhooks/815122326520987679/BXMNpn8woJM5faksL_kcnpKNlwAu2xToLNNcXQjrO8UjTA86BIqoIAVR1mULCHmSiAfa
set onlineMessage="Big Boy Jungle is LIVE at %externalIP% - Come chill!"
set offlineMessage="Big Boy Jungle is SIGNING OFF %externalIP% is offline."
curl -X POST -d content=%onlineMessage% %discordURL%
call java -Xmx1024M -Xms1024M -jar server.jar /wait
curl -X POST -d content=%offlineMessage% %discordURL%