
unary_minus_uint64_compare.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x19, [sp]
               	mov	x15, #0xa8              // =168
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x14, x15, x17
               	mov	x17, #0x1000            // =4096
               	cmp	x14, x17
               	b.hs	0x400280 <.text+0x60>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x15]
               	ldr	x10, [sp], #0x10
               	mov	x13, x15
               	sub	x13, x29, #0x10
               	ldr	x0, [x13]
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x13, x0, x17
               	mov	x17, #0x1000            // =4096
               	cmp	x13, x17
               	b.hs	0x4002e8 <.text+0xc8>
               	mov	x13, #0xc               // =12
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa8               // =168
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x13, x0, x17
               	mov	x17, #0x1000            // =4096
               	cmp	x13, x17
               	b.hs	0x400318 <.text+0xf8>
               	mov	x13, #0x1               // =1
               	stur	x13, [x29, #-0x38]
               	b	0x400324 <.text+0x104>
               	mov	x13, #0x2               // =2
               	stur	x13, [x29, #-0x38]
               	b	0x400324 <.text+0x104>
               	ldur	x13, [x29, #-0x38]
               	sxtw	x0, w13
               	cmp	x0, #0x2
               	b.eq	0x400348 <.text+0x128>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x8               // =8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x13, x17
               	mov	x17, #0x1000            // =4096
               	cmp	x0, x17
               	b.hs	0x400380 <.text+0x160>
               	mov	x0, #0xe                // =14
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
