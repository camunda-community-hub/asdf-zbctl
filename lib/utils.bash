#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/camunda-community-hub/zeebe-client-go"
TOOL_NAME="zbctl"
TOOL_TEST="zbctl version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | cut -f2 -d ' '
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/[0-9].*' | cut -d/ -f3-
}

list_all_versions() {
  list_github_tags
}

get_extension() {
  local -r kernel="$(uname -s)"
  if [[ ${OSTYPE} == "msys" || ${kernel} == "CYGWIN"* || ${kernel} == "MINGW"* ]]; then
    echo ".exe"
  elif [[ ${kernel} == "Darwin" || "$OSTYPE" == "darwin"* ]]; then
    echo ".darwin"
  fi
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"
  url="$GH_REPO/releases/download/${version}/zbctl$(get_extension)"

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "${filename}" -C - "${url}" || fail "Could not download ${url}"

  echo "* Validating $TOOL_NAME SHA1 checksums release $version..."
  # Note: The 2 spaces between the hash and file name are intentional, it's the shasum format.
  curl "${curl_opts[@]}" -o "${filename}.sha1sum" -C - "${url}.sha1sum" || fail "Could not download ${url}.sha1sum"
  echo "$(cat ${filename}.sha1sum | cut -f1 -d' ')  ${filename}" | shasum -c - --status
  rm "${filename}.sha1sum"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="${3%/bin}/bin"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path"
    chmod +x "$ASDF_DOWNLOAD_PATH/$TOOL_NAME-$ASDF_INSTALL_VERSION"
    cp "$ASDF_DOWNLOAD_PATH/$TOOL_NAME-$ASDF_INSTALL_VERSION" "$install_path/$TOOL_NAME"

    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error occurred while installing $TOOL_NAME $version."
  )
}
