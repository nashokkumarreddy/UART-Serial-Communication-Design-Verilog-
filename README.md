# UART Serial Communication Design (Verilog)

## 📌 Project Overview
This project is a fully functional implementation of a **Universal Asynchronous Receiver-Transmitter (UART)** designed in Verilog HDL. It enables serial communication between an FPGA and external devices (like a laptop or sensor).

The design includes a custom **Baud Rate Generator**, a **Transmitter (Tx)**, and a **Receiver (Rx)** with oversampling logic for robust data recovery. The project has been verified via simulation in **ModelSim** and is ready for synthesis on Xilinx/Intel FPGAs.

## 📂 File Structure
| File Name | Description |
| :--- | :--- |
| `baud_rate_gen.v` | Generates the "tick" pulse for synchronization. Uses 16x oversampling. |
| `uart_tx.v` | The Transmitter module (Parallel-to-Serial converter). |
| `uart_rx.v` | The Receiver module (Serial-to-Parallel converter). |
| `uart_tb.v` | The Testbench for ModelSim (Loopback test: Tx → Rx). |
| `uart_top.v` | Top-level wrapper for FPGA implementation (Echo System). |

## ⚙️ Key Features
* **Language:** Verilog (IEEE 1364-2005)
* **Data Frame:** 1 Start bit, 8 Data bits, 1 Stop bit, No Parity.
* **Oversampling:** 16x oversampling in the Receiver for noise immunity.
* **Configurable Baud Rate:** The divisor is parameterized for easy adjustment to any system clock.

## 🚀 How to Run Simulation (ModelSim)
1.  Open **ModelSim**.
2.  Create a new project and add `baud_rate_gen.v`, `uart_tx.v`, `uart_rx.v`, and `uart_tb.v`.
3.  **Compile All** files.
4.  Start Simulation on the library `work.uart_tb`.
5.  Add signals to the **Wave** window (`clk`, `rst`, `data_in`, `data_out`, `tx_line`).
6.  Run the simulation (`run -all`).
7.  **Verify:** Check the Transcript window for "SUCCESS" messages or view the Waveform to see `data_in` matching `data_out`.

## 🛠️ Hardware Implementation (FPGA)
To run this on a physical board (e.g., Basys 3, Arty A7, DE10-Lite):

1.  **Calculate the Divisor:**
    Update the `DIVISOR` parameter in `baud_rate_gen.v` using this formula:
    ```
    Divisor = System_Clock_Freq / (Baud_Rate * 16)
    ```
    *Example: For 100 MHz clock and 9600 baud -> 100,000,000 / (9600 * 16) = 651*

2.  **Synthesis:**
    * Open **Xilinx Vivado** or **Intel Quartus**.
    * Add all design files (excluding the testbench).
    * Set `uart_top.v` as the Top Module.
    * Assign pins (Constraints) for `clk`, `rst`, `RsRx`, and `RsTx`.

3.  **Testing:**
    * Flash the FPGA.
    * Open **Tera Term** or **PuTTY** on your PC.
    * Set Baud Rate to 9600.
    * Type characters; if the "Echo" system works, they will appear on the terminal.

## 📊 Future Improvements
* Add a FIFO (First-In-First-Out) buffer to handle high-speed data bursts.
* Implement Parity Bit logic (Odd/Even) for error checking.
* Add interrupt capability for embedded processor integration.

## 📝 Author
* **N ASHOK KUMAR REDDY ** - *Initial Work*
* Electronics and Communication Engineering (ECE) Student# uart-serial-communication-fpga
Full duplex UART implementation in Verilog features a custom baud rate generator, 16x oversampling receiver, and loopback verification. Ready for Xilinx/Intel FPGAs.
