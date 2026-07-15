
case_range.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	cmp	x0, #0x30
               	b.ge	<addr>
               	cmp	x0, #0x61
               	b.ge	<addr>
               	cmp	x0, #0x41
               	b.ge	<addr>
               	cmp	x0, #0x2d
               	b.lt	<addr>
               	cmp	x0, #0x2d
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x3                // =3
               	ret
               	cmp	x0, #0x2b
               	b.eq	<addr>
               	b	<addr>
               	cmp	x0, #0x5a
               	b.gt	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	cmp	x0, #0x7a
               	b.le	<addr>
               	b	<addr>
               	cmp	x0, #0x39
               	b.gt	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x30               // =48
               	bl	<addr>
               	cmp	x0, #0x1
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x0, #0x35               // =53
               	bl	<addr>
               	cmp	x0, #0x1
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x39               // =57
               	bl	<addr>
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x61               // =97
               	bl	<addr>
               	cmp	x0, #0x2
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x0, #0x6d               // =109
               	bl	<addr>
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x7a               // =122
               	bl	<addr>
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x41               // =65
               	bl	<addr>
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x5a               // =90
               	bl	<addr>
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2b               // =43
               	bl	<addr>
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x2d               // =45
               	bl	<addr>
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x24               // =36
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x0, #0x2f               // =47
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x3a               // =58
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0xa                // =10
               	mov	x1, #0xb                // =11
               	mov	x0, #0xa                // =10
               	mov	x0, #0xb                // =11
               	mov	x0, #0x0                // =0
               	cbnz	x0, <addr>
               	mov	x0, #0xa                // =10
               	mov	x0, #0xb                // =11
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
