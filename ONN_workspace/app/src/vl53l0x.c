
#include "vl53l0x.h"
#include "sleep.h"

static int writeData(VL53L0X *dev, u8 *buf, int len) {
    int status = XIicPs_MasterSendPolled(dev->Iic, buf, len, dev->address);
    while (XIicPs_BusIsBusy(dev->Iic));
    return status;
}

static int readData(VL53L0X *dev, u8 *buf, int len) {
    int status = XIicPs_MasterRecvPolled(dev->Iic, buf, len, dev->address);
    while (XIicPs_BusIsBusy(dev->Iic));
    return status;
}

int VL53L0X_writeReg(VL53L0X *dev, u8 reg, u8 val) {
    u8 buf[2] = {reg, val};
    return writeData(dev, buf, 2);
}

int VL53L0X_readReg(VL53L0X *dev, u8 reg, u8 *val) {
    int status = writeData(dev, &reg, 1);
    if (status != XST_SUCCESS) return status;
    return readData(dev, val, 1);
}

int VL53L0X_readMulti(VL53L0X *dev, u8 reg, u8 *buf, int len) {
    int status = writeData(dev, &reg, 1);
    if (status != XST_SUCCESS) return status;
    return readData(dev, buf, len);
}

int VL53L0X_init(VL53L0X *dev, XIicPs *iic) {
    dev->Iic = iic;
    dev->address = VL53L0X_I2C_ADDR;

    usleep(10000); // Allow sensor to boot

    // Minimal Pololu-style init
    VL53L0X_writeReg(dev, 0x88, 0x00);
    VL53L0X_writeReg(dev, 0x80, 0x01);
    VL53L0X_writeReg(dev, 0xFF, 0x01);
    VL53L0X_writeReg(dev, 0x00, 0x00);
    VL53L0X_writeReg(dev, 0x91, 0x3C); // Calib value
    VL53L0X_writeReg(dev, 0x00, 0x01);
    VL53L0X_writeReg(dev, 0xFF, 0x00);
    VL53L0X_writeReg(dev, 0x80, 0x00);

    return XST_SUCCESS;
}

int VL53L0X_startRanging(VL53L0X *dev) {
    return VL53L0X_writeReg(dev, 0x00, 0x01);  // SYSRANGE_START
}

int VL53L0X_readRangeMM(VL53L0X *dev, u16 *distance_mm) {
    u8 buf[12];
    int status = VL53L0X_readMulti(dev, 0x14, buf, 12);
    if (status != XST_SUCCESS) return status;

    *distance_mm = ((u16)buf[10] << 8) | buf[11];
    return XST_SUCCESS;
}
