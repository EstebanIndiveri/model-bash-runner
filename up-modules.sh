#!/bin/bash
#!load nvm env
source ~/.nvm/nvm.sh

raven_dir={modules_dir}

modules=(
  modules_name_to_up
)

node_version="16.20.1"

if ! nvm ls "$node_version" > /dev/null 2>&1; then
  echo "Instalando Node.js $node_version..."
  nvm install "$node_version"
fi

# Para cada módulo:
for module in "${modules[@]}"; do
  module_name="${module%.*}"
  cd "$raven_dir/$module" || continue
  nvm use "$node_version"
  npm start &
  pids+=($!)
done

for pid in "${pids[@]}"; do
  wait $pid
done