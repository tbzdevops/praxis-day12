# Tag 13 Praxis — AI in DevOps

> **Praxisauftraege.** Dieses Repository ist dein Arbeitsplatz fuer die
> Praxis-Uebungen von Tag 13. Es enthaelt bewusst nur das Geruest —
> jede Datei schreibst du selbst.

## Ausgangslage

AI entlang der DevOps-Kette: AI-Assisted Development (Auftrag 1),
Spec-Driven Development und ADR (Auftrag 2), AI in der CI/CD-Pipeline
(Auftrag 3) und Prompt Injection (Auftrag 4). Auftraege 1 und 2 sind
lauffaehiger, getesteter Python-Code; Auftrag 3 ist ein GitHub-Actions-
Workflow; Auftrag 4 ist eine Analyseuebung.

## Ordnerstruktur

Alle Dateien gehoeren ins **Wurzel-Verzeichnis** dieses Repos bzw. in
`.github/workflows/` — nur dort fuehrt GitHub Actions Workflows aus. Lege
keine Unterordner pro Auftrag an; die automatische Pruefung sucht die
Dateien genau hier.

```
utils/                            # Auftrag 1: dein Modul (z. B. validators.py)
tests/                            # Auftrag 1 + 2: pytest-Tests
specs/                            # Auftrag 2: die Spec
docs/adr/                         # Auftrag 2: der ADR
discounts/                        # Auftrag 2: die Implementierung zur Spec
.github/workflows/ai-review.yml   # Auftrag 3: AI-Review bei Pull Requests
DOKUMENTATION.md                  # Auftrag 4: Prompt Injection
```

## Aufgaben

### Auftrag 1 — AI-Assisted Development: Code verstehen und kritisch pruefen

Lass dir Code von einem AI-Assistenten erzeugen und pruefe ihn kritisch.

- Implementiere unter `utils/` ein Python-Modul (z. B. `validators.py`).
- Schreibe dazu pytest-Tests unter `tests/test_validators.py`.
- Dokumentiere, welche Schwaechen der AI-Vorschlag hatte und was du
  korrigiert hast.

### Auftrag 2 — Spec-Driven Development und ADR

Erst spezifizieren, dann implementieren, Entscheidung festhalten.

- Schreibe eine Spec unter `specs/<thema>.md` mit den Abschnitten Ziel,
  Anforderungen, Akzeptanzkriterien und Out of Scope.
- Implementiere die Spec (z. B. `discounts/validator.py`) und decke sie mit
  Tests unter `tests/` ab.
- Halte die Entscheidung als ADR unter `docs/adr/0001-<thema>.md` fest
  (Status, Kontext, Entscheidung, Konsequenzen).

### Auftrag 3 — AI in der CI/CD-Pipeline: automatisches PR-Feedback

- Lege `.github/workflows/ai-review.yml` an.
- Der Workflow reagiert auf `pull_request` und ruft ein AI-Modell auf
  (z. B. die GitHub Models API).
- Das Feedback wird als Kommentar oder Actions Summary ausgegeben.

### Auftrag 4 — Prompt Injection: Angriff und Verteidigung

Analyseuebung ohne eigenen Code.

- Fuehre einen Prompt-Injection-Angriff gegen deinen AI-Schritt durch.
- Dokumentiere in `DOKUMENTATION.md`, wie der Angriff funktioniert hat und
  welche Gegenmassnahmen du ergreifen wuerdest.

## Abnahmekriterien

Diese Kriterien prueft die Pipeline bei jedem Push automatisch. **Die Haken
setzt die Pipeline selbst:** ein erfuelltes Kriterium wird abgehakt, und
sobald eine Aenderung es wieder bricht, verschwindet der Haken. Du musst hier
nichts von Hand pflegen — beim naechsten Push wird die Liste ueberschrieben.

<!-- c50:progress -->
**Fortschritt: 0 / 14 Kriterien erfüllt** ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ — Stand: 2026-08-23 22:08 UTC.
<!-- /c50:progress -->

- [ ] ⬜ Aufgabe 1: Python-Modul unter utils/ vorhanden
- [ ] ⬜ Aufgabe 1: pytest-Tests vorhanden (tests/test_*.py)
- [ ] ⬜ Aufgabe 1: Tests enthalten mindestens einen Testfall (def test_)
- [ ] ⬜ Aufgabe 2: Spec vorhanden (specs/*.md)
- [ ] ⬜ Aufgabe 2: Spec nennt Ziel, Anforderungen und Akzeptanzkriterien
- [ ] ⬜ Aufgabe 2: Architecture Decision Record vorhanden (docs/adr/*.md)
- [ ] ⬜ Aufgabe 2: ADR nennt Status, Kontext, Entscheidung und Konsequenzen
- [ ] ⬜ Aufgabe 2: Implementierung mit Tests zur Spec vorhanden
- [ ] ⬜ Aufgabe 3: AI-Workflow vorhanden (.github/workflows/)
- [ ] ⬜ Aufgabe 3: AI-Modell wird im Workflow aufgerufen
- [ ] ⬜ Aufgabe 3: Workflow reagiert auf Pull Requests
- [ ] ⬜ Aufgabe 4: DOKUMENTATION.md vorhanden
- [ ] ⬜ Aufgabe 4: Prompt Injection dokumentiert (Angriff und Verteidigung)
- [ ] ⬜ Aufgabe 4: DOKUMENTATION.md hat ausreichend Inhalt (mind. 100 Wörter)

Zusaetzlich manuell abgenommen (nicht automatisch geprueft):

- Auftrag 4 im Kurs diskutiert und Gegenmassnahmen begruendet

## Abnahmekriterien selber pruefen

**Lokal** — jederzeit, ohne Push:

```bash
bash .github/classroom/grade.sh
```

Das Skript liest die Tagesnummer aus `.classroom50.yaml`. Du kannst sie
auch erzwingen:

```bash
CLASSROOM_DAY=13 bash .github/classroom/grade.sh
```

Die Ausgabe listet jedes Kriterium mit ✅ oder ❌ und nennt bei jedem ❌
den konkreten Loesungshinweis. Sobald ein Kriterium fehlt, endet das
Skript mit Exit-Code 1.

**In GitHub** — bei jedem Push:

Der Workflow **🎓 Classroom Autograding** laeuft automatisch und hakt die
erfuellten Kriterien oben im README ab. Ergebnis im Tab **Actions** →
letzter Run → Job *Abnahmekriterien pruefen*.

## Musterloesung

Nach dem Unterricht findest du die Musterloesung im Repository
[`tbzdevops/musterloesungen-praxisauftraege`](https://github.com/tbzdevops/musterloesungen-praxisauftraege/tree/day_13_solution)
auf dem Branch `day_13_solution`.
