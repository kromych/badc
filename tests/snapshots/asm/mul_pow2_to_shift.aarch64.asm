
mul_pow2_to_shift.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x0, #0x7                // =7
               	lsl	x1, x0, #1
               	sxtw	x1, w1
               	lsl	x2, x0, #2
               	sxtw	x2, w2
               	lsl	x3, x0, #3
               	sxtw	x3, w3
               	lsl	x4, x0, #4
               	sxtw	x4, w4
               	lsl	x5, x0, #10
               	sxtw	x5, w5
               	lsl	x6, x0, #1
               	mov	w6, w6
               	lsl	x7, x0, #8
               	mov	w7, w7
               	lsl	x8, x0, #5
               	lsl	x0, x0, #16
               	sxtw	x1, w1
               	sxtw	x2, w2
               	add	x1, x1, x2
               	sxtw	x1, w1
               	sxtw	x2, w3
               	add	x1, x1, x2
               	sxtw	x1, w1
               	sxtw	x2, w4
               	add	x1, x1, x2
               	sxtw	x1, w1
               	sxtw	x2, w5
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	w2, w6
               	add	x1, x1, x2
               	mov	w1, w1
               	mov	w2, w7
               	add	x1, x1, x2
               	mov	w1, w1
               	add	x1, x1, x8
               	add	x20, x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #0x24c0            // =9408
               	movk	x17, #0x7, lsl #16
               	cmp	x20, x17
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
