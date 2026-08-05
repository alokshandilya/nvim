local M = {}

local function staged_diff()
  local diff = vim.fn.system({ "git", "diff", "--cached" })

  if vim.v.shell_error ~= 0 or diff == "" then
    diff = vim.fn.system({ "git", "diff" })
  end

  return diff
end

local function commit_prompt(diff)
  return table.concat({
    "Write a concise Conventional Commit message for this diff:",
    diff,
    "Return only the commit message, nothing else (no explanation, no code fences).",
    "The subject line MUST follow the format: type(optional scope): description",
    "where type is one of: feat, fix, refactor, perf, docs, style, test, build, ci, chore.",
    "Use imperative mood, lowercase description, and no trailing period.",
    "Keep the subject line under 50 characters.",
    "Leave one blank line between the subject and the body.",
    "In the body, wrap lines at 72 characters.",
    "If there are several distinct changes, write the body as bullet points"
      .. " starting with '- '; if there is only one change, use a short prose"
      .. " paragraph instead.",
    "Omit the body entirely if the subject is self-explanatory.",
  }, "\n\n")
end

function M.generate_commit_message()
  local diff = staged_diff()

  if diff == "" then
    vim.notify("No staged or unstaged git diff found", vim.log.levels.WARN, { title = "claude" })
    return
  end

  vim.notify("Generating commit message...", vim.log.levels.INFO, { title = "claude" })

  vim.system(
    { "claude", "-p", "--model", "sonnet" },
    { text = true, stdin = commit_prompt(diff) },
    function(result)
      vim.schedule(function()
        if result.code ~= 0 then
          vim.notify(result.stderr or "Failed to generate commit message", vim.log.levels.ERROR, { title = "claude" })
          return
        end

        local message = vim.trim(result.stdout or "")

        if message == "" then
          vim.notify("Claude returned an empty commit message", vim.log.levels.WARN, { title = "claude" })
          return
        end

        vim.fn.setreg("+", message)
        vim.fn.setreg('"', message)
        vim.notify("Commit message copied to clipboard", vim.log.levels.INFO, { title = "claude" })
      end)
    end
  )
end

return M
