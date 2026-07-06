
branch_relaxation.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	b	<addr>
               	mov	x4, #0x3                // =3
               	sdiv	x17, x3, x4
               	msub	x4, x17, x4, x3
               	cmp	x4, #0x0
               	b.ne	<addr>
               	add	x1, x1, x2
               	b	<addr>
               	mov	x4, #0x3                // =3
               	sdiv	x17, x3, x4
               	msub	x4, x17, x4, x3
               	cmp	x4, #0x1
               	b.ne	<addr>
               	sub	x1, x1, #0x1
               	b	<addr>
               	add	x1, x1, #0x2
               	b	<addr>
               	add	x2, x3, #0x1
               	sxtw	x3, w2
               	cmp	x3, x0
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
