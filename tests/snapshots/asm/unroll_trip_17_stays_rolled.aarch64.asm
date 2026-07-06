
unroll_trip_17_stays_rolled.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	x0, #0x11
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, x1, lsl #3]
               	add	x3, x3, x0
               	add	x1, x1, #0x1
               	cmp	x1, #0x11
               	b.lt	<addr>
               	cmp	x3, #0x88
               	cset	x0, eq
               	mov	x3, #0x0                // =0
               	cbz	x0, <addr>
               	cmp	x1, #0x11
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x3, ne
               	cmp	x3, #0x0
               	cset	x0, eq
               	ret
               	b	<addr>
