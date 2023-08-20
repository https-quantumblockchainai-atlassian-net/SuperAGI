from typing import Type

from pydantic import BaseModel, Field
from superagi.helper.github_helper import GithubHelper
from superagi.tools.base_tool import BaseTool
import subprocess

class GithubDebSchema(BaseModel):
    deb_name: str = Field(
        description="create a .deb file with this name "
    )

class GithubDebTool(BaseTool):
    """
    Search File tool

    Attributes:
        name : The name.
        description : The description.
        args_schema : The args schema.
    """
    name = "GithubRepo packager"
    description = (
        "Create a package .deb for debian"
    )
    args_schema: Type[GithubDebSchema] = GithubDebSchema

    def _execute(self, deb_name: str) -> str:
        """
        Execute the subprocess to clone a repo.

        Args:
           deb_name 
        Returns:
        """
        try:
            # Use subprocess to execute the 'dh-make' command
            result_dh_make = subprocess.run(["dh-make"], check=True)
            if result_dh_make.returncode != 0:
                return f"Failed to create a Debian package using 'dh-make' for repository '{clone_url}'."

            # Use subprocess to execute the 'debuild' command
            result_debuild = subprocess.run(["debuild", "-us", "-uc"], check=True)
            if result_debuild.returncode == 0:
                return f"Debian package created successfully for repository '{clone_url}'."
            else:
                return f"Failed to create Debian package for repository '{clone_url}'."

        except Exception as e:
            return f"An error occurred: {str(e)}"

