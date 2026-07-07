
rotate_inline_const_count.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x1, w1
               	ror	x0, x0, x1
               	ret

<mix>:
               	ror	x1, x0, #0x1c
               	ror	x2, x0, #0x22
               	eor	x1, x1, x2
               	ror	x0, x0, #0x27
               	eor	x0, x1, x0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x89ab, lsl #16
               	movk	x0, #0x4567, lsl #32
               	movk	x0, #0x123, lsl #48
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	ror	x1, x0, #0x1c
               	ror	x2, x0, #0x22
               	eor	x1, x1, x2
               	ror	x0, x0, #0x27
               	eor	x0, x1, x0
               	mov	x17, #0xc1ab            // =49579
               	movk	x17, #0xc7e, lsl #16
               	movk	x17, #0x7a10, lsl #32
               	movk	x17, #0xb7c5, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
