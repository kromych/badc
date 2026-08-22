
data_pack_object_align.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<sum>:
               	adrp	x0, <addr>
		R_AARCH64_ADR_PREL_PG_HI21	.data+0x1000
               	add	x0, x0, #0x0
		R_AARCH64_ADD_ABS_LO12_NC	.data+0x1000
               	ldr	x0, [x0]
               	adrp	x1, <addr>
		R_AARCH64_ADR_PREL_PG_HI21	.data+0x2000
               	add	x1, x1, #0x0
		R_AARCH64_ADD_ABS_LO12_NC	.data+0x2000
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	adrp	x1, <addr>
		R_AARCH64_ADR_PREL_PG_HI21	.data+0x2040
               	add	x1, x1, #0x0
		R_AARCH64_ADD_ABS_LO12_NC	.data+0x2040
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	adrp	x1, <addr>
		R_AARCH64_ADR_PREL_PG_HI21	.bss
               	add	x1, x1, #0x0
		R_AARCH64_ADD_ABS_LO12_NC	.bss
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	ret

<cache_addr>:
               	adrp	x0, <addr>
		R_AARCH64_ADR_PREL_PG_HI21	.data+0x2000
               	add	x0, x0, #0x0
		R_AARCH64_ADD_ABS_LO12_NC	.data+0x2000
               	ret
