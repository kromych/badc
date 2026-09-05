
case_range.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, x0
               	mov	x0, #0x0                // =0
               	cmp	w1, #0x1
               	b.ge	<addr>
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sxtw	x0, w0
               	ret
               	add	x0, x0, #0x1
               	b	<addr>
               	cmp	w1, #0x3
               	b.gt	<addr>
               	mov	x0, #0xa                // =10
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x1, #0x30               // =48
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x1, #0x35               // =53
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x1, #0x39               // =57
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x61               // =97
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x2
               	b.ne	<addr>
               	mov	x1, #0x6d               // =109
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x1, #0x7a               // =122
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x41               // =65
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x2
               	b.ne	<addr>
               	mov	x1, #0x5a               // =90
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x2b               // =43
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x3
               	b.ne	<addr>
               	mov	x1, #0x2d               // =45
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x3
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x24               // =36
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cbnz	x0, <addr>
               	mov	x1, #0x2f               // =47
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x1, #0x3a               // =58
               	ldr	x0, [x20]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x1                // =1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0xb
               	b.ne	<addr>
               	mov	x1, #0x2                // =2
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0xb
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x1, #0x3                // =3
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0xb
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x4                // =4
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x9                // =9
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
