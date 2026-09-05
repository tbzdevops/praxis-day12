#!/bin/bash
# PRAXIS Tag 12 — AI in DevOps. Geprüft wird das Wurzel-Verzeichnis: Code und
# Workflow liegen dort, wo sie im echten Repo auch liegen (.github/workflows/).
source .github/classroom/grade.sh

solution_for_id() {
  case "$1" in
    ai-code) echo "Lege utils/validators.py mit der geprüften Funktion an" ;;
    ai-tests) echo "Lege tests/test_validators.py mit pytest-Tests an" ;;
    spec) echo "Lege specs/<thema>.md mit Ziel, Anforderungen und Akzeptanzkriterien an" ;;
    spec-content) echo "Ergänze in der Spec die Abschnitte Ziel, Anforderungen, Akzeptanzkriterien und Out of Scope" ;;
    adr) echo "Lege docs/adr/0001-<thema>.md an (Status, Kontext, Entscheidung, Konsequenzen)" ;;
    adr-content) echo "Der ADR braucht die Abschnitte Status, Kontext, Entscheidung und Konsequenzen" ;;
    spec-impl) echo "Implementiere die Spec (z. B. discounts/validator.py) inklusive Tests unter tests/" ;;
    ai-workflow) echo "Lege .github/workflows/ai-review.yml an" ;;
    ai-api) echo "Rufe im Workflow ein AI-Modell auf (z. B. models.inference.ai.azure.com oder GitHub Models)" ;;
    ai-pr) echo "Der Workflow soll auf pull_request reagieren und Feedback zurückgeben" ;;
    praxis-doku) echo "Lege DOKUMENTATION.md im Wurzel-Verzeichnis an und dokumentiere Prompt Injection (Angriff + Verteidigung, mind. 100 Wörter)" ;;
    *) echo "Überprüfe die Aufgabenstellung im README" ;;
  esac
}

echo "🔍 Prüfe Abnahmekriterien für Tag 12 Praxis — AI in DevOps"
echo ""

WF=.github/workflows
DOKU=DOKUMENTATION.md

# classroom.yml gehoert zur Bewertung und darf kein Kriterium erfuellen.
own_wf() { ls $WF/*.yml $WF/*.yaml 2>/dev/null | grep -v '/classroom\.yml$'; }
# Der AI-Review-Workflow, erkennbar am Modell-Aufruf.
ai_wf() { own_wf | xargs -r grep -lEi 'models\.inference|github models|openai|gpt-|claude|llm' 2>/dev/null; }
AI_FILES="$(ai_wf | tr '\n' ' ')/dev/null"

echo "── Aufgabe 1: AI-Assisted Development ──"

check "ai-code" \
  "Aufgabe 1: Python-Modul unter utils/ vorhanden" \
  "ls utils/*.py 2>/dev/null | grep -q ."

check "ai-tests" \
  "Aufgabe 1: pytest-Tests vorhanden (tests/test_*.py)" \
  "ls tests/test_*.py 2>/dev/null | grep -q ."

check "ai-tests" \
  "Aufgabe 1: Tests enthalten mindestens einen Testfall (def test_)" \
  "grep -rqE '^def test_' tests/ 2>/dev/null"

echo ""
echo "── Aufgabe 2: Spec-Driven Development und ADR ──"

check "spec" \
  "Aufgabe 2: Spec vorhanden (specs/*.md)" \
  "ls specs/*.md 2>/dev/null | grep -q ."

check "spec-content" \
  "Aufgabe 2: Spec nennt Ziel, Anforderungen und Akzeptanzkriterien" \
  "grep -rqiE 'ziel' specs/ 2>/dev/null && grep -rqiE 'anforderung' specs/ 2>/dev/null && grep -rqiE 'akzeptanzkriterien' specs/ 2>/dev/null"

check "adr" \
  "Aufgabe 2: Architecture Decision Record vorhanden (docs/adr/*.md)" \
  "ls docs/adr/*.md 2>/dev/null | grep -q ."

check "adr-content" \
  "Aufgabe 2: ADR nennt Status, Kontext, Entscheidung und Konsequenzen" \
  "grep -rqiE 'status' docs/adr/ 2>/dev/null && grep -rqiE 'kontext' docs/adr/ 2>/dev/null && grep -rqiE 'entscheidung' docs/adr/ 2>/dev/null && grep -rqiE 'konsequenz' docs/adr/ 2>/dev/null"

check "spec-impl" \
  "Aufgabe 2: Implementierung mit Tests zur Spec vorhanden" \
  "ls tests/test_*.py 2>/dev/null | grep -q . && ls discounts/*.py utils/*.py 2>/dev/null | grep -q ."

echo ""
echo "── Aufgabe 3: AI in der CI/CD-Pipeline ──"

check "ai-workflow" \
  "Aufgabe 3: AI-Workflow vorhanden (.github/workflows/)" \
  "ai_wf | grep -q ."

check "ai-api" \
  "Aufgabe 3: AI-Modell wird im Workflow aufgerufen" \
  "grep -qiE 'models\.inference|github models|openai|gpt-|claude|llm' $AI_FILES"

check "ai-pr" \
  "Aufgabe 3: Workflow reagiert auf Pull Requests" \
  "grep -qE 'pull_request' $AI_FILES"

echo ""
echo "── Aufgabe 4: Prompt Injection ──"

check_file_exists "praxis-doku" \
  "Aufgabe 4: DOKUMENTATION.md vorhanden" \
  "$DOKU"

check "praxis-doku" \
  "Aufgabe 4: Prompt Injection dokumentiert (Angriff und Verteidigung)" \
  "grep -qiE 'prompt.?injection' $DOKU 2>/dev/null"

check "praxis-doku" \
  "Aufgabe 4: DOKUMENTATION.md hat ausreichend Inhalt (mind. 100 Wörter)" \
  "[ \$(wc -w < $DOKU 2>/dev/null) -ge 100 ]"

summary 12
