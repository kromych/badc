
string_initializer_copy_rules.aarch64:	file format elf64-littleaarch64

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
               	ldrb	w1, [x0, #0x4]
               	mov	x17, #0x61              // =97
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x5]
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrb	w1, [x0, #0x6]
               	mov	x17, #0x62              // =98
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0x7]
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrb	w1, [x0, #0x4]
               	mov	x17, #0x61              // =97
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x6]
               	mov	x17, #0x63              // =99
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0x7]
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0, #0x1]
               	cbnz	x1, <addr>
               	ldrb	w0, [x0, #0x2]
               	mov	x17, #0x71              // =113
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	mov	x17, #0x61              // =97
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0x2]
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x62              // =98
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x2]
               	cbnz	x1, <addr>
               	ldrb	w0, [x0, #0x5]
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x2]
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0, #0x1]
               	mov	x17, #0x62              // =98
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x2]
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x3]
               	cbz	x1, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	ldrb	w1, [x0, #0x4]
               	mov	x17, #0x63              // =99
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x7]
               	mov	x17, #0x66              // =102
               	eor	x1, x1, x17
               	cbz	w1, <addr>
               	mov	x0, #0xc                // =12
               	ret
               	ldrb	w1, [x0, #0x8]
               	mov	x17, #0x67              // =103
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0x9]
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0, #0x4]
               	cmp	w1, #0x62
               	b.ne	<addr>
               	ldr	w1, [x0, #0x8]
               	cbnz	x1, <addr>
               	ldr	w1, [x0, #0xc]
               	cbz	x1, <addr>
               	mov	x0, #0xe                // =14
               	ret
               	ldr	w1, [x0, #0x10]
               	cmp	w1, #0x63
               	b.ne	<addr>
               	ldr	w1, [x0, #0x1c]
               	cmp	w1, #0x66
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	ldr	w1, [x0, #0x20]
               	cmp	w1, #0x67
               	b.ne	<addr>
               	ldr	w0, [x0, #0x24]
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0, #0x8]
               	cbz	x0, <addr>
               	mov	x0, #0x12               // =18
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0]
               	cmp	w1, #0x68
               	b.ne	<addr>
               	ldr	w0, [x0, #0x4]
               	cmp	w0, #0x69
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0, #0x4]
               	cmp	w1, #0x69
               	b.ne	<addr>
               	ldr	w1, [x0, #0x8]
               	cbnz	x1, <addr>
               	ldr	w0, [x0, #0xc]
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	ldrb	w1, [x0, #0x4]
               	eor	x1, x1, #0x78
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x5]
               	cbz	x1, <addr>
               	mov	x0, #0x16               // =22
               	ret
               	ldrb	w1, [x0, #0x6]
               	mov	x17, #0x79              // =121
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x7]
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x8]
               	cbz	x1, <addr>
               	mov	x0, #0x17               // =23
               	ret
               	ldr	w1, [x0, #0x10]
               	cmp	w1, #0x69
               	b.ne	<addr>
               	ldr	w1, [x0, #0x14]
               	cbnz	x1, <addr>
               	ldr	w0, [x0, #0x18]
               	cbz	x0, <addr>
               	mov	x0, #0x18               // =24
               	ret
               	mov	x0, #0x0                // =0
               	ret
