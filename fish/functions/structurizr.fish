function structurizr
    set -l port 8080
    set -l workspace ./structurizr
    set -l command local

    argparse 'p/port=' 'w/workspace=' h/help -- $argv
    if set -q _flag_help
        echo "Usage: structurizr [-p PORT] [-w WORKSPACE] [COMMAND]"
        echo "  -p, --port      Port to expose (default: 8080)"
        echo "  -w, --workspace Path to workspace directory (default: ./structurizr)"
        echo "  -h, --help      Show this help message"
        echo "  COMMAND         Command to run (local or playground, default: local)"
        return 0
    end
    if set -q _flag_port
        set port $_flag_port
    end
    if set -q _flag_workspace
        set workspace $_flag_workspace
    end

    if set -q argv[1]
        set command $argv[1]
    end

    if not test -d $workspace
        echo "Workspace directory '$workspace' does not exist. It will be created."
    end

    docker run \
        -it \
        --rm \
        -e STRUCTURIZR_THEMES=/usr/local/structurizr-themes \
        -e STRUCTURIZR_AUTOREFRESHINTERVAL=1000 \
        -p $port:8080 \
        -v $workspace:/usr/local/structurizr structurizr/structurizr \
        $command
end
