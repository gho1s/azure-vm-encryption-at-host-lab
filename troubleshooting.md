# Troubleshooting case study

## Symptom
The Azure portal reported **Failed to update virtual machine** during an attempt to enable Encryption at host on `SecurityLab-VM`.

## Clue
The notification referenced `Microsoft.Compute/EncryptionAtHost`, indicating a possible subscription feature prerequisite.

## Diagnostic path
1. Capture the error before making additional changes.
2. Inspect subscription **Preview features** to understand available feature registration controls.
3. Use Azure Cloud Shell with PowerShell to inspect/register the feature.
4. Check that the registration state reports **Registered**.
5. Retry the original VM configuration change.

## Result
The supplied terminal screenshot shows a **Registered** state, and the subsequent Azure portal screenshot shows Encryption at host set to **Yes** with a successful VM update notification.

## What not to infer
The evidence does not establish that registration is necessary for all subscriptions, that there was no VM restart, or that every storage encryption control was enabled.

## Reusable troubleshooting method
**Observe → isolate the failing dependency → verify prerequisites → make a minimal change → retry → validate → document.**
