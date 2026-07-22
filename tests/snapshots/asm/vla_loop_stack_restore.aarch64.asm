
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
               	mov	x6, x0
               	mov	x2, x0
               	b	<addr>
               	mov	x7, sp
               	ldursw	x1, [x29, #-0x8]
               	lsl	x4, x1, #18
               	add	x17, x4, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x1, sp
               	sub	x1, x1, x17
               	mov	sp, x1
               	mov	x17, #0xff              // =255
               	and	x5, x0, x17
               	strb	w5, [x1]
               	sub	x5, x4, #0x1
               	add	x8, x1, x5
               	add	x5, x0, #0x1
               	mov	x17, #0xff              // =255
               	and	x5, x5, x17
               	strb	w5, [x8]
               	cmp	x3, #0x0
               	b.ne	<addr>
               	mov	x2, x1
               	ldrb	w5, [x1]
               	sub	x4, x4, #0x1
               	add	x1, x1, x4
               	ldrb	w1, [x1]
               	add	x1, x5, x1
               	sxtw	x1, w1
               	add	x6, x6, x1
               	mov	sp, x7
               	b	<addr>
               	cmp	x1, x2
               	b.ne	<addr>
               	b	<addr>
               	add	x0, x3, #0x1
               	sxtw	x3, w0
               	cmp	x3, #0x40
               	b.lt	<addr>
               	mov	x17, #0x1000            // =4096
               	cmp	x6, x17
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	sxtw	x0, w0
               	sub	sp, x29, #0x60
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x60
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp], #0x70
               	ret
