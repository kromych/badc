
shift_result_type_signedness.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x1, w1
               	mov	w0, w0
               	lsl	x0, x0, x1
               	mov	w0, w0
               	sxtw	x0, w0
               	asr	x0, x0, x1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0xfb               // =251
               	mov	x1, #0x18               // =24
               	sxtw	x1, w1
               	mov	w0, w0
               	lsl	x0, x0, x1
               	mov	w0, w0
               	sxtw	x0, w0
               	asr	x0, x0, x1
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xff               // =255
               	mov	x1, #0x18               // =24
               	sxtw	x1, w1
               	mov	w0, w0
               	lsl	x0, x0, x1
               	mov	w0, w0
               	sxtw	x0, w0
               	asr	x0, x0, x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x80               // =128
               	mov	x1, #0x18               // =24
               	sxtw	x1, w1
               	mov	w0, w0
               	lsl	x0, x0, x1
               	mov	w0, w0
               	sxtw	x0, w0
               	asr	x0, x0, x1
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7f               // =127
               	mov	x1, #0x18               // =24
               	sxtw	x1, w1
               	mov	w0, w0
               	lsl	x0, x0, x1
               	mov	w0, w0
               	sxtw	x0, w0
               	asr	x0, x0, x1
               	cmp	x0, #0x7f
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8000             // =32768
               	lsl	x0, x0, #16
               	sxtw	x0, w0
               	asr	x0, x0, #16
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
