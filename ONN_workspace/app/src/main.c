#include "xgpio.h"
#include "xparameters.h"
#include "xil_printf.h"
#include "sleep.h"


// Base addresses from xgpio_g.c
#define GPIO_DATA1_BASEADDR 0x41200000
#define GPIO_DATA2_BASEADDR 0x41210000
#define GPIO_DATA3_BASEADDR 0x41220000
#define GPIO_DATA4_BASEADDR 0x41230000
#define GPIO_DATA5_BASEADDR 0x41240000
#define GPIO_RESET_BASEADDR 0x41250000


#define GPIO_CHANNEL 1


// Declare GPIO instances and config objects
XGpio gpio_data1, gpio_data2, gpio_data3, gpio_data4, gpio_data5, gpio_reset;
XGpio_Config cfg_data1 = {0, GPIO_DATA1_BASEADDR,0,0,0,0,32};
XGpio_Config cfg_data2 = {0, GPIO_DATA2_BASEADDR, 0,0,0,0,32};
XGpio_Config cfg_data3 = {0, GPIO_DATA3_BASEADDR, 0,0,0,0,32};
XGpio_Config cfg_data4 = {0, GPIO_DATA4_BASEADDR, 0,0,0,0,32};
XGpio_Config cfg_data5 = {0, GPIO_DATA5_BASEADDR, 0,0,0,0,32};
XGpio_Config cfg_reset = {0, GPIO_RESET_BASEADDR, 0,0,0,0,1};


int main() {
    xil_printf("Hello World from Zybo Z7 using Vitis!\r\n");
    xil_printf("Starting AXI GPIO multi-channel data + reset transfer...\r\n");


    // Initialize all GPIOs using CfgInitialize
    XGpio_CfgInitialize(&gpio_data1, &cfg_data1, cfg_data1.BaseAddress);
    XGpio_CfgInitialize(&gpio_data2, &cfg_data2, cfg_data2.BaseAddress);
    XGpio_CfgInitialize(&gpio_data3, &cfg_data3, cfg_data3.BaseAddress);
    XGpio_CfgInitialize(&gpio_data4, &cfg_data4, cfg_data4.BaseAddress);
    XGpio_CfgInitialize(&gpio_data5, &cfg_data5, cfg_data5.BaseAddress);
    XGpio_CfgInitialize(&gpio_reset, &cfg_reset, cfg_reset.BaseAddress);


    xil_printf("All GPIOs initialized.\r\n");


    // Set all directions to output
    xil_printf("Setting directions...\r\n");
    XGpio_SetDataDirection(&gpio_data1, GPIO_CHANNEL, 0x00000000);
    XGpio_SetDataDirection(&gpio_data2, GPIO_CHANNEL, 0x00000000);
    XGpio_SetDataDirection(&gpio_data3, GPIO_CHANNEL, 0x00000000);
    XGpio_SetDataDirection(&gpio_data4, GPIO_CHANNEL, 0x00000000);
    XGpio_SetDataDirection(&gpio_data5, GPIO_CHANNEL, 0x00000000);
    XGpio_SetDataDirection(&gpio_reset, GPIO_CHANNEL, 0x00000000);
    xil_printf("All GPIO directions set to output.\r\n");


    // Send data
    xil_printf("Sending data to ONNs...\r\n");
    XGpio_DiscreteWrite(&gpio_data1, GPIO_CHANNEL, 0xFFFF0000);
    XGpio_DiscreteWrite(&gpio_data2, GPIO_CHANNEL, 0xFFFF0000);
    XGpio_DiscreteWrite(&gpio_data3, GPIO_CHANNEL, 0xFFFF0000);
    XGpio_DiscreteWrite(&gpio_data4, GPIO_CHANNEL, 0xFFFF0000);
    XGpio_DiscreteWrite(&gpio_data5, GPIO_CHANNEL, 0xFFFF0000);
    xil_printf("Data sent to all 5 ONNs.\r\n");


    sleep(10);
    // Send reset pulse
    xil_printf("Sending reset pulse...\r\n");
    XGpio_DiscreteWrite(&gpio_reset, GPIO_CHANNEL, 1);
    sleep(10);  // 1,000,000 microseconds = 1 second
    XGpio_DiscreteWrite(&gpio_reset, GPIO_CHANNEL, 0);
    xil_printf("Reset pulse sent.\r\n");


    while (1);


    return 0;
}


