
linked_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400287 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100d8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%r11, %r11
               	movq	%r11, -0x8(%rbp)
               	movl	%r11d, -0x20(%rbp)
               	movl	%r11d, -0x28(%rbp)
               	jmp	0x4002aa <.text+0x3a>
               	movslq	-0x28(%rbp), %r11
               	cmpq	$0x5, %r11
               	jge	0x400320 <.text+0xb0>
               	jmp	0x4002d9 <.text+0x69>
               	leaq	-0x28(%rbp), %r11
               	movslq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	0x4002aa <.text+0x3a>
               	movl	$0x10, %r8d
               	movslq	%r8d, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4004c7 <malloc>
               	movq	%rax, %r9
               	movq	%r9, -0x18(%rbp)
               	movq	-0x18(%rbp), %rbx
               	movslq	-0x28(%rbp), %r9
               	movq	%r9, (%rbx)
               	movq	-0x18(%rbp), %r11
               	movq	%r11, %r9
               	addq	$0x8, %r9
               	movq	-0x8(%rbp), %r11
               	movq	%r11, (%r9)
               	movq	-0x18(%rbp), %rbx
               	movq	%rbx, -0x8(%rbp)
               	jmp	0x4002c0 <.text+0x50>
               	movq	-0x8(%rbp), %rbx
               	movq	%rbx, -0x10(%rbp)
               	jmp	0x40032d <.text+0xbd>
               	movq	-0x10(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	0x400368 <.text+0xf8>
               	movslq	-0x20(%rbp), %rbx
               	movq	-0x10(%rbp), %r11
               	movq	(%r11), %r9
               	movq	%rbx, %rdi
               	addq	%r9, %rdi
               	movl	%edi, -0x20(%rbp)
               	movq	%r11, %r9
               	addq	$0x8, %r9
               	movq	(%r9), %r11
               	movq	%r11, -0x10(%rbp)
               	jmp	0x40032d <.text+0xbd>
               	movslq	-0x20(%rbp), %r11
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x4003b7 <.text+0x147>
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
               	jae	0x40043e <.text+0x1ce>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400435 <.text+0x1c5>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400439 <.text+0x1c9>
               	andb	%ch, 0x74(%rax)
               	je	0x400449 <.text+0x1d9>
               	jae	0x400415 <.text+0x1a5>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400451 <.text+0x1e1>
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
               	callq	0x4004cd <exit>
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
               	jbe	0x40047b <.text+0x20b>
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
               	jae	0x400502 <exit+0x35>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4004f9 <exit+0x2c>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4004fd <exit+0x30>
               	andb	%ch, 0x74(%rax)
               	je	0x40050d <exit+0x40>
               	jae	0x4004d9 <exit+0xc>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400515 <exit+0x48>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<malloc>:
               	jmpq	*0xfc03(%rip)           # 0x4100d0

<exit>:
               	jmpq	*0xfc05(%rip)           # 0x4100d8
