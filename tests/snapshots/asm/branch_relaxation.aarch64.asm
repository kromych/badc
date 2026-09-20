
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
               	mov	x3, x0
               	mov	x1, #0x0                // =0
               	mov	x4, #0x3                // =3
               	mov	x5, #0x5556             // =21846
               	movk	x5, #0x5555, lsl #16
               	mov	x0, x1
               	cmp	w1, w3
               	b.ge	<addr>
               	mul	x2, x1, x5
               	lsr	x2, x2, #32
               	mul	x2, x2, x4
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
               	cmp	w1, w3
               	b.lt	<addr>
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
               	ret
