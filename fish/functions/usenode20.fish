function usenode20
  set node20_path "/opt/homebrew/opt/node@20/bin"

  if test -x "$node20_path/node"
    echo "Switching to Node.js version 20..."
    set -gx PATH /opt/homebrew/opt/node@20/bin $PATH
    set -gx LDFLAGS "-L/opt/homebrew/opt/node@20/lib"
    set -gx CPPFLAGS "-I/opt/homebrew/opt/node@20/include"
    echo "✅ Using Node.js version:"
    node --version
  else
    echo "❌Node.js version 20 not found at $node20_path"
    echo "Please ensure Node.js 20 is installed via `brew install node@20`."
    return 1
  end
end
