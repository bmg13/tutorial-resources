#  Copyright 2023 cluetec GmbH

#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at

#      http://www.apache.org/licenses/LICENSE-2.0

#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

resource "kubernetes_ingress_v1" "dtr-ingress" {
  metadata {
    name = "${var.humanReadableName}-ingress"
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/$2"
      "nginx.ingress.kubernetes.io/use-regex"      = "true"
    }
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      http {
        path {
          path = "/${var.humanReadableName}(/|$)(.*)"
          backend {
            service {
              name = "cx-${var.humanReadableName}-registry-svc"
              port {
                number = 8080
              }
            }
          }
        }
      }
    }
  }
}

locals {
  url = "http://localhost/${var.humanReadableName}/api/v3.0/"
}
