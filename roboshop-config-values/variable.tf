variable "token" {}


variable "secret-mounts" {
  default = {
    roboshop-dev = {
      description = "RoboShop Project Dev Secrets"
    }
    roboshop-infra = {
      description = "RoboShop Project Infra Secrets"
    }
  }
}


variable "secrets" {
  default = {
    cart = {
      secret_mount = "roboshop-dev"
      kv = {
        REDIS_HOST     = "redis-dev.robobal.store",
        CATALOGUE_HOST = "catalogue-dev.robobal.store",
        CATALOGUE_PORT = 8080
      }
    }

    frontend = {
      secret_mount = "roboshop-dev"
      kv = {
        CATALOGUE_URL  = "http://catalogue-dev.robobal.store:8080/"
        USER_URL       = "http://user-dev.robobal.store:8080/"
        CART_URL       = "http://cart-dev.robobal.store:8080/"
        SHIPPING_URL   = "http://shipping-dev.robobal.store:8080/"
        PAYMENT_URL    = "http://payment-dev.robobal.store:8080/"
        CATALOGUE_HOST = "catalogue-dev.robobal.store"
        CATALOGUE_PORT = "8080"
        USER_HOST      = "user-dev.robobal.store"
        USER_PORT      = "8080"
        CART_HOST      = "cart-dev.robobal.store"
        CART_PORT      = "8080"
        SHIPPING_HOST  = "shipping-dev.robobal.store"
        SHIPPING_PORT  = "8080"
        PAYMENT_HOST   = "payment-dev.robobal.store"
        PAYMENT_PORT   = "8080"
      }
    }

    catalogue = {
      secret_mount = "roboshop-dev"
      kv = {
        MONGO       = "true"
        MONGO_URL   = "mongodb://mongodb-dev.robobal.store:27017/catalogue"
        DB_TYPE     = "mongo"
        APP_GIT_URL = "https://github.com/roboshop-devops-project-v3/catalogue"
        DB_HOST     = "mongodb-dev.robobal.store"
        SCHEMA_FILE = "db/master-data.js"
      }
    }

    user = {
      secret_mount = "roboshop-dev"
      kv = {
        MONGO     = "true",
        REDIS_URL = "redis://redis-dev.robobal.store:6379",
        MONGO_URL = "mongodb://mongodb-dev.robobal.store:27017/users"
      }
    }

    mysql = {
      secret_mount = "roboshop-dev"
      kv = {
        ROOT_PASSWORD = "RoboShop@1"
      }
    }

    rabbitmq = {
      secret_mount = "roboshop-dev"
      kv = {
        APP_USER     = "roboshop",
        APP_PASSWORD = "roboshop123"
      }
    }

    shipping = {
      secret_mount = "roboshop-dev"
      kv = {
        CART_ENDPOINT = "cart-dev.robobal.store:8080"
        DB_HOST       = "mysql-dev.robobal.store"
        DB_USER       = "root"
        DB_PASS       = "RoboShop@1"
        DB_TYPE       = "mysql"
        APP_GIT_URL   = "https://github.com/roboshop-devops-project-v3/shipping"
      }
    }

    payment = {
      secret_mount = "roboshop-dev"
      kv = {
        CART_HOST = "cart-dev.robobal.store",
        CART_PORT = 8080,
        USER_HOST = "user-dev.robobal.store",
        USER_PORT = 8080,
        AMQP_HOST = "rabbitmq-dev.robobal.store",
        AMQP_USER = "roboshop",
        AMQP_PASS = "roboshop123"
      }
    }

    ssh = {
      secret_mount = "roboshop-infra"
      kv = {
        username = "ec2-user",
        password = "DevOps321"
      }
    }

    github-runner = {
      secret_mount = "roboshop-infra"
      kv = {
        RUNNER_TOKEN = "xxx"
        # Replace this value in UI, As Runner token is real secret and we cannot hardcode it in public repo
      }
    }
  }
}

