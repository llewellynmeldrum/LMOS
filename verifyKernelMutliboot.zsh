if grub-file --is-x86-multiboot bin/lmos; then
    echo "Multiboot confirmed (grub-file) ret 0"
else
    echo "Error: the file is not multiboot compatible."
fi
