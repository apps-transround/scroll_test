(echo const String buildTimeStamp = 'STAGE: %date% %time%';) > lib\build_timestamp.dart

call flutter build web

call firebase hosting:channel:deploy rot

time /t
