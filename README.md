# UVM-Verification-of-an-AES-Module
## 📌 Project Overview
This repository contains a high-assurance verification environment for an **AES-128 Encryption/Decryption** hardware module. The testbench is built using **SystemVerilog** and the **Universal Verification Methodology (UVM)**. 

The environment integrates a **Python-based Reference Model** to validate the hardware's mathematical correctness, ensuring that the RTL implementation matches the NIST standard for AES.

---

## 🏗️ System Architecture
The verification environment is designed to be modular and scalable, following the standard UVM component hierarchy:

- **AES Driver:** Converts transactions into pin-level activity on the AES interface.
- **AES Monitor:** Passively samples the interface to capture completed encryption cycles and broadcasts them to the Scoreboard.
- **Scoreboard & Reference Model:** Integrates a Python script that calculates the "Golden" ciphertext. The Scoreboard performs a cycle-accurate comparison between the RTL output and the Python result.
- **Functional Coverage:** Tracks the distribution of keys, data patterns, and back-to-back transaction sequences.

---
🛠️ Verification Features
-------------------------

*   **Constrained Random Stimulus:** Uses uvm\_sequence to generate non-repeating keys and plaintext combinations.
    
*   **Layered Sequences:** Supports complex scenarios such as key-rotation during active encryption.
    
*   **TLM Communication:** Efficient data transfer between components using Analysis Ports and FIFOs.
    
*   **Config DB:** Centrally managed simulation parameters.
    

📊 Verification Results
-----------------------

The environment is designed to achieve:

1.  **Functional Coverage:** 100%.
    
2.  **Code Coverage:** Statement, Branch, and FSM coverage sign-off.
    
3.  **Zero-Error Tolerance:** The Scoreboard will trigger a UVM\_ERROR immediately upon any data mismatch between RTL and the Python model.
