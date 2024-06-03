// SPDX-License-Identifier: GPL-2.0-or-later
/*
 *  HID driver for Goodix GT7868Q
 *
 *  Copyright (C) 2024 Terry Wong <terry.wong2@yahoo.com>
 */
#include <linux/device.h>
#include <linux/hid.h>
#include <linux/module.h>
#include "hid-multitouch.c"

static __u8 *goodix_gt7868q_report_fixup(struct hid_device *hdev, __u8 *rdesc, unsigned int *rsize)
{
    if (rdesc[607] == 0x15) {
        rdesc[607] = 0x25;
        dev_info(&hdev->dev, "Report descriptor fixup is applied.\n");
    } else {
        dev_info(&hdev->dev, "The byte is not expected for fixing the report descriptor. \
        It's possible that the touchpad firmware is not suitable for applying the fix. \
        got: %x\n", rdesc[607]);
    }

    return rdesc;
}

static const struct hid_device_id goodix_gt7868q_devices[] = {
    { HID_I2C_DEVICE(I2C_VENDOR_ID_GOODIX, 0x01E9) },
    { HID_I2C_DEVICE(I2C_VENDOR_ID_GOODIX, 0x01E8) },
    { }
};

MODULE_DEVICE_TABLE(hid, goodix_gt7868q_devices);
static struct hid_driver goodix_gt7868q_driver = {
    .name = "goodix-gt7868q",
    .id_table = goodix_gt7868q_devices,
    .report_fixup = goodix_gt7868q_report_fixup,
    .probe = mt_probe,
	.remove = mt_remove,
	.input_mapping = mt_input_mapping,
	.input_mapped = mt_input_mapped,
	.input_configured = mt_input_configured,
	.feature_mapping = mt_feature_mapping,
	.event = mt_event,
	.report = mt_report,
	.suspend = pm_ptr(mt_suspend),
	.reset_resume = pm_ptr(mt_reset_resume),
	.resume = pm_ptr(mt_resume),

};
module_hid_driver(goodix_gt7868q_driver);

MODULE_AUTHOR("Terry Wong <terry.wong2@yahoo.com>");
MODULE_DESCRIPTION("HID driver for Goodix GT7868Q");
MODULE_LICENSE("GPL");
