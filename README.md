# Snap for OpenVINO™ AI Plugins for GIMP

[![Get it from the Snap Store](https://snapcraft.io/en/light/install.svg)](https://snapcraft.io/openvino-ai-plugins-gimp)

This snap is a content producer snap for integrating AI plugins into the GIMP snap. The plugins include:

* Stable Diffusion (including "FastSD" plugin starting in version 3.2.1)
* Super Resolution
* Semantic Segmentation

Please refer to the [upstream repo](https://github.com/intel/openvino-ai-plugins-gimp) for instructions and demos on using the plugins.

## Instructions for installing and running the snap

### Install dependencies for NPU support (optional)

If you are running on an Intel® Core™ Ultra generation CPU containing an NPU accelerator, install the NPU snap:

```
sudo snap install intel-npu-driver # for NPU support
```

### Enable Intel GPU and/or NPU support (optional)

Ensure you have permissions to the device by adding yourself to the `render` Unix group:

```shell
sudo usermod -a -G render $USER
```

Next log out and log back in for this change to take effect.

Note that the Stable Diffusion plugin will only run on an Intel NPU or GPU, while the FastSD plugin can also run on a CPU.

### Install the plugins from the Snap Store

```
sudo snap install openvino-ai-plugins-gimp
```

### Install GIMP

```
sudo snap install gimp
```

> [!IMPORTANT]
>
> If you have upgraded to version >3.2.0 of the GIMP snap from version <3.2.0, you may need to run `rm -rf $HOME/.config/GIMP` in order for the plugins to appear.

### Build and install the snap locally (for development)

Build the snap:

```
snapcraft pack
```

```
sudo snap install --dangerous ./openvino-ai-plugins-gimp_*_amd64.snap
```

## Installing stable diffusion models

Models may be download from within GIMP by clicking "Model" in the top-left of the stable diffusion dialog window (Layer -> OpenVINO-AI-Plugins -> Stable Diffusion).

The FastSD (Fast Stable Diffusion) plugins download and install models automatically the first time they are selected.
