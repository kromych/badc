
loop_iv_spill_priority.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x2, x0
               	mov	x4, x1
               	mov	x0, #0x0                // =0
               	ldr	w1, [x2]
               	add	x1, x1, #0x1
               	mov	w7, w1
               	ldr	w1, [x2, #0x4]
               	add	x1, x1, #0x2
               	mov	w8, w1
               	ldr	w1, [x2, #0x8]
               	add	x1, x1, #0x3
               	mov	w9, w1
               	ldr	w1, [x2, #0xc]
               	add	x1, x1, #0x4
               	mov	w10, w1
               	ldr	w1, [x2, #0x10]
               	add	x1, x1, #0x5
               	mov	w11, w1
               	ldr	w1, [x2, #0x14]
               	add	x1, x1, #0x6
               	mov	w12, w1
               	ldr	w1, [x2, #0x18]
               	add	x1, x1, #0x7
               	mov	w13, w1
               	ldr	w1, [x2, #0x1c]
               	add	x1, x1, #0x8
               	mov	w14, w1
               	mov	x1, x0
               	b	<addr>
               	mov	w5, w1
               	mov	w1, w0
               	mov	x17, #0x7               // =7
               	and	x3, x1, x17
               	ldr	w3, [x2, x3, lsl #2]
               	add	x6, x1, #0x1
               	mov	w6, w6
               	mul	x3, x3, x6
               	mov	w3, w3
               	add	x3, x5, x3
               	mov	w3, w3
               	lsl	x5, x3, #1
               	mov	w5, w5
               	eor	x3, x3, x5
               	mov	w3, w3
               	add	x1, x3, x1
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w3, w0
               	mov	w5, w4
               	cmp	x3, x5
               	b.lo	<addr>
               	mov	w0, w1
               	mov	w1, w7
               	eor	x0, x0, x1
               	mov	w1, w8
               	eor	x0, x0, x1
               	mov	w1, w9
               	eor	x0, x0, x1
               	mov	w1, w10
               	eor	x0, x0, x1
               	mov	w1, w11
               	eor	x0, x0, x1
               	mov	w1, w12
               	eor	x0, x0, x1
               	mov	w1, w13
               	eor	x0, x0, x1
               	mov	w1, w14
               	eor	x0, x0, x1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	mov	x1, #0x3e8              // =1000
               	bl	<addr>
               	mov	w0, w0
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	sxtw	x0, w0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
