
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
               	str	x19, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	mov	x6, #0xff               // =255
               	mov	x5, x0
               	mov	x2, x0
               	b	<addr>
               	mov	x9, sp
               	ldursw	x1, [x29, #-0x10]
               	lsl	x3, x1, #18
               	add	x17, x3, #0xf
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
               	and	x4, x0, x6
               	strb	w4, [x1]
               	sub	x7, x3, #0x1
               	add	x8, x1, x7
               	add	x4, x0, #0x1
               	and	x4, x4, x6
               	strb	w4, [x8]
               	cbnz	x0, <addr>
               	mov	x2, x1
               	ldrb	w4, [x1]
               	ldrb	w1, [x8]
               	add	x1, x4, x1
               	sxtw	x1, w1
               	add	x5, x5, x1
               	mov	sp, x9
               	b	<addr>
               	cmp	x1, x2
               	b.ne	<addr>
               	b	<addr>
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	x0, #0x40
               	b.lt	<addr>
               	mov	x17, #0x1000            // =4096
               	cmp	x5, x17
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	sxtw	x0, w0
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	ret
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	ret
