docker build -t soichih/vncserver-fibernavigator .
if [ $? -eq 0 ];
then
    docker push soichih/vncserver-fibernavigator
fi
