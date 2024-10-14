# Goodix GT7868Q Linux Driver

This kernel module provides support for the Goodix GT7868Q touch controller. The module addresses a specific issue related to the Report Descriptor, specifically a duplicate description at byte position 605 and 607.

Please note that I've tested this kernel module on my ThinkBook 16+ 2024 IMH, but I cannot guarantee its functionality on other devices.

## Build

To build the module, simply run:

```bash
make
```

## Installation

### Insert the Module

Load the module into the kernel using the following command:

```bash
sudo modprobe ./goodix-gt7868q.ko
```

To make these changes _persistent on boot_, install the module to the system modules directory:

```bash
sudo make install-dkms
```

### Apply Libinput Quirks

To improve compatibility with libinput, follow these steps:

Copy the `local-overrides.quirks` file to `/usr/share/libinput/60-custom-thinkbookg6p2024imh.quirks`:

```bash
sudo make install-quirks
```

#### Explanation of the quirks

Adjust the default parameters to address issues with the device:

- The default press-down pressure threshold is higher than palm detection threshold, preventing the cursor movement.
- The maximum pressure detection is limited to 1000, even though the device report that supports up to 2000. Modify the `AttrThumbPressureThreshold` accordingly.
- If you prefer, you can adjust the touch up and down pressure by setting the `AttrPressureRange` or remove pressure detection altogether by adding `AttrEventCode=-ABS_MT_PRESSURE;-ABS_PRESSURE;`.

### Finally

Restart the display manager.
