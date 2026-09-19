
designator_multidim_scalar_array.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x3, x2, #0x20
               	lsl	x4, x0, #3
               	add	x1, x3, x4
               	ldrsw	x5, [x1]
               	cmp	w5, #0x9
               	b.ne	<addr>
               	ldrsw	x1, [x1, #0x4]
               	cmp	w1, #0xa
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	lsl	x3, x0, #3
               	add	x1, x2, x3
               	ldrsw	x4, [x1]
               	cbnz	w4, <addr>
               	ldrsw	x1, [x1, #0x4]
               	cbnz	w1, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x7                // =7
               	ret
