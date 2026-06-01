
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
               	mov	x0, #0x61               // =97
               	bl	<addr>
               	mov	x14, x0
               	cmp	x14, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x62              // =98
               	mov	x0, x14
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x63               // =99
               	bl	<addr>
               	mov	x14, x0
               	cmp	x14, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x64              // =100
               	mov	x0, x14
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x41               // =65
               	bl	<addr>
               	mov	x14, x0
               	cmp	x14, #0x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x42              // =66
               	mov	x0, x14
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x14, #0x6               // =6
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x30               // =48
               	bl	<addr>
               	mov	x14, x0
               	cmp	x14, #0x3
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x33              // =51
               	mov	x0, x14
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x14, #0x8               // =8
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3f               // =63
               	bl	<addr>
               	mov	x14, x0
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
