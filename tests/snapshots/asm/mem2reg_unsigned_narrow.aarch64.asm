
mem2reg_unsigned_narrow.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0x12c              // =300
               	mov	x1, #0x2345             // =9029
               	movk	x1, #0x1, lsl #16
               	mov	x3, #0x0                // =0
               	mov	x2, x3
               	mov	x4, x3
               	b	<addr>
               	sxtw	x5, w4
               	cmp	x5, #0x3
               	b.ge	<addr>
               	sxtw	x2, w2
               	mov	x17, #0xff              // =255
               	and	x5, x0, x17
               	add	x2, x2, x5
               	sxtw	x2, w2
               	sxtw	x3, w3
               	mov	x17, #0xffff            // =65535
               	and	x5, x1, x17
               	add	x3, x3, x5
               	sxtw	x3, w3
               	sxtw	x4, w4
               	add	x4, x4, #0x1
               	sxtw	x4, w4
               	b	<addr>
               	mov	x5, #0x0                // =0
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0x2c              // =44
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	add	x0, x5, #0x1
               	sxtw	x5, w0
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	and	x0, x1, x17
               	mov	x17, #0x2345            // =9029
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	sxtw	x0, w5
               	add	x0, x0, #0x2
               	sxtw	x5, w0
               	b	<addr>
               	sxtw	x0, w2
               	cmp	x0, #0x84
               	b.eq	<addr>
               	sxtw	x0, w5
               	add	x0, x0, #0x4
               	sxtw	x5, w0
               	b	<addr>
               	sxtw	x0, w3
               	mov	x17, #0x69cf            // =27087
               	cmp	x0, x17
               	b.eq	<addr>
               	sxtw	x0, w5
               	add	x0, x0, #0x8
               	sxtw	x5, w0
               	b	<addr>
               	sxtw	x0, w5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
