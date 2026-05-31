
commutative_imm_lhs_swap.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movl	$0x7, %r11d
               	movslq	%r11d, %r9
               	movq	%r9, %r8
               	shlq	$0x2, %r8
               	movslq	%r8d, %r8
               	cmpq	$0x1c, %r8
               	je	0x40025d <.text+0x3d>
               	movl	$0x1, %eax
               	retq
               	movslq	%r11d, %r9
               	movq	%r9, %rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	cmpq	$0xa, %rax
               	je	0x400280 <.text+0x60>
               	movl	$0x2, %eax
               	retq
               	movslq	%r11d, %r9
               	movq	%r9, %rax
               	andq	$0xf0, %rax
               	cmpq	$0x0, %rax
               	je	0x4002a0 <.text+0x80>
               	movl	$0x3, %eax
               	retq
               	movslq	%r11d, %r9
               	movq	%r9, %rax
               	orq	$0x10, %rax
               	cmpq	$0x17, %rax
               	je	0x4002c0 <.text+0xa0>
               	movl	$0x4, %eax
               	retq
               	movslq	%r11d, %r9
               	movq	%r9, %rax
               	xorq	$0xff, %rax
               	cmpq	$0xf8, %rax
               	je	0x4002e0 <.text+0xc0>
               	movl	$0x5, %eax
               	retq
               	movslq	%r11d, %r9
               	cmpq	$0x1, %r9
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	je	0x400305 <.text+0xe5>
               	movl	$0x6, %eax
               	retq
               	movslq	%r11d, %r9
               	cmpq	$0x1, %r9
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x1, %rax
               	je	0x40032a <.text+0x10a>
               	movl	$0x7, %eax
               	retq
               	movl	$0xa, %r9d
               	movslq	%r11d, %rax
               	movq	%r9, %rdi
               	subq	%rax, %rdi
               	movslq	%edi, %rdi
               	cmpq	$0x3, %rdi
               	je	0x400352 <.text+0x132>
               	movl	$0x8, %edi
               	movq	%rdi, %rax
               	retq
               	movslq	%r11d, %rax
               	cmpq	$0x8, %rax
               	setl	%r11b
               	movzbq	%r11b, %r11
               	cmpq	$0x0, %r11
               	jne	0x40037b <.text+0x15b>
               	movl	$0x9, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	retq
               	orb	(%r9), %cl
               	jbe	0x4003b7 <.text+0x197>
               	xorb	%ch, %cs:(%rsi)
               	cmpb	%cl, (%rdx)
               	orl	%esp, 0x6f(%rbx)
               	insl	%dx, %es:(%rdi)
               	insl	%dx, %es:(%rdi)
               	imull	$0x37313633, 0x32(%rax,%riz), %esi # imm = 0x37313633
               	xorw	(%rdi), %si
               	movslq	0x61(%rbp), %esp
               	xorl	$0x32613735, %eax       # imm = 0x32613735
               	xorl	$0x35363734, %eax       # imm = 0x35363734
               	xorl	$0x31306335, %eax       # imm = 0x31306335
               	<unknown>
               	xorl	$0x38323965, %eax       # imm = 0x38323965
               	movslq	(%rdx), %esi
               	<unknown>
               	xorl	%esi, (%rsi)
               	orb	(%rcx), %cl
               	<unknown>
               	movslq	0x67(%rsi), %esp
               	popq	%rdi
               	jae	0x40043e <.text+0x21e>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400435 <.text+0x215>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400439 <.text+0x219>
               	andb	%ch, 0x74(%rax)
               	je	0x400449 <.text+0x229>
               	jae	0x400415 <.text+0x1f5>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400451 <.text+0x231>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
		...
               	addb	%dl, 0x48(%rbp)
               	movl	%esp, %ebp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4004c7 <exit>
               	movzbq	%al, %rax
               	movq	%rax, %r9
               	xorq	%r9, %r9
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x40047b <.text+0x25b>
               	xorb	%ch, %cs:(%rsi)
               	cmpb	%cl, (%rdx)
               	orl	%esp, 0x6f(%rbx)
               	insl	%dx, %es:(%rdi)
               	insl	%dx, %es:(%rdi)
               	imull	$0x37313633, 0x32(%rax,%riz), %esi # imm = 0x37313633
               	xorw	(%rdi), %si
               	movslq	0x61(%rbp), %esp
               	xorl	$0x32613735, %eax       # imm = 0x32613735
               	xorl	$0x35363734, %eax       # imm = 0x35363734
               	xorl	$0x31306335, %eax       # imm = 0x31306335
               	<unknown>
               	xorl	$0x38323965, %eax       # imm = 0x38323965
               	movslq	(%rdx), %esi
               	<unknown>
               	xorl	%esi, (%rsi)
               	orb	(%rcx), %cl
               	<unknown>
               	movslq	0x67(%rsi), %esp
               	popq	%rdi
               	jae	0x400502 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4004f9 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4004fd <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x40050d <exit+0x46>
               	jae	0x4004d9 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400515 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfbf3(%rip)           # 0x4100c0
