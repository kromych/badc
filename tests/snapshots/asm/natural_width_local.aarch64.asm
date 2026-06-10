
natural_width_local.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0xc8               // =200
               	mov	x3, #0x0                // =0
               	mov	x2, x3
               	b	<addr>
               	sxtw	x4, w2
               	cmp	x4, #0x4
               	b.ge	<addr>
               	sxtw	x3, w3
               	sxtb	x4, w0
               	add	x3, x3, x4
               	sxtw	x3, w3
               	sxtw	x2, w2
               	add	x2, x2, #0x1
               	sxtw	x2, w2
               	b	<addr>
               	mov	x4, #0x0                // =0
               	sxtb	x2, w0
               	cmp	x2, #0x2c
               	b.eq	<addr>
               	add	x2, x4, #0x1
               	sxtw	x4, w2
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0x2c              // =44
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	sxtw	x0, w4
               	add	x0, x0, #0x2
               	sxtw	x4, w0
               	b	<addr>
               	sxtb	x0, w1
               	mov	x17, #0xffc8            // =65480
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	sxtw	x0, w4
               	add	x0, x0, #0x4
               	sxtw	x4, w0
               	b	<addr>
               	sxtw	x0, w3
               	cmp	x0, #0xb0
               	b.eq	<addr>
               	sxtw	x0, w4
               	add	x0, x0, #0x8
               	sxtw	x4, w0
               	b	<addr>
               	sxtw	x0, w4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
