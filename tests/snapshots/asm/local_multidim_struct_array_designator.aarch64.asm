
local_multidim_struct_array_designator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x18]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x1c]
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldrsw	x1, [x0]
               	cmp	w1, #0x9
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldrsw	x1, [x0, #0x8]
               	cbnz	x1, <addr>
               	ldrsw	x0, [x0, #0x14]
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
