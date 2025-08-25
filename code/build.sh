#!/bin/bash

# Check that Q3_MOD_DIR is set
if [ -z "$Q3_MOD_DIR" ]; then
    echo "Error: Q3_MOD_DIR environment variable is not set."
    exit 1
fi

# Run the build
echo "Building q3 game VM..."
if ! make -f unix/Makefile.Game; then
    echo "Error: Make failed. Aborting."
    exit 1
fi

# Verify the build output exists
if [ ! -d "../baseq3/vm" ]; then
    echo "Error: ../baseq3/vm directory not found. Build may have failed."
    exit 1
fi

# Prepare temporary staging directory for PK3
TMPDIR=$(mktemp -d)
mkdir -p "$TMPDIR/vm"

# Copy all VM files into staging directory
cp ../baseq3/vm/* "$TMPDIR/vm/"

# Backup old pak0.pk3 if it exists
if [ -f "$Q3_MOD_DIR/pak0.pk3" ]; then
    echo "Backing up existing pak0.pk3..."
    mv "$Q3_MOD_DIR/pak0.pk3" "$Q3_MOD_DIR/pak0.pk3.bak"
fi

# Create pak0.pk3 (zip format)
echo "Creating pak0.pk3..."
cd "$TMPDIR"
zip -r pak0.pk3 vm
cd -

# Copy the pak0.pk3 to the mod directory
cp "$TMPDIR/pak0.pk3" "$Q3_MOD_DIR/"

# Clean up
rm -rf "$TMPDIR"

echo "pak0.pk3 deployed to $Q3_MOD_DIR successfully."

