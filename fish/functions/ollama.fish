function ollama_update 
  ollama ls | awk '{ print $1}' | grep -v NAME | xargs -I {} sh -c 'echo "Updating model: {}"; ollama pull {}; echo "—" && echo "All models updated."'
end
