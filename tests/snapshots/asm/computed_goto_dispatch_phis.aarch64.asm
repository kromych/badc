
computed_goto_dispatch_phis.aarch64:	file format elf64-littleaarch64

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

<run>:
               	mov	x5, #0x0                // =0
               	mov	x3, #0x1                // =1
               	ldr	x2, [x0]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x6, [x4, x2, lsl #3]
               	add	x6, x6, #0x1
               	str	x6, [x4, x2, lsl #3]
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x9, #0x3                // =3
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x6, [x6, x2, lsl #3]
               	mov	x2, x3
               	br	x6
               	add	x8, x1, #0x8
               	add	x6, x2, #0x1
               	ldr	x2, [x0, x2, lsl #3]
               	str	x2, [x1]
               	add	x2, x6, #0x1
               	ldr	x6, [x0, x6, lsl #3]
               	ldr	x1, [x4, x6, lsl #3]
               	add	x1, x1, #0x1
               	str	x1, [x4, x6, lsl #3]
               	add	x3, x3, #0x1
               	ldr	x6, [x7, x6, lsl #3]
               	mov	x1, x8
               	br	x6
               	sub	x1, x1, #0x8
               	sub	x6, x1, #0x8
               	ldr	x8, [x6]
               	ldr	x10, [x1]
               	add	x8, x8, x10
               	str	x8, [x6]
               	add	x8, x2, #0x1
               	ldr	x2, [x0, x2, lsl #3]
               	ldr	x6, [x4, x2, lsl #3]
               	add	x6, x6, #0x1
               	str	x6, [x4, x2, lsl #3]
               	add	x3, x3, #0x1
               	ldr	x6, [x7, x2, lsl #3]
               	mov	x2, x8
               	br	x6
               	sub	x1, x1, #0x8
               	sub	x6, x1, #0x8
               	ldr	x8, [x6]
               	ldr	x10, [x1]
               	sub	x8, x8, x10
               	str	x8, [x6]
               	add	x8, x2, #0x1
               	ldr	x2, [x0, x2, lsl #3]
               	ldr	x6, [x4, x2, lsl #3]
               	add	x6, x6, #0x1
               	str	x6, [x4, x2, lsl #3]
               	add	x3, x3, #0x1
               	ldr	x6, [x7, x2, lsl #3]
               	mov	x2, x8
               	br	x6
               	sub	x1, x1, #0x8
               	sub	x6, x1, #0x8
               	ldr	x8, [x6]
               	ldr	x10, [x1]
               	mul	x8, x8, x10
               	str	x8, [x6]
               	add	x8, x2, #0x1
               	ldr	x2, [x0, x2, lsl #3]
               	ldr	x6, [x4, x2, lsl #3]
               	add	x6, x6, #0x1
               	str	x6, [x4, x2, lsl #3]
               	add	x3, x3, #0x1
               	ldr	x6, [x7, x2, lsl #3]
               	mov	x2, x8
               	br	x6
               	sub	x6, x1, #0x8
               	ldr	x6, [x6]
               	str	x6, [x1]
               	add	x1, x1, #0x8
               	add	x8, x2, #0x1
               	ldr	x2, [x0, x2, lsl #3]
               	ldr	x6, [x4, x2, lsl #3]
               	add	x6, x6, #0x1
               	str	x6, [x4, x2, lsl #3]
               	add	x3, x3, #0x1
               	ldr	x6, [x7, x2, lsl #3]
               	mov	x2, x8
               	br	x6
               	sub	x6, x1, #0x8
               	ldr	x10, [x6]
               	sub	x8, x1, #0x10
               	ldr	x11, [x8]
               	str	x11, [x6]
               	str	x10, [x8]
               	add	x8, x2, #0x1
               	ldr	x2, [x0, x2, lsl #3]
               	ldr	x6, [x4, x2, lsl #3]
               	add	x6, x6, #0x1
               	str	x6, [x4, x2, lsl #3]
               	add	x3, x3, #0x1
               	ldr	x6, [x7, x2, lsl #3]
               	mov	x2, x8
               	br	x6
               	add	x6, x2, #0x1
               	ldr	x2, [x0, x2, lsl #3]
               	sub	x8, x1, #0x8
               	ldr	x8, [x8]
               	cbz	x8, <addr>
               	mov	x6, x2
               	add	x2, x6, #0x1
               	ldr	x6, [x0, x6, lsl #3]
               	ldr	x8, [x4, x6, lsl #3]
               	add	x8, x8, #0x1
               	str	x8, [x4, x6, lsl #3]
               	add	x3, x3, #0x1
               	ldr	x6, [x7, x6, lsl #3]
               	br	x6
               	sub	x6, x1, #0x8
               	ldr	x8, [x6]
               	sub	x8, x8, #0x1
               	str	x8, [x6]
               	add	x8, x2, #0x1
               	ldr	x2, [x0, x2, lsl #3]
               	ldr	x6, [x4, x2, lsl #3]
               	add	x6, x6, #0x1
               	str	x6, [x4, x2, lsl #3]
               	add	x3, x3, #0x1
               	ldr	x6, [x7, x2, lsl #3]
               	mov	x2, x8
               	br	x6
               	add	x5, x5, #0x2
               	add	x5, x5, #0x1
               	add	x8, x2, #0x1
               	ldr	x2, [x0, x2, lsl #3]
               	ldr	x6, [x4, x2, lsl #3]
               	add	x6, x6, #0x1
               	str	x6, [x4, x2, lsl #3]
               	add	x3, x3, #0x1
               	ldr	x6, [x7, x2, lsl #3]
               	mov	x2, x8
               	br	x6
               	ldr	x6, [x0, x2, lsl #3]
               	add	x5, x5, x6
               	add	x6, x2, #0x1
               	ldr	x6, [x0, x6, lsl #3]
               	lsl	x6, x6, #1
               	add	x5, x5, x6
               	add	x6, x2, #0x2
               	ldr	x6, [x0, x6, lsl #3]
               	mul	x6, x6, x9
               	add	x5, x5, x6
               	add	x6, x2, #0x3
               	ldr	x6, [x0, x6, lsl #3]
               	lsl	x6, x6, #2
               	add	x5, x5, x6
               	add	x6, x2, #0x4
               	add	x2, x6, #0x1
               	ldr	x6, [x0, x6, lsl #3]
               	ldr	x8, [x4, x6, lsl #3]
               	add	x8, x8, #0x1
               	str	x8, [x4, x6, lsl #3]
               	add	x3, x3, #0x1
               	ldr	x6, [x7, x6, lsl #3]
               	br	x6
               	add	x8, x2, #0x1
               	ldr	x2, [x0, x2, lsl #3]
               	ldr	x6, [x4, x2, lsl #3]
               	add	x6, x6, #0x1
               	str	x6, [x4, x2, lsl #3]
               	add	x3, x3, #0x1
               	ldr	x6, [x7, x2, lsl #3]
               	mov	x2, x8
               	br	x6
               	b	<addr>
               	sub	x0, x1, #0x8
               	ldr	x0, [x0]
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x0, x17
               	mov	x17, #0xa               // =10
               	mul	x1, x5, x17
               	add	x0, x0, x1
               	add	x0, x0, x3
               	ret

<run_switch>:
               	mov	x5, #0x0                // =0
               	mov	x7, #0x3                // =3
               	mov	x3, x5
               	mov	x4, x5
               	add	x2, x4, #0x1
               	ldr	x4, [x0, x4, lsl #3]
               	add	x5, x5, #0x1
               	cmp	x4, #0xd
               	b.hs	<addr>
               	adrp	x17, <page>
               	add	x17, x17, <lo12>
               	ldr	x17, [x17, x4, lsl #3]
               	br	x17
               	add	x6, x1, #0x8
               	add	x4, x2, #0x1
               	ldr	x2, [x0, x2, lsl #3]
               	str	x2, [x1]
               	mov	x1, x6
               	b	<addr>
               	sub	x1, x1, #0x8
               	sub	x4, x1, #0x8
               	ldr	x6, [x4]
               	ldr	x8, [x1]
               	add	x6, x6, x8
               	str	x6, [x4]
               	mov	x4, x2
               	b	<addr>
               	sub	x1, x1, #0x8
               	sub	x4, x1, #0x8
               	ldr	x6, [x4]
               	ldr	x8, [x1]
               	sub	x6, x6, x8
               	str	x6, [x4]
               	mov	x4, x2
               	b	<addr>
               	sub	x1, x1, #0x8
               	sub	x4, x1, #0x8
               	ldr	x6, [x4]
               	ldr	x8, [x1]
               	mul	x6, x6, x8
               	str	x6, [x4]
               	mov	x4, x2
               	b	<addr>
               	sub	x4, x1, #0x8
               	ldr	x4, [x4]
               	str	x4, [x1]
               	add	x1, x1, #0x8
               	mov	x4, x2
               	b	<addr>
               	sub	x4, x1, #0x8
               	ldr	x8, [x4]
               	sub	x6, x1, #0x10
               	ldr	x9, [x6]
               	str	x9, [x4]
               	str	x8, [x6]
               	mov	x4, x2
               	b	<addr>
               	add	x4, x2, #0x1
               	ldr	x2, [x0, x2, lsl #3]
               	sub	x6, x1, #0x8
               	ldr	x6, [x6]
               	cbz	x6, <addr>
               	mov	x4, x2
               	b	<addr>
               	sub	x4, x1, #0x8
               	ldr	x6, [x4]
               	sub	x6, x6, #0x1
               	str	x6, [x4]
               	mov	x4, x2
               	b	<addr>
               	add	x3, x3, #0x3
               	mov	x4, x2
               	b	<addr>
               	add	x3, x3, #0x1
               	mov	x4, x2
               	b	<addr>
               	ldr	x4, [x0, x2, lsl #3]
               	add	x3, x3, x4
               	add	x4, x2, #0x1
               	ldr	x4, [x0, x4, lsl #3]
               	lsl	x4, x4, #1
               	add	x3, x3, x4
               	add	x4, x2, #0x2
               	ldr	x4, [x0, x4, lsl #3]
               	mul	x4, x4, x7
               	add	x3, x3, x4
               	add	x4, x2, #0x3
               	ldr	x4, [x0, x4, lsl #3]
               	lsl	x4, x4, #2
               	add	x3, x3, x4
               	add	x4, x2, #0x4
               	b	<addr>
               	mov	x4, x2
               	add	x2, x4, #0x1
               	ldr	x4, [x0, x4, lsl #3]
               	add	x5, x5, #0x1
               	cmp	x4, #0xd
               	b.lo	<addr>
               	sub	x0, x1, #0x8
               	ldr	x0, [x0]
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x0, x17
               	mov	x17, #0xa               // =10
               	mul	x1, x3, x17
               	add	x0, x0, x1
               	add	x0, x0, x5
               	ret

<pressure>:
               	stp	x20, x21, [sp, #-0x50]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x15, #0xb               // =11
               	mov	x2, #0x1                // =1
               	mov	x12, #0x2               // =2
               	mov	x11, #0x3               // =3
               	mov	x10, #0x4               // =4
               	mov	x9, #0x5                // =5
               	mov	x8, #0x6                // =6
               	mov	x7, #0x7                // =7
               	mov	x6, #0x8                // =8
               	mov	x5, #0x9                // =9
               	mov	x4, #0xa                // =10
               	mov	x3, #0xc                // =12
               	sub	x1, x29, #0x20
               	adr	x13, <addr>
               	str	x13, [x1]
               	adr	x13, <addr>
               	str	x13, [x1, #0x8]
               	adr	x13, <addr>
               	str	x13, [x1, #0x10]
               	adr	x13, <addr>
               	str	x13, [x1, #0x18]
               	ldrb	w13, [x0]
               	ldr	x14, [x1, x13, lsl #3]
               	mov	x13, x15
               	mov	x1, x2
               	br	x14
               	add	x1, x1, x3
               	add	x12, x12, x1
               	add	x11, x11, x12
               	add	x10, x10, x11
               	eor	x9, x9, x10
               	add	x8, x8, x9
               	sub	x21, x29, #0x20
               	sxtw	x14, w2
               	add	x2, x14, #0x1
               	mov	x17, #0xa2e9            // =41705
               	movk	x17, #0x2e8b, lsl #16
               	mul	x20, x14, x17
               	asr	x20, x20, #33
               	lsr	x22, x20, #63
               	add	x20, x20, x22
               	msub	x14, x20, x15, x14
               	ldrb	w14, [x0, x14]
               	ldr	x14, [x21, x14, lsl #3]
               	br	x14
               	add	x7, x7, x8
               	sub	x6, x6, x7
               	add	x5, x5, x6
               	eor	x4, x4, x5
               	add	x13, x13, x4
               	add	x3, x3, x13
               	sub	x21, x29, #0x20
               	sxtw	x14, w2
               	add	x2, x14, #0x1
               	mov	x17, #0xa2e9            // =41705
               	movk	x17, #0x2e8b, lsl #16
               	mul	x20, x14, x17
               	asr	x20, x20, #33
               	lsr	x22, x20, #63
               	add	x20, x20, x22
               	msub	x14, x20, x15, x14
               	ldrb	w14, [x0, x14]
               	ldr	x14, [x21, x14, lsl #3]
               	br	x14
               	sub	x20, x29, #0x20
               	sxtw	x14, w2
               	mov	x17, #0xa2e9            // =41705
               	movk	x17, #0x2e8b, lsl #16
               	mul	x2, x14, x17
               	asr	x2, x2, #33
               	lsr	x21, x2, #63
               	add	x2, x2, x21
               	mul	x21, x2, x15
               	sub	x2, x14, x21
               	ldrb	w2, [x0, x2]
               	ldr	x2, [x20, x2, lsl #3]
               	adr	x22, <addr>
               	cmp	x2, x22
               	b.ne	<addr>
               	add	x1, x1, #0x3e8
               	eor	x12, x12, x1
               	add	x10, x10, x11
               	sub	x8, x8, x9
               	add	x6, x6, x7
               	sub	x4, x4, x5
               	eor	x3, x3, x13
               	add	x2, x14, #0x1
               	sub	x14, x14, x21
               	ldrb	w14, [x0, x14]
               	ldr	x14, [x20, x14, lsl #3]
               	br	x14
               	lsl	x0, x12, #1
               	add	x0, x1, x0
               	mov	x17, #0x3               // =3
               	mul	x1, x11, x17
               	add	x0, x0, x1
               	lsl	x1, x10, #2
               	add	x0, x0, x1
               	mov	x17, #0x5               // =5
               	mul	x1, x9, x17
               	add	x0, x0, x1
               	mov	x17, #0x6               // =6
               	mul	x1, x8, x17
               	add	x0, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x7, x17
               	add	x0, x0, x1
               	lsl	x1, x6, #3
               	add	x0, x0, x1
               	mov	x17, #0x9               // =9
               	mul	x1, x5, x17
               	add	x0, x0, x1
               	mov	x17, #0xa               // =10
               	mul	x1, x4, x17
               	add	x0, x0, x1
               	mov	x17, #0xb               // =11
               	mul	x1, x13, x17
               	add	x0, x0, x1
               	mov	x17, #0xc               // =12
               	mul	x1, x3, x17
               	add	x0, x0, x1
               	sxtw	x1, w2
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret

<pressure_switch>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x14, #0xb               // =11
               	mov	x1, #0x1                // =1
               	mov	x11, #0x2               // =2
               	mov	x10, #0x3               // =3
               	mov	x9, #0x4                // =4
               	mov	x8, #0x5                // =5
               	mov	x7, #0x6                // =6
               	mov	x6, #0x7                // =7
               	mov	x5, #0x8                // =8
               	mov	x4, #0x9                // =9
               	mov	x3, #0xa                // =10
               	mov	x2, #0xc                // =12
               	mov	x13, #0x0               // =0
               	mov	x12, x14
               	sxtw	x15, w13
               	add	x13, x15, #0x1
               	mov	x17, #0xa2e9            // =41705
               	movk	x17, #0x2e8b, lsl #16
               	mul	x20, x15, x17
               	asr	x20, x20, #33
               	lsr	x21, x20, #63
               	add	x20, x20, x21
               	msub	x15, x20, x14, x15
               	ldrb	w15, [x0, x15]
               	cmp	w15, #0x1
               	b.lo	<addr>
               	cmp	w15, #0x2
               	b.lo	<addr>
               	cmp	w15, #0x2
               	b.ne	<addr>
               	sxtw	x15, w13
               	mov	x17, #0xa2e9            // =41705
               	movk	x17, #0x2e8b, lsl #16
               	mul	x20, x15, x17
               	asr	x20, x20, #33
               	lsr	x21, x20, #63
               	add	x20, x20, x21
               	msub	x15, x20, x14, x15
               	ldrb	w15, [x0, x15]
               	eor	x15, x15, #0x3
               	cbnz	w15, <addr>
               	add	x1, x1, #0x3e8
               	eor	x11, x11, x1
               	add	x9, x9, x10
               	sub	x7, x7, x8
               	add	x5, x5, x6
               	sub	x3, x3, x4
               	eor	x2, x2, x12
               	b	<addr>
               	add	x6, x6, x7
               	sub	x5, x5, x6
               	add	x4, x4, x5
               	eor	x3, x3, x4
               	add	x12, x12, x3
               	add	x2, x2, x12
               	b	<addr>
               	add	x1, x1, x2
               	add	x11, x11, x1
               	add	x10, x10, x11
               	add	x9, x9, x10
               	eor	x8, x8, x9
               	add	x7, x7, x8
               	b	<addr>
               	lsl	x0, x11, #1
               	add	x0, x1, x0
               	mov	x17, #0x3               // =3
               	mul	x1, x10, x17
               	add	x0, x0, x1
               	lsl	x1, x9, #2
               	add	x0, x0, x1
               	mov	x17, #0x5               // =5
               	mul	x1, x8, x17
               	add	x0, x0, x1
               	mov	x17, #0x6               // =6
               	mul	x1, x7, x17
               	add	x0, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x6, x17
               	add	x0, x0, x1
               	lsl	x1, x5, #3
               	add	x0, x0, x1
               	mov	x17, #0x9               // =9
               	mul	x1, x4, x17
               	add	x0, x0, x1
               	mov	x17, #0xa               // =10
               	mul	x1, x3, x17
               	add	x0, x0, x1
               	mov	x17, #0xb               // =11
               	mul	x1, x12, x17
               	add	x0, x0, x1
               	mov	x17, #0xc               // =12
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	sxtw	x1, w13
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret

<records>:
               	mov	x3, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x2, x0, #0x1
               	ldrb	w0, [x0]
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	ldr	x6, [x4, x0, lsl #3]
               	mov	x5, x3
               	mov	x0, x3
               	mov	x4, x3
               	br	x6
               	add	x4, x4, #0x1
               	ldrb	w6, [x2]
               	cbnz	w6, <addr>
               	add	x2, x2, #0x1
               	add	x0, x0, #0x64
               	add	x6, x2, #0x1
               	ldrb	w2, [x2]
               	lsl	x2, x2, #4
               	add	x2, x1, x2
               	ldr	x8, [x2]
               	ldr	x2, [x2, #0x8]
               	cmp	x2, x5
               	b.le	<addr>
               	mov	x3, x8
               	mov	x5, x2
               	add	x0, x0, #0x1
               	add	x2, x6, #0x1
               	ldrb	w6, [x6]
               	ldr	x6, [x7, x6, lsl #3]
               	br	x6
               	add	x8, x2, #0x1
               	ldrb	w2, [x2]
               	ldr	x6, [x7, x2, lsl #3]
               	mov	x2, x8
               	br	x6
               	b	<addr>
               	mov	x17, #0x2710            // =10000
               	mul	x1, x3, x17
               	mov	x17, #0x3e8             // =1000
               	mul	x2, x5, x17
               	add	x1, x1, x2
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	add	x0, x1, x0
               	add	x0, x0, x4
               	ret

<depth>:
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x0                // =0
               	ldrb	w3, [x0]
               	ldr	x3, [x2, x3, lsl #3]
               	br	x3
               	ldrb	w3, [x0, #0x1]
               	add	x0, x0, #0x2
               	add	x1, x1, x3
               	b	<addr>
               	mov	x0, x1
               	ret

<single>:
               	sxtw	x0, w0
               	sxtw	x1, w1
               	cbz	x0, <addr>
               	adr	x0, <addr>
               	cmp	w1, #0x64
               	b.le	<addr>
               	lsl	x1, x1, #1
               	add	x0, x1, #0x2
               	sxtw	x0, w0
               	ret
               	br	x0
               	add	x0, x1, #0x1
               	ret
               	b	<addr>
               	adr	x0, <addr>
               	b	<addr>

<main>:
               	str	x20, [sp, #-0xa0]!
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x80
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x80
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x20, [sp], #0xa0
               	ret
               	mov	x17, #0xbadb            // =47835
               	movk	x17, #0x1, lsl #16
               	cmp	x20, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x20, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x10]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x18]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x20]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x28]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x30]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x38]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x40]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x48]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x50]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x58]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x60]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x68]
               	add	x1, x1, x2
               	cmp	x1, #0x1f
               	b.ne	<addr>
               	ldr	x1, [x0, #0x30]
               	cmp	x1, #0x3
               	b.ne	<addr>
               	ldr	x1, [x0, #0x50]
               	cmp	x1, #0x1
               	b.ne	<addr>
               	ldr	x0, [x0, #0x68]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x20, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xb                // =11
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xb                // =11
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x20, [sp], #0xa0
               	ret
               	mov	x17, #-0x131e           // =-4894
               	cmp	x20, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x20, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x17, #0x5403            // =21507
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x20, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x20, [sp], #0xa0
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x6
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x7
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	mov	x1, #0xc8               // =200
               	bl	<addr>
               	cmp	x0, #0x192
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x20, [sp], #0xa0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x20, [sp], #0xa0
               	ret
