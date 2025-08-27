
#ifndef VL53L0X_H_
#define VL53L0X_H_

#include "xiicps.h"
#include "xstatus.h"
#include "xil_types.h"

#define VL53L0X_I2C_ADDR  0x29
#define VL53L0X_I2C_CLK   100000

typedef struct {
    XIicPs *Iic;
    u8 address;
} VL53L0X;

int VL53L0X_init(VL53L0X *dev, XIicPs *iic);
int VL53L0X_readRangeMM(VL53L0X *dev, u16 *distance_mm);
int VL53L0X_startRanging(VL53L0X *dev);
int VL53L0X_writeReg(VL53L0X *dev, u8 reg, u8 val);
int VL53L0X_readReg(VL53L0X *dev, u8 reg, u8 *val);
int VL53L0X_readMulti(VL53L0X *dev, u8 reg, u8 *buf, int len);

#endif /* VL53L0X_H_ */
