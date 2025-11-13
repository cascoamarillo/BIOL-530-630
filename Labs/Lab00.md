# BIOL-530/630 - Bioinformatics Algorithms

**Spring 2025**

## Lab00

### How to Get Your Computer Ready

It would be best if you had a computer connected to the Internet. You
need to be an admin to install essential bioinformatics software.

------------------------------------------------------------------------

### Text Editor

Copying biological sequences and/or commands from Word or other
sophisticated word processors to the terminal leads to all sorts of
problems. You'll want to use a simple text editor.

#### Additional Text Editors

-   **Windows:** Notepad\
-   **Mac:** TextEdit\
-   **Linux/Ubuntu:** GNOME Text Editor --- a small and lightweight text
    editor for the GNOME Desktop.

Feel free to explore your preferred text editor.

------------------------------------------------------------------------

### Documenting Your Projects/Assignments

It is important to store your inputs, steps, software, parameters, code,
and outputs so that:

-   You (or anyone else) can repeat your analysis.\
-   We can help you troubleshoot any problems you encounter.

This is part of your course grade. I will guide you through each
analysis step, but you should document all your steps to arrive at your
conclusions.

I **strongly encourage** you not to use Word (.docx) or other
sophisticated word processing programs to save your code. These programs
embed many additional lines of code that will be misinterpreted by the
terminal and the programs you will be using. Even "saving as" a text
file may not remove all these symbols.

I recommend using a text editor, Visual Studio Code, or free websites
like [HackMD](https://hackmd.io), [GitLab (RIT
GitLab)](https://git.rc.rit.edu), or [GitHub](https://github.com).

RIT Research Computing uses GitLab (`git.rc.rit.edu`) for documentation.
RIT students and staff can create and share projects using their RIT
usernames.

I have created the repo <https://git.rc.rit.edu/biol-530-630>, where I
plan to upload some examples done through the class. You should be able
to access it with your RIT credentials.

The **Final Project** will consist of many parts. One of them will be
the documentation of all steps taken to get your results (e.g., a PDF of
your documentation).

------------------------------------------------------------------------

### Software

We need specific software installed on our computers to work in the dry
labs. Although there are good online alternatives, running them locally
on your computer (or on the oedipus server) is preferred.

#### PHYLIP package

<https://phylipweb.github.io/phylip/>

#### MEGA software

Graphical (GUI) and command line (CC): <https://www.megasoftware.net/>

#### Tree visualization

<https://github.com/rambaut/figtree/releases>

...and more that will be mentioned for each lab.

------------------------------------------------------------------------

### Online Phylogenetic Programs

-   [Phylogeny.fr](http://phylogeny.lirmm.fr/phylo_cgi/index.cgi)
-   [AliView: alignment viewer and
    editor](https://ormbunkar.se/aliview/)
-   [Clustal Omega: multiple sequence alignment
    program](https://www.ebi.ac.uk/jdispatcher/msa/clustalo)
-   [Interactive Tree of Life](https://itol.embl.de/upload.cgi)
-   [Galaxy Tools: web-based platform for data-intensive biomedical
    research](https://usegalaxy.org)
-   Sequence conversion tools:
    -   <https://mafft.cbrc.jp/alignment/server/cgi-bin/readseq.txt>\
    -   <https://www.ebi.ac.uk/jdispatcher/sfc/emboss_seqret>

------------------------------------------------------------------------

### Using the Terminal: Basic Unix Commands

We will use the terminal to run different programs. Please make sure
your computer has a working terminal.

Since Windows Command Prompt is different from the Unix-like terminal
from Mac and Linux distros, I highly recommend installing an equivalent,
like **WSL** or **Cygwin**, so you can use the same commands as on Mac
or Linux.

-   **WSL:** <https://learn.microsoft.com/en-us/windows/wsl/install>

------------------------------------------------------------------------

#### Common Commands

  -----------------------------------------------------------------------
  Command                       Description
  ----------------------------- -----------------------------------------
  `mkdir directory`             Creates a new directory

  `cd`                          Navigates to a directory

  `ls`                          Lists folders or files in a directory

  `ls -l`                       Lists folders or files with specs

  `rm file`                     Removes a file

  `rm -r directory`             Removes directories and their contents
                                recursively

  `mv`                          Moves a file

  `pwd`                         Displays current directory path

  `cd ~`                        Home directory

  `cd ..`                       Go back one directory

  `cd ../..`                    Go back two directories
  -----------------------------------------------------------------------

For all these commands, typing the flag `-h` or `--help` usually lists
usage options.

**In summary ... READ THE DOCUMENTATION!**

------------------------------------------------------------------------

### Connect to Oedipus

Open the terminal and type:

``` bash
ssh -X user@oedipus.bioinformatics.rit.edu
```

Then enter your password when prompted.

------------------------------------------------------------------------

### Workspace on `oedipus.bioinformatics.rit.edu`

  Directory                                   Description
  ------------------------------------------- ------------------
  `/mnt/classes/biol_530_630`                 Class directory
  `/mnt/classes/biol_530_630/data/`           Lab datasets
  `/mnt/classes/biol_530_630/bioware/`        Class software
  `/mnt/classes/biol_530_630/home/xyz1234/`   Your directory
  `/mnt/sde_dir/software/`                    General software

------------------------------------------------------------------------

### To Transfer Files To/From Your Computer

File transfer software:
[FileZilla](https://en.wikipedia.org/wiki/FileZilla)\
Download the appropriate FileZilla **Client** version:
<https://filezilla-project.org/>

You are welcome to use other options.

------------------------------------------------------------------------

### `screen`

While working on a server (via SSH), to avoid stopping your run because
of lost connection (e.g., WiFi issues), log into the server and before
running anything, invoke:

``` bash
screen
```

A blank new terminal will appear, which has your previous environment.
Run your script, and (if no error occurs) you can close your terminal or
turn off your computer. When you log back in, just type:

``` bash
screen -dr
```

Your previous terminal will show up.\
More info: <https://linuxize.com/post/how-to-use-linux-screen/>

------------------------------------------------------------------------

**Fernando Rodriguez**
