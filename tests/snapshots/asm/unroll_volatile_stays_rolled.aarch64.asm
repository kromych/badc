
unroll_volatile_stays_rolled.aarch64:	file format elf64-littleaarch64

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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	ldr	x2, [x1]
               	add	x2, x2, #0x1
               	str	x2, [x1]
               	add	x0, x0, #0x1
               	cmp	x0, #0x4
               	b.lt	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, #0x4
               	mov	x1, #0x0                // =0
               	b.ne	<addr>
               	cmp	w0, #0x4
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	ret
               	b	<addr>
