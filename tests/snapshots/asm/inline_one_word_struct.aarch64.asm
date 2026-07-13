
inline_one_word_struct.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
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
               	mov	x3, x0
               	mov	x4, x1
               	sxtw	x4, w4
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	ldr	x5, [x3, x1, lsl #3]
               	add	x2, x2, x5
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, x4
               	b.lt	<addr>
               	mov	x0, x2
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x28
               	add	x0, x0, #0x0
               	mov	x1, #0x64               // =100
               	str	x1, [x0]
               	sub	x0, x29, #0x28
               	mov	x1, #0xc8               // =200
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x28
               	mov	x1, #0x12c              // =300
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0x28
               	mov	x1, #0x190              // =400
               	str	x1, [x0, #0x18]
               	sub	x0, x29, #0x28
               	mov	x1, #0x1f4              // =500
               	str	x1, [x0, #0x20]
               	sub	x0, x29, #0x28
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x5dc
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
