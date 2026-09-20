# Tag 12 Praxis — AI in DevOps

> **Praxisaufträge.** Dieses Repository ist dein Arbeitsplatz für die
> Praxis-Übungen von Tag 12. Es enthält nur das Gerüst und die Vorlage
> `DOKUMENTATION.md` — Spec, Code und Tests schreibst du selbst.

## Ausgangslage

Die Praxis dauert **eine Lektion (45 Min)** und bereitet direkt das Projekt
vor, in dem ihr einen AI-Review-Bot für TechStyle baut:

| Auftrag | Zeit | Thema |
| --- | --- | --- |
| 1 | 25 Min | Spec-Driven Development: AI gegen eine Spec implementieren lassen und kritisch prüfen |
| 2 | 15 Min | Prompt Injection: Angriff und Verteidigung |
| Recap | 5 Min | Plenum |

Die ausführliche Aufgabenstellung steht in der Tagesplanung Tag 12.

## Ordnerstruktur

Alle Dateien gehören ins **Wurzel-Verzeichnis** dieses Repos. Lege keine
Unterordner pro Auftrag an; die automatische Prüfung sucht die Dateien
genau hier.

```
specs/rabattcode.md          # Auftrag 1: die Spec (zuerst!)
discounts/__init__.py        # Auftrag 1: leer, macht discounts/ zum Paket
discounts/validator.py       # Auftrag 1: validate_discount_code (AI-generiert, von dir geprüft)
tests/test_discount.py       # Auftrag 1: Akzeptanzkriterien + eigene Randfälle als pytest-Tests
DOKUMENTATION.md             # Auftrag 1 + 2: Review des AI-Outputs, Prompt Injection
```

## Format der Abgabe-Dateien

Der Autograder beurteilt **nicht**, ob deine Analyse fachlich stimmt — das
macht die Lehrperson beim Durchsehen. Er prüft nur: liegen die Dateien am
richtigen Ort, laufen die Tests grün, und ist die Vorlage ausgefüllt?
**Inhalt frei, Struktur verbindlich.**

### `DOKUMENTATION.md`

| Regel | Warum |
| --- | --- |
| Dateiname **exakt `DOKUMENTATION.md`**, alle Buchstaben gross | Der Prüf-Runner läuft unter Linux — `Dokumentation.md` ist dort eine **andere** Datei. |
| Die Überschriften `## Auftrag 1` und `## Auftrag 2` bleiben stehen | Die Prüfung liest jeden Abschnitt einzeln. |
| Jeden `<Platzhalter>` ersetzen | Ein Abschnitt mit Platzhaltern gilt als nicht ausgefüllt. |

**Abschnitt Auftrag 1:** mindestens 40 Wörter dazu, was die AI übersehen
hat, was du korrigiert hast und was die Spec verändert hat.

**Abschnitt Auftrag 2 — drei Pflichtangaben:**

1. Die Tabelle: je Angriff `ja` oder `nein`, ohne und mit Härtung.
2. Der gehärtete System-Prompt als **Codeblock** (mindestens 20 Wörter).
3. Die Transfer-Antwort: wie ein Angreifer einen AI-Review-Bot über den
   **Diff** eines Pull Requests manipulieren kann — das Wort `Diff` muss
   vorkommen.

### Spec und Tests

- Die Spec unter `specs/` braucht die vier Überschriften `Ziel`,
  `Anforderungen`, `Akzeptanzkriterien` und `Out of Scope`.
- Die Implementierung liegt unter `discounts/`, die Tests unter
  `tests/test_*.py`. Die Prüfung führt `python3 -m pytest tests/` aus —
  alle Tests müssen grün sein.

## Aufgaben

### Auftrag 1 — Spec-Driven Development mit AI (25 Min)

1. **Spec schreiben:** `specs/rabattcode.md` mit Ziel, Anforderungen,
   Akzeptanzkriterien und Out of Scope (Vorlage in der Tagesplanung).
2. **AI implementieren lassen:** Gib Copilot oder dem Playground von GitHub
   Models die ganze Spec als Kontext und lass `discounts/validator.py`
   generieren. Übernimm jedes Akzeptanzkriterium als Test in
   `tests/test_discount.py`.
3. **Kritisch prüfen:** Teste Fälle, die nicht in der Spec stehen
   (`"summer25"`, `" SUMMER25"`, `"SUMMER25!"`, 13 Zeichen, `None`) und
   ergänze dafür Tests. Halte in `DOKUMENTATION.md` fest, was die AI
   übersehen hat und was du korrigiert hast.

### Auftrag 2 — Prompt Injection: Angriff und Verteidigung (15 Min)

1. **Angriff:** Setze im Playground von GitHub Models den System-Prompt des
   TechStyle-Kundenservice-Bots und greife ihn mit drei Techniken an:
   direkt, per Rollenspiel und mit einer versteckten Anweisung.
2. **Verteidigung:** Härte den System-Prompt und wiederhole die Angriffe.
3. **Transfer:** Im Projekt baust du einen Bot, der den Diff eines Pull
   Requests liest. Wie könnte ein Angreifer ihn über den Diff manipulieren,
   und was hilft dagegen?

## Abnahmekriterien

Diese Kriterien prüft die Pipeline bei jedem Push automatisch. **Die Haken
setzt die Pipeline selbst:** ein erfülltes Kriterium wird abgehakt, und
sobald eine Änderung es wieder bricht, verschwindet der Haken. Du musst hier
nichts von Hand pflegen — beim nächsten Push wird die Liste überschrieben.

<!-- c50:progress -->
**Fortschritt: 0 / 9 Kriterien erfüllt** ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ — Stand: 2026-09-20 08:38 UTC.
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

Zusätzlich manuell abgenommen (nicht automatisch geprüft):

- Auftrag 2 im Recap diskutiert: welcher Angriff hat die Härtung überstanden?

## Abnahmekriterien selber prüfen

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
den konkreten Lösungshinweis. Sobald ein Kriterium fehlt, endet das
Skript mit Exit-Code 1.

**In GitHub** — bei jedem Push:

Der Workflow **🎓 Classroom Autograding** läuft automatisch und hakt die
erfüllten Kriterien oben im README ab. Ergebnis im Tab **Actions** →
letzter Run → Job *Abnahmekriterien prüfen*.

Die Punktzahl ist **anteilig**: jedes erfüllte Abnahmekriterium zählt einen
Punkt (z. B. `Points 8/13`). Grün wird der Lauf erst, wenn alle Kriterien
erfüllt sind — Teilpunkte gibt es aber ab dem ersten.

## Musterlösung

Nach dem Unterricht findest du die Musterlösung im Repository
[`tbzdevops/musterloesungen-praxisauftraege`](https://github.com/tbzdevops/musterloesungen-praxisauftraege/tree/day_12_solution)
auf dem Branch `day_12_solution`.
