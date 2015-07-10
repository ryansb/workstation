# Usage: ignore python PyCharm vim > .gitignore
function ignore() {
    curl -s -L --ciphers ecdhe_ecdsa_aes_128_gcm_sha_256 --insecure http://www.gitignore.io/api/${(j:,:)@}
}
