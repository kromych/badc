
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
               	add	x1, x1, x2
               	ldrsw	x0, [x0, w1, sxtw #2]
               	ret

<wrapped_unsigned>:
               	add	x1, x1, x2
               	ldr	x0, [x0, w1, uxtw #3]
               	ret

<index_and_value>:
               	add	x1, x1, x2
               	sxtw	x1, w1
               	ldrsw	x0, [x0, x1, lsl #2]
               	add	x0, x0, x1
               	ret

<swap>:
               	ldrsw	x3, [x0, w1, sxtw #2]
               	ldrsw	x4, [x0, w2, sxtw #2]
               	str	w4, [x0, w1, sxtw #2]
               	str	w3, [x0, w2, sxtw #2]
               	ret

<sum_down>:
               	mov	x2, x0
               	sxtw	x1, w1
               	mov	x0, #0x0                // =0
               	sub	x1, x1, #0x1
               	cmp	w1, #0x0
               	b.lt	<addr>
               	ldrsh	x3, [x2, x1, lsl #1]
               	add	x0, x0, x3
               	sub	x1, x1, #0x1
               	cmp	w1, #0x0
               	b.ge	<addr>
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x7
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	sub	x1, x1, #0x7
               	bl	<addr>
               	mov	x17, #-0x80             // =-128
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x4
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	sub	x1, x1, #0x2
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	add	x1, x1, #0x7
               	bl	<addr>
               	cmp	x0, #0x7f
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x7
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	sub	x1, x1, #0x1
               	bl	<addr>
               	cmp	x0, #0xff
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	sub	x1, x1, #0x5
               	bl	<addr>
               	cmp	x0, #0x80
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0xe
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	sub	x1, x1, #0x7
               	bl	<addr>
               	mov	x17, #-0x8000           // =-32768
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	sub	x1, x1, #0x2
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0xe
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	sub	x1, x1, #0x1
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	sub	x1, x1, #0x5
               	bl	<addr>
               	mov	x17, #0x8000            // =32768
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x1c
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	sub	x1, x1, #0x7
               	bl	<addr>
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	sub	x1, x1, #0x2
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x1c
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	sub	x1, x1, #0x1
               	bl	<addr>
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	sub	x1, x1, #0x5
               	bl	<addr>
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	sub	x1, x1, #0x7
               	bl	<addr>
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	sub	x1, x1, #0x2
               	bl	<addr>
               	mov	x17, #0x100000000       // =4294967296
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	sub	x1, x1, #0x8
               	mov	x2, #0xc8               // =200
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	sub	x1, x1, #0x8
               	mov	x2, #0x9c40             // =40000
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	sub	x1, x1, #0x8
               	mov	x2, #-0x5               // =-5
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	sub	x1, x1, #0x8
               	mov	x2, #-0x6               // =-6
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsb	x0, [x1]
               	mov	x17, #-0x38             // =-56
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsh	x0, [x2]
               	mov	x17, #-0x63c0           // =-25536
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	mov	x17, #-0x5              // =-5
               	cmp	w3, w17
               	b.ne	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x4, [x3]
               	mov	x17, #-0x6              // =-6
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsb	x1, [x1, #0x1]
               	mov	x17, #-0x2              // =-2
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrsh	x1, [x2, #0x2]
               	mov	x17, #-0x2              // =-2
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x4]
               	mov	x17, #-0x2              // =-2
               	cmp	w1, w17
               	b.ne	<addr>
               	ldr	x1, [x3, #0x8]
               	mov	x17, #-0x2              // =-2
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	add	x1, x1, #0x7
               	bl	<addr>
               	mov	x17, #0x7fffffff        // =2147483647
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	add	x1, x1, #0x1
               	bl	<addr>
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	add	x1, x1, #0x3
               	mov	x2, #0x21               // =33
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x18]
               	cmp	x1, #0x21
               	b.ne	<addr>
               	ldr	x1, [x0, #0x10]
               	mov	x17, #-0x1              // =-1
               	cmp	x1, x17
               	b.ne	<addr>
               	ldr	x0, [x0, #0x20]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x1, [x2]
               	mov	x17, #0x7fffffff        // =2147483647
               	add	x1, x1, x17
               	ldrsw	x2, [x2]
               	mov	x17, #0x7fffffff        // =2147483647
               	add	x2, x2, x17
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x1, [x2]
               	mov	x17, #-0x80000000       // =-2147483648
               	add	x1, x1, x17
               	ldrsw	x2, [x2]
               	mov	x17, #-0x80000000       // =-2147483648
               	add	x2, x2, x17
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x1, [x2]
               	sub	x1, x1, #0x1
               	ldrsw	x2, [x2]
               	add	x2, x2, #0x3
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x1, [x2]
               	mov	x17, #0x7fffffff        // =2147483647
               	add	x1, x1, x17
               	ldrsw	x2, [x2]
               	mov	x17, #0x7fffffff        // =2147483647
               	add	x2, x2, x17
               	bl	<addr>
               	mov	x17, #-0x3              // =-3
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x1, [x2]
               	add	x1, x1, #0x1
               	ldrsw	x2, [x2]
               	add	x2, x2, #0x2
               	bl	<addr>
               	mov	x17, #0x2               // =2
               	movk	x17, #0x8000, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x1, [x2]
               	sub	x1, x1, #0x3
               	ldrsw	x2, [x2]
               	add	x2, x2, #0x3
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x4]
               	mov	x17, #0x7fffffff        // =2147483647
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x1c]
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x2
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	add	x1, x1, #0x7
               	bl	<addr>
               	mov	x17, #0xfffd            // =65533
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x3]
               	sub	x1, x1, #0x4
               	ldrsw	x2, [x3]
               	add	x2, x2, #0x4
               	ldrsw	x3, [x3]
               	add	x3, x3, #0x8
               	bl	<addr>
               	cmp	x0, #0x100
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
