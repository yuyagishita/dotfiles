function fish_user_key_bindings

    # bind \cg '__ghq_repository_search'
    bind \ci '__ghq_repository_search'
    
    if bind -M insert >/dev/null 2>/dev/null
        # bind -M insert \cg '__ghq_repository_search'
        bind -M insert \ci '__ghq_repository_search'
    end

end
