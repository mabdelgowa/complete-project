// cidr blocks are added as objects in list (take in consideration the zero indexing)
cidr_blocks = [{cidr_block = "10.0.0.0/16", name = "myapp" },
                {cidr_block = "10.0.50.0/24", name = "myapp"}
              ]

my_ip = ["102.184.122.122/32"] // this is my public IP address

env_prefix = "myapp"

instance_type = "t2.micro"
