
#import "Template_wis.typ": *

#show: documentstijl.with(
  titel: "Werkblad 2",
  vak: "Wiskunde 2.3",
  auteur: "Joris Busink",
  datum: "November 2026",
  toon-header: true,
  toon-footer: true,
  toon-paginanummer: true,
)

// Kies: "opgaven", "beide", "uitwerkingen"
#let (exercise, solution) = maak-opgaven(
  modus: "beide",
)


= Integraalrekening

#exercise[
  Bereken de volgende integraal:

  $ I = integral_0^oo (ln x)^2 / (1+x^2) dif x $

  Gebruik hiervoor differentiatie naar een parameter.
]

#solution[
  *Stap 1 — Introduceer een parameter*

  We definiëren de parameterafhankelijke integraal

  $ F(s) = integral_0^oo x^(s-1)/(1+x^2) dif x $

  De integraal convergeert voor $0 < s < 2$.
  In de buurt van $x=0$ gedraagt de integrand
  zich namelijk als $x^(s-1)$, terwijl voor
  $x -> oo$ het gedrag $x^(s-3)$ is.

  Door tweemaal te differentiëren naar $s$
  krijgen we

  $ F'(s) = integral_0^oo
      x^(s-1) ln x / (1+x^2) dif x $

  en

  $ F''(s) = integral_0^oo
      x^(s-1) (ln x)^2 / (1+x^2) dif x $

  De gevraagde integraal volgt dus uit

  $ I = F''(1) $


  *Stap 2 — Bereken de parameterintegraal*

  We voeren de substitutie

  $ t = x^2 $

  uit. Hieruit volgt

  $ x = sqrt(t), quad dif x = 1/(2 sqrt(t)) dif t $

  Invullen levert

  $ F(s) = 1/2 integral_0^oo
      t^(s/2-1)/(1+t) dif t $

  Dit herkennen we als een integraalrepresentatie
  van de bètafunctie:

  $ B(a,b) = integral_0^oo
      t^(a-1)/(1+t)^(a+b) dif t $

  Met $a=s/2$ en $b=1-s/2$ volgt

  $ F(s) = 1/2 B(s/2, 1-s/2) $

  De bètafunctie hangt samen met de gammafunctie:

  $ B(a,b) = (Gamma(a) Gamma(b))/(Gamma(a+b)) $

  Omdat $a+b=1$ en $Gamma(1)=1$, vinden we

  $ F(s) = 1/2 Gamma(s/2) Gamma(1-s/2) $

  Met de reflectieformule van Euler,

  $ Gamma(z) Gamma(1-z) = pi/sin(pi z) $

  verkrijgen we

  $ F(s) = pi/(2 sin(pi s/2)) $


  *Stap 3 — Differentieer tweemaal*

  We schrijven

  $ F(s) = pi/2 csc(pi s/2) $

  Voor de eerste afgeleide geldt

  $ F'(s) = -pi^2/4
      csc(pi s/2) cot(pi s/2) $

  Nogmaals differentiëren geeft

  $
    F''(s) = pi^3/8 (
      csc(pi s/2) cot^2(pi s/2)
      + csc^3(pi s/2)
    )
  $


  *Stap 4 — Evalueer bij $s=1$*

  Voor $s=1$ gebruiken we

  $ sin(pi/2)=1, quad cot(pi/2)=0 $

  Daarmee wordt

  $ F''(1) = pi^3/8 (0+1) $

  Het uiteindelijke antwoord is

  #antwoord[
    $ I = integral_0^oo (ln x)^2/(1+x^2) dif x
        = pi^3/8 $
  ]
]


#exercise[
  Bereken met behulp van de residustelling

  $ I = integral_(-oo)^oo 1/(x^4+1) dif x $

  Gebruik een halfronde contour in het
  bovenste complexe halfvlak.
]

#solution[
  *Stap 1 — Definieer de complexe functie*

  We beschouwen de meromorfe functie

  $ f(z) = 1/(z^4+1) $

  We integreren over een gesloten contour
  bestaande uit het lijnsegment van $-R$ tot
  $R$ op de reële as en een halve cirkel
  met straal $R$ in het bovenste halfvlak.

  Volgens de residustelling geldt

  $
    integral_(C_R) f(z) dif z
      = 2 pi i sum_k "Res"(f,z_k)
  $

  waarbij de som loopt over alle polen
  binnen de contour.


  *Stap 2 — Bepaal de polen*

  De polen zijn de nulpunten van de noemer:

  $ z^4+1=0 $

  We schrijven

  $ z^4=-1=e^(i(pi+2 pi k)) $

  De vier oplossingen zijn

  $ z_k = e^(i(pi/4+k pi/2)),
      quad k=0,1,2,3 $

  Expliciet vinden we

  $
    z_0 = (1+i)/sqrt(2)
  $

  $
    z_1 = (-1+i)/sqrt(2)
  $

  $
    z_2 = (-1-i)/sqrt(2)
  $

  $
    z_3 = (1-i)/sqrt(2)
  $

  Alleen $z_0$ en $z_1$ liggen in het
  bovenste complexe halfvlak.


  *Stap 3 — Bereken de residuen*

  De polen zijn enkelvoudig, omdat

  $ (dif)/(dif z)(z^4+1)=4z^3 $

  niet nul is bij de polen.

  Voor een enkelvoudige pool geldt

  $
    "Res"(f,z_k)
      = lim_(z -> z_k) (z-z_k) f(z)
      = 1/(4z_k^3)
  $

  Voor de eerste pool gebruiken we

  $ z_0=e^(i pi/4) $

  zodat

  $
    "Res"(f,z_0)
      = 1/4 e^(-3i pi/4)
      = (-1-i)/(4 sqrt(2))
  $

  Voor de tweede pool geldt

  $ z_1=e^(3i pi/4) $

  en dus

  $
    "Res"(f,z_1)
      = 1/4 e^(-9i pi/4)
      = (1-i)/(4 sqrt(2))
  $

  De som van beide residuen wordt

  $
    sum_k "Res"(f,z_k)
      = (-1-i+1-i)/(4 sqrt(2))
      = -i/(2 sqrt(2))
  $


  *Stap 4 — Pas de residustelling toe*

  De residustelling levert

  $
    integral_(C_R) 1/(z^4+1) dif z
      = 2 pi i (-i/(2 sqrt(2)))
      = pi/sqrt(2)
  $

  We splitsen de contour op in het
  lijnsegment en de halve cirkel:

  $
    integral_(C_R) f(z) dif z
      = integral_(-R)^R f(x) dif x
      + integral_(Gamma_R) f(z) dif z
  $


  *Stap 5 — Neem de limiet $R -> oo$*

  Op de halve cirkel geldt $|z|=R$.

  Met de omgekeerde driehoeksongelijkheid
  vinden we voor $R>1$

  $ |z^4+1| >= R^4-1 $

  en daarom

  $ |f(z)| <= 1/(R^4-1) $

  De lengte van de halve cirkel is $pi R$.
  Met de ML-ongelijkheid volgt

  $
    |integral_(Gamma_R) f(z) dif z|
      <= (pi R)/(R^4-1)
  $

  Omdat

  $ lim_(R -> oo) (pi R)/(R^4-1)=0 $

  verdwijnt de bijdrage van de cirkelboog.

  De contourintegraal reduceert daarmee
  tot de oorspronkelijke reële integraal.


  *Stap 6 — Eindresultaat*

  We vinden

  #antwoord[
    $ I = integral_(-oo)^oo 1/(x^4+1) dif x
        = pi/sqrt(2) $
  ]
]
