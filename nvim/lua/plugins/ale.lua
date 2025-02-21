--[====[return {
    'dense-analysis/ale',
    enabled = false, 
    config = function()
        -- Configuration goes here.
        local g = vim.g

        g.ale_ruby_rubocop_auto_correct_all = 1

        g.ale_linters = {
            typescript = {'tsserver'},
            typescriptreact = {'tsserver'},
        }
    end
}
--]====]

return {
  'dense-analysis/ale',
  enabled = true,
  config = function()
    local g = vim.g

    -- Linter configuration
    g.ale_linters = {
      c = {'clang', 'clangtidy', 'gcc'},
      cpp = {'clang', 'clangtidy', 'cppcheck'},
      python = {'flake8', 'pylint', 'mypy'},
      php = {'php', 'phpcs', 'phpmd'},
      markdown = {'markdownlint', 'vale'},
    }

    -- Fixer configuration
    g.ale_fixers = {
      c = {'clang-format'},
      cpp = {'clang-format'},
      python = {'black', 'isort'},
      php = {'php_cs_fixer'},
      markdown = {'prettier'},
    }

    -- Language-specific settings
    -- C/C++
    g.ale_c_clang_options = '-std=c17 -Wall -Wextra -I./include'
    g.ale_cpp_clang_options = '-std=c++20 -Wall -Wextra -I./include'
    g.ale_cpp_cppcheck_options = '--enable=all --std=c++20'

    -- Python
    g.ale_python_flake8_options = '--max-line-length=88 --ignore=E203,W503'
    g.ale_python_black_options = '--line-length 88'

    -- PHP
    g.ale_php_phpcs_standard = 'PSR12'
    g.ale_php_phpmd_ruleset = 'codesize,design,unusedcode'

    -- Markdown
    g.ale_markdown_markdownlint_options = '--config ~/.markdownlint.json'
    g.ale_markdown_prettier_options = '--prose-wrap always'

    -- General settings
    g.ale_fix_on_save = 1
    g.ale_lint_on_text_changed = 'normal'
    g.ale_completion_enabled = 1
  end
}
