
word_index_addressing.aarch64:	file format elf64-littleaarch64

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

<get8s>:
               	ldrsb	x0, [x0, w1, sxtw]
               	ret

<get8u>:
               	ldrb	w0, [x0, w1, sxtw]
               	ret

<get16s>:
               	ldrsh	x0, [x0, w1, sxtw #1]
               	ret

<get16u>:
               	ldrh	w0, [x0, w1, sxtw #1]
               	ret

<get32s>:
               	ldrsw	x0, [x0, w1, sxtw #2]
               	ret

<get32u>:
               	ldr	w0, [x0, w1, sxtw #2]
               	ret

<get64>:
               	ldr	x0, [x0, w1, sxtw #3]
               	ret

<put8>:
               	mov	x2, #-0x38              // =-56
               	strb	w2, [x0, w1, sxtw]
               	ret

<put16>:
               	mov	x2, #-0x63c0            // =-25536
               	strh	w2, [x0, w1, sxtw #1]
               	ret

<put32>:
               	mov	x2, #-0x5               // =-5
               	str	w2, [x0, w1, sxtw #2]
               	ret

<put64>:
               	mov	x2, #-0x6               // =-6
               	str	x2, [x0, w1, sxtw #3]
               	ret

<getu>:
               	ldrsw	x0, [x0, w1, uxtw #2]
               	ret

<putu>:
               	mov	x2, #0x21               // =33
               	str	x2, [x0, w1, uxtw #3]
               	ret

<wrapped_int>:
               	mov	x3, x0
               	add	x0, x1, x2
               	ldrsw	x0, [x3, w0, sxtw #2]
               	ret

<wrapped_unsigned>:
               	add	x1, x1, x2
               	ldr	x0, [x0, w1, uxtw #3]
               	ret

<index_and_value>:
               	mov	x3, x0
               	add	x0, x1, x2
               	sxtw	x0, w0
               	ldrsw	x1, [x3, x0, lsl #2]
               	add	x0, x1, x0
               	ret

<swap>:
               	ldrsw	x3, [x0, w1, sxtw #2]
               	ldrsw	x4, [x0, w2, sxtw #2]
               	str	w4, [x0, w1, sxtw #2]
               	str	w3, [x0, w2, sxtw #2]
               	ret

<sum_down>:
               	mov	x2, x0
               	mov	x0, x1
               	mov	x1, #0x0                // =0
               	sub	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.lt	<addr>
               	ldrsh	x3, [x2, w0, sxtw #1]
               	add	x1, x1, x3
               	sub	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.ge	<addr>
               	mov	x0, x1
               	ret

<sum_from>:
               	mov	x4, x0
               	mov	x0, #0x0                // =0
               	cmp	w2, w3
               	b.hs	<addr>
               	add	x5, x1, x2
               	ldrb	w5, [x4, w5, uxtw]
               	add	x0, x0, x5
               	add	x2, x2, #0x1
               	cmp	w2, w3
               	b.lo	<addr>
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	add	x0, x21, #0x7
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrsw	x1, [x20]
               	sub	x1, x1, #0x7
               	bl	<addr>
               	mov	x17, #-0x80             // =-128
               	cmp	x0, x17
               	b.ne	<addr>
               	add	x0, x21, #0x4
               	ldrsw	x1, [x20]
               	sub	x1, x1, #0x2
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	ldrsw	x0, [x20]
               	add	x1, x0, #0x7
               	mov	x0, x21
               	bl	<addr>
               	cmp	x0, #0x7f
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x7
               	ldrsw	x1, [x20]
               	sub	x1, x1, #0x1
               	bl	<addr>
               	cmp	x0, #0xff
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	ldrsw	x1, [x20]
               	sub	x1, x1, #0x5
               	bl	<addr>
               	cmp	x0, #0x80
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0xe
               	ldrsw	x1, [x20]
               	sub	x1, x1, #0x7
               	bl	<addr>
               	mov	x17, #-0x8000           // =-32768
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	ldrsw	x1, [x20]
               	sub	x1, x1, #0x2
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0xe
               	ldrsw	x1, [x20]
               	sub	x1, x1, #0x1
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	ldrsw	x1, [x20]
               	sub	x1, x1, #0x5
               	bl	<addr>
               	mov	x17, #0x8000            // =32768
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x1c
               	ldrsw	x1, [x20]
               	sub	x1, x1, #0x7
               	bl	<addr>
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	ldrsw	x1, [x20]
               	sub	x1, x1, #0x2
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x1c
               	ldrsw	x1, [x20]
               	sub	x1, x1, #0x1
               	bl	<addr>
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x20
               	ldrsw	x1, [x20]
               	sub	x1, x1, #0x5
               	bl	<addr>
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x38
               	ldrsw	x1, [x20]
               	sub	x1, x1, #0x7
               	bl	<addr>
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x40
               	ldrsw	x1, [x20]
               	sub	x1, x1, #0x2
               	bl	<addr>
               	mov	x17, #0x100000000       // =4294967296
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	add	x0, x21, #0x8
               	ldrsw	x1, [x20]
               	sub	x1, x1, #0x8
               	mov	x2, #0xc8               // =200
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	ldrsw	x1, [x20]
               	sub	x1, x1, #0x8
               	mov	x2, #0x9c40             // =40000
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x20
               	ldrsw	x1, [x20]
               	sub	x1, x1, #0x8
               	mov	x2, #-0x5               // =-5
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x40
               	ldrsw	x1, [x20]
               	sub	x1, x1, #0x8
               	mov	x2, #-0x6               // =-6
               	bl	<addr>
               	ldrsb	x0, [x21]
               	mov	x17, #-0x38             // =-56
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsh	x0, [x0]
               	mov	x17, #-0x63c0           // =-25536
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	mov	x17, #-0x5              // =-5
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #-0x6              // =-6
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	ldrsb	x0, [x21, #0x1]
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsh	x0, [x0, #0x2]
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x20]
               	add	x0, x0, #0x7
               	mov	w0, w0
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	mov	x17, #0x7fffffff        // =2147483647
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x20]
               	add	x0, x0, #0x1
               	mov	w0, w0
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	ldrsw	x0, [x20]
               	add	x0, x0, #0x3
               	mov	w1, w0
               	mov	x2, #0x21               // =33
               	mov	x0, x21
               	bl	<addr>
               	ldr	x0, [x21, #0x18]
               	cmp	x0, #0x21
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x10]
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x20]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	ldrsw	x1, [x20]
               	mov	x17, #0x7fffffff        // =2147483647
               	add	x1, x1, x17
               	ldrsw	x2, [x20]
               	mov	x17, #0x7fffffff        // =2147483647
               	add	x2, x2, x17
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	ldrsw	x1, [x20]
               	mov	x17, #-0x80000000       // =-2147483648
               	add	x1, x1, x17
               	ldrsw	x2, [x20]
               	mov	x17, #-0x80000000       // =-2147483648
               	add	x2, x2, x17
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x20]
               	sub	x0, x0, #0x1
               	mov	w2, w0
               	ldrsw	x0, [x20]
               	add	x0, x0, #0x3
               	mov	w0, w0
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	ldrsw	x1, [x20]
               	mov	x17, #0x7fffffff        // =2147483647
               	add	x1, x1, x17
               	ldrsw	x2, [x20]
               	mov	x17, #0x7fffffff        // =2147483647
               	add	x2, x2, x17
               	bl	<addr>
               	mov	x17, #-0x3              // =-3
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	ldrsw	x1, [x20]
               	add	x1, x1, #0x1
               	ldrsw	x2, [x20]
               	add	x2, x2, #0x2
               	bl	<addr>
               	mov	x17, #0x2               // =2
               	movk	x17, #0x8000, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	add	x0, x21, #0x10
               	ldrsw	x1, [x20]
               	sub	x1, x1, #0x3
               	ldrsw	x2, [x20]
               	add	x2, x2, #0x3
               	bl	<addr>
               	ldrsw	x0, [x21, #0x4]
               	mov	x17, #0x7fffffff        // =2147483647
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x1c]
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x2
               	ldrsw	x1, [x20]
               	add	x1, x1, #0x7
               	bl	<addr>
               	mov	x17, #0xfffd            // =65533
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x20]
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x20]
               	sub	x0, x0, #0x4
               	mov	w2, w0
               	ldrsw	x0, [x20]
               	add	x0, x0, #0x4
               	mov	w3, w0
               	ldrsw	x0, [x20]
               	add	x0, x0, #0x8
               	mov	w0, w0
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x0
               	mov	x0, x16
               	bl	<addr>
               	cmp	x0, #0x100
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
