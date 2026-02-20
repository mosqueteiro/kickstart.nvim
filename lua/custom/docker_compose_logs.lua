local M = {}

---Creates a new buffer and streams docker compose logs into it
---@param cmd string[]|nil Command to run for streaming logs, default={ 'docker', 'compose', 'logs', '-f' }
---@param name string|nil Name of service streaming logs from
function M.compose_logs(cmd, name)
  cmd = cmd or { 'docker', 'compose', 'logs', '-f' }
  if name then
    table.insert(cmd, name)
  end
  name = name or ''

  local buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_name(buf, 'compose-logs://' .. name)
  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = 'log'

  vim.api.nvim_set_current_buf(buf)

  ---Append chunks to buffer
  ---@param lines string[] Array of strings to append
  local function append_to_buffer(lines)
    if not lines or #lines == 0 then
      return
    end

    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(buf) then
        return
      end
      local last_line = vim.api.nvim_buf_get_lines(buf, -2, -1, false)[1]

      lines[1] = (last_line or '') .. lines[1]

      vim.api.nvim_buf_set_lines(buf, -2, -1, false, lines)
    end)
  end

  local job_id = vim.fn.jobstart(cmd, {
    stdout_buffered = false,
    stderr_buffered = false,
    on_stdout = function(_, data)
      append_to_buffer(data)
    end,
    on_stderr = function(_, data)
      append_to_buffer(data)
    end,
    on_exit = function(_, code)
      append_to_buffer { '', ('[compose logs exited: %d]'):format(code) }
    end,
  })
  if job_id < 1 then
    vim.notify('Failed to start docker compose logs', vim.log.levels.ERROR)
    return
  end
  vim.api.nvim_create_autocmd('BufDelete', {
    buffer = buf,
    callback = function()
      if job_id and job_id > 0 then
        vim.fn.jobstop(job_id)
      end
    end,
    desc = 'Stop stdout stream job',
    once = true,
  })

  vim.b[buf].compose_logs_job_id = job_id
end

function M.stop_logs(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local job_id = vim.b[buf].compose_logs_job_id
  if job_id and job_id > 0 then
    vim.fn.jobstop(job_id)
    vim.b[buf].compose_logs_job_id = nil
  end
end

vim.api.nvim_create_user_command('ComposeLogs', function(opts)
  local service = opts.args ~= '' and opts.args or nil
  M.compose_logs(nil, service)
end, { nargs = '?' })
vim.api.nvim_create_user_command('ComposeLogsStop', function()
  M.stop_logs()
end, {})

return M
