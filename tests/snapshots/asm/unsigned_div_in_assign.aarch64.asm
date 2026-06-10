
unsigned_div_in_assign.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	ldr	x1, [x0]
               	mov	x2, #0x18               // =24
               	udiv	x2, x1, x2
               	mov	x0, #0x7                // =7
               	udiv	x17, x1, x0
               	msub	x0, x17, x0, x1
               	sxtw	x1, w2
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	sxtw	x1, w1
               	sxtw	x0, w0
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, #0xd0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x8
               	bl	<addr>
               	cmp	x0, #0x3ea
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
