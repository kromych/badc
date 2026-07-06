
narrow_param_entry_extend.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtb	x0, w0
               	sxth	x1, w1
               	mov	x4, #0x0                // =0
               	stur	w4, [x29, #-0x8]
               	sxtw	x3, w4
               	cmp	x3, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x3, w4
               	add	x4, x3, #0x1
               	b	<addr>
               	ldursw	x3, [x29, #-0x8]
               	add	x3, x3, x4
               	stur	w3, [x29, #-0x8]
               	b	<addr>
               	ldursw	x3, [x29, #-0x8]
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	mul	x0, x0, x17
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	add	x0, x0, x2
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<uscale>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x3, #0x0                // =0
               	stur	w3, [x29, #-0x8]
               	sxtw	x2, w3
               	cmp	x2, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x2, w3
               	add	x3, x2, #0x1
               	b	<addr>
               	ldursw	x2, [x29, #-0x8]
               	add	x2, x2, x3
               	stur	w2, [x29, #-0x8]
               	b	<addr>
               	ldursw	x2, [x29, #-0x8]
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	mul	x0, x0, x17
               	mov	w0, w0
               	mov	x17, #0xffff            // =65535
               	and	x1, x1, x17
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
