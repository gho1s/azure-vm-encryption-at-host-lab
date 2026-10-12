# Lessons learned

1. **Security controls have prerequisites.** An option visible in a portal may still fail if the subscription or VM does not meet requirements.
2. **Errors are valuable evidence.** The failed update notification directed investigation toward the Azure Compute feature.
3. **Use the command line for verification.** Cloud Shell made it possible to check feature registration state instead of guessing.
4. **Validate the final state.** A configuration attempt is not a successful deployment until the platform confirms the update.
5. **Document the troubleshooting path.** Explaining a real failure and resolution is often more valuable than showing only a final success screenshot.
6. **Separate evidence from assumptions.** The screenshots support enabling Encryption at host; they do not support claims about CMK, Key Vault, or production-grade Zero Trust architecture.

## Possible next lab
Add Azure Policy to audit Encryption at host settings, verify settings programmatically, and create a Defender for Cloud / Sentinel alerting workflow for configuration drift.
