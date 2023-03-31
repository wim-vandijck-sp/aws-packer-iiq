# aws-packer-iiq
Test project to build IIQ with Packer into an AWS AMI

## Notes on IIQ build

IdentityIQ is being built as part of the ansible playbook. This will result in an almost 100% vanilla IIQ. It checks out a repo with an SSB-based file structure, that contains almost nothing.

The identityiq role in the playbook will thus create a vanilla iiq and any customizations are done in the seri role. This is mostly for demonstration purposes to show how these steps can be performed.

### Customizing IIQ build

So there are two ways to create a customized identityiq installation.

1. Use a repo, where all desired artefacts are stored, and refer to that repo during the build-war task in the identityiq role.
2. Keep the identityiq role as vanilla, and perform any additional steps in subsequent role(s).

* The advantage of the first would be that you need to be perform a single action to always get the same configuration.
* The advantage of the second is that you can make it modular, and parametrize what you want to include in the build or not. In the future this might enable setting these parameters from a different UI before calling the CodeBuild... E.g. do you want to include healthcare artefacts, do you want to include GroupManagement, etc etc.

