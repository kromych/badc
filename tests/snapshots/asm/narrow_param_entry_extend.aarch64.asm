
narrow_param_entry_extend.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	mov	x3, x0
               	mov	x5, x2
               	mov	x4, x1
               	sxtb	x3, w3
               	sxth	x4, w4
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	ldursw	x1, [x29, #-0x8]
               	add	x1, x1, x0
               	stur	w1, [x29, #-0x8]
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x3
               	b.lt	<addr>
               	ldursw	x0, [x29, #-0x8]
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	mul	x0, x3, x17
               	mov	x17, #0xa               // =10
               	mul	x1, x4, x17
               	add	x0, x0, x1
               	add	x0, x0, x5
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<uscale>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x3, x0
               	mov	x4, x1
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	ldursw	x1, [x29, #-0x8]
               	add	x1, x1, x0
               	stur	w1, [x29, #-0x8]
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x3
               	b.lt	<addr>
               	ldursw	x0, [x29, #-0x8]
               	mov	x17, #0xff              // =255
               	and	x0, x3, x17
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	mul	x0, x0, x17
               	mov	w0, w0
               	mov	x17, #0xffff            // =65535
               	and	x1, x4, x17
               	add	x0, x0, x1
               	mov	w0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x20, [x0]
               	mov	x0, x20
               	mov	x2, x20
               	mov	x1, x20
               	bl	<addr>
               	mov	x17, #0xcd17            // =52503
               	movk	x17, #0x6b, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, x20
               	mov	x1, x20
               	bl	<addr>
               	mov	x17, #0x6c65            // =27749
               	movk	x17, #0x69, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
