function __run_ai_tool
    set -l image "ai-tools:latest"
    set -l dockerfile (realpath (dirname (status -f))/ai-tools.Dockerfile)

    set -l exists (docker images -q $image)
    if test -z "$exists"
        echo "$image missing; building it now."

        echo "Using Dockerfile $dockerfile"
        docker build --pull --no-cache -t $image - <$dockerfile
        echo "Build finished with status $status"
    end

    echo "Launching \"$argv\" in \"$image\" with workspace \"$(pwd)\" mounted."

    docker run --rm -it \
        -v $HOME/.codex:/home/node/.codex \
        -v $HOME/.copilot:/home/node/.copilot \
        -v (pwd):/home/node/app \
        $image $argv
end
