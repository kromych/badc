
vla_basic_sum.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x4, x0
               	sxtw	x4, w4
               	lsl	x0, x4, #2
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x2, sp
               	sub	x2, x2, x17
               	mov	sp, x2
               	mov	x0, #0x0                // =0
               	b	<addr>
               	lsl	x3, x1, #1
               	str	w3, [x2, x1, lsl #2]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	ldrsw	x5, [x2, x3, lsl #2]
               	add	x1, x1, x5
               	add	x0, x3, #0x1
               	sxtw	x3, w0
               	cmp	x3, x4
               	b.lt	<addr>
               	sxtw	x0, w1
               	sxtw	x0, w0
               	sub	sp, x29, #0x40
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
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
