#!/bin/bash

# Atualiza o crontab com as tarefas do Whenever
bundle exec whenever --update-crontab

# Inicia o cron em modo foreground
cron -f