
builtin_bit_byte_const.aarch64:	file format elf64-littleaarch64

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

<classify>:
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
               	rev	w0, w0
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
               	rev	w0, w0
               	lsr	w0, w0, #16
               	mov	x17, #0x3412            // =13330
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
