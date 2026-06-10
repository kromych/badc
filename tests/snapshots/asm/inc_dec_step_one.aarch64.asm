
inc_dec_step_one.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<minus_one>:
               	sxtw	x0, w0
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<plus_one_l>:
               	add	x0, x0, #0x1
               	ret

<minus_neg_one>:
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	sub	x0, x0, x17
               	ret

<count_up>:
               	sxtw	x0, w0
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	b	<addr>
               	sxtw	x3, w2
               	cmp	x3, x0
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x2, w2
               	add	x2, x2, #0x1
               	b	<addr>
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	sxtw	x1, w1
               	b	<addr>
               	sxtw	x0, w1
               	ret

<wrap>:
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	add	x0, x0, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x29               // =41
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2b               // =43
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xe3ff             // =58367
               	movk	x0, #0x540b, lsl #16
               	movk	x0, #0x2, lsl #32
               	add	x0, x0, #0x1
               	mov	x17, #0xe400            // =58368
               	movk	x17, #0x540b, lsl #16
               	movk	x17, #0x2, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x29               // =41
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	sub	x0, x0, x17
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	add	x0, x0, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x29               // =41
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	add	x0, x0, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
