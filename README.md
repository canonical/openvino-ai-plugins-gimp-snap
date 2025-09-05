# Snap for OpenVINO™ AI Plugins for GIMP

This snap is a content producer snap for integrating AI plugins into the GIMP snap. It also distributes an app for user's to interactively download models that can be used for one of the GIMP plugins (stable diffusion).

Note this snap exists specifically to support the `gimp` snap, and thus is not designed to be generic.

## Instructions for installing and running the snap

### Install dependencies

```
sudo snap install intel-npu-driver # for NPU support
sudo snap install openvino-toolkit-2404
```

### Install from the latest revision in the store

```
sudo snap install openvino-ai-plugins-gimp
```

### Install GIMP and connect plugins

```
sudo snap install gimp
sudo snap connect gimp:gimp-plugins openvino-ai-plugins-gimp:gimp-plugins
```

### Build and install the snap locally

Build the snap:

```
snapcraft
```

```
sudo snap install --dangerous ./openvino-ai-plugins-gimp_*_amd64.snap
```

### Connect plugs manually

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

## Installing stable diffusion models

To install models for the stable diffusion plugin (models for other plugins are small in size and thus are installed inside the snap), there is a `openvino-ai-plugins-gimp.model-setup` command line tool that provides an interactive menu for installing models to your home directory at `~/.local/share/openvino-ai-plugins-gimp`.

Also note that if you are running on a system with Intel NPU support, some models may be automatically compiled for the NPU following the download.

Rather than downloading models from the command line, users may download models from within GIMP by clicking "Model" in the top-left of the stable diffusion dialog window (Layer -> OpenVINO-AI-Plugins -> Stable Diffusion).
