#!/usr/bin/env bash
set -xeuo pipefail

export PYTHONUNBUFFERED=1

export CONDA_BUILD_WORKSPACE="${CONDA_BUILD_WORKSPACE:-/github/workspace}"
export CONDA_BUILD_CHANNEL="${CONDA_BUILD_CHANNEL:-/github/workspace/conda-build}"

mkdir -p "$CONDA_BUILD_WORKSPACE"
cd "${CONDA_BUILD_WORKSPACE}"

mkdir -p "$CONDA_BUILD_CHANNEL"
/opt/conda/bin/conda index "$CONDA_BUILD_CHANNEL"


conda_build () {
  local args=()
  local i=0

  for channel in "$CONDA_BUILD_CHANNELS"
  do
    args[$i]="-c"
    ((++i))
    args[$i]="$channel"
    ((++i))
  done

  for arg in "$@"
  do
    if [ ! -z "$arg" ]; then
      args[$i]="$arg"
      ((++i))
    fi
  done

  /opt/conda/bin/conda build -c file:/"$CONDA_BUILD_CHANNEL" --no-anaconda-upload --output-folder "$CONDA_BUILD_CHANNEL" "${args[@]}"

  return 0
}

conda_build "$@"

/opt/conda/bin/conda index "$CONDA_BUILD_CHANNEL"
