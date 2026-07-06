
array_compound_literal_static_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldrsw	x1, [x1, #0x8]
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x1, [x0]
               	ldr	x1, [x1]
               	ldrb	w1, [x1]
               	mov	x17, #0x61              // =97
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x1, [x0, #0x8]
               	ldrsw	x1, [x1, #0x8]
               	cmp	x1, #0x2aa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	x1, [x0, #0x8]
               	ldr	x1, [x1]
               	ldrb	w1, [x1]
               	mov	x17, #0x69              // =105
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldr	x1, [x0, #0x8]
               	ldr	x1, [x1]
               	ldrb	w1, [x1, #0x1]
               	mov	x17, #0x66              // =102
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldr	x1, [x0, #0x8]
               	ldrsw	x1, [x1, #0x18]
               	cmp	x1, #0x28b
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldr	x1, [x0, #0x8]
               	ldr	x1, [x1, #0x10]
               	ldrb	w1, [x1, #0x1]
               	mov	x17, #0x6e              // =110
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	ldr	x1, [x0, #0x8]
               	ldrsw	x1, [x1, #0x28]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	ldr	x1, [x0, #0x8]
               	ldr	x1, [x1, #0x20]
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	ldr	x1, [x0, #0x10]
               	ldrsw	x1, [x1, #0x8]
               	cmp	x1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	ldr	x1, [x0, #0x10]
               	ldrsw	x1, [x1, #0x18]
               	cmp	x1, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldr	x1, [x0, #0x10]
               	ldr	x1, [x1, #0x10]
               	cmp	x1, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0xa                // =10
               	ret
               	ldr	x0, [x0, #0x10]
               	ldrsw	x0, [x0, #0x28]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
