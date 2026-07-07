
volatile_unused_read.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	mov	x1, #0x7                // =7
               	stur	w1, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	ldrsw	x0, [x0]
               	cmp	x0, #0x5
               	cset	x0, eq
               	cbz	x0, <addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x7
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
               	b	<addr>
