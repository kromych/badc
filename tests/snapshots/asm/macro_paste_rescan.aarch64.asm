
macro_paste_rescan.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	b	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	b	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	b	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	b	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	b	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	mov	x0, #0x0                // =0
               	ret
