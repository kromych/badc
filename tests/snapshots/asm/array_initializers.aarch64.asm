
array_initializers.aarch64:	file format elf64-littleaarch64

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

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	mov	x17, #0x68              // =104
               	eor	x1, x1, x17
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrb	w1, [x0, #0x4]
               	mov	x17, #0x6f              // =111
               	eor	x1, x1, x17
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrb	w0, [x0, #0x5]
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x1, x2
               	ldrsw	x2, [x0, #0x8]
               	add	x1, x1, x2
               	ldrsw	x2, [x0, #0xc]
               	add	x1, x1, x2
               	ldrsw	x0, [x0, #0x10]
               	add	x0, x1, x0
               	cmp	w0, #0x1c
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	mov	x17, #0x68              // =104
               	eor	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x69              // =105
               	eor	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x2]
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0xf]
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0xc]
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x10]
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x61              // =97
               	eor	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	ldrb	w0, [x0]
               	mov	x17, #0x62              // =98
               	eor	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x10]
               	ldrb	w0, [x0, #0x4]
               	mov	x17, #0x61              // =97
               	eor	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x0, #0x12               // =18
               	ret
               	mov	x0, #0x0                // =0
               	ret
