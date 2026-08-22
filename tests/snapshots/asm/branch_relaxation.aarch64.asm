
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
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	sxtw	x2, w1
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x5, x2, x17
               	asr	x3, x5, #32
               	lsr	x6, x3, #63
               	add	x7, x3, x6
               	mov	x17, #0x3               // =3
               	mul	x8, x7, x17
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
               	cmp	w1, w9
               	b.lt	<addr>
               	sxtw	x0, w0
               	ret

<main>:
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	sxtw	x2, w1
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x5, x2, x17
               	asr	x3, x5, #32
               	lsr	x6, x3, #63
               	add	x7, x3, x6
               	mov	x17, #0x3               // =3
               	mul	x8, x7, x17
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
               	cmp	w1, #0xa
               	b.lt	<addr>
               	sxtw	x0, w0
               	ret
