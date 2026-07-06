
unroll_volatile_stays_rolled.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, #0x0                // =0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	add	x2, x2, #0x1
               	str	x2, [x0]
               	add	x1, x1, #0x1
               	cmp	x1, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x4
               	cset	x0, eq
               	mov	x3, #0x0                // =0
               	cbz	x0, <addr>
               	cmp	x1, #0x4
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x3, ne
               	cmp	x3, #0x0
               	cset	x0, eq
               	ret
               	b	<addr>
