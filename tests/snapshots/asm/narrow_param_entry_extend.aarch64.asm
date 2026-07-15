
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
               	sub	sp, sp, #0x40
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	sxtw	x0, w3
               	sxtb	x4, w0
               	sxth	x5, w0
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x28]
               	b	<addr>
               	ldursw	x1, [x29, #-0x28]
               	add	x1, x1, x0
               	stur	w1, [x29, #-0x28]
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x3
               	b.lt	<addr>
               	ldursw	x0, [x29, #-0x28]
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	mul	x0, x4, x17
               	mov	x17, #0xa               // =10
               	mul	x1, x5, x17
               	add	x0, x0, x1
               	add	x0, x0, x3
               	sxtw	x1, w0
               	sxtw	x0, w1
               	mov	x17, #0xcd17            // =52503
               	movk	x17, #0x6b, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x38]
               	b	<addr>
               	ldursw	x1, [x29, #-0x38]
               	add	x1, x1, x0
               	stur	w1, [x29, #-0x38]
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x3
               	b.lt	<addr>
               	ldursw	x0, [x29, #-0x38]
               	mov	x17, #0xff              // =255
               	and	x0, x3, x17
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	mul	x0, x0, x17
               	mov	w0, w0
               	mov	x17, #0xffff            // =65535
               	and	x1, x3, x17
               	add	x0, x0, x1
               	mov	w0, w0
               	mov	x17, #0x6c65            // =27749
               	movk	x17, #0x69, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
