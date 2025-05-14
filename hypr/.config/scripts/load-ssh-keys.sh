#!/bin/bash

# Vänta några sekunder för att SSH-agent ska starta
sleep 2

# Ladda miljövariablerna
if [ -f "$HOME/.ssh/agent.env" ]; then
    . "$HOME/.ssh/agent.env"
fi

# Lägg till nycklarna
ssh-add
