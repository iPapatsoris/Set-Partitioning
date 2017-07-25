# Set-Partitioning
The Set Partitioning problem solved using constraint programming.
The following preprocessing is performed on the data to reduce the search space:
* **Multiple Sets Pruning**: Keep the pairings with the lowest cost among identical ones, discard the rest.
* **Subsumed Sets Pruning**: If a pairing can be subsummed by a number of other pairings with a lower total cost, discard that pairing. An exhaustive search for this pruning would require exponential time, so a greedy approach is implemented as presented in [this publication](https://www.ps.uni-saarland.de/Publications/documents/Mueller_98a.pdf).

## Running
**`flights(I,P,C).`**
* **I**: Index for input from flight_data.pl
* **P**: Chosen pairings output
* **C**: Final cost output

Input inside flight_data.pl as 
**`get_flight_data(I,N,PairingList,CostList).`**
* **I**: Input ID
* **N**: Total flights

Using [ECLiPSe](http://eclipseclp.org/) platform.
flight_data.pl and acsdata provided by instructor Panagiotis Stamatopoulos
