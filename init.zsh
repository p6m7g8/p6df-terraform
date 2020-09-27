######################################################################
#<
#
# Function: p6df::modules::terraform::version()
#
#>
######################################################################
p6df::modules::terraform::version() { echo "0.0.1" }
######################################################################
#<
#
# Function: p6df::modules::terraform::deps()
#
#>
######################################################################
p6df::modules::terraform::deps() { ModuleDeps=( ohmyzsh/ohmyzsh:plugins/terraform ) }

######################################################################
#<
#
# Function: p6df::modules::terraform::external::brew()
#
#>
######################################################################
p6df::modules::terraform::external::brew() {

    brew install hashicorp/tap/terraform

    brew install terraform-inventory
    brew install terraform-provisioner-ansible
    brew install terraform-docs
    brew install terraform_landscape
    brew install terraformer
    brew install terraforming
    brew install terragrunt

}

######################################################################
#<
#
# Function: p6df::modules::terraform::home::symlink()
#
#>
######################################################################
p6df::modules::terraform::home::symlink() {

    ln -fs $P6_DFZ_P6M7G8_DIR/p6-terraform/share/.terraformrc $HOME/.terraformrc
}

######################################################################
#<
#
# Function: p6df::modules::terraform::init()
#
#>
######################################################################
p6df::modules::terraform::init() {

    alias tf='terraform'
    alias tfw='terraform workspace'
    alias tg=terragrunt
}

######################################################################
#<
#
# Function: str str = p6df::prompt::terraform::line()
#
#  Returns:
#	str - str
#
#>
######################################################################
p6df::prompt::terraform::line() {

    local str
     if [ -d .terraform ]; then
       str="terraform: $(p6_terraform_workspace_show)#$(p6_terraform_workspace_tfvar_file)"
       local str="terraform: $(p6_terraform_workspace_show)#$(p6_terraform_workspace_tfvar_file)"
       p6_return_str "$str"
    else
       p6_return_void
     fi
}

######################################################################
#<
#
# Function: p6_terraform_workspace_show()
#
#>
######################################################################
p6_terraform_workspace_show() {

    terraform workspace show
}

######################################################################
#<
#
# Function: path ./tfvars/${ws}.tfvars = p6_terraform_workspace_tfvar_file()
#
#  Returns:
#	path - ./tfvars/${ws}.tfvars
#
#>
######################################################################
p6_terraform_workspace_tfvar_file() {

    local ws=$(terraform workspace show)

    p6_return_path "./tfvars/${ws}.tfvars"
}

######################################################################
#<
#
# Function: p6_terraform_validate()
#
#>
######################################################################
p6_terraform_validate() {

    terraform validate -var-file=$(p6_terraform_workspace_tfvar_file)
}

######################################################################
#<
#
# Function: p6_terraform_plan()
#
#>
######################################################################
p6_terraform_plan() {

    terraform plan -var-file=$(p6_terraform_workspace_tfvar_file)
}

######################################################################
#<
#
# Function: p6_terraform_apply()
#
#>
######################################################################
p6_terraform_apply() {

    terraform apply -var-file=$(p6_terraform_workspace_tfvar_file)
}

######################################################################
#<
#
# Function: p6_terraform_console()
#
#>
######################################################################
p6_terraform_console() {

    terraform console -var-file=$(p6_terraform_workspace_tfvar_file)
}

######################################################################
#<
#
# Function: p6_terraform_destroy()
#
#>
######################################################################
p6_terraform_destroy() {

    terraform destroy -var-file=$(p6_terraform_workspace_tfvar_file)
}
