locals {
  suffix = "${var.environment}-${var.suffix}"

  tags = {
    environment = "${var.environment}"
  }

  consumers =  merge(
    [ for topic in var.topics :
      { for consumer in topic.consumers :
          "${topic.key}-${consumer}" => {
            key      = topic.key
            consumer = consumer }
      }
    ]
  ...)
}
