
## Motivation
Despite electromagnetic induction was first performed in the mid-19th century, until recently the technology that uses this property is somewhat inefficient over long distances between the emitter and the receiver. This project aims to mathematically model a two-antenna system performing induction to analyze its limitations based on power transmission and distance between antennas.
 

## Modelling steps:
#### 1. Create the emitter antenna
Both the antennas used have the Archimedean geometry, internal radius of 0.4m and external radius 0.5m 
#### 2. Find the impedance and resonance frequency 
The resonance frequency must be found to minimize the impedance and maximize the transmission gain between the two antennas. These values can be found plotting the values of the imaginary part of the impedance by the frequency, the resonance frequency is the one where the imaginary impedance is zero.

![image](https://user-images.githubusercontent.com/56456537/176956911-919a3c21-71d4-4923-a416-1d40082fa0f1.png)

 
#### 3. Create the transmitter antenna
It has the same geometry and dimension of the emitter antenna 
#### 4. Simulate the antennas coupling
Was calculated the gain between the antennas 
#### 5. Visualize the gains
Was plotted the gain magnitude by the frequency. It’s possible to observe that the maximum gain happens on the resonance frequency 

![image](https://user-images.githubusercontent.com/56456537/176956888-870e0f01-2a8c-4b9f-96fd-447646f89bff.png)
 
#### 6. Visualize the gains as a function of frequency and distance
Was plotted the gain magnitude by the frequency by the distance between the antennas. 

![image](https://user-images.githubusercontent.com/56456537/176956990-a39803b2-494b-4f13-a879-ce634c4fc805.png)



## Appendix:
### Fundamental concepts introduction
#### Induction:
#### Impedance:
#### Resonance: 
#### Transmission gain:
