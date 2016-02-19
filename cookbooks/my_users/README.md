my_users Cookbook
=================
This cookbook creates users with SSH access. 

The users belonging to group Sysadmin will have root access
The users belonging to group developers will have access to developer's home directory only

Requirements
------------
TODO: List your cookbook requirements. Be sure to include any requirements this cookbook has on platforms, libraries, other cookbooks, packages, operating systems, etc.

This cookbook works for RHEL/Fedora/CentOS/Amazon Linux.

You will need to put the user specific SSH Public keys in this cookbook 

Attributes
----------

This cookbook will need SSH Pubic Keys. You can put them into databags of respective users.

Usage
-----
Hi,

We are creating two groups - Sysadmin & Dev

Users included in group Sysadmin has root access without any password
required. You will need Private key to login to this user. Users belonging
to Sysadmin group are 'Vader' & 'Han'

Another group is Developers. This has home diretory "/home/developers". We
need ppk file to login to this user. User 'leia' & 'chewbacca' belong to
this group. Please use user 'chewbacca' for logging in as user 'leia' is
locked for testing purpose.

We need to follow the following commands for this tutorial. We need to
enable "root" user on client node so that we can test this recipe. We need
root access as we configure the system files, add users & install
packages.

After installing Chef,Go to diretory called Chef-repo.

and create directory 'cookbooks'
after creating the directory, we need to install dependencies cookbooks
i.e. sudo & users
upload those cookbooks using command "knife cookbook upload -a"
Once we have uploaded these cookbooks, create our cookbook "my_users". You
will find file 'cookbooks/my_users/metadata.rb'. We willl specify
dependancy on cookbook "sudo" & "users".

We will specify our recipe in 'default.rb' file:
cookbooks/my_users/recipes/default.rb

Once we have created recipe, we are going to upload it to Chef server.

we are using data bags to store user specific data. create databags using
'knife data_bag create users'

Steps to execute recipe:

Login to Chef-server with required credentials & root user

$ cd /opt/chef-repo

$ knife cookbook site install users

$ knife cookbook site install sudo

$ knife cookbook upload -a

##To create databags
Databags: Databags are variables that is stored as  JSON and is accessible from chef-server. We can create databags manually or using knife. But as long as the structure is maintaned, you can use databags in either way. 

$ knife data_bag create users

$ cd data_bags/users

Create databag files for users

$ tree data_bags/
data_bags/
&#9492;&#9472;&#9472; users
    &#9500;&#9472;&#9472; chewbacca.json
    &#9500;&#9472;&#9472; han.json
    &#9500;&#9472;&#9472; leia.json
    &#9492;&#9472;&#9472; vader.json
1 directory, 4 files


Upload the data_bag files to Chef server

$ knife data_bag from file users data_bags/users/*


Once done, you can bootstrap a node with our recipe using command.
(Command you need to run directly as config has already been done)

$ cd /opt/chef-repo
$ knife bootstrap xx.xx.xx.xx -r 'recipe[my_users]' --ssh-user root
--ssh-identity-file /opt/chef-repo/chef-test-myuser.pem

Try to login using uesr vader & chewbacca & try to gain root access. User
vader belongs to Sysadmin group, he'll be able to go to root while user
chewbacca will be limited to /home/developers directory as it belongs to
Developers group.


Contributing 
------------
ToDO: 

Check out the git code & make required changes for improvement.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: 
Aniruddha Jawanjal
