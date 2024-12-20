# Snap for OpenVINO™ AI Plugins for GIMP

This snap is a content producer snap for integrating AI plugins into the GIMP snap. It also distributes an app for user's to interactively download models that can be used for one of the GIMP plugins (stable diffusion).

Note this snap exists specifically to support the `gimp` snap, and thus is not designed to be generic.

## Instructions for installing and running the snap

### Install dependencies

```
sudo snap install intel-npu-driver --beta # for NPU support
sudo snap install openvino-toolkit-2404 --beta
```

### Install from the latest revision in the store

```
sudo snap install openvino-ai-plugins-gimp --beta
```

### Build and install the snap locally

Build the snap:

```
snapcraft
```

```
sudo snap install --dangerous ./openvino-ai-plugins-gimp_*_amd64.snap
```

### Connecting plugs manually

Note, these plugs should now all autoconnect so it is no longer necessary to run these commands manually. The commands are still shown below for posterity or troubleshooting purposes.

In order to run the `openvino-ai-plugins-gimp.model-setup` app (more details below), a number of snapd interfaces must first be plugged. The following will allow the snap write access to `~/.local/share/openvino-ai-plugins-gimp` and also connect to a content producer snap providing OpenVINO runtime libraries:

```
sudo snap connect openvino-ai-plugins-gimp:dot-local-share-openvino-ai-plugins-gimp
sudo snap connect openvino-ai-plugins-gimp:openvino-libs openvino-toolkit-2404:openvino-libs
```

Additionally, if you are running on an Intel® Core™ Ultra generation CPU containing a NPU accelerator, also plug the interfaces for NPU support:

```
sudo snap connect openvino-ai-plugins-gimp:intel-npu intel-npu-driver:intel-npu
sudo snap connect openvino-ai-plugins-gimp:npu-libs intel-npu-driver:npu-libs
```

### Snap slots

This snap exposes a few snapd slots: one using the content interface to enable the GIMP snap to integrate the Python-based GIMP plugins, and the second allows the GIMP snap to access the stable diffusion model directory at `~/.local/share/openvino-ai-plugins-gimp`.

An example snippet for a consuming app's `snapcraft.yaml` may look like:

```yaml
plugs:
  openvino-ai-plugins-gimp-libs:
    interface: content
    content: openvino-ai-plugins-gimp-2404
    target: $SNAP/openvino-ai-plugins-gimp
  dot-local-share-openvino-ai-plugins-gimp:
    interface: personal-files
    read:
      - $HOME/.local/share/openvino-ai-plugins-gimp

apps:
  gimp-app:
    command: ...
    command-chain:
      - command-chain/openvino-ai-plugins-gimp-launch
    plugs:
      - openvino-ai-plugins-gimp-libs
      - dot-local-share-openvino-ai-plugins-gimp

parts:
  gimp:
    ...
    override-stage: |
      ...
      # update gimp's plugin search path so it will pick up plugins mounted over snapd's content interface
      current_path=$(grep "# (plug-in-path" ${CRAFT_PART_INSTALL}/etc/gimp/2.99/gimprc | cut -d '"' -f2)
      add_dir=/snap/"${SNAPCRAFT_PROJECT_NAME}"/current/openvino-ai-plugins-gimp/gimp-plugins
      echo "(plug-in-path \"${current_path}:${add_dir}\")" >> $CRAFT_PART_INSTALL/etc/gimp/2.99/gimprc

  command-chain-openvino-ai-plugins-gimp:
    plugin: dump
    source-type: git
    source: https://github.com/canonical/openvino-ai-plugins-gimp-snap.git
    source-branch: ...
    stage:
      - command-chain/openvino-ai-plugins-gimp-launch
```

## Installing stable diffusion models

To install models for the stable diffusion plugin (models for other plugins are small in size and thus are installed inside the snap), there is a `openvino-ai-plugins-gimp.model-setup` command line tool that provides an interactive menu for installing models to your home directory at `~/.local/share/openvino-ai-plugins-gimp`.

Also note that if you are running on a system with Intel NPU support, some models may be automatically compiled for the NPU following the download.

Rather than downloading models from the command line, users may download models from within GIMP by clicking "Model" in the top-left of the stable diffusion dialog window (Layer -> OpenVINO-AI-Plugins -> Stable Diffusion).
