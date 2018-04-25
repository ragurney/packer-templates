An attempt at a Docker friendly [Packer](https://www.packer.io/) template for Ubuntu [Vagrant](https://www.vagrantup.com/) box

## Usage

Clone the repository:

    $ git clone .../packer-templates && cd packer-templates

Build a machine image from the template in the repository:

    $ packer build ubuntu-16.04-amd64.json

## Configuration

You can configure each template to match your requirements by setting the following [user variables](https://packer.io/docs/templates/user-variables.html).

 User Variable       | Default Value | Description
---------------------|---------------|----------------------------------------------------------------------------------------
 `compression_level` | 6             | [Documentation](https://packer.io/docs/post-processors/vagrant.html#compression_level)
 `cpus`              | 2             | Number of CPUs
 `disk_size`         | 42000         | [Documentation](https://packer.io/docs/builders/virtualbox-iso.html#disk_size)
 `headless`          | 0             | [Documentation](https://packer.io/docs/builders/virtualbox-iso.html#headless)
 `memory`            | 1024          | Memory size in MB
 `mirror`            |               | A URL of the mirror where the ISO image is available

### Example

Build an uncompressed Ubuntu vagrant box with a 4GB hard disk using the VirtualBox provider:

    $ packer build -only=virtualbox-iso -var compression_level=0 -var disk_size=4000 ubuntu-16.04-amd64.json
