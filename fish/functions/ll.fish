function ll --wraps=ls --wraps='eza --all --group-directories-first --long --classify=always --icons=always --hyperlink --header --no-permissions --no-user --color --color-scale' --description 'List directory'
    eza --all --group-directories-first --long --classify=always --icons=always --hyperlink --header --no-permissions --no-user --color --color-scale --git $argv
end
