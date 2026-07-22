
vla_size_from_arg.aarch64:	file format elf64-littleaarch64

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
               	mov	x3, x0
               	sxtw	x3, w3
               	add	x17, x3, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x4, sp
               	sub	x4, x4, x17
               	mov	sp, x4
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x5, x4, x1
               	add	x2, x1, #0x1
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x5]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, x3
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	add	x5, x4, x2
               	ldrb	w5, [x5]
               	add	x1, x1, x5
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, x3
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
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	cmp	x0, #0x37
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
