# CI/CD Deployment
Initial deployment of the toolchain

```
https://cloud.ibm.com/devops/setup/deploy?env_id=ibm:yp:<IBM-REGION>
&region_name=<IBM-REGION>
&repository=<INFRASTRUCTURE-REPO-URL>
&branch=<INFRASTRUCTURE-REPO-BRANCH>
&repository_token=<INFRASTRUCTURE-REPO-TOKEN>
&apiKey=<IBM-API-KEY>
&toolchain_name=<TOOLCHAIN-NAME>
&source_provider=<IBM-GIT-PROVIDER>
&type=<IBM-GIT-PROVIDER-TYPE>
&customer=<CUSTOMER-NAME>
```

- **IBM-REGION**: Region where you want to deploy every objects -> ```$ ibmcloud regions```
- **INFRASTRUCTURE-REPO-URL**: URL of the Git infrastructure repo -> ```https://github.ibm.com/tech-garage-spgi/infra-repo```
- **INFRASTRUCTURE-REPO-BRANCH**: ```master```/```release```/```develop```,...
- **INFRASTRUCTURE-REPO-TOKEN**: Access token to Git repo. [Create GitHub Personal Access Token](https://github.ibm.com/settings/tokens).
- **IBM-API-KEY**: Access token to IBM account. [Create IBM API Key](https://cloud.ibm.com/iam/apikeys).
- **TOOLCHAIN-NAME**: Name for the new toolchain resource.
- **IBM-GIT-PROVIDER**: Git access object -> ```github_integrated``` for **GitHub**, ```hostedgit``` for **GitLab**.
- **IBM-GIT-PROVIDER-TYPE**: Type of repo -> ```link``` for **Existing**.
- **CUSTOMER-NAME**: Prefix name for every new cloud objects.
