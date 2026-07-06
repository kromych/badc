
branch_relaxation.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x3, x0
               	sxtw	x3, w3
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	mov	x4, #0x3                // =3
               	sdiv	x17, x2, x4
               	msub	x4, x17, x4, x2
               	cmp	x4, #0x0
               	b.ne	<addr>
               	add	x0, x0, x1
               	b	<addr>
               	mov	x4, #0x3                // =3
               	sdiv	x17, x2, x4
               	msub	x4, x17, x4, x2
               	cmp	x4, #0x1
               	b.ne	<addr>
               	sub	x0, x0, #0x1
               	b	<addr>
               	add	x0, x0, #0x2
               	b	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, x3
               	b.lt	<addr>
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
