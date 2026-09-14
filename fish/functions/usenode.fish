function usenode
    set -l node_version $argv[1]

    if test -z "$node_version"
        echo "Usage: usenode VERSION (e.g. usenode 22)"
        return 1
    end

    set -l node_path "/opt/homebrew/opt/node@$node_version/bin"

    if test -x "$node_path/node"
        echo "Switching to Node.js version $node_version..."
        set -gx PATH $node_path $PATH
        set -gx LDFLAGS "-L/opt/homebrew/opt/node@$node_version/lib"
        set -gx CPPFLAGS "-I/opt/homebrew/opt/node@$node_version/include"
        echo "Using Node.js version:"
        node --version
    else
        echo "Node.js version $node_version not found at $node_path"
        echo "Please ensure Node.js $node_version is installed via \"brew install node@$node_version\"."
        return 1
    end
end
