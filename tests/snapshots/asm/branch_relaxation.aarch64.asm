
branch_relaxation.aarch64:	file format elf64-littleaarch64

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

<classify>:
               	mov	x4, x0
               	sxtw	x4, w4
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	mov	x3, #0x3                // =3
               	sdiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	cbnz	x3, <addr>
               	add	x0, x0, x1
               	b	<addr>
               	mov	x3, #0x3                // =3
               	sdiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	cmp	x3, #0x1
               	b.ne	<addr>
               	sub	x0, x0, #0x1
               	b	<addr>
               	add	x0, x0, #0x2
               	b	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, x4
               	b.lt	<addr>
               	sxtw	x0, w0
               	ret

<main>:
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	mov	x3, #0x3                // =3
               	sdiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	cbnz	x3, <addr>
               	add	x0, x0, x1
               	b	<addr>
               	mov	x3, #0x3                // =3
               	sdiv	x17, x2, x3
               	msub	x3, x17, x3, x2
               	cmp	x3, #0x1
               	b.ne	<addr>
               	sub	x0, x0, #0x1
               	b	<addr>
               	add	x0, x0, #0x2
               	b	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0xa
               	b.lt	<addr>
               	sxtw	x0, w0
               	ret
