
builtin_bit_byte_const.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0xff00            // =65280
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x17, #0xff00            // =65280
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x2                // =2
               	ret
               	mov	x17, #0x3412            // =13330
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x1                // =1
               	mov	x0, #0x2                // =2
               	mov	x0, #0x0                // =0
               	mov	x0, #0x5678             // =22136
               	movk	x0, #0x1234, lsl #16
               	stur	w0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsl	x1, x1, #24
               	lsr	x2, x0, #8
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #16
               	orr	x1, x1, x2
               	lsr	x2, x0, #16
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #8
               	orr	x1, x1, x2
               	lsr	x0, x0, #24
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	orr	x0, x1, x0
               	mov	x17, #0x3412            // =13330
               	movk	x17, #0x7856, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1234             // =4660
               	sturh	w0, [x29, #-0x10]
               	ldurh	w0, [x29, #-0x10]
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsl	x1, x1, #8
               	lsr	x0, x0, #8
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	orr	x0, x1, x0
               	mov	x17, #0x3412            // =13330
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
