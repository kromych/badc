
vla_loop_stack_restore.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	mov	x6, x0
               	mov	x4, x0
               	cmp	w0, #0x40
               	b.ge	<addr>
               	mov	x7, sp
               	ldursw	x1, [x29, #-0x10]
               	lsl	x5, x1, #18
               	add	x17, x5, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x1, sp
               	sub	x1, x1, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x1
               	and	x2, x0, #0xff
               	strb	w2, [x1]
               	sub	x2, x5, #0x1
               	add	x3, x0, #0x1
               	and	x8, x3, #0xff
               	strb	w8, [x1, x2]
               	cmp	w0, #0x0
               	b.ne	<addr>
               	mov	x4, x1
               	b	<addr>
               	cmp	x1, x4
               	b.ne	<addr>
               	ldrb	w8, [x1]
               	ldrb	w1, [x1, x2]
               	add	x1, x8, x1
               	sxtw	x1, w1
               	add	x6, x6, x1
               	mov	sp, x7
               	mov	x0, x3
               	cmp	w0, #0x40
               	b.lt	<addr>
               	mov	x17, #0x1000            // =4096
               	cmp	x6, x17
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	sxtw	x0, w0
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
