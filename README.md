# General Performance Infrastructure with Terraform, Github Actions and AWS

## About security hardening with OpenID Connect
OpenID Connect allows your workflows to exchange short-lived tokens directly from your cloud provider.

GitHub Actions workflows are often designed to access a cloud provider (such as AWS, Azure, GCP, or HashiCorp Vault) in order to deploy software or use the cloud's services. Before the workflow can access these resources, it will supply credentials, such as a password or token, to the cloud provider. These credentials are usually stored as a secret in GitHub, and the workflow presents this secret to the cloud provider every time it runs
With OpenID Connect (OIDC), you can take a different approach by configuring your workflow to request a short-lived access token directly from the cloud provider.

## Configuring the OID trust with the Cloud
When you configure your cloud to trust GitHub's OIDC provider, you must add conditions that filter incoming requests, so that untrusted repositories or workflows can’t request access tokens for your cloud resources

* Before granting an access token, your cloud provider checks that the subject and other claims used to set conditions in its trust settings match those in the request's JSON Web Token (JWT). As a result, you must take care to correctly define the subject and other conditions in your cloud provider.

* The OIDC trust configuration steps and the syntax to set conditions for cloud roles (using Subject and other claims) will vary depending on which cloud provider you're using.


## Creating OpenID Connect indentity providers
IAM OIDC identity providers are entities in IAM that describe an external identity provider (IdP) service that supports the OpenID Connect (OIDC) standard, such as Google or Salesforce.

