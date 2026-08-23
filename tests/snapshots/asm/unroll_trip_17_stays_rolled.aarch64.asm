
unroll_trip_17_stays_rolled.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, x1
               	b	<addr>
               	str	x0, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	x0, #0x11
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	ldr	x3, [x2, x0, lsl #3]
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	x0, #0x11
               	b.lt	<addr>
               	cmp	x1, #0x88
               	mov	x1, #0x0                // =0
               	b.ne	<addr>
               	cmp	x0, #0x11
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	ret
               	b	<addr>
