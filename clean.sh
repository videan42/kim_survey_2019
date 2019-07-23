#!/bin/zsh

# Clean and reformat jupyter notebooks so they play nice with github
# Based on: http://timstaley.co.uk/posts/making-git-and-jupyter-notebooks-play-nice/

jq --indent 1 \
    '
    (.cells[] | select(has("outputs")) | .outputs) = []
    | (.cells[] | select(has("execution_count")) | .execution_count) = null
    | .metadata = {"language_info": {"name":"python", "pygments_lexer": "ipython3"}}
    | .cells[].metadata = {}
    ' "$1" > "$1.tmp"
mv "$1.tmp" "$1"
