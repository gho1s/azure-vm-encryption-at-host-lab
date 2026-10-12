# Reference commands from the Azure Encryption at host troubleshooting workflow.
# Run only in a subscription where you have authorization to manage provider features.
# Azure behavior/requirements may vary by subscription and VM configuration.

Register-AzProviderFeature -FeatureName 'EncryptionAtHost' -ProviderNamespace 'Microsoft.Compute'
Get-AzProviderFeature -FeatureName 'EncryptionAtHost' -ProviderNamespace 'Microsoft.Compute'
