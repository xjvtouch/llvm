include "llvm/Option/OptParser.td"

multiclass Eq<string name, string help> {
  def NAME : Separate<["--", "-"], name>;
  def NAME #_eq : Joined<["--", "-"], name #"=">,
                  Alias<!cast<Separate>(NAME)>,
                  HelpText<help>;
}

def help : Flag<["-", "--"], "help">;

defm binary_architecture
    : Eq<"binary-architecture", "Used when transforming an architecture-less "
                                "format (such as binary) to another format">;
def B : JoinedOrSeparate<["-"], "B">, Alias<binary_architecture>;

defm target : Eq<"target", "Format of the input and output file">,
              Values<"binary">;
def F : JoinedOrSeparate<["-"], "F">, Alias<target>;

defm input_target : Eq<"input-target", "Format of the input file">,
                    Values<"binary">;
def I : JoinedOrSeparate<["-"], "I">, Alias<input_target>;

defm output_target : Eq<"output-target", "Format of the output file">,
                     Values<"binary">;
def O : JoinedOrSeparate<["-"], "O">, Alias<output_target>;

def compress_debug_sections : Flag<["--", "-"], "compress-debug-sections">;
def compress_debug_sections_eq
    : Joined<["--", "-"], "compress-debug-sections=">,
      MetaVarName<"[ zlib | zlib-gnu ]">,
      HelpText<"Compress DWARF debug sections using specified style. Supported "
               "styles: 'zlib-gnu' and 'zlib'">;
def decompress_debug_sections : Flag<["-", "--"], "decompress-debug-sections">,
                                HelpText<"Decompress DWARF debug sections.">;
defm split_dwo
    : Eq<"split-dwo", "Equivalent to extract-dwo on the input file to "
                      "<dwo-file>, then strip-dwo on the input file">,
      MetaVarName<"dwo-file">;

def enable_deterministic_archives
    : Flag<["-", "--"], "enable-deterministic-archives">,
      HelpText<"Enable deterministic mode when copying archives (use zero for "
               "UIDs, GIDs, and timestamps).">;
def D : Flag<["-"], "D">,
        Alias<enable_deterministic_archives>,
        HelpText<"Alias for --enable-deterministic-archives">;

def disable_deterministic_archives
    : Flag<["-", "--"], "disable-deterministic-archives">,
      HelpText<"Disable deterministic mode when copying archives (use real "
               "values for UIDs, GIDs, and timestamps).">;
def U : Flag<["-"], "U">,
        Alias<disable_deterministic_archives>,
        HelpText<"Alias for --disable-deterministic-archives">;

def preserve_dates : Flag<["-", "--"], "preserve-dates">,
                     HelpText<"Preserve access and modification timestamps">;
def p : Flag<["-"], "p">, Alias<preserve_dates>;

defm add_gnu_debuglink
    : Eq<"add-gnu-debuglink", "Add a .gnu_debuglink for <debug-file>">,
      MetaVarName<"debug-file">;

defm remove_section : Eq<"remove-section", "Remove <section>">,
                      MetaVarName<"section">;
def R : JoinedOrSeparate<["-"], "R">, Alias<remove_section>;

defm rename_section
    : Eq<"rename-section",
         "Renames a section from old to new, optionally with specified flags. "
         "Flags supported for GNU compatibility: alloc, load, noload, "
         "readonly, debug, code, data, rom, share, contents, merge, strings.">,
      MetaVarName<"old=new[,flag1,...]">;
defm redefine_symbol
    : Eq<"redefine-sym", "Change the name of a symbol old to new">,
      MetaVarName<"old=new">;
defm redefine_symbols
    : Eq<"redefine-syms",
         "Reads a list of symbol pairs from <filename> and runs as if "
         "--redefine-sym=<old>=<new> is set for each one. <filename> "
         "contains two symbols per line separated with whitespace and may "
         "contain comments beginning with '#'. Leading and trailing "
         "whitespace is stripped from each line. May be repeated to read "
         "symbols from many files.">,         
      MetaVarName<"filename">;

defm keep_section : Eq<"keep-section", "Keep <section>">,
                    MetaVarName<"section">;
defm only_section : Eq<"only-section", "Remove all but <section>">,
                    MetaVarName<"section">;
def j : JoinedOrSeparate<["-"], "j">, Alias<only_section>;
defm add_section
    : Eq<"add-section",
         "Make a section named <section> with the contents of <file>.">,
      MetaVarName<"section=file">;

defm set_section_flags
    : Eq<"set-section-flags",
         "Set section flags for a given section. Flags supported for GNU "
         "compatibility: alloc, load, noload, readonly, debug, code, data, "
         "rom, share, contents, merge, strings.">,
      MetaVarName<"section=flag1[,flag2,...]">;

def strip_all : Flag<["-", "--"], "strip-all">,
                HelpText<"Remove non-allocated sections outside segments. "
                         ".gnu.warning* sections are not removed">;
def S : Flag<["-"], "S">, Alias<strip_all>;
def strip_all_gnu : Flag<["-", "--"], "strip-all-gnu">,
                    HelpText<"Compatible with GNU objcopy's --strip-all">;
def strip_debug : Flag<["-", "--"], "strip-debug">,
                  HelpText<"Remove all debug information">;
def g : Flag<["-"], "g">, Alias<strip_debug>,
        HelpText<"Alias for --strip-debug">;
def strip_dwo : Flag<["-", "--"], "strip-dwo">,
                HelpText<"Remove all DWARF .dwo sections from file">;
def strip_sections
    : Flag<["-", "--"], "strip-sections">,
      HelpText<"Remove all section headers and all sections not in segments">;
def strip_non_alloc
    : Flag<["-", "--"], "strip-non-alloc">,
      HelpText<"Remove all non-allocated sections outside segments">;
def strip_unneeded : Flag<["-", "--"], "strip-unneeded">,
                     HelpText<"Remove all symbols not needed by relocations">;
defm strip_unneeded_symbol
    : Eq<"strip-unneeded-symbol",
         "Remove symbol <symbol> if it is not needed by relocations">,
      MetaVarName<"symbol">;
defm strip_unneeded_symbols
    : Eq<"strip-unneeded-symbols",
         "Reads a list of symbols from <filename> and removes them "
         "if they are not needed by relocations">,
      MetaVarName<"filename">;

def extract_dwo
    : Flag<["-", "--"], "extract-dwo">,
      HelpText<
          "Remove all sections that are not DWARF .dwo sections from file">;

def localize_hidden
    : Flag<["-", "--"], "localize-hidden">,
      HelpText<
          "Mark all symbols that have hidden or internal visibility as local">;
defm localize_symbol : Eq<"localize-symbol", "Mark <symbol> as local">,
                       MetaVarName<"symbol">;
defm localize_symbols
    : Eq<"localize-symbols",
         "Reads a list of symbols from <filename> and marks them local.">,
      MetaVarName<"filename">;

def L : JoinedOrSeparate<["-"], "L">, Alias<localize_symbol>;

defm globalize_symbol : Eq<"globalize-symbol", "Mark <symbol> as global">,
                        MetaVarName<"symbol">;

defm globalize_symbols
    : Eq<"globalize-symbols",
         "Reads a list of symbols from <filename> and marks them global.">,
      MetaVarName<"filename">;

defm keep_global_symbol
    : Eq<"keep-global-symbol",
         "Convert all symbols except <symbol> to local. May be repeated to "
         "convert all except a set of symbols to local.">,
      MetaVarName<"symbol">;
def G : JoinedOrSeparate<["-"], "G">, Alias<keep_global_symbol>;

defm keep_global_symbols
    : Eq<"keep-global-symbols",
         "Reads a list of symbols from <filename> and runs as if "
         "--keep-global-symbol=<symbol> is set for each one. <filename> "
         "contains one symbol per line and may contain comments beginning with "
         "'#'. Leading and trailing whitespace is stripped from each line. May "
         "be repeated to read symbols from many files.">,
      MetaVarName<"filename">;

defm weaken_symbol : Eq<"weaken-symbol", "Mark <symbol> as weak">,
                     MetaVarName<"symbol">;
defm weaken_symbols
    : Eq<"weaken-symbols",
         "Reads a list of symbols from <filename> and marks them weak.">,
      MetaVarName<"filename">;

def W : JoinedOrSeparate<["-"], "W">, Alias<weaken_symbol>;
def weaken : Flag<["-", "--"], "weaken">,
             HelpText<"Mark all global symbols as weak">;

def discard_locals : Flag<["-", "--"], "discard-locals">,
                     HelpText<"Remove compiler-generated local symbols, (e.g. "
                              "symbols starting with .L)">;
def X : Flag<["-"], "X">, Alias<discard_locals>;

def discard_all
    : Flag<["-", "--"], "discard-all">,
      HelpText<"Remove all local symbols except file and section symbols">;
def x : Flag<["-"], "x">, Alias<discard_all>;
defm strip_symbol : Eq<"strip-symbol", "Remove symbol <symbol>">,
                    MetaVarName<"symbol">;
defm strip_symbols
    : Eq<"strip-symbols",
         "Reads a list of symbols from <filename> and removes them.">,
      MetaVarName<"filename">;

def N : JoinedOrSeparate<["-"], "N">, Alias<strip_symbol>;
defm keep_symbol : Eq<"keep-symbol", "Do not remove symbol <symbol>">,
                   MetaVarName<"symbol">;
def K : JoinedOrSeparate<["-"], "K">, Alias<keep_symbol>;

def only_keep_debug
    : Flag<["-", "--"], "only-keep-debug">,
      HelpText<"Clear sections that would not be stripped by --strip-debug. "
               "Currently only implemented for COFF.">;

def keep_file_symbols : Flag<["-", "--"], "keep-file-symbols">,
                        HelpText<"Do not remove file symbols">;
defm dump_section
    : Eq<"dump-section",
         "Dump contents of section named <section> into file <file>">,
      MetaVarName<"section=file">;
defm prefix_symbols
    : Eq<"prefix-symbols", "Add <prefix> to the start of every symbol name">,
      MetaVarName<"prefix">;

def version : Flag<["-", "--"], "version">,
              HelpText<"Print the version and exit.">;
def V : Flag<["-"], "V">, Alias<version>;
defm build_id_link_dir
    : Eq<"build-id-link-dir", "Set directory for --build-id-link-input and "
                              "--build-id-link-output to <dir>">,
      MetaVarName<"dir">;
defm build_id_link_input
    : Eq<"build-id-link-input", "Hard-link the input to <dir>/xx/xxx<suffix> "
                                "name derived from hex build ID">,
      MetaVarName<"suffix">;
defm build_id_link_output
    : Eq<"build-id-link-output", "Hard-link the output to <dir>/xx/xxx<suffix> "
                                 "name derived from hex build ID">,
      MetaVarName<"suffix">;

def regex
    : Flag<["-", "--"], "regex">,
      HelpText<"Permit regular expressions in name comparison">;

defm set_start : Eq<"set-start", "Set the start address to <addr>. Overrides "
                    "any previous --change-start or --adjust-start values.">,
                 MetaVarName<"addr">;
defm change_start : Eq<"change-start", "Add <incr> to the start address. Can be "                        
                       "specified multiple times, all values will be applied "
                       "cumulatively.">,
                    MetaVarName<"incr">;
def adjust_start : JoinedOrSeparate<["-", "--"], "adjust-start">,
                   Alias<change_start>;

defm add_symbol
    : Eq<"add-symbol", "Add new symbol <name> to .symtab. Accepted flags: "
         "global, local, weak, default, hidden, file, section, object, "
         "function, indirect-function. Accepted but ignored for "
         "compatibility: debug, constructor, warning, indirect, synthetic, "
         "unique-object, before.">,
      MetaVarName<"name=[section:]value[,flags]">;
