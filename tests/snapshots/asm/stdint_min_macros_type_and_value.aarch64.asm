
stdint_min_macros_type_and_value.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x2, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cbnz	x2, <addr>
               	mov	x2, #0x0                // =0
               	cbz	x2, <addr>
               	mov	x0, #0x1e               // =30
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	mov	x0, #0x16               // =22
               	ret
               	mov	x0, #0xa                // =10
               	ret
               	mov	x0, #0xb                // =11
               	ret
