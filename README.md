# Snap for OpenVINO™ AI Plugins for GIMP

This snap is a content producer snap for integrating AI plugins into the GIMP snap. The plugins include:

* Stable Diffusion
* Super Resolution
* Semantic Segmentation

## Instructions for installing and running the snap

### Install dependencies for NPU support (optional)

If you are running on an Intel® Core™ Ultra generation CPU containing a NPU accelerator, install the NPU snap:

```
sudo snap install intel-npu-driver # for NPU support
```

### Enable Intel GPU and/or NPU support (optional)

Ensure you have permissions to the device by adding yourself to the `render` Unix group:

```shell
sudo usermod -a -G render $USER
```

Next log out and log back in for this change to take effect.

Note that the Stable Diffusion plugin requires the use of either an Intel NPU or GPU.

### Install from the latest revision in the store

```
sudo snap install openvino-ai-plugins-gimp
```

### Install GIMP and connect plugins

```
sudo snap install gimp
sudo snap connect gimp:gimp-plugins openvino-ai-plugins-gimp:gimp-plugins
```

The second command is what makes the OpenVINO plugins available to the GIMP snap.

### Build and install the snap locally (for development)

Build the snap:

```
snapcraft
```

```
sudo snap install --dangerous ./openvino-ai-plugins-gimp_*_amd64.snap
```

### Connect plugs manually (should not be needed)

Note, these plugs should now autoconnect. The commands are still shown below for posterity or troubleshooting purposes only.

If you are running on an Intel® Core™ Ultra generation CPU containing a NPU accelerator, plug the interfaces for NPU support:

```
sudo snap connect openvino-ai-plugins-gimp:intel-npu intel-npu-driver:intel-npu
sudo snap connect openvino-ai-plugins-gimp:npu-libs intel-npu-driver:npu-libs
```

## Installing stable diffusion models

Models may be download from within GIMP by clicking "Model" in the top-left of the stable diffusion dialog window (Layer -> OpenVINO-AI-Plugins -> Stable Diffusion).
