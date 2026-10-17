
divide_width.aarch64:	file format elf64-littleaarch64

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

<wide_quot>:
               	sxtw	x0, w0
               	sxtw	x1, w1
               	sdiv	x0, x0, x1
               	ret

<wide_rem>:
               	sxtw	x0, w0
               	sxtw	x1, w1
               	sdiv	x17, x0, x1
               	msub	x0, x17, x1, x0
               	ret

<wide_quot_ll>:
               	sxtw	x0, w0
               	sxtw	x1, w1
               	sdiv	x0, x0, x1
               	ret

<compound_wide>:
               	sxtw	x0, w0
               	sxtw	x1, w1
               	sdiv	x0, x0, x1
               	ret

<low_words>:
               	lsr	x0, x0, #31
               	and	x1, x1, #0x7
               	mov	x17, #0x100000000       // =4294967296
               	add	x1, x1, x17
               	udiv	w0, w0, w1
               	mov	x17, #0xaaab            // =43691
               	movk	x17, #0xaaaa, lsl #16
               	mul	x1, x0, x17
               	cmp	w0, #0x1
               	cset	x0, hi
               	add	x0, x0, x1, lsr #33
               	ret

<rem_bounded>:
               	sxtw	x0, w0
               	add	x1, x0, x0, lsr #61
               	asr	x1, x1, #3
               	sub	x0, x0, x1, lsl #3
               	ret

<urem_bounded>:
               	mov	x0, #0x5                // =5
               	ret

<pair>:
               	sdiv	w2, w0, w1
               	sxtw	x3, w2
               	msub	x2, x2, x1, x0
               	sxtw	x2, w2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x3, x17
               	add	x4, x4, x2
               	madd	x1, x3, x1, x2
               	cmp	w1, w0
               	cset	x0, eq
               	add	x0, x4, x0
               	ret

<two_widths>:
               	add	x0, x0, x1
               	sxtw	x0, w0
               	mov	x1, #0xaaab             // =43691
               	movk	x1, #0xaaaa, lsl #16
               	movk	x1, #0xaaaa, lsl #32
               	movk	x1, #0xaaaa, lsl #48
               	umulh	x1, x0, x1
               	lsr	x1, x1, #1
               	mov	w0, w0
               	mov	x17, #0xaaab            // =43691
               	movk	x17, #0xaaaa, lsl #16
               	mul	x0, x0, x17
               	lsr	x0, x0, #33
               	eor	x0, x1, x0, lsl #1
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x20, [x0]
               	ldrsw	x21, [x0, #0x4]
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0x8]
               	bl	<addr>
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, x20
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #-0xd               // =-13
               	bl	<addr>
               	mov	x17, #-0x5              // =-5
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x0, #0xd                // =13
               	bl	<addr>
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0xffffffff         // =4294967295
               	bl	<addr>
               	mov	x17, #0x5               // =5
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1, #0x8]
               	ldrsw	x1, [x1, #0xc]
               	bl	<addr>
               	mov	x17, #-0x7cc            // =-1996
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x10]
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #-0xda51           // =-55889
               	movk	x17, #0x9249, lsl #16
               	movk	x17, #0xffb8, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1, #0xc]
               	lsl	x0, x0, #1
               	ldrsw	x1, [x1, #0x8]
               	sub	x1, x1, #0xa
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	mov	x17, #-0xb              // =-11
               	movk	x17, #0x5555, lsl #32
               	movk	x17, #0x5555, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
