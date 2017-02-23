# To run this state, run:
# salt 'my_minion" state.apply install_nginx saltenv=development

install_nginx:
  pkg.install:
    - name: nginx
