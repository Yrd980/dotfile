function pdf2web -d "Convert PDF to self-contained HTML (pdf2htmlEX) preserving original layout"
    if test (count $argv) -lt 1
        echo "Usage: pdf2web <input.pdf> [output.html]"
        return 2
    end

    set in "$argv[1]"
    if not test -f "$in"
        echo "Error: file not found: $in"
        return 1
    end

    # Default output is <basename>.html unless explicitly provided
    if test (count $argv) -ge 2
        set out "$argv[2]"
    else
        set base (basename "$in" .pdf)
        set out "$base.html"
    end

    if not type -q pdf2htmlEX
        echo "Error: pdf2htmlEX not found. Install it: yay -S pdf2htmlex"
        return 127
    end

    pdf2htmlEX \
        --embed cfijo \
        --font-format woff \
        --embed-external-font 1 \
        --decompose-ligature 1 \
        --zoom 1.5 \
        "$in" "$out"

    set code $status
    if test $code -eq 0
        echo "✅ Generated: $out"
        echo "Tip: xdg-open $out  (or serve via: python3 -m http.server)"
    else
        echo "❌ pdf2htmlEX failed with code $code"
        echo "Hint: try removing '--font-format woff' or switch to '--font-format ttf'"
    end
end
