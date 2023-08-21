from typing import Type

from pydantic import BaseModel, Field
from superagi.helper.github_helper import GithubHelper
from superagi.tools.base_tool import BaseTool
import subprocess

class GithubCloneRepoSchema(BaseModel):
    clone_url: str = Field(
        description="clone repo "
    )

class GithubRepoCloneTool(BaseTool):
    """
    Search File tool

    Attributes:
        name : The name.
        description : The description.
        args_schema : The args schema.
    """
    name = "GithubRepo Clone"
    description = (
        "Clone a Github repository"
    )
    args_schema: Type[GithubCloneRepoSchema] = GithubCloneRepoSchema

    def _execute(self, clone_url: str) -> str:
        """
        Execute the subprocess to clone a repo.

        Args:
            clone_url
        Returns:
        """
#        try:
        print(clone_url)
        # Use subprocess to execute the 'git clone' command
        result = subprocess.run(["git", "clone", clone_url], check=True)
        if result.returncode == 0:
            return f"Repository '{clone_url}' cloned successfully."
        else:
            return f"Failed to clone repository '{clone_url}'."
 #       except Exception as e:
 #           return f"An error occurred: {str(e)}"
