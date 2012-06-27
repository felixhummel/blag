Brain Dump
==========
Will wissen, ob es eine vokabel schon gibt. couchdb nimmt ``?key="Ein Satz"`` und wirft ne ID und die sprache raus. Sprache1: de, sprache2: fr, einfache boolesche logik::

     de | fr | also
    --------------------------------
      0 |  0 | simples insert
      1 |  0 | an doc dran
      0 |  1 | an doc dran
      1 |  1 | "sorry, gibt's schon"

problem: kp, wann ajax-request fertig ist. brauche ein event "de geholt UND fr geholt".

oder ich muss callbacks chainen::

    start: ajax(hole_de, merke_de_und_weiter)
    merke_de_und_weiter: ..., ajax(hole_fr, merke_fr_und_fertig)
    merke_fr_und_fertig: ..., vergleich de, fr, mach weiter

oder ich bau eine ajax_and-methode::

    ajax_and(pre1, conf1, post1, pre2, conf2, post2, final) {
        eval(pre1)

oder ich bau ein callback, das checkt ob beide da setzt und ansonsten das eine setzt. jo. das passt.
