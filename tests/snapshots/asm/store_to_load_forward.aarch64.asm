
store_to_load_forward.aarch64:	file format elf64-littleaarch64

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
               	sub	x0, x29, #0x10
               	mov	x1, #0x3e8              // =1000
               	mov	x2, #0x7                // =7
               	str	x1, [x0]
               	str	w2, [x0, #0x8]
               	mov	x3, #0x7                // =7
               	strh	w3, [x0, #0xc]
               	mov	x4, #0x7                // =7
               	strb	w4, [x0, #0xe]
               	mov	x5, #0x7                // =7
               	strb	w5, [x0, #0xf]
               	sxtw	x2, w2
               	sxth	x3, w3
               	sxtb	x4, w4
               	ldrb	w0, [x0, #0xf]
               	add	x1, x1, x2
               	add	x1, x1, x3
               	add	x1, x1, x4
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	add	x0, x1, x0
               	cmp	x0, #0x404
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	mov	x1, #0x15               // =21
               	str	x1, [x0]
               	add	x0, x1, x1
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x28
               	mov	x1, #0x9                // =9
               	str	x1, [x0]
               	str	x1, [x0]
               	add	x2, x1, x1
               	add	x2, x2, #0x0
               	add	x0, x2, x1
               	cmp	x0, #0x1b
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
