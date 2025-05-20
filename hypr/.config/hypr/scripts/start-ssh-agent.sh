#!/bin/bash

# Avsluta alla tidigare agenter först
pkill -u $USER ssh-agent
pkill -u $USER gnome-keyring-d

# Ge systemet en chans att städa upp
sleep 1

# Starta ssh-agent
eval $(ssh-agent)

# Spara miljövariabler för framtida sessioner
echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" > ~/.ssh/agent.env
echo "export SSH_AGENT_PID=$SSH_AGENT_PID" >> ~/.ssh/agent.env

# Informera användaren
echo "SSH agent started with PID $SSH_AGENT_PID"
echo "SSH_AUTH_SOCK=$SSH_AUTH_SOCK"

# Lägg till nycklar automatiskt (optional)
ssh-add
