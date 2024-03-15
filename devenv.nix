{
  pkgs,
  lib,
  ...
}: let
  python = pkgs.python311.withPackages (packages: with packages; [librouteros]);
  ansible-playbook-wrapped = pkgs.writeShellScriptBin "ansible-playbook" ''
    exec ${python}/bin/python ${pkgs.ansible}/bin/.ansible-playbook-wrapped $@
  '';
  ansible = pkgs.symlinkJoin {
    name = "ansible";
    paths = [
      ansible-playbook-wrapped
      pkgs.ansible
    ];
  };
in {
  languages.ansible.enable = true;
  languages.ansible.package = ansible;
  packages = [python];
  enterShell = ''
    mkdir -p $DEVENV_ROOT/.ansible
    export ANSIBLE_SSH_CONTROL_PATH_DIR="$DEVENV_ROOT/.ansible/cp"
    export ANSIBLE_ACTION_PLUGINS="$DEVENV_ROOT/.ansible/plugins/action"
    export ANSIBLE_CACHE_PLUGINS="$DEVENV_ROOT/.ansible/plugins/cache"
    export ANSIBLE_CALLBACK_PLUGINS="$DEVENV_ROOT/.ansible/plugins/callback"
    export ANSIBLE_CONNECTION_PLUGINS="$DEVENV_ROOT/.ansible/plugins/connection"
    export ANSIBLE_FILTER_PLUGINS="$DEVENV_ROOT/.ansible/plugins/filter"
    export ANSIBLE_INVENTORY_PLUGINS="$DEVENV_ROOT/.ansible/plugins/inventory"
    export ANSIBLE_LOCAL_TEMP="$DEVENV_ROOT/.ansible/tmp"
    export ANSIBLE_LOOKUP_PLUGINS="$DEVENV_ROOT/.ansible/plugins/lookup"
    export ANSIBLE_LIBRARY="$DEVENV_ROOT/.ansible/plugins/modules"
    export ANSIBLE_MODULE_UTILS="$DEVENV_ROOT/.ansible/plugins/module_utils"
    export ANSIBLE_ROLES_PATH="$DEVENV_ROOT/.ansible/roles"
    export ANSIBLE_STRATEGY_PLUGINS="$DEVENV_ROOT/.ansible/plugins/strategy"
    export ANSIBLE_TEST_PLUGINS="$DEVENV_ROOT/.ansible/plugins/test"
    export ANSIBLE_VARS_PLUGINS="$DEVENV_ROOT/.ansible/plugins/vars"
    export ANSIBLE_PERSISTENT_CONTROL_PATH_DIR="$DEVENV_ROOT/.ansible/pc"

    ${pkgs.ansible}/bin/ansible-galaxy install -r requirements.yml
  '';
}
