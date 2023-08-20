from typing import Type

from pydantic import BaseModel, Field
from superagi.helper.github_helper import GithubHelper
from superagi.tools.base_tool import BaseTool


class GithubFindRepoSchema(BaseModel):
    repository_name: str = Field(
        description="name of repo we must find"
    )

class GithubRepoFindTool(BaseTool):
    """
    Search File tool

    Attributes:
        name : The name.
        description : The description.
        args_schema : The args schema.
    """
    name = "GithubRepo Find"
    description = (
        "Find a Github repository with name"
    )
    args_schema: Type[GithubFindRepoSchema] = GithubFindRepoSchema

    def _execute(self, repository_name: str) -> str:
        """
        Execute the search file tool.

        Args:
            repository_owner : The owner of the repository to search file in.
            repository_name : The name of the repository to search file in.
            file_name : The name of the file to search.
            folder_path : The path of the folder to search the file in.

        Returns:
            The content of the github file.
        """
        github_access_token = self.get_tool_config("GITHUB_ACCESS_TOKEN")
        github_username = self.get_tool_config("GITHUB_USERNAME")
        github_repo_search = GithubHelper(github_access_token, github_username)
        try:
            repositories = github_repo_search.search_repository(repository_name)
            #print(repositories)
            return repositories
            #for repo in repositories:
            #    if repo['name'] == repository_name:
            #        content = github_repo_search.search_repository(repository_name)
            #        return content, repo
            #return "Repository not found"
        except:
            return "File not found"

