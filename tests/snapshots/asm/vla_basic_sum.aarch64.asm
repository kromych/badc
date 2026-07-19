
vla_basic_sum.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x0, [sp, #-0x10]!
               	str	x19, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	stur	w0, [x29, #0x10]
               	ldursw	x0, [x29, #0x10]
               	lsl	x0, x0, #2
               	stur	x0, [x29, #-0x10]
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	mov	sp, x0
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	ldur	x2, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x18]
               	lsl	x1, x0, #1
               	str	w1, [x2, x0, lsl #2]
               	ldursw	x0, [x29, #-0x18]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x18]
               	ldursw	x0, [x29, #-0x18]
               	ldursw	x1, [x29, #0x10]
               	cmp	x0, x1
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x20]
               	stur	w0, [x29, #-0x28]
               	b	<addr>
               	ldursw	x2, [x29, #-0x20]
               	ldur	x0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x28]
               	ldrsw	x0, [x0, x1, lsl #2]
               	add	x0, x2, x0
               	stur	w0, [x29, #-0x20]
               	ldursw	x0, [x29, #-0x28]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x28]
               	ldursw	x0, [x29, #-0x28]
               	ldursw	x1, [x29, #0x10]
               	cmp	x0, x1
               	b.lt	<addr>
               	ldursw	x0, [x29, #-0x20]
               	sub	sp, x29, #0x40
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
