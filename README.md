<div align="center">

# 🧠 GreenMatrix

### FPGA AI Matrix Accelerator

*A Parameterized Systolic Array Architecture Built in SystemVerilog*

<br>

![SystemVerilog](https://img.shields.io/badge/SystemVerilog-Hardware%20Design-blue?style=for-the-badge)
![Vivado](https://img.shields.io/badge/AMD-Vivado-E01F27?style=for-the-badge)
![FPGA](https://img.shields.io/badge/FPGA-Artix--7-00A86B?style=for-the-badge)
![AI Accelerator](https://img.shields.io/badge/AI-Systolic%20Array-8A2BE2?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)

---

**GreenMatrix** is an FPGA-based AI accelerator that demonstrates how matrix multiplication can be performed using a parameterized systolic array architecture. Built entirely in **SystemVerilog**, the project implements reusable hardware modules, simulation-driven verification, and full synthesis and implementation using **AMD Vivado**.

</div>

---

# 🚀 Project Highlights

- ✅ Parameterized hardware design
- ✅ Reusable Processing Elements (PE)
- ✅ Multiply-Accumulate (MAC) architecture
- ✅ 2×2 Systolic Array
- ✅ Matrix Loader
- ✅ Controller Finite State Machine (FSM)
- ✅ UART module framework
- ✅ Fully simulated with Icarus Verilog
- ✅ Synthesized in AMD Vivado
- ✅ Successfully Implemented on Artix-7 Architecture

---

# 🏗️ System Architecture

```
                 Matrix A Inputs
                       │
                       ▼
              ┌────────────────┐
              │ Matrix Loader  │
              └───────┬────────┘
                      │
                      ▼

           ┌────────────────────────┐
           │    2×2 Systolic Array  │
           │                        │
           │   PE ─────► PE         │
           │   │          │         │
           │   ▼          ▼         │
           │   PE ─────► PE         │
           └────────────────────────┘
                      │
                      ▼

                Matrix C Output
```

---

# 📂 Repository Structure

```text
GreenMatrix
│
├── rtl
│   ├── package.sv
│   ├── mac_unit.sv
│   ├── pe.sv
│   ├── systolic_array.sv
│   ├── controller.sv
│   ├── matrix_loader.sv
│   ├── output_buffer.sv
│   ├── uart_rx.sv
│   ├── uart_tx.sv
│   └── greenmatrix_top.sv
│
├── tb
│
├── constraints
│
├── docs
│
├── images
│   ├── GM_synthesis.png
│   └── GM_implementation.png
│
└── README.md
```

---

# ⚙️ Core Modules

| Module | Description |
|---------|-------------|
| **package.sv** | Global parameters and reusable data types |
| **mac_unit.sv** | Multiply-Accumulate arithmetic engine |
| **pe.sv** | Processing Element containing MAC and forwarding logic |
| **systolic_array.sv** | Parameterized 2×2 systolic array |
| **controller.sv** | Finite State Machine controlling execution |
| **matrix_loader.sv** | Loads matrix values into the array |
| **output_buffer.sv** | Collects completed matrix results |
| **greenmatrix_top.sv** | Top-level FPGA integration |

---

# 🧪 Verification

Each hardware component was verified independently before full integration.

### Completed Testbenches

- ✔ MAC Unit
- ✔ Processing Element
- ✔ Controller FSM
- ✔ Parameterized Systolic Array
- ✔ Top-Level Integration

---

# 📊 Matrix Multiplication Example

### Input

```
A = |1 2|
    |3 4|

B = |5 6|
    |7 8|
```

### Output

```
C = |19 22|
    |43 50|
```

All simulations completed successfully.

---

# 🔬 Vivado RTL Synthesis

<p align="center">
<img src="images/GM_synthesis.png" width="600">
</p>

---

# ⚡ Vivado Device Implementation

<p align="center">
<img src="images/GM_implementation.png" width="600">
</p>

---

# 🛠️ Development Tools

- SystemVerilog
- AMD Vivado 2026.1
- Icarus Verilog
- GTKWave
- Git
- GitHub
- Windows PowerShell

---

# 📈 Project Progress

| Stage | Status |
|--------|--------|
| Architecture Design | ✅ Complete |
| RTL Development | ✅ Complete |
| Unit Verification | ✅ Complete |
| System Integration | ✅ Complete |
| Vivado Synthesis | ✅ Complete |
| Vivado Implementation | ✅ Complete |
| GitHub Portfolio | ✅ Complete |

---

# 🔮 Future Enhancements

- 4×4 Systolic Array
- 8×8 AI Accelerator
- AXI4 Interface
- DDR Memory Support
- DMA Engine
- PCIe Interface
- INT8 Quantization
- CNN Acceleration
- Tensor Processing Pipeline

---

# 👩🏽‍💻 Author

**A'Yana Leonard**

U.S. Army Veteran • Physics Student • Mathematics Student • FPGA Design • Digital Hardware • AI Acceleration

---

<div align="center">

### *Building efficient hardware for the next generation of AI acceleration.*

⭐ If you enjoyed this project, consider giving it a star!

</div>
