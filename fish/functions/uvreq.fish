function uvreq
    # Ensure .venv exists
    if not test -d .venv
        echo "Creating .venv..."
        uv venv
    end

    # Activate .venv (optional — so commands run inside)
    source .venv/bin/activate.fish

    # Install from requirements.txt if present
    if test -f requirements.txt
        echo "Installing from requirements.txt..."
        uv pip install -r requirements.txt
    else
        echo "No requirements.txt found in this directory."
    end
end
