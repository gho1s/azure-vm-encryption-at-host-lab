# Azure VM Security Hardening: Encryption at Host

**Hands-on Microsoft Azure security configuration and troubleshooting lab**

> **Outcome:** Successfully enabled **Encryption at host** for an Azure virtual machine after troubleshooting a subscription-level feature registration error. This repository documents the configuration, failed attempt, investigation, corrective action, and successful update using six screenshots captured during the lab.

## Project overview

This lab focused on protecting virtual machine data using Azure's **Encryption at host** setting. The work involved reviewing the OS disk of `SecurityLab-VM`, attempting to enable the setting, diagnosing an Azure Compute feature registration error, using Azure Cloud Shell to register the feature, and retrying the configuration.

The strongest evidence in this project is not just the final success notification: it is the **troubleshooting sequence** showing how the initial failure was investigated and resolved.

## Architecture and workflow

![Architecture and workflow](docs/architecture.svg)

| Component | Purpose | Evidence |
|---|---|---|
| Azure VM `SecurityLab-VM` | Target virtual machine | Screenshot 01 |
| OS managed disk | Disk configuration reviewed | Screenshot 01 |
| Encryption at host | VM-level encryption setting | Screenshots 02, 06 |
| Azure subscription feature registration | Resolved prerequisite error | Screenshots 03–05 |
| Azure Cloud Shell / PowerShell | Executed feature registration | Screenshot 05 |

**Scope:** This is a focused VM hardening exercise. It does not demonstrate a complete encryption key-management strategy, customer-managed keys, disk encryption at rest configuration, Azure Key Vault integration, or comprehensive Zero Trust controls.

## Implementation walkthrough with evidence

### 1. Inspect the VM's disk configuration

Opened the **Disks** blade for `SecurityLab-VM` and reviewed the operating system disk and its properties before making security changes. Establishing the existing configuration is important for comparing the state before and after hardening.

![VM disk configuration](screenshots/01-vm-disk-configuration.jpg)

**Evidence:** Azure portal view of the VM OS disk and disk settings. The image does not, by itself, prove Encryption at host was enabled.

### 2. Review Encryption at host before the change

Opened the VM's disk settings and located the **Encryption at host** option. The initial screenshot shows the option set to **No**. Attempted to change the setting to **Yes**.

![Encryption at host before](screenshots/02-encryption-before.jpg)

**Security rationale:** Encryption at host is an Azure VM feature designed to encrypt supported data handled by the VM host. It is a distinct setting from managed disk server-side encryption and guest OS encryption.

### 3. Capture and investigate the failed update

The initial update did **not** complete. Azure returned a failed update notification referencing the subscription feature `Microsoft.Compute/EncryptionAtHost`.

![Failed update](screenshots/03-failed-update.jpg)

**Troubleshooting insight:** The failure suggested a prerequisite or subscription capability issue rather than proof that the disk was corrupted or that encryption was active. Recording the error was essential to understanding the resolution.

### 4. Investigate subscription preview features

Navigated to the Azure subscription's **Preview features** area to investigate the feature registration state and available controls.

![Preview feature investigation](screenshots/04-preview-feature-investigation.jpg)

**Evidence:** The subscription feature management interface used during troubleshooting. The screenshot alone does not prove a specific feature was already registered.

### 5. Register the EncryptionAtHost feature using Cloud Shell

Opened Azure Cloud Shell with PowerShell and ran the registration workflow for the `Microsoft.Compute` provider's `EncryptionAtHost` feature. The terminal screenshot shows **RegistrationState: Registered**.

![Cloud Shell registration](screenshots/05-feature-registration.jpg)

Example PowerShell commands corresponding to the workflow:

```powershell
Register-AzProviderFeature -FeatureName 'EncryptionAtHost' -ProviderNamespace 'Microsoft.Compute'
Get-AzProviderFeature -FeatureName 'EncryptionAtHost' -ProviderNamespace 'Microsoft.Compute'
```

> Feature availability and registration requirements can vary by Azure subscription, region, VM configuration, and current Azure platform behavior. The commands above are a reproducible reference, not a claim that they are required for every deployment.

### 6. Retry and verify the VM update

Returned to the VM's disk settings, selected **Yes** for **Encryption at host**, and applied the change. The final screenshot shows the setting enabled and a **Successfully updated virtual machine** notification.

![Encryption at host success](screenshots/06-encryption-success.jpg)

**Verified outcome:** The Azure portal reported a successful VM update with Encryption at host set to Yes. The screenshots do not independently demonstrate cryptographic operations, key rotation, or the state of every disk/temporary disk attached to the VM.

## Results

| Validation | Result |
|---|---|
| Inspected OS disk settings | Completed |
| Identified initial Encryption at host state | No, before change |
| Recorded unsuccessful update | Captured |
| Investigated subscription feature settings | Captured |
| Verified feature registration in Cloud Shell | Registered |
| Reapplied Encryption at host configuration | Successful VM update notification |

## Troubleshooting summary

**Problem:** Azure rejected the initial attempt to update the VM's Encryption at host configuration.

**Investigation:** Reviewed Azure update notifications and the subscription feature management page.

**Action:** Used Cloud Shell PowerShell to register the `Microsoft.Compute/EncryptionAtHost` feature and confirmed a `Registered` state.

**Outcome:** Retried the VM configuration and observed a successful update notification.

**Lesson:** Cloud security engineering involves understanding prerequisites, interpreting platform errors, validating corrective actions, and documenting evidence—not simply selecting a setting in a portal.

## Security considerations and limitations

- The screenshots establish a successful Azure portal configuration update, **not** an independent audit of the underlying encryption implementation.
- Encryption at host does not replace access control, monitoring, patching, backups, or network hardening.
- Feature support and VM restart/deallocation requirements can vary; consult current Microsoft documentation before repeating in production.
- No penetration test, attacker simulation, customer-managed key implementation, or automated compliance evaluation was performed in the provided evidence.
- **Cost:** A VM, managed disks, monitoring, and related resources may continue to incur charges. Stop/deallocate or remove resources that are no longer needed, after checking whether retained disks and other resources still bill.

## Repository contents

```text
azure-vm-encryption-at-host-lab/
├── README.md
├── screenshots/
│   ├── 01-vm-disk-configuration.jpg
│   ├── 02-encryption-before.jpg
│   ├── 03-failed-update.jpg
│   ├── 04-preview-feature-investigation.jpg
│   ├── 05-feature-registration.jpg
│   └── 06-encryption-success.jpg
├── docs/
│   ├── architecture.svg
│   ├── implementation.md
│   ├── troubleshooting.md
│   ├── lessons-learned.md
│   └── screenshot-guide.md
└── scripts/
    └── feature-registration.ps1
```

## Skills demonstrated

**Microsoft Azure · VM Security Hardening · Encryption at Host · Azure Managed Disks · Azure Compute Feature Registration · Azure Cloud Shell · PowerShell · Troubleshooting · Configuration Validation · Technical Documentation**

## Resume-ready project entry

**Azure Virtual Machine Security Hardening — Encryption at Host (Personal Lab)**

- Configured Azure virtual machine encryption-at-host settings to strengthen VM data protection, validating the change through Azure portal update results.
- Diagnosed a failed VM security configuration update associated with the `Microsoft.Compute/EncryptionAtHost` feature prerequisite.
- Used Azure Cloud Shell and PowerShell to register the required subscription feature, verified its registered state, and successfully reapplied the VM configuration.
- Documented the before-and-after configuration, troubleshooting steps, and validation evidence in a GitHub technical portfolio.

## Future enhancements

1. Verify the configuration through Azure PowerShell or CLI and capture structured command output.
2. Review disk encryption and key-management options, including managed disk server-side encryption and customer-managed keys.
3. Add Azure Policy auditing of Encryption at host settings where supported.
4. Create a repeatable deployment and verification process using infrastructure as code.
5. Expand the lab to include least-privilege RBAC and Defender for Cloud recommendations.

## Screenshot privacy note

The browser/account header area has been covered in the supplied portfolio images. **Manually review every image before publishing** for remaining subscription identifiers, resource details, or sensitive information. The original photos are not included in this GitHub-ready package.
