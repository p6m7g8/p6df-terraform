p6df::modules::terraform::version() { echo "0.0.1" }
p6df::modules::terraform::deps() { ModuleDeps=( robbyrussell/oh-my-zsh:plugins/terraform ) }

p6df::modules::terraform::external::brew() {

    brew install terraform
    brew install terraform-inventory
    brew install terraform-provisioner-ansible
    brew install terraform-docs
    brew install terraform_landscape
    brew install terraformer
    brew install terraforming
    brew install terragrunt

    brew install terraform@0.11
}

p6df::modules::terraform::home::symlink() {

    ln -fs $P6_DFZ_P6M7G8_DIR/p6-terraform/share/.terraformrc $HOME/.terraformrc
}

p6df::modules::terraform::init() {

    alias tf='terraform'
    alias tfw='terraform workspace'
    alias tg=terragrunt
}

p6df::prompt::terraform::line() {

    local str
    if [ -d .terraform ]; then
	str="terraform: $(p6_terraform_workspace_show)#$(p6_terraform_workspace_tfvar_file)"
    fi

    p6_return_str "$str"
}

p6_terraform_workspace_show() {

    terraform workspace show
}

p6_terraform_workspace_tfvar_file() {

    local ws=$(terraform workspace show)

    p6_return_path "./tfvars/${ws}.tfvars"
}

p6_terraform_validate() {

    terraform validate -var-file=$(p6_terraform_workspace_tfvar_file)
}

p6_terraform_plan() {

    terraform plan -var-file=$(p6_terraform_workspace_tfvar_file)
}

p6_terraform_apply() {

    terraform apply -var-file=$(p6_terraform_workspace_tfvar_file)
}

p6_terraform_console() {

    terraform console -var-file=$(p6_terraform_workspace_tfvar_file)
}

p6_terraform_destroy() {

    terraform destroy -var-file=$(p6_terraform_workspace_tfvar_file)
}
