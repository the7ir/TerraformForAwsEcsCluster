data "aws_codecommit_repository" "source_repository" {
  repository_name = "my-repo-name" // match với repository_name bên code_commit
}
