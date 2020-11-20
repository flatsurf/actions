FROM condaforge/linux-anvil-comp7

RUN /opt/conda/bin/conda config --set channel_priority strict

RUN /opt/conda/bin/conda install --yes --quiet conda-build -c conda-forge

ENV CONDA_BUILD_WORKSPACE=/github/workspace
ENV CONDA_BUILD_CHANNEL=/github/workspace/conda-build
ENV CONDA_BUILD_CHANNELS=

COPY build_steps.sh /home/conda/build_steps.sh

ENTRYPOINT ["/bin/bash", "/home/conda/build_steps.sh"]
