# "cd" wrapper to handle commands like "cd ..", "cd ...", "cd ....", etc.
function cd --wraps cd --description 'Change the current directory' -a path
    if test (string match -r '^\.{2,}$' $path)
        set dotcount (string length -- $path)
        set target_path (string repeat -n (math $dotcount - 1) "../")
        builtin cd $target_path
    else
        builtin cd $argv
    end
end
