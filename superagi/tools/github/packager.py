from typing import Type

from pydantic import BaseModel, Field
from superagi.helper.github_helper import GithubHelper
from superagi.tools.base_tool import BaseTool
import subprocess
import os

class GithubDebSchema(BaseModel):
    deb_name: str = Field(
        description="create a .deb file with this name "
    )

class GithubDebTool(BaseTool):
    """
     .deb creation tool

    Attributes:
        deb_name : The package name.
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
            # Assuming the necessary steps to clone the repository and build it
            # are done before reaching this point in the code.
            sources_directory = "crypto_project"
            os.chdir(sources_directory)
            # Use subprocess to execute the 'dh-make' command
            dh_make_command = "dh_make -y -s --createorig -c gpl -e your@email.com -p "

            test_dh_make = subprocess.run(["dpkg", "-l"], stdout=subprocess.PIPE, text=True, check=True)
            grep_result = subprocess.run(["grep", "dh-make"], input=test_dh_make.stdout, stdout=subprocess.PIPE, text=True, check=True)

            print(grep_result.stdout)

            try:
                result = subprocess.run(["dpkg-query", "-L", "dh_make"], stdout=subprocess.PIPE, text=True, check=True)
                package_files = result.stdout.strip().split("\n")
                install_folder = package_files[0] if package_files else None
                if install_folder:
                    print(f"dh-make is installed in folder:", install_folder)
                else:
                    print(f"dh-make installation folder not found.")
            except subprocess.CalledProcessError:
                print(f"Error getting information about dh-make.")

#            result_dh_make = subprocess.run(dh_make_command+deb_name,shell=True, check=True)
            result_dh_make = subprocess.run(dh_make_command + deb_name, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            print(result_dh_make.stdout.decode())  # Print standard output
            print(result_dh_make.stderr.decode())  # Print standard error

            if result_dh_make.returncode != 0:
                return f"Failed to create a Debian package using 'dh-make' for package '{deb_name}'."

            # Use subprocess to execute the 'debuild' command
            result_debuild = subprocess.run(["debuild", "-us", "-uc"], check=True)
            if result_debuild.returncode == 0:
                return f"Debian package '{deb_name}' created successfully."
            else:
                return f"Failed to create Debian package '{deb_name}'."

        except Exception as e:
            return f"An error occurred: {str(e)}"

