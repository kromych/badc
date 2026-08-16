
loop_iv_spill_priority.aarch64:	file format elf64-littleaarch64

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

<hot>:
               	mov	x1, x0
               	mov	x0, #0x0                // =0
               	ldr	w2, [x1]
               	add	x2, x2, #0x1
               	mov	w6, w2
               	ldr	w2, [x1, #0x4]
               	add	x2, x2, #0x2
               	mov	w7, w2
               	ldr	w2, [x1, #0x8]
               	add	x2, x2, #0x3
               	mov	w8, w2
               	ldr	w2, [x1, #0xc]
               	add	x2, x2, #0x4
               	mov	w9, w2
               	ldr	w2, [x1, #0x10]
               	add	x2, x2, #0x5
               	mov	w10, w2
               	ldr	w2, [x1, #0x14]
               	add	x2, x2, #0x6
               	mov	w11, w2
               	ldr	w2, [x1, #0x18]
               	add	x2, x2, #0x7
               	mov	w12, w2
               	ldr	w2, [x1, #0x1c]
               	add	x2, x2, #0x8
               	mov	w13, w2
               	mov	x2, x0
               	b	<addr>
               	mov	w4, w2
               	mov	w2, w0
               	mov	x17, #0x7               // =7
               	and	x3, x2, x17
               	ldr	w3, [x1, x3, lsl #2]
               	add	x5, x2, #0x1
               	mov	w5, w5
               	mul	x3, x3, x5
               	mov	w3, w3
               	add	x3, x4, x3
               	mov	w3, w3
               	lsl	x4, x3, #1
               	mov	w4, w4
               	eor	x3, x3, x4
               	mov	w3, w3
               	add	x2, x3, x2
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w3, w0
               	cmp	x3, #0x3e8
               	b.lo	<addr>
               	mov	w0, w2
               	mov	w1, w6
               	eor	x0, x0, x1
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
               	mov	w0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
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
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
