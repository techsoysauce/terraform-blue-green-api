# Terraform Blue Green Deployment

This project will setup a total of 4 EC2 instances in AWS.  2 of the instances will be assigned to the **Blue** environment and the other 2 will be assigned to the **Green** environment.  A load balancer is used to serve traffic to either of the 2 nodes that are in the active (production) environment.  

The goal with Blue/Green  environments is to deploy a new releases to the **Green** side and then gradually re-direct traffic over to the **Green** environment.  Once traffic is fully converted over to **Green**, the **Blue** side becomes the new testing ground for the next update, and so on and so on.  Issuing a **terraform apply** without any additional paremeters will cause the Blue side to become the production environment.


# Commands to know:
1. How to deploy Blue Green infra with terraform and default to **Blue** environment

    terraform apply

2. How to verify which environment and node is reponding

    for i in `seq 1 5`; do curl $(terraform output -raw lb_dns_name); done

3. How to route 90% traffic to **Blue** and 10% to **Green**

    terraform apply -var 'traffic_distribution=blue-90

4. How to route traffic accordingly based on percentages of traffic<br/>
    
    *route 50% to each environment*<br/>
    terraform apply -var 'traffic_distribution=split <br/><br/>

    *route 90% to **Green** and 10% to **Blue** environments.*<br/>
    terraform apply -var 'traffic_distribution=green-90<br/><br/>

    *route 100% to **Green** environment.*<br/>
    terraform apply -var 'traffic_distribution=green<br/><br/>
