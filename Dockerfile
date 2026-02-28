ARG PANGEO_BASE_IMAGE_TAG=2026.01.30
FROM pangeo/pytorch-notebook:${PANGEO_BASE_IMAGE_TAG}


# Copy and install environment.yml
COPY environment.yml /tmp/environment.yml

# Set environment variables to force pip to build llama-cpp-python with CUDA
RUN mamba env update -f /tmp/environment.yml --name notebook && \
    mamba clean --all -f -y

    # Set environment variables to force pip to build with CUDA
ENV CMAKE_ARGS="-DGGML_CUDA=on"
ENV FORCE_CMAKE=1

RUN /srv/conda/envs/notebook/bin/python -m pip install llama-cpp-python