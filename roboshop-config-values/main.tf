resource "vault_mount" "secret-mounts" {
  for_each = var.secret-mounts
  path     = each.key
  type     = "kv-v2"
  options = {
    version = "2"
    type    = "kv-v2"
  }
  description = each.value["description"]
}

resource "vault_kv_secret_v2" "secrets" {
  depends_on = [vault_mount.secret-mounts]
  for_each   = var.secrets
  mount      = each.value["secret_mount"]
  name       = each.key
  cas        = 1
  data_json  = jsonencode(each.value["kv"])
}



