return {
    'gera2ld/ai.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {
        api_key = 'YOUR_GEMINI_API_KEY', -- or read from env: `os.getenv('GEMINI_API_KEY')`
        locale = 'fr',
        alternate_locale = 'en',
    },
    cmd = { 'GeminiDefine', 'GeminiDefineV', 'GeminiTranslate', 'GeminiAsk' },
}
