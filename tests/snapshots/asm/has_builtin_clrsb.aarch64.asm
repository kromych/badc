
has_builtin_clrsb.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	mov	x0, #0xff               // =255
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0xfc00             // =64512
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	x0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x8]
               	asr	x1, x0, #31
               	eor	x0, x0, x1
               	lsr	x1, x0, #1
               	orr	x0, x0, x1
               	lsr	x1, x0, #2
               	orr	x0, x0, x1
               	lsr	x1, x0, #4
               	orr	x0, x0, x1
               	lsr	x1, x0, #8
               	orr	x0, x0, x1
               	lsr	x1, x0, #16
               	orr	x0, x0, x1
               	mov	w0, w0
               	lsr	x1, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	and	x1, x1, x17
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x20               // =32
               	sub	x0, x1, x0
               	sub	x0, x0, #0x1
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	asr	x1, x0, #63
               	eor	x0, x0, x1
               	lsr	x1, x0, #1
               	orr	x0, x0, x1
               	lsr	x1, x0, #2
               	orr	x0, x0, x1
               	lsr	x1, x0, #4
               	orr	x0, x0, x1
               	lsr	x1, x0, #8
               	orr	x0, x0, x1
               	lsr	x1, x0, #16
               	orr	x0, x0, x1
               	lsr	x1, x0, #32
               	orr	x0, x0, x1
               	lsr	x1, x0, #1
               	mov	x17, #0x5555            // =21845
               	movk	x17, #0x5555, lsl #16
               	movk	x17, #0x5555, lsl #32
               	movk	x17, #0x5555, lsl #48
               	and	x1, x1, x17
               	sub	x0, x0, x1
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x1, x0, x17
               	lsr	x0, x0, #2
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3333, lsl #48
               	and	x0, x0, x17
               	add	x0, x1, x0
               	lsr	x1, x0, #4
               	add	x0, x0, x1
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	movk	x17, #0xf0f, lsl #32
               	movk	x17, #0xf0f, lsl #48
               	and	x0, x0, x17
               	lsr	x1, x0, #8
               	add	x0, x0, x1
               	lsr	x1, x0, #16
               	add	x0, x0, x1
               	lsr	x1, x0, #32
               	add	x0, x0, x1
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	mov	x1, #0x40               // =64
               	sub	x0, x1, x0
               	sub	x0, x0, #0x1
               	cmp	x0, #0x35
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
