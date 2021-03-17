Setting up LetsEncrypt for Nginx proxy in Docker swarm
===============
This took a while to figure out and a lot of trial and error. The working implementation was largely taken from [this
article's walkthrough](https://medium.com/@dbillinghamuk/certbot-certificate-verification-through-nginx-container-710c299ec549).

#### Notable differences:
Instead of a host path of `/root/certs-data/` it is changed to `./certs-data/` relative to the proxy image's `WORKDIR`.
This is important when you are generating the cert manually from the Digital Ocean Droplet host. You'll need to
adjust the certbot command as below.

## Cert Creation
We use Certbot to generate a LetsEncrypt SSL cert. An effort was made to containerize and automate this, but it proved
to be difficult and complicated. Ideally it could get automated in future. Until then, here are instructions on how to
generate and setup the Cert manually.

*This should only need to happen one time from the Digital Ocean Droplet host*:
1. SSH into the Digital Ocean droplet host. Ensure your account can run things as root with something like `sudo ls .`
2. Ensure the pbbg_production docker stack is deployed and accessible over normal http. Most importantly the `pbbg/proxy` service should be
running and you should be able to access this url: `http://www.pbbg.com/.well-known/`. If you cannot access that then
certbot will not be able to create the certs.
3. Perform a dry-run test to see if all is in order:
   ```shell
   sudo certbot certonly --webroot -w /home/githubuser/certs-data/ -d www.pbbg.com --staging --dry-run
   ```
    > Keep in mind the webroot path is the absolute path in the DO droplet host, and also the user account (instead of
    > 'githubuser') is whatever account that does the automated github builds (it's one of the Github Actions secrets
    > in the repository settings).
4. If there are no errors from the `--dry-run` then go ahead and run it again for real (omit the `--dry-run` argument).
5. Confirm that the new `.pem` keys were created by listing via `sudo ls /etc/letsencrypt/live/www.pbbg.com/`. If you see
'fullchain.pem' and 'privkey.pem' then it was successful.
6. Last step is a clean restart:
   * restart the docker stack - `docker stack rm pbbg_production`
   * wait for all containers to go down (confirm with `docker ps`)
   * nuke all docker files and artifacts on DO droplet host (`docker system prune --all --force`)
   * rerun the deployment steps that Github Actions build does:
    ```shell
    export DB_DATABASE=someSecret DB_USERNAME=someSecret2 DB_PASSWORD=someSecret3;
    bash ./create-stack.sh --databasename=someSecret --username=someSecret2 --rootpassword=someSecret3 --production=true
    ```
   > The `--production=true` is important if you are deploying/doing this in production, otherwise leave it off.


## Cert Renewal
LetsEncrypt certs need to be renewed every 90 days. Ideally we automate this with a crontab or something, but for now
you can renew them with a simple command from the Digital Ocean Droplet host.

To do a dry run for testing:
```shell
sudo certbot renew --dry-run
```
should output something that looks like this:
```shell
githubuser@dev:/$ sudo certbot renew --dry-run
[sudo] password for githubuser: 
Saving debug log to /var/log/letsencrypt/letsencrypt.log

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/dev.pbbg.com.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Cert not due for renewal, but simulating renewal for dry run
Plugins selected: Authenticator webroot, Installer None
Simulating renewal of an existing certificate for dev.pbbg.com
Performing the following challenges:
http-01 challenge for dev.pbbg.com
Using the webroot path /home/githubuser/certs-data for all unmatched domains.
Waiting for verification...
Cleaning up challenges

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
new certificate deployed without reload, fullchain is
/etc/letsencrypt/live/dev.pbbg.com/fullchain.pem
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Congratulations, all simulated renewals succeeded: 
  /etc/letsencrypt/live/dev.pbbg.com/fullchain.pem (success)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
```

Finally, to run the Cert Renewal for real simply rerun as `sudo certbot renew`.
