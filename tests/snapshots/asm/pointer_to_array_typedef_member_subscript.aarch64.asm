
pointer_to_array_typedef_member_subscript.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x10
               	mov	x1, #0x3                // =3
               	str	w1, [x0]
               	sub	x1, x29, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x0, [x1, #0x8]
               	sub	x1, x29, #0x18
               	ldr	w2, [x1]
               	mov	x17, #0x3f              // =63
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	mov	x17, #0x40              // =64
               	orr	x2, x2, x17
               	str	w2, [x1]
               	sub	x1, x29, #0x18
               	ldr	w2, [x1]
               	mov	x17, #0xffc0            // =65472
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	mov	x17, #0x1               // =1
               	orr	x2, x2, x17
               	str	w2, [x1]
               	ldr	w1, [x0, #0x808]
               	mov	x17, #0x3f              // =63
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x240             // =576
               	orr	x1, x1, x17
               	str	w1, [x0, #0x808]
               	ldr	w1, [x0, #0x80c]
               	mov	x17, #0x3f              // =63
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	mov	x17, #0x140             // =320
               	orr	x1, x1, x17
               	str	w1, [x0, #0x80c]
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x18
               	ldr	x0, [x0, #0x8]
               	ldr	w1, [x1]
               	asr	x1, x1, #6
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x3ff, lsl #16
               	and	x1, x1, x17
               	lsl	x1, x1, #11
               	add	x0, x0, x1
               	ldr	w0, [x0, #0x8]
               	asr	x0, x0, #6
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x3ff, lsl #16
               	and	x0, x0, x17
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x0, [x0, #0x8]
               	ldr	w0, [x0, #0x80c]
               	asr	x0, x0, #6
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x3ff, lsl #16
               	and	x0, x0, x17
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
