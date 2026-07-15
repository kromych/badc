
static_locals.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x280              // =640
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	sxtw	x1, w1
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	sxtw	x1, w1
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	sxtw	x0, w1
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1]
               	add	x0, x0, #0x1
               	str	w0, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	sxtw	x0, w0
               	add	x0, x3, x0
               	str	w0, [x2]
               	ldrsw	x1, [x1]
               	sxtw	x0, w0
               	add	x0, x1, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0xca
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1]
               	add	x0, x0, #0x1
               	str	w0, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	sxtw	x0, w0
               	add	x0, x3, x0
               	str	w0, [x2]
               	ldrsw	x1, [x1]
               	sxtw	x0, w0
               	add	x0, x1, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0x131
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x64               // =100
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1]
               	add	x0, x0, #0x1
               	str	w0, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	sxtw	x0, w0
               	add	x0, x3, x0
               	str	w0, [x2]
               	ldrsw	x1, [x1]
               	sxtw	x0, w0
               	add	x0, x1, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0xca
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1]
               	add	x0, x0, #0x1
               	str	w0, [x1]
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1]
               	add	x0, x0, #0x1
               	str	w0, [x1]
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1]
               	add	x0, x0, #0x1
               	str	w0, [x1]
               	sxtw	x0, w0
               	cmp	x0, #0x3e9
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1]
               	add	x0, x0, #0x1
               	str	w0, [x1]
               	sxtw	x0, w0
               	cmp	x0, #0x3ea
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1]
               	add	x0, x0, #0x1
               	str	w0, [x1]
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x0, #0x0                // =0
               	ret
