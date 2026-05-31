
unary_minus_uint64_compare.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
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
               	mul	x15, x15, x17
               	mov	x17, #0x1000            // =4096
               	cmp	x15, x17
               	b.hs	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x15]
               	ldr	x10, [sp], #0x10
               	sub	x15, x29, #0x10
               	ldr	x15, [x15]
               	sxtw	x15, w15
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x15, x15, x17
               	mov	x17, #0x1000            // =4096
               	cmp	x15, x17
               	b.hs	<addr>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0xa8              // =168
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x15, x15, x17
               	mov	x17, #0x1000            // =4096
               	cmp	x15, x17
               	b.hs	<addr>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x38]
               	b	<addr>
               	mov	x0, #0x2                // =2
               	stur	x0, [x29, #-0x38]
               	b	<addr>
               	ldur	x0, [x29, #-0x38]
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x15, #0xd               // =13
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x0, x17
               	mov	x17, #0x1000            // =4096
               	cmp	x0, x17
               	b.hs	<addr>
               	mov	x15, #0xe               // =14
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
