function ll --wraps=ls --wraps='eza --all --group-directories-first --long --classify=always --icons=always --hyperlink --header --no-permissions --no-user --color --color-scale' --description 'list directory'
    eza --all --group-directories-first --long --classify=always --icons=always --hyperlink --header --no-permissions --no-user --color --color-scale $argv
end
