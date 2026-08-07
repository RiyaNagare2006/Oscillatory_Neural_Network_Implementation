/*
 * two_xshut_toggle_test.c
 *
 * Toggles two VL53L0X XSHUT pins via one AXI GPIO block.
 *  - bit0 -> Sensor 1 XSHUT
 *  - bit1 -> Sensor 2 XSHUT
 *
 * Sequence:
 *   1. Both OFF
 *   2. Sensor 1 ON  (Sensor 2 OFF)
 *   3. Both OFF
 *   4. Sensor 2 ON  (Sensor 1 OFF)
 *   5. Repeat forever
 *
 * Use a multimeter or LEDs to confirm voltage changes on each XSHUT line.
 */

#include "xparameters.h"
#include "xgpio.h"
#include "xil_printf.h"
#include "sleep.h"

#define GPIO_XSHUT_BASEADDR  0x41250000   // your AXI GPIO base
#define GPIO_CHANNEL         1
#define XSHUT_SENSOR1_MASK   0x1u
#define XSHUT_SENSOR2_MASK   0x2u

static XGpio gpio_xshut;

/* Write the two-bit mask to GPIO */
static void xshut_write_mask(u32 mask) {
    XGpio_DiscreteWrite(&gpio_xshut, GPIO_CHANNEL, mask & 0x3);
    usleep(2000);
}

/* Convenience helpers */
static void both_off(void)        { xshut_write_mask(0x0); }
static void sensor1_on_only(void) { xshut_write_mask(XSHUT_SENSOR1_MASK); }
static void sensor2_on_only(void) { xshut_write_mask(XSHUT_SENSOR2_MASK); }

int main(void) {
    xil_printf("\r\n=== Two-XSHUT ON/OFF Toggle Test ===\r\n");

    /* Init GPIO (2 bits wide) */
    XGpio_Config cfg = {0, GPIO_XSHUT_BASEADDR, 0,0,0,0,2};
    XGpio_CfgInitialize(&gpio_xshut, &cfg, cfg.BaseAddress);
    XGpio_SetDataDirection(&gpio_xshut, GPIO_CHANNEL, 0x0);  // outputs

    both_off();
    xil_printf("Both sensors OFF\r\n");
    sleep(1);

    while (1) {
        xil_printf("\nSensor 1 ON, Sensor 2 OFF\r\n");
        sensor1_on_only();
        xil_printf("GPIO readback = 0x%02X\r\n",
                   XGpio_DiscreteRead(&gpio_xshut, GPIO_CHANNEL) & 0x3);
        sleep(2);

        xil_printf("Both OFF\r\n");
        both_off();
        xil_printf("GPIO readback = 0x%02X\r\n",
                   XGpio_DiscreteRead(&gpio_xshut, GPIO_CHANNEL) & 0x3);
        sleep(2);

        xil_printf("Sensor 2 ON, Sensor 1 OFF\r\n");
        sensor2_on_only();
        xil_printf("GPIO readback = 0x%02X\r\n",
                   XGpio_DiscreteRead(&gpio_xshut, GPIO_CHANNEL) & 0x3);
        sleep(2);

        xil_printf("Both OFF\r\n");
        both_off();
        xil_printf("GPIO readback = 0x%02X\r\n",
                   XGpio_DiscreteRead(&gpio_xshut, GPIO_CHANNEL) & 0x3);
        sleep(2);
    }
}
