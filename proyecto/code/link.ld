ENTRY(_start)

/*Como la memoria está separada inician en 0 porque son memorias distintas*/
MEMORY
{
    /* Programa */
    INSTR_MEM (rx) : ORIGIN = 0x00000, LENGTH = 4K
    /* Imagen cargada */
    ROM (r) : ORIGIN = 0x80000, LENGTH = 1K
    /* Region para tablas de frecuencia acumulada */
    /* 10*256 bytes para armar la tabla del ecualizador*/
    DATA_TABLE (rw) : ORIGIN = ORIGIN(ROM) + LENGTH(ROM), LENGTH = 1K
    /* Imagen que se muestra por VGA */
    IMAGE_RES (rw) : ORIGIN = ORIGIN(DATA_TABLE) + LENGTH(DATA_TABLE), LENGTH = 1K
}

SECTIONS
{
  .text : 
  {
    *(.text .text.*);
  } > INSTR_MEM
}

PROVIDE(__image_r_start = ORIGIN(ROM));
PROVIDE(__image_r_end = ORIGIN(ROM) + LENGTH(ROM));
PROVIDE(__data_table_start = ORIGIN(DATA_TABLE));
PROVIDE(__data_table_end = ORIGIN(DATA_TABLE) + LENGTH(DATA_TABLE));
PROVIDE(__image_w_start = ORIGIN(IMAGE_RES));
PROVIDE(__image_w_end = ORIGIN(IMAGE_RES) + LENGTH(IMAGE_RES));
