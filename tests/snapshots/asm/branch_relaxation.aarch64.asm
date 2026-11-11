
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
               	mov	x0, #0x0                // =0
               	mov	x4, #0x5556             // =21846
               	movk	x4, #0x5555, lsl #16
               	mov	x1, x0
               	cmp	w0, w3
               	b.ge	<addr>
               	mul	x2, x0, x4
               	lsr	x2, x2, #32
               	add	x2, x2, x2, lsl #1
               	sub	x2, x0, x2
               	cbnz	w2, <addr>
               	add	x1, x1, x0
               	b	<addr>
               	sub	x5, x1, #0x1
               	add	x1, x1, #0x2
               	cmp	w2, #0x1
               	csel	x1, x5, x1, eq
               	add	x0, x0, #0x1
               	cmp	w0, w3
               	b.lt	<addr>
               	mov	x0, x1
               	ret

<main>:
               	mov	x3, #0x5556             // =21846
               	movk	x3, #0x5555, lsl #16
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mul	x2, x0, x3
               	lsr	x2, x2, #32
               	add	x2, x2, x2, lsl #1
               	sub	x2, x0, x2
               	cbnz	w2, <addr>
               	add	x1, x1, x0
               	b	<addr>
               	sub	x4, x1, #0x1
               	add	x1, x1, #0x2
               	cmp	w2, #0x1
               	csel	x1, x4, x1, eq
               	add	x0, x0, #0x1
               	cmp	w0, #0xa
               	b.lt	<addr>
               	mov	x0, x1
               	ret
