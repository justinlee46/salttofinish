# To run this state, run:
# salt 'my_minion" state.apply install_nginx
# or
# salt 'my_minion" state.apply install_nginx saltenv=production 

install_nginx:
  pkg.install:
    - name: nginx
