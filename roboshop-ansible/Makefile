default:
	git pull
	ansible-playbook -i $(role_name)-dev.robobal.store, -e ansible_user=ec2-user -e ansible_password=DevOps321 roboshop.yml -e role_name=$(role_name) -e env=$(env) -e token=$(token)

tool:
	git pull
	ansible-playbook -i $(tool_name)-internal.robobal.store, -e ansible_user=ec2-user -e ansible_password=DevOps321 roboshop.yml -e role_name=$(tool_name) -e vault_token=$(token)
