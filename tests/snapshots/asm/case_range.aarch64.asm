
case_range.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<classify>:
               	cmp	w0, #0x30
               	b.ge	<addr>
               	cmp	w0, #0x61
               	b.ge	<addr>
               	cmp	w0, #0x41
               	b.ge	<addr>
               	cmp	w0, #0x2d
               	b.lt	<addr>
               	cmp	w0, #0x2d
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x3                // =3
               	ret
               	cmp	w0, #0x2b
               	b.eq	<addr>
               	b	<addr>
               	cmp	w0, #0x5a
               	b.gt	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	cmp	w0, #0x7a
               	b.le	<addr>
               	b	<addr>
               	cmp	w0, #0x39
               	b.gt	<addr>
               	mov	x0, #0x1                // =1
               	ret

<count>:
               	mov	x1, #0x0                // =0
               	cmp	w0, #0x1
               	b.ge	<addr>
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #-0x1               // =-1
               	ret
               	add	x0, x1, #0x1
               	b	<addr>
               	cmp	w0, #0x3
               	b.gt	<addr>
               	mov	x1, #0xa                // =10
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x0, #0x30               // =48
               	blr	x1
               	cmp	w0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x0, #0x35               // =53
               	blr	x1
               	cmp	w0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x0, #0x39               // =57
               	blr	x1
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x0, #0x61               // =97
               	blr	x1
               	cmp	w0, #0x2
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x0, #0x6d               // =109
               	blr	x1
               	cmp	w0, #0x2
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x0, #0x7a               // =122
               	blr	x1
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x0, #0x41               // =65
               	blr	x1
               	cmp	w0, #0x2
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x0, #0x5a               // =90
               	blr	x1
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x0, #0x2b               // =43
               	blr	x1
               	cmp	w0, #0x3
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x0, #0x2d               // =45
               	blr	x1
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x0, #0x24               // =36
               	blr	x1
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x0, #0x2f               // =47
               	blr	x1
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x0, #0x3a               // =58
               	blr	x1
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x18]
               	mov	x0, #0x1                // =1
               	blr	x1
               	cmp	w0, #0xb
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x18]
               	mov	x0, #0x2                // =2
               	blr	x1
               	cmp	w0, #0xb
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x18]
               	mov	x0, #0x3                // =3
               	blr	x1
               	cmp	w0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x18]
               	mov	x0, #0x4                // =4
               	blr	x1
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x18]
               	mov	x0, #0x9                // =9
               	blr	x1
               	cmn	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
