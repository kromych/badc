
switch_multilabel.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x15, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	ret
               	mov	x15, #0x2               // =2
               	mov	x0, x15
               	ret
               	mov	x0, #0x3                // =3
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ret
               	cmp	x15, #0x61
               	b.eq	<addr>
               	cmp	x15, #0x62
               	b.eq	<addr>
               	cmp	x15, #0x63
               	b.eq	<addr>
               	cmp	x15, #0x64
               	b.eq	<addr>
               	cmp	x15, #0x41
               	b.eq	<addr>
               	cmp	x15, #0x42
               	b.eq	<addr>
               	cmp	x15, #0x30
               	b.eq	<addr>
               	cmp	x15, #0x31
               	b.eq	<addr>
               	cmp	x15, #0x32
               	b.eq	<addr>
               	cmp	x15, #0x33
               	b.eq	<addr>
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	mov	x20, #0x61              // =97
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x62              // =98
               	mov	x0, x21
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x63              // =99
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x20, #0x3               // =3
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x64              // =100
               	mov	x0, x21
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x21, #0x4               // =4
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x41              // =65
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x20, #0x5               // =5
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x42              // =66
               	mov	x0, x21
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x21, #0x6               // =6
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x30              // =48
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x20, #0x7               // =7
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x33              // =51
               	mov	x0, x21
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x21, #0x8               // =8
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3f              // =63
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x20, #0x9               // =9
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
