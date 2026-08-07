# Obstacle Avoidance Mobile Robot using Oscillatory Neural Networks (ONNs)

##  Introduction
### Motivation
Edge devices collect large amounts of data from the environment. Conventional Von Neumann architectures face limitations due to the **memory–processing bottleneck**, consuming more time and power. 

Oscillatory Neural Networks (ONNs) provide a **Non-Von Neumann architecture** (in-memory computing), enabling parallel processing, lower latency, and reduced power consumption. This makes them suitable for real-time edge applications, such as building an **obstacle-avoiding mobile robot**.

### Problem Statement
Design and implement an obstacle avoidance mobile robot using ONNs, achieving lower time and power requirements compared to conventional AI algorithms.

### Overview of Proposed Solution
- ONNs mimic biological neurons and support **parallel computation**, reducing decision latency.
- ONNs overcome the **Von Neumann bottleneck** by eliminating memory–processing data transfer.
- The robot uses **two ONNs**:
  - **5×8 ONN** for obstacle sensing.
  - **1×8 ONN** for decision-making (navigation commands).

---

## Background and Literature Review
### Basics of ONNs
- ONNs consist of arrays of interconnected neurons with weighted synapses.
- Each neuron oscillates in phase; neurons iteratively adjust based on neighbors.
- The network evolves toward a **minimum energy state**, which represents the recognized pattern.

### Digital ONN Workflow (example with 8 neurons)
1. **Hebbian Learning Rule** – Generate weight matrix (8×8).
2. **Output Signal Calculation** – Flip-flops & multiplexers produce oscillatory outputs.
3. **Input Signal Calculation** – Compute *nin* using weighted connections.
4. **Phase Alignment** – Adjust phase based on signal edge order (+Δφ or −Δφ).
5. **Final Output** – Match result against trained patterns; select closest.

---

## Methodology
### System Overview (ZYBO Z7 board)

#### PL (Programmable Logic) Part
- **5×8 ONN (Obstacle Detector)**:
  - Trained on **256 exhaustive patterns** from 8 ToF proximity sensors.
- **1×8 ONN (Decision Maker)**:
  - Trained on **16 navigation patterns** (left, forward, right).
- Output of 5×8 ONN → Input to 1×8 ONN.

#### PS (Processing System) Part
- Block diagram connecting PS and PL through **AXI GPIO**.
- Sensor data (via **I2C**) converted into 5×8 matrix → sent to PL.

#### UART Communication
- Final direction output sent via **PMOD → Arduino UNO**.
- Arduino controls motors using a motor driver.

---

## Results and Analysis
### Results
- **Vivado Utilization Report** provided.
- Time for cascaded ONNs to reach a decision: **108 µs** (simulation).

**Example Outputs:**
```
Input (5×8 ONN)   →   Output (1×8 ONN)   →   Navigation
--------------------------------------------------------
Pattern A         →   Vector 1          →   Forward
Pattern B         →   Vector 2          →   Right
Pattern C         →   Vector 3          →   Left
```

### Analysis
- **5×8 ONN** performs accurately (trained on exhaustive patterns).
- **1×8 ONN** shows reduced accuracy (trained on only 16 patterns).
- **Resource Utilization**:
  - Higher LUT usage compared to reference paper [1].
  - Reason: Entire computation implemented in hardware, unlike [1] where some functions were offloaded to PS.

---

## References
[1] https://hal.science/hal-04007886/ 
[2] https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=9967581
