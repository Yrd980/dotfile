function git_sparse_clone
    if test (count $argv) -lt 2
        echo "Usage: git_sparse_clone <repo_url> <folder1> [folder2] [folder3] ..."
        return 1
    end

    set repo_url $argv[1]
    set repo_name (basename $repo_url .git)
    set folders (string sub -s 2 $argv)  # Extract all folder arguments

    # Clone the repo with sparse checkout enabled
    git clone --filter=blob:none --no-checkout $repo_url $repo_name
    cd $repo_name

    git sparse-checkout init --cone
    git sparse-checkout set $folders  # Set multiple folders

    git checkout

    echo "Cloned folders: $folders from $repo_url into $repo_name"
end

