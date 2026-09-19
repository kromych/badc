
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
               	mov	x2, #0x0                // =0
               	mov	x4, #0x3                // =3
               	mov	x5, #0x5556             // =21846
               	movk	x5, #0x5555, lsl #16
               	mov	x1, x2
               	cmp	w2, w0
               	b.ge	<addr>
               	mul	x3, x2, x5
               	lsr	x3, x3, #32
               	mul	x3, x3, x4
               	sub	x3, x2, x3
               	cbnz	w3, <addr>
               	add	x1, x1, x2
               	b	<addr>
               	cmp	w3, #0x1
               	b.ne	<addr>
               	sub	x1, x1, #0x1
               	b	<addr>
               	add	x1, x1, #0x2
               	add	x2, x2, #0x1
               	cmp	w2, w0
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret

<main>:
               	mov	x3, #0x3                // =3
               	mov	x4, #0x5556             // =21846
               	movk	x4, #0x5555, lsl #16
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	mul	x2, x1, x4
               	lsr	x2, x2, #32
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	cbnz	w2, <addr>
               	add	x0, x0, x1
               	b	<addr>
               	cmp	w2, #0x1
               	b.ne	<addr>
               	sub	x0, x0, #0x1
               	b	<addr>
               	add	x0, x0, #0x2
               	add	x1, x1, #0x1
               	cmp	w1, #0xa
               	b.lt	<addr>
               	sxtw	x0, w0
               	ret
