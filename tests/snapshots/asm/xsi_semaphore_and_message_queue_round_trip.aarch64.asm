
xsi_semaphore_and_message_queue_round_trip.aarch64:	file format elf64-littleaarch64

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

<semaphores>:
               	stp	x20, x21, [sp, #-0xa0]!
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	sub	x0, x29, #0x78
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w16, [x1]
               	str	w16, [x0]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x2                // =2
               	mov	x2, #0x380              // =896
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x0
               	b.ge	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x3, x29, #0x70
               	sub	x0, x29, #0x78
               	stur	x0, [x29, #-0x70]
               	mov	x1, #0x0                // =0
               	mov	x2, #0x11               // =17
               	mov	x0, x20
               	ldr	x3, [x3]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x3, x29, #0x70
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x70]
               	mov	x1, #0x1                // =1
               	mov	x2, #0x10               // =16
               	mov	x0, x20
               	ldr	x3, [x3]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #0xc                // =12
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0xc                // =12
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x1, x29, #0x68
               	sturh	wzr, [x29, #-0x68]
               	mov	x2, #-0x2               // =-2
               	sturh	w2, [x29, #-0x66]
               	sturh	wzr, [x29, #-0x64]
               	mov	x0, #0x1                // =1
               	sturh	w0, [x29, #-0x62]
               	sturh	w0, [x29, #-0x60]
               	mov	x0, #0x1000             // =4096
               	sturh	w0, [x29, #-0x5e]
               	mov	x2, #0x2                // =2
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x1, x29, #0x68
               	mov	x0, #-0x2               // =-2
               	sturh	w0, [x29, #-0x66]
               	mov	x0, #0x800              // =2048
               	sturh	w0, [x29, #-0x64]
               	mov	x2, #0x1                // =1
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0xb
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x78
               	mov	x1, #0xff               // =255
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sub	x3, x29, #0x70
               	sub	x0, x29, #0x78
               	stur	x0, [x29, #-0x70]
               	mov	x1, #0x0                // =0
               	mov	x2, #0xd                // =13
               	mov	x0, x20
               	ldr	x3, [x3]
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldurh	w0, [x29, #-0x78]
               	eor	x0, x0, #0x1
               	cbnz	w0, <addr>
               	ldurh	w0, [x29, #-0x76]
               	eor	x0, x0, #0x8
               	cbz	w0, <addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #0xb                // =11
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x21, x0
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x3, x29, #0x70
               	sub	x0, x29, #0x58
               	stur	x0, [x29, #-0x70]
               	mov	x1, #0x0                // =0
               	mov	x2, #0x2                // =2
               	mov	x0, x20
               	ldr	x3, [x3]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	ldur	x0, [x29, #-0x18]
               	cmp	x0, #0x2
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x44]
               	and	x0, x0, #0x1ff
               	eor	x0, x0, #0x180
               	cbz	w0, <addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x20
               	mov	x2, x1
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x20, x21, [sp], #0xa0
               	ret

<messages>:
               	stp	x20, x21, [sp, #-0xb0]!
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	mov	x0, #0x0                // =0
               	mov	x1, #0x380              // =896
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x0
               	b.ge	<addr>
               	mov	x0, #0x1e               // =30
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	sub	x0, x29, #0x90
               	mov	x1, #0x1                // =1
               	stur	x1, [x29, #-0x90]
               	add	x0, x0, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sub	x1, x29, #0x90
               	mov	x2, #0x6                // =6
               	mov	x3, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1f               // =31
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	sub	x0, x29, #0x90
               	mov	x1, #0x2                // =2
               	stur	x1, [x29, #-0x90]
               	add	x0, x0, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sub	x1, x29, #0x90
               	mov	x2, #0xf                // =15
               	mov	x3, #0x800              // =2048
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x20               // =32
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	mov	x1, #0x2                // =2
               	sub	x2, x29, #0x78
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x21               // =33
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	ldur	x0, [x29, #-0x28]
               	cmp	x0, #0x2
               	b.ne	<addr>
               	ldursw	x21, [x29, #-0x18]
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x21, x0
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x64]
               	and	x0, x0, #0x1ff
               	eor	x0, x0, #0x180
               	cbz	w0, <addr>
               	mov	x0, #0x22               // =34
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	sub	x0, x29, #0x90
               	mov	x1, #0x0                // =0
               	mov	x2, #0x18               // =24
               	bl	<addr>
               	sub	x1, x29, #0x90
               	mov	x2, #0x10               // =16
               	mov	x3, #0x2                // =2
               	mov	x4, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0xf
               	b.ne	<addr>
               	sub	x0, x29, #0x90
               	ldur	x1, [x29, #-0x90]
               	cmp	x1, #0x2
               	b.ne	<addr>
               	add	x0, x0, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x23               // =35
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	sub	x1, x29, #0x90
               	mov	x2, #0x3                // =3
               	mov	x3, #0x0                // =0
               	mov	x4, #0x800              // =2048
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x24               // =36
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	sub	x0, x29, #0x90
               	mov	x1, #0x0                // =0
               	mov	x2, #0x18               // =24
               	bl	<addr>
               	sub	x1, x29, #0x90
               	mov	x2, #0x3                // =3
               	mov	x3, #0x0                // =0
               	mov	x4, #0x1000             // =4096
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x3
               	b.ne	<addr>
               	sub	x0, x29, #0x90
               	ldur	x1, [x29, #-0x90]
               	cmp	x1, #0x1
               	b.ne	<addr>
               	add	x0, x0, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x25               // =37
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	sub	x1, x29, #0x90
               	mov	x2, #0x10               // =16
               	mov	x3, #0x0                // =0
               	mov	x4, #0x800              // =2048
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x26               // =38
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	mov	x1, #0x2                // =2
               	sub	x2, x29, #0x78
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x28]
               	cbnz	x0, <addr>
               	ldursw	x21, [x29, #-0x14]
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x21, x0
               	b.eq	<addr>
               	mov	x0, #0x27               // =39
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x20
               	mov	x2, x1
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x28               // =40
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xa0]
               	ldp	x20, x21, [sp], #0xb0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cbz	w0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
