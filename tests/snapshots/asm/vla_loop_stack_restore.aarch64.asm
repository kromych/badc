
vla_loop_stack_restore.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x10]
               	stur	x0, [x29, #-0x18]
               	stur	w0, [x29, #-0x20]
               	b	<addr>
               	mov	x0, sp
               	stur	x0, [x29, #-0x40]
               	ldursw	x0, [x29, #-0x8]
               	lsl	x0, x0, #18
               	stur	x0, [x29, #-0x28]
               	ldur	x0, [x29, #-0x28]
               	stur	x0, [x29, #-0x38]
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	mov	sp, x0
               	stur	x0, [x29, #-0x30]
               	ldur	x0, [x29, #-0x30]
               	ldursw	x1, [x29, #-0x20]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0]
               	ldur	x0, [x29, #-0x30]
               	ldur	x1, [x29, #-0x28]
               	sub	x1, x1, #0x1
               	add	x1, x0, x1
               	ldursw	x0, [x29, #-0x20]
               	add	x0, x0, #0x1
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	strb	w0, [x1]
               	ldursw	x0, [x29, #-0x20]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x30]
               	stur	x0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x18]
               	ldur	x0, [x29, #-0x30]
               	ldrb	w2, [x0]
               	ldur	x3, [x29, #-0x28]
               	sub	x3, x3, #0x1
               	add	x0, x0, x3
               	ldrb	w0, [x0]
               	add	x0, x2, x0
               	sxtw	x0, w0
               	add	x0, x1, x0
               	stur	x0, [x29, #-0x18]
               	ldur	x0, [x29, #-0x40]
               	mov	sp, x0
               	b	<addr>
               	ldur	x0, [x29, #-0x30]
               	ldur	x1, [x29, #-0x10]
               	cmp	x0, x1
               	b.eq	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x20]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x20]
               	ldursw	x0, [x29, #-0x20]
               	cmp	x0, #0x40
               	b.lt	<addr>
               	ldur	x0, [x29, #-0x18]
               	mov	x17, #0x1000            // =4096
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	stur	x0, [x29, #-0x50]
               	ldur	x0, [x29, #-0x50]
               	sxtw	x0, w0
               	sub	sp, x29, #0x60
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	mov	x0, #0x2                // =2
               	stur	x0, [x29, #-0x50]
               	b	<addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x60
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	b	<addr>
