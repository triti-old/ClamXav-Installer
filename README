Makefile plus additional files necessary for building an Apple installer package for mass deployment of the ClamXav application. Requires you to have [The Luggage][1] installed.

[1]: https://github.com/unixorn/luggage "The Luggage GitHub Page"

The preflight script is specific to our site and removes an older version of the customized installer so you should very likely just remove it from the makefile.

To build the installer:

1. Download [ClamXav](http://www.clamxav.com/ "ClamXav Home Page")
2. Mount the disk image
3. Copy the ClamXav.app into the same folder as this repository
4. Open the Terminal
5. `cd` to the repository directory
6. Type `make pkg` to build the installer package

To modify the scheduled scans and updates (either the scheduled times or which folder paths are scanned), edit the ClamXavSchedule.sh file and the uk.co.markallan.clamxav.plist file.

---

This software is provided "as is", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement. In no event shall the authors or copyright holders be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.
