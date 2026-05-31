
sizeof_typedef_array.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, #0x200             // =512
               	sxtw	x15, w15
               	cmp	x15, #0x200
               	b.eq	0x400250 <.text+0x30>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x15, #0x28              // =40
               	sxtw	x15, w15
               	cmp	x15, #0x28
               	b.eq	0x400268 <.text+0x48>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400278 <.text+0x58>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400288 <.text+0x68>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400298 <.text+0x78>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4002a8 <.text+0x88>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ret
