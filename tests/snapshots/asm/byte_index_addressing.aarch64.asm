
byte_index_addressing.aarch64:	file format elf64-littleaarch64

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

<get_s>:
               	ldrsb	x0, [x0, w1, sxtw]
               	ret

<get_u>:
               	ldrb	w0, [x0, w1, sxtw]
               	ret

<get_long>:
               	ldrsb	x0, [x0, x1]
               	ret

<get_unsigned>:
               	ldrb	w0, [x0, w1, uxtw]
               	ret

<get_reversed>:
               	ldrb	w0, [x0, w1, sxtw]
               	ret

<put>:
               	mov	x2, #-0x4d              // =-77
               	strb	w2, [x0, w1, sxtw]
               	ret

<twice_s>:
               	sxtw	x1, w1
               	ldrsb	x3, [x0, w1, sxtw]
               	mov	x17, #0x3e8             // =1000
               	mul	x2, x3, x17
               	add	x0, x2, x3
               	sxtw	x0, w0
               	ret

<stored_s>:
               	strb	w2, [x0, w1, sxtw]
               	sxtb	x0, w2
               	ret

<stored_u>:
               	mov	x2, #0x2c               // =44
               	strb	w2, [x0, w1, sxtw]
               	ldrb	w0, [x0, w1, sxtw]
               	ret

<across_pointer>:
               	mov	x3, x2
               	ldrsb	x2, [x0, w1, sxtw]
               	mov	x4, #0x7                // =7
               	strb	w4, [x3]
               	mov	x17, #0x64              // =100
               	mul	x2, x2, x17
               	ldrsb	x0, [x0, w1, sxtw]
               	add	x0, x2, x0
               	sxtw	x0, w0
               	ret

<across_index>:
               	ldrb	w4, [x0, w1, sxtw]
               	mov	x5, #0x9                // =9
               	strb	w5, [x2, w3, sxtw]
               	mov	x17, #0x64              // =100
               	mul	x2, x4, x17
               	ldrb	w0, [x0, w1, sxtw]
               	add	x0, x2, x0
               	sxtw	x0, w0
               	ret

<across_equal_index>:
               	ldrb	w3, [x0, w1, sxtw]
               	mov	x4, #0xb                // =11
               	strb	w4, [x0, w2, sxtw]
               	mov	x17, #0x64              // =100
               	mul	x2, x3, x17
               	ldrb	w0, [x0, w1, sxtw]
               	add	x0, x2, x0
               	sxtw	x0, w0
               	ret

<bump>:
               	ldrb	w2, [x0, w1, sxtw]
               	add	x2, x2, #0x1
               	strb	w2, [x0, w1, sxtw]
               	ret

<across_call>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	sxtw	x21, w1
               	ldrb	w22, [x20, w21, sxtw]
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #0x64              // =100
               	mul	x0, x22, x17
               	ldrb	w1, [x20, w21, sxtw]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<across_copy>:
               	mov	x3, x1
               	ldrb	w1, [x0, w2, sxtw]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	ldrb	w0, [x0, w2, sxtw]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret

<across_volatile>:
               	mov	x3, x2
               	ldrb	w2, [x0, w1, sxtw]
               	mov	x4, #0x3                // =3
               	strb	w4, [x3]
               	mov	x17, #0x64              // =100
               	mul	x2, x2, x17
               	ldrb	w0, [x0, w1, sxtw]
               	add	x0, x2, x0
               	sxtw	x0, w0
               	ret

<across_word>:
               	mov	x3, x2
               	ldrb	w2, [x0, w1, sxtw]
               	mov	x4, #0x505              // =1285
               	movk	x4, #0x505, lsl #16
               	str	w4, [x3]
               	mov	x17, #0x64              // =100
               	mul	x2, x2, x17
               	ldrb	w0, [x0, w1, sxtw]
               	add	x0, x2, x0
               	sxtw	x0, w0
               	ret

<count_zero>:
               	mov	x2, x0
               	mov	x4, x1
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, w4
               	b.ge	<addr>
               	ldrb	w3, [x2, w0, sxtw]
               	cbnz	x3, <addr>
               	add	x1, x1, #0x1
               	add	x0, x0, #0x1
               	cmp	w0, w4
               	b.lt	<addr>
               	mov	x0, x1
               	ret

<mark>:
               	mov	x3, x0
               	mul	x0, x1, x1
               	cmp	w0, w2
               	b.ge	<addr>
               	mov	x4, #0x1                // =1
               	strb	w4, [x3, w0, sxtw]
               	add	x0, x0, x1
               	cmp	w0, w2
               	b.lt	<addr>
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x50]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	add	x0, x22, #0x0
               	mov	x1, #-0x80              // =-128
               	strb	w1, [x0]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	add	x0, x20, #0x0
               	mov	x1, #0x78               // =120
               	strb	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x6f              // =-111
               	strb	w1, [x0, #0x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x89               // =137
               	strb	w1, [x0, #0x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x5e              // =-94
               	strb	w1, [x0, #0x2]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x9a               // =154
               	strb	w1, [x0, #0x2]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x4d              // =-77
               	strb	w1, [x0, #0x3]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xab               // =171
               	strb	w1, [x0, #0x3]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x3c              // =-60
               	strb	w1, [x0, #0x4]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xbc               // =188
               	strb	w1, [x0, #0x4]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x2b              // =-43
               	strb	w1, [x0, #0x5]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xcd               // =205
               	strb	w1, [x0, #0x5]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x1a              // =-26
               	strb	w1, [x0, #0x6]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xde               // =222
               	strb	w1, [x0, #0x6]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x9               // =-9
               	strb	w1, [x0, #0x7]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xef               // =239
               	strb	w1, [x0, #0x7]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x8                // =8
               	strb	w1, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x19               // =25
               	strb	w1, [x0, #0x9]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x11               // =17
               	strb	w1, [x0, #0x9]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2a               // =42
               	strb	w1, [x0, #0xa]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x22               // =34
               	strb	w1, [x0, #0xa]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x3b               // =59
               	strb	w1, [x0, #0xb]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x33               // =51
               	strb	w1, [x0, #0xb]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x4c               // =76
               	strb	w1, [x0, #0xc]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x44               // =68
               	strb	w1, [x0, #0xc]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x5d               // =93
               	strb	w1, [x0, #0xd]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x55               // =85
               	strb	w1, [x0, #0xd]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x6e               // =110
               	strb	w1, [x0, #0xe]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x66               // =102
               	strb	w1, [x0, #0xe]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x7f               // =127
               	strb	w1, [x0, #0xf]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x77               // =119
               	strb	w1, [x0, #0xf]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #-0x1               // =-1
               	strb	w1, [x0, #0x8]
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	ldrsw	x1, [x21]
               	bl	<addr>
               	mov	x17, #-0x80             // =-128
               	cmp	x0, x17
               	b.ne	<addr>
               	ldrsw	x0, [x21]
               	add	x1, x0, #0x8
               	mov	x0, x22
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	ldrsw	x0, [x21]
               	add	x1, x0, #0xf
               	mov	x0, x22
               	bl	<addr>
               	cmp	x0, #0x7f
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldrsw	x1, [x21]
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x78
               	b.ne	<addr>
               	ldrsw	x0, [x21]
               	add	x1, x0, #0x8
               	mov	x0, x20
               	bl	<addr>
               	cbnz	x0, <addr>
               	ldrsw	x0, [x21]
               	add	x1, x0, #0x7
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0xef
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	add	x0, x22, #0x8
               	ldrsw	x1, [x21]
               	sub	x1, x1, #0x8
               	bl	<addr>
               	mov	x17, #-0x80             // =-128
               	cmp	x0, x17
               	b.ne	<addr>
               	add	x0, x22, #0x8
               	ldrsw	x1, [x21]
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	add	x0, x22, #0x8
               	ldrsw	x1, [x21]
               	add	x1, x1, #0x7
               	bl	<addr>
               	cmp	x0, #0x7f
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	add	x0, x20, #0x8
               	ldrsw	x1, [x21]
               	sub	x1, x1, #0x1
               	bl	<addr>
               	cmp	x0, #0xef
               	b.ne	<addr>
               	add	x0, x20, #0x10
               	ldrsw	x1, [x21]
               	sub	x1, x1, #0x10
               	bl	<addr>
               	cmp	x0, #0x78
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	add	x0, x22, #0x8
               	ldrsw	x1, [x21]
               	sub	x1, x1, #0x8
               	bl	<addr>
               	mov	x17, #-0x80             // =-128
               	cmp	x0, x17
               	b.ne	<addr>
               	ldrsw	x0, [x21]
               	add	x1, x0, #0xf
               	mov	x0, x22
               	bl	<addr>
               	cmp	x0, #0x7f
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldrsw	x0, [x21]
               	add	x0, x0, #0x7
               	mov	w1, w0
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0xef
               	b.ne	<addr>
               	add	x0, x20, #0x8
               	ldrsw	x1, [x21]
               	sub	x1, x1, #0x1
               	bl	<addr>
               	cmp	x0, #0xef
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	add	x0, x22, #0x8
               	ldrsw	x1, [x21]
               	sub	x1, x1, #0x3
               	mov	x2, #-0x4d              // =-77
               	bl	<addr>
               	ldrsb	x0, [x22, #0x5]
               	mov	x17, #-0x4d             // =-77
               	cmp	w0, w17
               	b.ne	<addr>
               	ldrsw	x0, [x21]
               	add	x1, x0, #0x5
               	mov	x0, x22
               	bl	<addr>
               	mov	x17, #-0x4d             // =-77
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldrsw	x0, [x21]
               	add	x1, x0, #0x5
               	mov	x0, x22
               	bl	<addr>
               	mov	x17, #-0x2d15           // =-11541
               	movk	x17, #0xfffe, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldrsw	x0, [x21]
               	add	x1, x0, #0x2
               	mov	x2, #0xc8               // =200
               	mov	x0, x22
               	bl	<addr>
               	mov	x17, #-0x38             // =-56
               	cmp	x0, x17
               	b.ne	<addr>
               	ldrsb	x0, [x22, #0x2]
               	mov	x17, #-0x38             // =-56
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldrsw	x0, [x21]
               	add	x1, x0, #0x2
               	mov	x2, #0x12c              // =300
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	ldrb	w0, [x20, #0x2]
               	mov	x17, #0x2c              // =44
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	add	x0, x22, #0x8
               	ldrsw	x1, [x21]
               	sub	x1, x1, #0x6
               	mov	x2, #-0x81              // =-129
               	bl	<addr>
               	cmp	x0, #0x7f
               	b.ne	<addr>
               	ldrsb	x0, [x22, #0x2]
               	cmp	w0, #0x7f
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	add	x2, x22, #0x4
               	mov	x0, #0x32               // =50
               	strb	w0, [x2]
               	ldrsw	x0, [x21]
               	add	x1, x0, #0x4
               	mov	x0, x22
               	bl	<addr>
               	mov	x17, #0x138f            // =5007
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	add	x2, x22, #0x4
               	mov	x0, #0x32               // =50
               	strb	w0, [x2]
               	add	x0, x22, #0x8
               	ldrsw	x1, [x21]
               	sub	x1, x1, #0x4
               	bl	<addr>
               	mov	x17, #0x138f            // =5007
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x3c               // =60
               	strb	w0, [x20, #0x6]
               	ldrsw	x0, [x21]
               	add	x1, x0, #0x6
               	add	x2, x20, #0x9
               	ldrsw	x0, [x21]
               	sub	x3, x0, #0x3
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #0x1779            // =6009
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x3c               // =60
               	strb	w0, [x20, #0x6]
               	ldrsw	x0, [x21]
               	add	x1, x0, #0x6
               	ldrsw	x0, [x21]
               	add	x3, x0, #0x5
               	mov	x0, x20
               	mov	x2, x20
               	bl	<addr>
               	mov	x17, #0x17ac            // =6060
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x3c               // =60
               	strb	w0, [x20, #0x6]
               	ldrsw	x0, [x21]
               	add	x1, x0, #0x6
               	ldrsw	x0, [x21]
               	add	x2, x0, #0x6
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #0x177b            // =6011
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x3c               // =60
               	strb	w0, [x20, #0x6]
               	ldrsw	x0, [x21]
               	add	x1, x0, #0x6
               	ldrsw	x0, [x21]
               	add	x2, x0, #0x7
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #0x17ac            // =6060
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0xff               // =255
               	strb	w0, [x20, #0x6]
               	ldrsw	x0, [x21]
               	add	x1, x0, #0x6
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #0x639c            // =25500
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	ldrsw	x2, [x21]
               	add	x2, x2, #0x3
               	bl	<addr>
               	cmp	x0, #0x19e
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	add	x2, x20, #0x6
               	mov	x0, #0x3c               // =60
               	strb	w0, [x2]
               	ldrsw	x0, [x21]
               	add	x1, x0, #0x6
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #0x1773            // =6003
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	mov	x1, #0x3c               // =60
               	strb	w1, [x0, #0x1]
               	ldrsw	x1, [x21]
               	add	x1, x1, #0x1
               	mov	x2, x0
               	bl	<addr>
               	mov	x17, #0x1775            // =6005
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	strb	w1, [x0]
               	strb	w1, [x0, #0x1]
               	mov	x20, #0x2               // =2
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	mul	x0, x20, x20
               	cmp	w0, #0x40
               	b.ge	<addr>
               	ldrb	w0, [x22, w20, sxtw]
               	cbnz	x0, <addr>
               	ldrsw	x0, [x21]
               	add	x2, x0, #0x40
               	mov	x0, x22
               	mov	x1, x20
               	bl	<addr>
               	add	x20, x20, #0x1
               	mul	x0, x20, x20
               	cmp	w0, #0x40
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x21]
               	add	x1, x1, #0x40
               	bl	<addr>
               	cmp	x0, #0x12
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x21]
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
