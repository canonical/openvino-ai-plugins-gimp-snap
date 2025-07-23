# Checkbox Provider for OpenVINO AI Plugins for GIMP Snap

This directory contains the Checkbox Provider for the OpenVINO AI Plugins for GIMP snap, including the snap recipe for building the snap and integrating with the Checkbox snap. The test plan runs the `openvino-ai-plugins-gimp.model-setup` tool to verify the functionality of the snap.

## Installation

Prerequisites:

```
sudo snap install --classic snapcraft
sudo snap install checkbox24
sudo snap install lxd
sudo adduser ubuntu lxd
lxd init --auto
```

Now build and install the sample content consumer snap and the checkbox provider for OpenVINO AI Plugins for GIMP:

```
git clone https://github.com/canonical/openvino-ai-plugins-gimp-snap.git

# build and install the checkbox tests for openvino-ai-plugins-gimp
cd openvino-ai-plugins-gimp-snap/checkbox
snapcraft
sudo snap install --dangerous --classic ./checkbox-openvino-ai-plugins-gimp_1.0.0_amd64.snap
```

## Installing test dependencies

```
checkbox-openvino-ai-plugins-gimp.install-full-deps
```

By default, `checkbox-openvino-ai-plugins-gimp.install-full-deps` will NOT install the `openvino-ai-plugins-gimp` snap. This is by design as typically tests will be run on a modified version of the snap built and installed locally. To install the latest version from the `latest/stable` channel in the Snap Store use:

```
checkbox-openvino-ai-plugins-gimp.install-full-deps --install_from_store
```

Note that the checkbox tests will install models to the same path(s) used by the `openvino-ai-plugins-gimp.model-setup` application. This is because the application has permissions to only write to certain paths, and thus users are not allowed the flexibility to install to any arbitrary path. Therefore, in order for the GIMP plugin tests to run, the models and a config file should be absent in order to test whether the application creates these files in the expected locations. Between checkbox runs, you can remove these files and directories by passing the `--clean_plugin_dirs` option:

```
checkbox-openvino-ai-plugins-gimp.install-full-deps --clean_plugin_dirs
```

**IMPORTANT**: please use this with caution as it will remove models that you may have previously installed to a machine for running the OpenVINO AI plugins with GIMP.

## Automated run

```
checkbox-openvino-ai-plugins-gimp.test-runner-automated
```

## Manual run

```
checkbox-openvino-ai-plugins-gimp.test-runner
```
