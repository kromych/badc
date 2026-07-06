
inline_one_word_struct.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x8
               	str	x0, [x16]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<sum_sr>:
               	sxtw	x1, w1
               	mov	x3, #0x0                // =0
               	mov	x2, x3
               	b	<addr>
               	sxtw	x4, w3
               	ldr	x4, [x0, x4, lsl #3]
               	add	x2, x2, x4
               	sxtw	x3, w3
               	add	x3, x3, #0x1
               	sxtw	x4, w3
               	cmp	x4, x1
               	b.lt	<addr>
               	mov	x0, x2
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x0, x29, #0x28
               	sxtw	x2, w1
               	add	x3, x2, #0x1
               	sxtw	x3, w3
               	mov	x17, #0x64              // =100
               	mul	x3, x3, x17
               	str	x3, [x0, x2, lsl #3]
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x5
               	b.lt	<addr>
               	sub	x0, x29, #0x28
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x5dc
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
