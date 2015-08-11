function tmpenv {
    venv_name="tmpenv-$(cat /dev/urandom | tr -dc '0-9a-zA-Z' | head -c15)"
    pyenv virtualenv "${1:-2.7.9}" ${venv_name}
    pyenv activate $venv_name
}

function rmtmpenv {
    rm -rf ~/.pyenv/versions/tmpenv-*
}
