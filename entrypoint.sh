#!/bin/sh

git clone --recurse-submodules -j8 "${GIT_REPO}" "${BLOG_DIR}"

cd "${BLOG_DIR}"

hugo server --bind "0.0.0.0"

