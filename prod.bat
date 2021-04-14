(echo const String buildTimeStamp = 'STAGE: %date% %time%';) > lib\build_timestamp.dart

call flutter build web

call firebase deploy --only hosting
time /t
