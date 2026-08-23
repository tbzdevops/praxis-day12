#!/bin/bash
# PRAXIS Tag 13 — AI in DevOps. Geprüft wird der Praxis-Ordner tag13/.
source .github/classroom/grade.sh

solution_for_id() {
  case "$1" in
    ai-code) echo "Lege tag13/auftrag01-ai-assisted/utils/validators.py mit der geprüften Funktion an" ;;
    ai-tests) echo "Lege tag13/auftrag01-ai-assisted/tests/test_validators.py mit pytest-Tests an" ;;
    spec) echo "Lege tag13/auftrag02-spec-adr/specs/<thema>.md mit Ziel, Anforderungen und Akzeptanzkriterien an" ;;
    spec-content) echo "Ergänze in der Spec die Abschnitte Ziel, Anforderungen, Akzeptanzkriterien und Out of Scope" ;;
    adr) echo "Lege tag13/auftrag02-spec-adr/docs/adr/0001-<thema>.md an (Status, Kontext, Entscheidung, Konsequenzen)" ;;
    adr-content) echo "Der ADR braucht die Abschnitte Status, Kontext, Entscheidung und Konsequenzen" ;;
    spec-impl) echo "Implementiere die Spec unter tag13/auftrag02-spec-adr/ inklusive Tests" ;;
    ai-workflow) echo "Lege tag13/auftrag03-ai-cicd/.github/workflows/ai-review.yml an" ;;
    ai-api) echo "Rufe im Workflow ein AI-Modell auf (z. B. models.inference.ai.azure.com oder GitHub Models)" ;;
    ai-pr) echo "Der Workflow soll auf pull_request reagieren und Feedback zurückgeben" ;;
    praxis-doku) echo "Lege tag13/README.md an und dokumentiere Prompt Injection (Angriff + Verteidigung, mind. 100 Wörter)" ;;
    *) echo "Überprüfe die Aufgabenstellung im README" ;;
  esac
}

echo "🔍 Prüfe Abnahmekriterien für Tag 13 Praxis — AI in DevOps"
echo ""

A1=tag13/auftrag01-ai-assisted
A2=tag13/auftrag02-spec-adr
A3WF=tag13/auftrag03-ai-cicd/.github/workflows

ai_wf() { ls $A3WF/*.yml $A3WF/*.yaml 2>/dev/null; }
AI_FILES="$(ai_wf | tr '\n' ' ')/dev/null"

echo "── Aufgabe 1: AI-Assisted Development ──"

check "ai-code" \
  "Aufgabe 1: Python-Modul unter tag13/auftrag01-ai-assisted/ vorhanden" \
  "ls $A1/utils/*.py $A1/*.py 2>/dev/null | grep -q ."

check "ai-tests" \
  "Aufgabe 1: pytest-Tests vorhanden (tests/test_*.py)" \
  "ls $A1/tests/test_*.py 2>/dev/null | grep -q ."

check "ai-tests" \
  "Aufgabe 1: Tests enthalten mindestens einen Testfall (def test_)" \
  "grep -rqE '^def test_' $A1/tests/ 2>/dev/null"

echo ""
echo "── Aufgabe 2: Spec-Driven Development und ADR ──"

check "spec" \
  "Aufgabe 2: Spec vorhanden (tag13/auftrag02-spec-adr/specs/*.md)" \
  "ls $A2/specs/*.md 2>/dev/null | grep -q ."

check "spec-content" \
  "Aufgabe 2: Spec nennt Ziel, Anforderungen und Akzeptanzkriterien" \
  "grep -rqiE 'ziel' $A2/specs/ 2>/dev/null && grep -rqiE 'anforderung' $A2/specs/ 2>/dev/null && grep -rqiE 'akzeptanzkriterien' $A2/specs/ 2>/dev/null"

check "adr" \
  "Aufgabe 2: Architecture Decision Record vorhanden (docs/adr/*.md)" \
  "ls $A2/docs/adr/*.md 2>/dev/null | grep -q ."

check "adr-content" \
  "Aufgabe 2: ADR nennt Status, Kontext, Entscheidung und Konsequenzen" \
  "grep -rqiE 'status' $A2/docs/adr/ 2>/dev/null && grep -rqiE 'kontext' $A2/docs/adr/ 2>/dev/null && grep -rqiE 'entscheidung' $A2/docs/adr/ 2>/dev/null && grep -rqiE 'konsequenz' $A2/docs/adr/ 2>/dev/null"

check "spec-impl" \
  "Aufgabe 2: Implementierung mit Tests zur Spec vorhanden" \
  "ls $A2/tests/test_*.py 2>/dev/null | grep -q ."

echo ""
echo "── Aufgabe 3: AI in der CI/CD-Pipeline ──"

check "ai-workflow" \
  "Aufgabe 3: AI-Workflow vorhanden (tag13/auftrag03-ai-cicd/.github/workflows/)" \
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
  "Aufgabe 4: tag13/README.md vorhanden" \
  "tag13/README.md"

check "praxis-doku" \
  "Aufgabe 4: Prompt Injection dokumentiert (Angriff und Verteidigung)" \
  "grep -qiE 'prompt.?injection' tag13/README.md 2>/dev/null"

check "praxis-doku" \
  "Aufgabe 4: tag13/README.md hat ausreichend Inhalt (mind. 100 Wörter)" \
  "[ \$(wc -w < tag13/README.md 2>/dev/null) -ge 100 ]"

summary 13
