
deferred_array_typedef.aarch64:	file format elf64-littleaarch64

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
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	mov	x1, x0
               	b	<addr>
               	sxtw	x2, w0
               	lsl	x3, x2, #4
               	add	x3, x4, x3
               	ldrsw	x3, [x3, #0xc]
               	add	x1, x1, x3
               	add	x0, x2, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sxtw	x0, w1
               	cmp	w0, #0x18
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x0                // =0
               	ret
