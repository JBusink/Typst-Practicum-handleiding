#import "../../styl.typ": *
#show: stijl.with(titel: "Aero pendulum OL", kop: "Technische Natuurkunde — Na2.2")

#show: vergelijking_refs


== P-regeling met Laplacetransformaties en overdrachtsfuncties

=== Van het tijdsdomein naar het Laplacedomein

Tot nu toe hebben we dynamische systemen beschreven met differentiaalvergelijkingen. Deze vergelijkingen geven aan hoe een grootheid, bijvoorbeeld een positie of hoek, in de tijd verandert.

Een voorbeeld is de gedempte harmonische oscillator:

#math.equation(block: true, numbering: "(1)",
  $ m dot.double(x) + b dot(x) + k x = F(t) $
)

Hierin beschrijft $F(t)$ een uitwendige kracht die op het systeem werkt. De oplossing $x(t)$ geeft de positie als functie van de tijd.

Het rechtstreeks oplossen van differentiaalvergelijkingen wordt ingewikkelder wanneer meerdere dynamische systemen gekoppeld zijn. Denk bijvoorbeeld aan een mechanisch systeem dat wordt aangestuurd door een motor en een regelaar.

Met behulp van de Laplacetransformatie kunnen we deze differentiaalvergelijkingen omzetten naar algebraïsche vergelijkingen. Hierdoor kunnen we de afzonderlijke onderdelen van een regelsysteem eenvoudiger combineren.

De Laplacetransformatie van een functie $f(t)$ is gedefinieerd als:

#math.equation(block: true, numbering: "(1)",
  $ F(s) = integral_0^infinity f(t) e^(-s t) dif t $
)

Hierbij wordt de functie $f(t)$ uit het tijdsdomein omgezet naar een functie $F(s)$ in het *Laplacedomein*.

De variabele $s$ is in het algemeen complex:

#math.equation(block: true, numbering: "(1)",
  $ s = sigma + i omega $
)

Hierin is $sigma$ het reële deel en $omega$ het imaginaire deel van $s$.

=== De fysische betekenis van de variabele s

Om de betekenis van $s$ te begrijpen, beschouwen we een functie van de vorm:

#math.equation(block: true, numbering: "(1)",
  $ x(t) = C e^(s t) $
)

Door $s = sigma + i omega$ in te vullen, vinden we:

#math.equation(block: true, numbering: "(1)",
  $ x(t) = C e^(sigma t) e^(i omega t) $
)

Deze uitdrukking bestaat uit twee factoren met verschillende fysische betekenissen.

De factor $e^(sigma t)$ bepaalt hoe de amplitude zich ontwikkelt:

- Bij $sigma < 0$ neemt de amplitude exponentieel af.
- Bij $sigma = 0$ blijft de amplitude constant.
- Bij $sigma > 0$ groeit de amplitude exponentieel.

De factor $e^(i omega t)$ beschrijft een oscillatie met hoekfrequentie $omega$. Een fysische, reële beweging kan worden opgebouwd uit de reële delen van zulke complexe exponentiële functies.

We kunnen de complexe variabele $s$ dus gebruiken om zowel de oscillatiefrequentie als de stabiliteit van een beweging te beschrijven.

=== Waarom gebruiken we complexe exponentiële functies?

Een belangrijke eigenschap van exponentiële functies is dat differentiëren bijzonder eenvoudig wordt:

#math.equation(block: true, numbering: "(1)",
  $ (dif)/(dif t) e^(s t) = s e^(s t) $
)

Voor de tweede afgeleide geldt:

#math.equation(block: true, numbering: "(1)",
  $ (dif^2)/(dif t^2) e^(s t) = s^2 e^(s t) $
)

Differentiëren komt bij deze functies dus overeen met vermenigvuldigen met $s$.

Dit is de belangrijkste reden waarom Laplacetransformaties zo bruikbaar zijn voor het analyseren van lineaire differentiaalvergelijkingen.

Voor een willekeurige functie $f(t)$ gelden de transformaties:

#math.equation(block: true, numbering: "(1)",
  $ cal(L){dot(f)(t)} = s F(s) - f(0) $
)

#math.equation(block: true, numbering: "(1)",
  $ cal(L){dot.double(f)(t)}
    = s^2 F(s) - s f(0) - dot(f)(0) $
)

De termen $f(0)$ en $dot(f)(0)$ beschrijven de beginvoorwaarden.

Wanneer we de beginvoorwaarden gelijk aan nul kiezen, worden de uitdrukkingen:

#math.equation(block: true, numbering: "(1)",
  $ cal(L){dot(f)} = s F(s),
    quad cal(L){dot.double(f)} = s^2 F(s) $
)

Hierdoor verandert een differentiaalvergelijking in een algebraïsche vergelijking met machten van $s$.

=== Wat is een overdrachtsfunctie?

Een overdrachtsfunctie beschrijft hoe een lineair, tijdsinvariant systeem reageert op een ingangssignaal.

We noemen het ingangssignaal $u(t)$ en het uitgangssignaal $y(t)$. Hun Laplacetransformaties zijn respectievelijk $U(s)$ en $Y(s)$.

De overdrachtsfunctie is gedefinieerd als:

#math.equation(block: true, numbering: "(1)",
  $ eqbox(G(s) = Y(s)/U(s)) $
)

Deze definitie geldt bij nulbeginvoorwaarden.

Om te begrijpen hoe we een overdrachtsfunctie bepalen, beschouwen we opnieuw de gedempte harmonische oscillator:

#math.equation(block: true, numbering: "(1)",
  $ m dot.double(x) + b dot(x) + k x = F(t) $
)

We passen de Laplacetransformatie toe en nemen nulbeginvoorwaarden aan:

#math.equation(block: true, numbering: "(1)",
  $ m s^2 X(s) + b s X(s) + k X(s) = F(s) $
)

Door $X(s)$ buiten haakjes te halen:

#math.equation(block: true, numbering: "(1)",
  $ (m s^2 + b s + k) X(s) = F(s) $
)

De verhouding tussen de uitgang $X(s)$ en de ingang $F(s)$ wordt:

#math.equation(block: true, numbering: "(1)",
  $ eqbox(G(s) = X(s)/F(s) = 1/(m s^2 + b s + k)) $
)

De overdrachtsfunctie bevat daarmee alle informatie over de lineaire dynamica van het systeem bij nulbeginvoorwaarden.

=== Polen en stabiliteit

Een overdrachtsfunctie kan in het algemeen worden geschreven als een breuk:

#math.equation(block: true, numbering: "(1)",
  $ G(s) = N(s)/D(s) $
)

Hierin zijn $N(s)$ en $D(s)$ polynomen in de complexe variabele $s$.

De *polen* zijn de waarden van $s$ waarvoor de noemer nul wordt, na eventuele gemeenschappelijke factoren van teller en noemer te hebben verwijderd:

#math.equation(block: true, numbering: "(1)",
  $ D(s) = 0 $
)

Voor de harmonische oscillator vinden we:

#math.equation(block: true, numbering: "(1)",
  $ m s^2 + b s + k = 0 $
)

Met de abc-formule volgen de twee polen:

#math.equation(block: true, numbering: "(1)",
  $ s_(1,2) = -b/(2m) plus.minus
    sqrt(b^2/(4m^2) - k/m) $
)

Voor een ondergedempte oscillator zijn deze polen complex:

#math.equation(block: true, numbering: "(1)",
  $ s_(1,2) = -b/(2m) plus.minus i omega_d $
)

met:

#math.equation(block: true, numbering: "(1)",
  $ omega_d = sqrt(k/m - b^2/(4m^2)) $
)

Het reële deel van de polen is $-b/(2m)$ en bepaalt hoe snel de oscillaties uitdoven. Het imaginaire deel bepaalt de oscillatiefrequentie.

Voor een systeem waarvan alle dynamische modi in de overdrachtsfunctie zichtbaar zijn, geldt:

- *Polen in het linkerhalfvlak* ($Re(s) < 0$): alle bijbehorende bewegingen doven uit.
- *Polen op de imaginaire as* ($Re(s) = 0$): de bijbehorende bewegingen doven niet exponentieel uit.
- *Polen in het rechterhalfvlak* ($Re(s) > 0$): de bijbehorende bewegingen groeien exponentieel.

Een lineair systeem is asymptotisch stabiel wanneer alle wortels van zijn karakteristieke vergelijking een negatief reëel deel hebben.

Voor een minimale realisatie van het systeem zijn dit precies de polen van de overdrachtsfunctie.

=== Waarom zijn overdrachtsfuncties nuttig voor regeltechniek?

Het belangrijkste voordeel van overdrachtsfuncties is dat we gekoppelde lineaire systemen kunnen combineren door hun overdrachtsfuncties te vermenigvuldigen.

Wanneer een regelaar een motor aanstuurt en deze motor vervolgens een mechanisch systeem aandrijft, kunnen we schrijven:

#math.equation(block: true, numbering: "(1)",
  $ G_"totaal"(s) = G_"regelaar"(s)
    G_"motor"(s) G_"mechanisch"(s) $
)

Dit geldt voor een serieschakeling zonder tussenliggende terugkoppelingen.

Bij een gesloten regelkring met negatieve eenheidsterugkoppeling wordt de overdrachtsfunctie:

#math.equation(block: true, numbering: "(1)",
  $ eqbox(T(s) = G_"totaal"(s)/(1 + G_"totaal"(s))) $
)

De stabiliteit van het gesloten systeem wordt bepaald door de karakteristieke vergelijking die ontstaat uit de noemer van deze uitdrukking.

Hiermee kunnen we onderzoeken hoe de versterking van een regelaar en de responstijd van een motor de stabiliteit beïnvloeden, zonder alle gekoppelde differentiaalvergelijkingen rechtstreeks op te lossen.

=== Overdrachtsfunctie van de pendulum

We beschouwen kleine hoekafwijkingen rond een evenwichtshoek $theta_0$. De gelineariseerde bewegingsvergelijking luidt:

#math.equation(block: true, numbering: "(1)",
  $ J dot.double(epsilon) + b dot(epsilon)
    + B epsilon = q $
)

Hierin is:

$ B = m g l cos(theta_0) $

en $q$ de afwijking van het motorkoppel ten opzichte van het evenwichtskoppel.

We passen de Laplacetransformatie toe, met nulbeginvoorwaarden:

#math.equation(block: true, numbering: "(1)",
  $ J s^2 E(s) + b s E(s) + B E(s) = Q(s) $
)

We brengen de termen met $E(s)$ bij elkaar:

#math.equation(block: true, numbering: "(1)",
  $ (J s^2 + b s + B) E(s) = Q(s) $
)

De *overdrachtsfunctie* is de verhouding tussen de uitgang en de ingang van een lineair systeem, bij nulbeginvoorwaarden.

Voor de pendulum vinden we:

#math.equation(block: true, numbering: "(1)",
  $ eqbox(
    G_p(s) = E(s)/Q(s)
    = 1/(J s^2 + b s + B)
  ) $
)

Deze overdrachtsfunctie beschrijft hoe de hoekafwijking reageert op een verandering van het motorkoppel.

=== De proportionele regelaar

Een P-regelaar bepaalt het motorkoppel op basis van het verschil tussen de gewenste en de gemeten hoek.

We definiëren de referentieafwijking $r(t)$ en de regelafwijking:

#math.equation(block: true, numbering: "(1)",
  $ e(t) = r(t) - epsilon(t) $
)

De regelaar levert een PWM-correctie:

#math.equation(block: true, numbering: "(1)",
  $ delta u(t) = K_p e(t) $
)

Met de eerder gedefinieerde evenredigheidsconstante $A$ wordt de afwijking van het motorkoppel:

#math.equation(block: true, numbering: "(1)",
  $ q(t) = A K_p e(t) $
)

In het Laplacedomein volgt:

#math.equation(block: true, numbering: "(1)",
  $ Q(s) = A K_p (R(s) - E(s)) $
)

De overdrachtsfunctie van de regelaar inclusief de omzetting naar motorkoppel is dus:

#math.equation(block: true, numbering: "(1)",
  $ G_c(s) = A K_p $
)

=== Gesloten regelsysteem zonder motorvertraging

We combineren de overdrachtsfunctie van de pendulum met de P-regelaar:

$ E(s) = G_p(s) G_c(s) (R(s) - E(s)) $

Uitwerken geeft:

$ E(s) (1 + G_p(s) G_c(s)) = G_p(s) G_c(s) R(s) $

De overdrachtsfunctie van het gesloten systeem wordt daarmee:

#math.equation(block: true, numbering: "(1)",
  $ T(s) = E(s)/R(s)
    = (G_p(s) G_c(s))/(1 + G_p(s) G_c(s)) $
)

Door de overdrachtsfuncties in te vullen vinden we:

#math.equation(block: true, numbering: "(1)",
  $ eqbox(
    T(s) = (A K_p)/(J s^2 + b s + B + A K_p)
  ) $
)

De noemer bepaalt de stabiliteit van het gesloten systeem. De karakteristieke vergelijking is:

#math.equation(block: true, numbering: "(1)",
  $ J s^2 + b s + B + A K_p = 0 $
)

Dit is dezelfde karakteristieke vergelijking die we eerder uit de differentiaalvergelijking hebben afgeleid.

Voor $J > 0$ en $b > 0$ is het systeem asymptotisch stabiel wanneer:

#math.equation(block: true, numbering: "(1)",
  $ eqbox(B + A K_p > 0) $
)

Een grotere proportionele versterking verhoogt de effectieve stijfheid, maar veroorzaakt in dit ideale model geen instabiliteit zolang aan deze voorwaarde wordt voldaan.

=== Overdrachtsfunctie van de motor

In werkelijkheid reageert de motor niet onmiddellijk op een verandering van de PWM-waarde.

We beschrijven de motor met een eersteordemodel:

#math.equation(block: true, numbering: "(1)",
  $ tau_m dot(q) + q = A K_p e(t) $
)

Hierin is $tau_m$ de tijdconstante van de motor.

Na Laplacetransformatie met nulbeginvoorwaarden vinden we:

#math.equation(block: true, numbering: "(1)",
  $ (tau_m s + 1) Q(s) = A K_p (R(s) - E(s)) $
)

De overdrachtsfunctie van de motor, van gewenst naar werkelijk motorkoppel, is:

#math.equation(block: true, numbering: "(1)",
  $ eqbox(G_m(s) = 1/(tau_m s + 1)) $
)

De motor introduceert daarmee een extra factor in de open-loop-overdrachtsfunctie.

=== Open-loop-overdrachtsfunctie

De open-loop-overdrachtsfunctie is het product van de regelaar, de motor en de pendulum:

#math.equation(block: true, numbering: "(1)",
  $ L(s) = G_c(s) G_m(s) G_p(s) $
)

Invullen geeft:

#math.equation(block: true, numbering: "(1)",
  $ eqbox(
    L(s) = (A K_p)/
    ((tau_m s + 1)(J s^2 + b s + B))
  ) $
)

De open-loop-overdrachtsfunctie beschrijft de dynamica van de regelkring voordat de terugkoppeling wordt gesloten.

=== Gesloten regelsysteem met motorvertraging

Voor negatieve eenheidsterugkoppeling geldt opnieuw:

#math.equation(block: true, numbering: "(1)",
  $ T(s) = L(s)/(1 + L(s)) $
)

Daarmee vinden we:

#math.equation(block: true, numbering: "(1)",
  $ T(s) = (A K_p)/
    ((tau_m s + 1)(J s^2 + b s + B) + A K_p) $
)

We werken de noemer uit:

#math.equation(block: true, numbering: "(1)",
  $ eqbox(
    T(s) = (A K_p)/
    (tau_m J s^3
    + (J + tau_m b) s^2
    + (b + tau_m B) s
    + B + A K_p)
  ) $
)

De motorvertraging heeft een extra factor in de noemer geïntroduceerd. Het gesloten systeem is daardoor van de derde orde geworden.

=== Stabiliteit met het Routh-Hurwitz-criterium

De karakteristieke vergelijking is:

#math.equation(block: true, numbering: "(1)",
  $ tau_m J s^3
    + (J + tau_m b) s^2
    + (b + tau_m B) s
    + B + A K_p = 0 $
)

Voor een derdeorde-systeem met positieve coëfficiënten vereist het Routh-Hurwitz-criterium:

#math.equation(block: true, numbering: "(1)",
  $ a_2 a_1 > a_3 a_0 $
)

Invullen geeft:

#math.equation(block: true, numbering: "(1)",
  $ (J + tau_m b)(b + tau_m B)
    > tau_m J (B + A K_p) $
)

De stabiliteitsgrens vinden we door de ongelijkheid te vervangen door een gelijkheid en op te lossen naar $K_p$:

#math.equation(block: true, numbering: "(1)",
  $ eqbox(
    K_(p,"krit") = b/A
    (1/tau_m + b/J + (tau_m B)/J)
  ) $
)

Voor positieve $J$, $b$, $B$, $A$ en $tau_m$ geldt:

- Bij $K_p < K_(p,"krit")$ is het systeem asymptotisch stabiel.
- Bij $K_p = K_(p,"krit")$ ligt het systeem op de stabiliteitsgrens.
- Bij $K_p > K_(p,"krit")$ is het systeem instabiel.

=== Fysische interpretatie

In het Laplacedomein wordt de invloed van de motorvertraging zichtbaar als de factor:

$ 1/(tau_m s + 1) $

Deze factor introduceert een extra pool in het systeem en zorgt ervoor dat de motor niet onmiddellijk reageert op de regelaar.

Bij een grotere proportionele versterking wordt de terugkoppeling sterker. Door de vertraagde motorrespons kan de kracht echter steeds verder uit fase raken met de beweging.

Wanneer de versterking de kritische waarde overschrijdt, verschuiven karakteristieke polen naar het rechterhalfvlak van het complexe vlak. De bijbehorende verstoringen groeien dan exponentieel.

