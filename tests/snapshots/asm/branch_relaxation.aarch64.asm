
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
               	mov	x6, x0
               	mov	x0, #0x0                // =0
               	mov	x7, #0x3                // =3
               	mov	x8, #0x5556             // =21846
               	movk	x8, #0x5555, lsl #16
               	mov	x1, x0
               	cmp	w0, w6
               	b.ge	<addr>
               	mul	x3, x0, x8
               	lsr	x4, x3, #32
               	mul	x5, x4, x7
               	sub	x2, x0, x5
               	cbnz	w2, <addr>
               	add	x1, x1, x0
               	b	<addr>
               	cmp	w2, #0x1
               	b.ne	<addr>
               	sub	x1, x1, #0x1
               	b	<addr>
               	add	x1, x1, #0x2
               	add	x0, x0, #0x1
               	cmp	w0, w6
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret

<main>:
               	mov	x6, #0x3                // =3
               	mov	x7, #0x5556             // =21846
               	movk	x7, #0x5555, lsl #16
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, #0xa
               	b.ge	<addr>
               	mul	x3, x0, x7
               	lsr	x4, x3, #32
               	mul	x5, x4, x6
               	sub	x2, x0, x5
               	cbnz	w2, <addr>
               	add	x1, x1, x0
               	b	<addr>
               	cmp	w2, #0x1
               	b.ne	<addr>
               	sub	x1, x1, #0x1
               	b	<addr>
               	add	x1, x1, #0x2
               	add	x0, x0, #0x1
               	cmp	w0, #0xa
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret
