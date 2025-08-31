AWS EC2 Launcher Script

This Bash script launches an AWS EC2 instance using the AWS CLI.  
It creates an instance, waits until it’s running, and prints the public IP.

## Usage
1. Configure AWS CLI with your credentials.
2. write this in cli: nano launch-ec2.sh
3. copy the script
4. Update the variables in `launch-ec2.sh`:
   - `AMI_ID`
   - `INSTANCE_TYPE`
   - `KEY_NAME`
   - `SEC_GROUP`
5. Run the script:

```bash
chmod +x launch-ec2.sh
./launch-ec2.sh
