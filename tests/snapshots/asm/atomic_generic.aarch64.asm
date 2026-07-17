
atomic_generic.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x50
               	mov	x0, #0x7788             // =30600
               	movk	x0, #0x5566, lsl #16
               	movk	x0, #0x3344, lsl #32
               	movk	x0, #0x1122, lsl #48
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	sub	x1, x29, #0x10
               	str	x0, [x1]
               	ldur	x0, [x29, #-0x10]
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x18]
               	mov	x0, #0xcafe             // =51966
               	movk	x0, #0xbeef, lsl #16
               	movk	x0, #0xdead, lsl #32
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x20
               	ldr	x1, [x1]
               	str	x1, [x0]
               	ldur	x0, [x29, #-0x18]
               	mov	x17, #0xcafe            // =51966
               	movk	x17, #0xbeef, lsl #16
               	movk	x17, #0xdead, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	stur	w0, [x29, #-0x28]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x30]
               	sub	x0, x29, #0x28
               	ldrsw	x0, [x0]
               	sub	x1, x29, #0x30
               	str	w0, [x1]
               	ldursw	x0, [x29, #-0x30]
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x38]
               	mov	x0, #0xfff9             // =65529
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	w0, [x29, #-0x40]
               	sub	x0, x29, #0x38
               	sub	x1, x29, #0x40
               	ldrsw	x1, [x1]
               	str	w1, [x0]
               	ldursw	x0, [x29, #-0x38]
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1000             // =4096
               	stur	x0, [x29, #-0x48]
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x50]
               	sub	x0, x29, #0x48
               	ldr	x0, [x0]
               	sub	x1, x29, #0x50
               	str	x0, [x1]
               	ldur	x0, [x29, #-0x50]
               	mov	x17, #0x1000            // =4096
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
