# Implementation details

## Objective
Enable **Encryption at host** on `SecurityLab-VM` and document successful configuration after troubleshooting a failed update.

## Prerequisites
- Azure subscription with permissions to modify the target VM and register provider features, where applicable.
- A compatible Azure VM and supported region/size/disk configuration.
- Access to Azure portal and Azure Cloud Shell.
- Awareness that VM changes can require downtime or restart and that Azure resources may incur charges.

## Reconstructed sequence from the supplied screenshots

1. Open `SecurityLab-VM` → **Disks**; review the OS disk and encryption-related settings.
2. Open disk settings and inspect **Encryption at host**; initially set to **No**.
3. Attempt to enable the setting; capture the failed Azure update notification.
4. Investigate the subscription's **Preview features** / feature registration interface.
5. Open **Cloud Shell (PowerShell)**; register `EncryptionAtHost` under `Microsoft.Compute` and check that `RegistrationState` reports `Registered`.
6. Return to the VM's disk settings; enable Encryption at host again.
7. Confirm the setting is **Yes** and Azure reports **Successfully updated virtual machine**.

## Validation approach

**Observed:** The final screenshot shows Encryption at host set to Yes and a successful VM update notification.

**Recommended additional validation (not shown in the evidence):** Query the VM configuration through Azure CLI/PowerShell; capture its encryption-at-host property and verify support, disk inventory, and expected security posture.

## Distinctions

Encryption at host is not equivalent to Azure Disk Encryption (guest OS encryption) or to customer-managed-key configuration. Avoid claiming these additional controls were deployed without independent evidence.
