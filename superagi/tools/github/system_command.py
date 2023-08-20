from typing import Type

from pydantic import BaseModel, Field
from superagi.helper.github_helper import GithubHelper
from superagi.tools.base_tool import BaseTool
import subprocess

class GithubSystemCommandSchema(BaseModel):
    shell_cmd: str = Field(
        description="execute a shell command "
    )

class GithubSystemCommandTool(BaseTool):
    """
    Give a shell acces

    Attributes:
        name : The name.
        description : The description.
        args_schema : The args schema.
    """
    name = "GithubRepo SystemCommand"
    description = (
        "Acces to the shell"
    )
    args_schema: Type[GithubSystemCommandSchema] = GithubSystemCommandSchema

    def _execute(self, shell_cmd: str) -> str:
        """
        Execute a shell cmd.

        Args:
            shell_cmd
        Returns:
        """
        try:
            print(shell_cmd)
            # Use subprocess to execute the 'git clone' command
            result = subprocess.run(shell_cmd, shell=True, check=True)
            if result.returncode == 0:
                return f"Command '{shell_cmd}' executed successfully."
            else:
                return f"Failed to execute command '{shell_cmd}'."
        except Exception as e:
            return f"An error occurred: {str(e)}"
