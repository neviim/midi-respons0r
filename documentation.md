---
layout: page
title: Documentation
permalink: /documentation/
---

* [Introduction](#introduction)
* [What channel transports what](#channels)
* [How to trigger the MIDI dump](#trigger)
* [Using BCR and VSTi](#bcr-and-vsti)


### Introduction

Respons0r is a plugin to dump parameters in
renoise
to a midi-controller, to get parameters properly displayed on the midi-controller.
This makes only sense for midi-controller , like

* [BCR-2000](http://www.behringer.com/EN/Products/BCR2000.aspx),
* [BCF-2000](http://www.behringer.com/EN/Products/BCF2000.aspx),
* [Nocturn](http://global.novationmusic.com/midi-controllers/nocturn),

coming with parameter displays.

### Channels

right now the channels and parameters are fixed, but some day you can configure them yourself.

{: .table .table-striped .table-hover}
Channel  | Parameter   | MIDI Value  |  Description
--- | --- | --- | ---
1 | 0-31 | 0-127 | *Global Mappings* > *Track DSPs* > *Selected FX* = *Parameter* 1 to 32
2 | 0 | 0-127 | The MIDI Value given is the currently selected Track DSP.
2 | 1-127 | 0,127 | The parameter references to the DSP in the current track. 0 means unfocused, 127 means focused

### Trigger
To get the MIDI dump triggered you have to change the selection of the DSP or the Track.

### BCR and VSTi
When you want to control a VSTi using your BCR and renoise is the main idea behind this project.

* configure the *Selected FX* parameters
* download or create an instrument automatisation
* download or create a overlay for your VSTi
* print and cut the overlay
* use magnet-scotch-tape to glue the overlay to your midi-controller
