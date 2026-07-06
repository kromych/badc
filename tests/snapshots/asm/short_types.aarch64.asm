
short_types.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	sxtw	x1, w0
               	mov	x17, #0x8000            // =32768
               	and	x1, x1, x17
               	cbz	x1, <addr>
               	mov	x17, #0x10000           // =65536
               	sub	x0, x0, x17
               	sxtw	x0, w0
               	ret
               	sxtw	x0, w0
               	ret

<as_ushort>:
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xf0
               	str	x20, [sp]
               	mov	x0, #0x10000            // =65536
               	bl	<addr>
               	sxth	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8000             // =32768
               	bl	<addr>
               	sxth	x0, w0
               	mov	x17, #0x8000            // =32768
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xd8
               	mov	x1, #0x64               // =100
               	strh	w1, [x0]
               	sub	x0, x29, #0xd8
               	mov	x1, #0xc8               // =200
               	strh	w1, [x0, #0x2]
               	sub	x0, x29, #0xd8
               	mov	x1, #0xfed4             // =65236
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	strh	w1, [x0, #0x4]
               	sub	x20, x29, #0xd8
               	sub	x0, x29, #0xd8
               	ldrsh	x1, [x0]
               	sub	x0, x29, #0xd8
               	ldrsh	x0, [x0, #0x2]
               	add	x0, x1, x0
               	sub	x1, x29, #0xd8
               	ldrsh	x1, [x1, #0x4]
               	add	x0, x0, x1
               	bl	<addr>
               	strh	w0, [x20, #0x6]
               	sub	x0, x29, #0xd8
               	ldrsh	x0, [x0, #0x6]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xe0
               	mov	x1, #0x7                // =7
               	strh	w1, [x0]
               	sub	x0, x29, #0xe0
               	mov	x1, #0xfff9             // =65529
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	strh	w1, [x0, #0x2]
               	sub	x0, x29, #0xe0
               	mov	x1, #0xc0de             // =49374
               	strh	w1, [x0, #0x4]
               	sub	x0, x29, #0xe0
               	ldrsh	x1, [x0]
               	sub	x0, x29, #0xe0
               	ldrsh	x0, [x0, #0x2]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xe0
               	ldrh	w0, [x0, #0x4]
               	mov	x17, #0xc0de            // =49374
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xd                // =13
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xe                // =14
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xf                // =15
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x10               // =16
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x11               // =17
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x12               // =18
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
