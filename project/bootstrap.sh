#/usr/bin/env bash
#--------------------------------------------------------------------------------------------------------------------#
#title           :bootstrap.sh
#description     :this script will bootstrap the infrastructure in replacement of jenkins
#author          :Taranveer TENGURCHITTOO (ttaran7@gmail.com)
#date            :2021-10-27
#version         :0.1
#bash_version    :GNU bash, version 5.1.8(1)-release (x86_64-apple-darwin20.3.0)
#--------------------------------------------------------------------------------------------------------------------#
#Parameters provided by user
USAGE="bootstrap.sh -[cdh]"
#--------------------------------------------------------------------------------------------------------------------#
#functions - visual output of script
function column-fill {
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}
function get-colours {
    source ./colours.sh
}
#functions - logic of script
#--------------------------------------------------------------------------------------------------------------------#
function terraform-create() {
    cd iac
    terraform init
    terraform validate
    terraform plan -out /tmp/terraform.plan
    terraform apply /tmp/terraform.plan
    cd -
}
function terraform-destroy() {
    cd iac
    terraform destroy
    cd -
}
function secret-create() {
    HASH_1=$(openssl rand -base64 64 | tr -cd '[:alnum:]._-' | cut -c1-32)
    HASH_2=$(openssl rand -base64 64 | tr -cd '[:alnum:]._-' | cut -c1-32)

    REGION=$(grep -i region iac/terraform.tfvars | awk '{print $NF}' | sed 's/\"//g')
    if aws secretsmanager list-secrets --region ${REGION} | grep -iq ckc-dc-secret; then
        echo "secret exists"
    else
        aws secretsmanager create-secret --region ${REGION} --name ckc-dc-secret
        aws secretsmanager put-secret-value --region ${REGION} --secret-id ckc-dc-secret --secret-string "[{\"Key\":\"db_password\",\"Value\":\"${HASH_1}\"},{\"Key\":\"wp_password\",\"Value\":\"${HASH_2}\"}]"
    fi
}
function secret-destroy() {
    echo ${PWD}
    REGION=$(grep -i region iac/terraform.tfvars | awk '{print $NF}' | sed 's/\"//g')
    if aws secretsmanager list-secrets --region ${REGION} | grep -iq ckc-dc-secret; then
        aws secretsmanager delete-secret --region ${REGION} --secret-id ckc-dc-secret
    fi
}
function ssh-keypair-create() {
    if [[ ! -f ~/.ssh/ckc-dev-key_pair ]]; then
        ssh-keygen -t "rsa" -b "4096" -N '' -f ~/.ssh/ckc-dev-key_pair -C "ttaran7@gmail.com"
    fi
}
function ssh-keypair-destroy() {
    if [[ ! -f ~/.ssh/ckc-dev-key_pair ]]; then
        rm -rf ~/.ssh/ckc-dev-key_pai*
    fi
}
#get current public IP
function get-current-ip {
    CURRENT_IP_ADDRESS=$(curl ifconfig.io)
    sed
}

#--------------------------------------------------------------------------------------------------------------------#
#main
get-colours
while getopts ':hdc' option; do
    case $option in
    h)
        column-fill
        echo "Help for the project bootstrap"
        echo
        echo "Syntax: ./bootstrap.sh [-h|c|d]"
        echo "options:"
        echo
        echo "c     create the infrastructure."
        echo "d     delete the infrastructure."
        echo "h     print this help."
        column-fill
        exit 1
        ;;

    d)
        column-fill
        terraform-destroy
        ssh-keypair-destroy
        #secret-destroy
        column-fill
        echo -e "${GREEN}Infrastructure has been destroyed${COLOR_OFF}"
        exit 2
        ;;

    c)
        column-fill
        secret-create
        ssh-keypair-create
        terraform-create
        column-fill
        echo -e "${GREEN}Infrastructure has been created${COLOR_OFF}"
        exit 3
        ;;
    *)
        if [[ "$#" -ne 1 ]]; then
            column-fill
            echo -e "${RED}Number of arguments provided is incorrect"
            echo -e "${GREEN}Usage : ${USAGE}"
            column-fill
        else
            wrapper
        fi
        ;;
    esac
done
#--------------------------------------------------------------------------------------------------------------------#
