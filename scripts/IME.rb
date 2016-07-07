module WinAPI
  module User32
    WM_KEYDOWN = 0x0100
    WM_KEYUP   = 0x0101
    WM_IME_STARTCOMPOSITION = 0x010D
    WM_IME_ENDCOMPOSITION   = 0x010E
    WM_IME_COMPOSITION      = 0x010F
    WM_TABLE = {
      WM_KEYDOWN => :key_down,
      WM_KEYUP   => :key_up,
      WM_IME_STARTCOMPOSITION => :ime_start_composition
      WM_IME_ENDCOMPOSITION   => :ime_end_composition
      WM_IME_COMPOSITION      => :ime_composition
    }
    extern "int MapVirtualKey(int, int)"
  end

  module Imm32
    extend DL::Importer
    dlload "imm32"
    GCS_RESULTSTR = 0x0800
    CompositionForm = struct [
      "int  style", "int  x",   "int  y",
      "int  left",  "int  top", "int  right", "int  bottom"
    ]
    extern "int ImmGetContext(int)"
    extern "int ImmReleaseContext(int, int)"
    extern "int ImmSetOpenStatus(int, int)"
    extern "int ImmGetCandidateWindow( int, int, int* )"
    extern "int ImmSetCandidateWindow( int, int* )"
    extern "int ImmSetCompositionWindow(int, int*)"
    extern "int ImmSetCompositionFont(int, int*)"
    extern "int ImmGetCompositionString(int, int, void*, int)"
  end

  module Gdi32
    extend DL::Importer
    LogFont = struct [
      "int height",     "int width",
      "int esc",        "int oriented",
      "int weight",     "char italic",
      "char underline", "char strikeout",
      "char charset",   "char outprec",
      "char clipprec",  "char quality",
      "char family",    "char name[32]"
    ]
    def self.create_logfont(size, fontname)
      LogFont.malloc.tap do |f|
        f.height,    f.width     = size, 0
        f.esc,       f.oriented  = 0, 0
        f.weight,    f.italic    = 400, 0
        f.underline, f.strikeout = 0, 0
        f.outprec,   f.clipprec  = 0, 0
        f.quality,   f.charset   = 0, 1
        f.family,    f.name      = 0, fontname.ljust(32)
      end
    end
  end
end

class IME
  attr_reader :hImc, :hWnd, :font
  def initialize(hWnd)
    @hImc = nil
    @hWnd = hWnd
    @font = Font.new(16)
    @logfont = WinAPI::Gdi32.create_logfont(@font.size, @font.fontname)
    @active = false
  end
  def active?
    @active
  end
  def font=(font)
    @font = font
    @logfont = WinAPI::Gdi32.create_logfont(@font.size, @font.fontname)
  end
  def acquire_context
    @hImc = WinAPI::Imm32.ImmGetContext(hWnd)
  end
  def release_context
    WinAPI::Imm32.ImmReleaseContext(hWnd, hImc)
    @hImc = nil
  end
  def set_open_status(status)
    WinAPI::Imm32.ImmSetOpenStatus(hImc, status)
  end
  def open(x, y)
    @active = true
    acquire_context
    set_open_status 1
    set_composition_window x, y
    set_composition_font @logfont
    release_context
  end
  def close_ime
    acquire_context
    set_open_status 0
    release_context
    @active = false
  end
  def map_virtual_key(code, type)
    WinAPI::User32.MapVirtualKey(code, type)
  end
  def get_virtual_key(code)
    self.map_virtual_key(code, 1)
  end
  def set_composition_window(x, y)
    WinAPI::Imm32::CompositionForm.malloc.tap {|form|
      form.style  = 0x0002
      form.x , form.y = x, y
      form.left, form.top = 0, 0
      form.right, form.bottom = Console.width, Console.line_height
      WinAPI::Imm32.ImmSetCompositionWindow(self.hImc, form)
    }
  end
  def set_composition_font(font)
      WinAPI::Imm32.ImmSetCompositionFont(self.hImc, font)
  end
  def composited_string(size)
    acquire_context
    (" " * size).tap {|string| WinAPI::Imm32.ImmGetCompositionString(
      self.hImc, GCS_RESULTSTR, string, size
    )}.force_encoding("Windows-31J").rstrip.encode("UTF-8").tap {
      release_context
    }
  end
end

module Window
  @@ime = nil
  def ime=(ime) @@ime = ime end
  def ime() @@ime end
  def self.enable_ime
    WinAPI::User32.WINNLSEnableIME(hWnd, 1)
  end
  def self.disable_ime
    WinAPI::User32.WINNLSEnableIME(hWnd, 0)
  end
end

Window.ime = IME.new(Window.hWnd)