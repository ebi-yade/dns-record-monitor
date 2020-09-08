#####################################
# Archive Files
#####################################
data "archive_file" "layer" {
  type        = "zip"
  source_dir  = "../opt/${var.layer_name}"
  output_path = "archive/layer-${var.layer_name}.zip"
}
data "archive_file" "function" {
  type        = "zip"
  source_dir  = "../src/${var.func_name}"
  output_path = "archive/func-${var.func_name}.zip"
}
