
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
               	mov	x9, x0
               	sxtw	x9, w9
               	mov	x1, #0x0                // =0
               	mov	x10, #0x3               // =3
               	mov	x11, #0x5556            // =21846
               	movk	x11, #0x5555, lsl #16
               	mov	x0, x1
               	b	<addr>
               	mul	x5, x2, x11
               	asr	x3, x5, #32
               	lsr	x6, x3, #63
               	add	x7, x3, x6
               	mul	x8, x7, x10
               	sub	x4, x2, x8
               	cbnz	x4, <addr>
               	add	x0, x0, x1
               	b	<addr>
               	cmp	x4, #0x1
               	b.ne	<addr>
               	sub	x0, x0, #0x1
               	b	<addr>
               	add	x0, x0, #0x2
               	b	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, x9
               	b.lt	<addr>
               	sxtw	x0, w0
               	ret

<main>:
               	mov	x9, #0x3                // =3
               	mov	x10, #0x5556            // =21846
               	movk	x10, #0x5555, lsl #16
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	mul	x5, x2, x10
               	asr	x3, x5, #32
               	lsr	x6, x3, #63
               	add	x7, x3, x6
               	mul	x8, x7, x9
               	sub	x4, x2, x8
               	cbnz	x4, <addr>
               	add	x0, x0, x1
               	b	<addr>
               	cmp	x4, #0x1
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
