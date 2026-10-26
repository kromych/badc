
pthread_rwlock_spin_barrier_and_attributes.aarch64:	file format elf64-littleaarch64

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

<reader>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x10
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x20, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	w20, #0x7
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x2                // =2
               	b	<addr>

<rwlocks>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	mov	x0, #-0x1               // =-1
               	stur	w0, [x29, #-0x40]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x7                // =7
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x10
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, x1
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x50]
               	sub	x1, x29, #0x48
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x48]
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, x0
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x50]
               	sub	x1, x29, #0x48
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x48]
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x58
               	sub	x1, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x40]
               	cbz	w0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	sub	x1, x29, #0x58
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x38
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret

<attributes>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	stur	xzr, [x29, #-0x58]
               	mov	x0, #-0x1               // =-1
               	stur	w0, [x29, #-0x50]
               	stur	w0, [x29, #-0x48]
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x100000           // =1048576
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	sub	x1, x29, #0x58
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x58]
               	mov	x17, #0x100000          // =1048576
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	sub	x1, x29, #0x50
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x50]
               	cbz	w0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sub	x0, x29, #0x60
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x50
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x50]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x50
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x50]
               	cbz	w0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x50
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x50]
               	cbz	w0, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x48
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x48]
               	cbz	w0, <addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x48]
               	sub	x1, x29, #0x50
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x50]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret

<reentrant>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x4a0
               	str	x20, [sp]
               	mov	x0, #0x5                // =5
               	str	w0, [sp, #0x18]
               	str	w0, [sp, #0x20]
               	str	xzr, [sp, #0x28]
               	sub	x0, x29, #0x488
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	sub	x0, x29, #0x480
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x20, x0
               	b.ne	<addr>
               	ldr	w0, [sp, #0x18]
               	ldr	w1, [sp, #0x20]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldr	x20, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x450
               	mov	x1, #0x0                // =0
               	mov	x2, #0x38               // =56
               	bl	<addr>
               	sub	x0, x29, #0x450
               	mov	x1, #0x46               // =70
               	str	w1, [sp, #0x64]
               	mov	x1, #0x1                // =1
               	str	w1, [sp, #0x5c]
               	mov	x1, #0x4                // =4
               	str	w1, [sp, #0x68]
               	sub	x1, x29, #0x470
               	bl	<addr>
               	mov	x1, x0
               	sub	x0, x29, #0x470
               	cmp	x1, x0
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x15               // =21
               	ldr	x20, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	cbz	x20, <addr>
               	sub	x1, x29, #0x418
               	sub	x2, x29, #0x478
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldr	x0, [sp, #0x28]
               	sub	x1, x29, #0x418
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ldr	x20, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret

<linux_only>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x160
               	str	x20, [sp]
               	sub	x0, x29, #0x130
               	stp	xzr, xzr, [x0]
               	mov	x0, #-0x1               // =-1
               	str	w0, [sp, #0x28]
               	sub	x0, x29, #0x150
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x150
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1f               // =31
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x150
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x10
               	b.ne	<addr>
               	sub	x0, x29, #0x150
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x20               // =32
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x150
               	bl	<addr>
               	sub	x0, x29, #0x120
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x21               // =33
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x120
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x22               // =34
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x120
               	bl	<addr>
               	sub	x0, x29, #0x148
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x148
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x148
               	sub	x1, x29, #0x138
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldrsw	x0, [sp, #0x28]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x23               // =35
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x148
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x140
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldrsw	x0, [sp, #0x20]
               	sub	x1, x29, #0x130
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x24               // =36
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x20
               	b.lt	<addr>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x20, x0
               	b.gt	<addr>
               	mov	x0, #0x25               // =37
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x100
               	bl	<addr>
               	bl	<addr>
               	mov	x1, x0
               	sub	x0, x29, #0x100
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x100
               	mov	x2, x0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x26               // =38
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	stur	w0, [x29, #-0x8]
               	bl	<addr>
               	mov	x20, x0
               	bl	<addr>
               	mov	x1, x0
               	sub	x2, x29, #0x8
               	mov	x0, x20
               	ldr	x2, [x2]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x27               // =39
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x130
               	mov	x0, #0x5                // =5
               	str	x0, [sp, #0x30]
               	str	xzr, [sp, #0x38]
               	sub	x0, x29, #0x100
               	sub	x1, x29, #0x80
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x20, x0
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x68]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x28               // =40
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cbnz	w0, <addr>
               	bl	<addr>
               	cbnz	w0, <addr>
               	bl	<addr>
               	cbnz	w0, <addr>
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
