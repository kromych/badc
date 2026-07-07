
unroll_trip_17_stays_rolled.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x0, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	x0, #0x11
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2, x0, lsl #3]
               	add	x1, x1, x2
               	add	x0, x0, #0x1
               	cmp	x0, #0x11
               	b.lt	<addr>
               	cmp	x1, #0x88
               	cset	x2, eq
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	cmp	x0, #0x11
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x0, eq
               	ret
               	b	<addr>
