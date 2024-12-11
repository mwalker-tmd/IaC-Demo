/*
 * This file defines the NAT Gateway and Elastic IP resources.
 * These are used to translate private vm IP addresses to public IP addresses
 * into public IP addresses. This is how internet access is provided to the
 * private subnets.
 *
 * NOTE: For production systems, it is highly recommended to allocate a static
 *       public IP manually before creating the NAT. This way the public IP does not
 *       change if the NAT is recreated (helpful for whitelisting by API partners).
 *
 *        The public IP address is associated with the NAT Gateway and cannot be changed
 *        once it is created,
 */
resource "aws_eip" "eip" {
    domain = "vpc"

    tags = {
        Name = "${var.env}-${var.project_name}-eip"
    }
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.eip.id
    subnet_id     = aws_subnet.public_zone_1.id

    tags = {
        Name = "${var.env}-${var.project_name}-nat"
    }

    depends_on = [
        aws_internet_gateway.igw,
        aws_subnet.public_zone_1
    ]
}