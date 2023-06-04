ENTRY(_start)

/*Como la memoria está separada inician en 0 porque son memorias distintas*/
MEMORY
{
    /* Programa */
    INSTR_MEM (rx) : ORIGIN = 0x00000, LENGTH = 64K
    /* Imagen cargada */
    IMAGE_ROM (r) : ORIGIN = 0x10000, LENGTH = 64K
    /* Region para tablas de frecuencia acumulada */
    /* 10*256 bytes para armar la tabla del ecualizador*/
    DATA_TABLE (rw) : ORIGIN = 0x20000, LENGTH = 64K
    /* Imagen que se muestra por VGA */
    IMAGE_VGA (w) : ORIGIN = 0x30000, LENGTH = 64K
    CTRL_REGS (r) : ORIGIN = 0x40000, LENGTH = 64K
}

SECTIONS
{
  .text : 
  {
    *(.text .text.*);
  } > INSTR_MEM
}

PROVIDE(__image_r_start = ORIGIN(IMAGE_ROM));
PROVIDE(__image_r_end = ORIGIN(IMAGE_ROM) + LENGTH(IMAGE_ROM));
PROVIDE(__data_table_start = ORIGIN(DATA_TABLE));
PROVIDE(__data_table_end = ORIGIN(DATA_TABLE) + LENGTH(DATA_TABLE));
PROVIDE(__image_w_start = ORIGIN(IMAGE_VGA));
PROVIDE(__image_w_end = ORIGIN(IMAGE_VGA) + LENGTH(IMAGE_VGA));
PROVIDE(__ctrl_val_1 = ORIGIN(CTRL_REGS) + 0);
PROVIDE(__ctrl_val_2 = ORIGIN(CTRL_REGS) + 4);
PROVIDE(__ctrl_val_3 = ORIGIN(CTRL_REGS) + 5);
