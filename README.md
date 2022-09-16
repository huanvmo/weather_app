# weather_app

This my weather app

## Techology

1. Using bloc for state management
2. Using dio and retrofit for API calling
3. Using route management
4. Have multi languages (english, VietNamese)
5. Using firebase to login, signup and do some more
6. Using line chart to show the temperature of each location
7. Change metric to imperial and vice versa

### Feature

1. Login/signup with email, gmail, facebook,
2. Forgot password
3. In home screen, you can see your weather current location
4. In search screen, you can search locaion and details of the places you have found
5. in Account screen, you can change your name and avatar

## Run coverage test

flutter test --coverage

perl C:\ProgramData\chocolatey\lib\lcov\tools\bin\lcov --remove coverage/lcov.info 'lib\config\**' '
lib\gen\**' 'lib\generated\**' 'lib\L110n' 'lib/**/*.g.dart' 'lib/**/model/*' 'lib/**/models/*' '
lib/**/*state.dart' 'lib/**/*route.dart' 'lib/**/*event.dart' 'lib/**/*screen.dart' 'lib/**/*
screen.dart' 'lib/presentation/common/**' 'lib/**/*screen.dart' 'lib/presentation/main/ui**' 'lib/**
/*widget.dart' 'lib/**/*widgets.dart' 'lib\presentation\main\news\**' 'lib\utils\**' '
lib\data\firebase\**' -o coverage/new_lcov.info

perl C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml coverage/new_lcov.info --output=coverage
