# Tag 12 Praxis — AI in DevOps

> **Praxisauftraege.** Dieses Repository ist dein Arbeitsplatz fuer die
> Praxis-Uebungen von Tag 12. Es enthaelt nur das Geruest und die Vorlage
> `DOKUMENTATION.md` — Spec, Code und Tests schreibst du selbst.

## Ausgangslage

Die Praxis dauert **eine Lektion (45 Min)** und bereitet direkt das Projekt
vor, in dem ihr einen AI-Review-Bot fuer TechStyle baut:

| Auftrag | Zeit | Thema |
| --- | --- | --- |
| 1 | 25 Min | Spec-Driven Development: AI gegen eine Spec implementieren lassen und kritisch pruefen |
| 2 | 15 Min | Prompt Injection: Angriff und Verteidigung |
| Recap | 5 Min | Plenum |

Die ausfuehrliche Aufgabenstellung steht in der Tagesplanung Tag 12.

## Ordnerstruktur

Alle Dateien gehoeren ins **Wurzel-Verzeichnis** dieses Repos. Lege keine
Unterordner pro Auftrag an; die automatische Pruefung sucht die Dateien
genau hier.

```
specs/rabattcode.md          # Auftrag 1: die Spec (zuerst!)
discounts/__init__.py        # Auftrag 1: leer, macht discounts/ zum Paket
discounts/validator.py       # Auftrag 1: validate_discount_code (AI-generiert, von dir geprueft)
tests/test_discount.py       # Auftrag 1: Akzeptanzkriterien + eigene Randfaelle als pytest-Tests
DOKUMENTATION.md             # Auftrag 1 + 2: Review des AI-Outputs, Prompt Injection
```

## Format der Abgabe-Dateien

Der Autograder beurteilt **nicht**, ob deine Analyse fachlich stimmt — das
macht die Lehrperson beim Durchsehen. Er prueft nur: liegen die Dateien am
richtigen Ort, laufen die Tests gruen, und ist die Vorlage ausgefuellt?
**Inhalt frei, Struktur verbindlich.**

### `DOKUMENTATION.md`

| Regel | Warum |
| --- | --- |
| Dateiname **exakt `DOKUMENTATION.md`**, alle Buchstaben gross | Der Pruef-Runner laeuft unter Linux — `Dokumentation.md` ist dort eine **andere** Datei. |
| Die Ueberschriften `## Auftrag 1` und `## Auftrag 2` bleiben stehen | Die Pruefung liest jeden Abschnitt einzeln. |
| Jeden `<Platzhalter>` ersetzen | Ein Abschnitt mit Platzhaltern gilt als nicht ausgefuellt. |

**Abschnitt Auftrag 1:** mindestens 40 Woerter dazu, was die AI uebersehen
hat, was du korrigiert hast und was die Spec veraendert hat.

**Abschnitt Auftrag 2 — drei Pflichtangaben:**

1. Die Tabelle: je Angriff `ja` oder `nein`, ohne und mit Haertung.
2. Der gehaertete System-Prompt als **Codeblock** (mindestens 20 Woerter).
3. Die Transfer-Antwort: wie ein Angreifer einen AI-Review-Bot ueber den
   **Diff** eines Pull Requests manipulieren kann — das Wort `Diff` muss
   vorkommen.

### Spec und Tests

- Die Spec unter `specs/` braucht die vier Ueberschriften `Ziel`,
  `Anforderungen`, `Akzeptanzkriterien` und `Out of Scope`.
- Die Implementierung liegt unter `discounts/`, die Tests unter
  `tests/test_*.py`. Die Pruefung fuehrt `python3 -m pytest tests/` aus —
  alle Tests muessen gruen sein.

## Aufgaben

### Auftrag 1 — Spec-Driven Development mit AI (25 Min)

1. **Spec schreiben:** `specs/rabattcode.md` mit Ziel, Anforderungen,
   Akzeptanzkriterien und Out of Scope (Vorlage in der Tagesplanung).
2. **AI implementieren lassen:** Gib Copilot oder dem Playground von GitHub
   Models die ganze Spec als Kontext und lass `discounts/validator.py`
   generieren. Uebernimm jedes Akzeptanzkriterium als Test in
   `tests/test_discount.py`.
3. **Kritisch pruefen:** Teste Faelle, die nicht in der Spec stehen
   (`"summer25"`, `" SUMMER25"`, `"SUMMER25!"`, 13 Zeichen, `None`) und
   ergaenze dafuer Tests. Halte in `DOKUMENTATION.md` fest, was die AI
   uebersehen hat und was du korrigiert hast.

### Auftrag 2 — Prompt Injection: Angriff und Verteidigung (15 Min)

1. **Angriff:** Setze im Playground von GitHub Models den System-Prompt des
   TechStyle-Kundenservice-Bots und greife ihn mit drei Techniken an:
   direkt, per Rollenspiel und mit einer versteckten Anweisung.
2. **Verteidigung:** Haerte den System-Prompt und wiederhole die Angriffe.
3. **Transfer:** Im Projekt baust du einen Bot, der den Diff eines Pull
   Requests liest. Wie koennte ein Angreifer ihn ueber den Diff manipulieren,
   und was hilft dagegen?

## Abnahmekriterien

Diese Kriterien prueft die Pipeline bei jedem Push automatisch. **Die Haken
setzt die Pipeline selbst:** ein erfuelltes Kriterium wird abgehakt, und
sobald eine Aenderung es wieder bricht, verschwindet der Haken. Du musst hier
nichts von Hand pflegen — beim naechsten Push wird die Liste ueberschrieben.

<!-- c50:progress -->
**Fortschritt: 0 / 9 Kriterien erfüllt** ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ — Stand: 2026-09-19 14:23 UTC.
<!-- /c50:progress -->

- [ ] ⬜ Auftrag 1: Spec vorhanden (specs/*.md)
- [ ] ⬜ Auftrag 1: Spec nennt Ziel, Anforderungen, Akzeptanzkriterien und Out of Scope
- [ ] ⬜ Auftrag 1: Implementierung zur Spec vorhanden (discounts/*.py)
- [ ] ⬜ Auftrag 1: Tests zu den Akzeptanzkriterien vorhanden (tests/test_*.py mit def test_)
- [ ] ⬜ Auftrag 1: Tests laufen grün (pytest)
- [ ] ⬜ Auftrag 1: Review des AI-Outputs dokumentiert (DOKUMENTATION.md, ohne Platzhalter, mind. 40 Wörter)
- [ ] ⬜ Auftrag 2: Ergebnis je Angriff dokumentiert (ohne Platzhalter, ja/nein)
- [ ] ⬜ Auftrag 2: Gehärteter System-Prompt als Codeblock (mind. 20 Wörter)
- [ ] ⬜ Auftrag 2: Transfer auf den AI-Review-Bot — Angriff über den PR-Diff beschrieben

Zusaetzlich manuell abgenommen (nicht automatisch geprueft):

- Auftrag 2 im Recap diskutiert: welcher Angriff hat die Haertung ueberstanden?

## Abnahmekriterien selber pruefen

**Lokal** — jederzeit, ohne Push:

```bash
bash .github/classroom/grade.sh
```

Das Skript liest die Tagesnummer aus `.classroom50.yaml`. Du kannst sie
auch erzwingen:

```bash
CLASSROOM_DAY=12 bash .github/classroom/grade.sh
```

Die Ausgabe listet jedes Kriterium mit ✅ oder ❌ und nennt bei jedem ❌
den konkreten Loesungshinweis. Sobald ein Kriterium fehlt, endet das
Skript mit Exit-Code 1.

**In GitHub** — bei jedem Push:

Der Workflow **🎓 Classroom Autograding** laeuft automatisch und hakt die
erfuellten Kriterien oben im README ab. Ergebnis im Tab **Actions** →
letzter Run → Job *Abnahmekriterien pruefen*.

Die Punktzahl ist **anteilig**: jedes erfuellte Abnahmekriterium zaehlt einen
Punkt (z. B. `Points 8/13`). Gruen wird der Lauf erst, wenn alle Kriterien
erfuellt sind — Teilpunkte gibt es aber ab dem ersten.

## Musterloesung

Nach dem Unterricht findest du die Musterloesung im Repository
[`tbzdevops/musterloesungen-praxisauftraege`](https://github.com/tbzdevops/musterloesungen-praxisauftraege/tree/day_12_solution)
auf dem Branch `day_12_solution`.
