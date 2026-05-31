
many_args_host_stack_overflow.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400444 <.text+0x224>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	popq	%r10
               	subq	$0x50, %rsp
               	movq	0x50(%rsp), %rax
               	movq	%rax, (%rsp)
               	movq	0x58(%rsp), %rax
               	movq	%rax, 0x10(%rsp)
               	movq	0x60(%rsp), %rax
               	movq	%rax, 0x20(%rsp)
               	movq	0x68(%rsp), %rax
               	movq	%rax, 0x30(%rsp)
               	movq	0x70(%rsp), %rax
               	movq	%rax, 0x40(%rsp)
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movslq	%ecx, %rcx
               	movslq	%r8d, %r8
               	movslq	%r9d, %r9
               	cmpq	$0x1, %rdi
               	je	0x4002d2 <.text+0xb2>
               	movl	$0x1, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	cmpq	$0x2, %rsi
               	je	0x4002f1 <.text+0xd1>
               	movl	$0x2, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	cmpq	$0x3, %rdx
               	je	0x400310 <.text+0xf0>
               	movl	$0x3, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	cmpq	$0x4, %rcx
               	je	0x40032f <.text+0x10f>
               	movl	$0x4, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	cmpq	$0x5, %r8
               	je	0x40034e <.text+0x12e>
               	movl	$0x5, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	cmpq	$0x6, %r9
               	je	0x40036d <.text+0x14d>
               	movl	$0x6, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	movslq	0x70(%rbp), %r11
               	cmpq	$0x7, %r11
               	je	0x400394 <.text+0x174>
               	movl	$0x7, %r11d
               	movq	%r11, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	movslq	0x80(%rbp), %rax
               	cmpq	$0x8, %rax
               	je	0x4003ba <.text+0x19a>
               	movl	$0x8, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	movslq	0x90(%rbp), %r11
               	cmpq	$0x9, %r11
               	je	0x4003e4 <.text+0x1c4>
               	movl	$0x9, %r11d
               	movq	%r11, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	movslq	0xa0(%rbp), %rax
               	cmpq	$0xa, %rax
               	je	0x40040a <.text+0x1ea>
               	movl	$0xa, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	movslq	0xb0(%rbp), %r11
               	cmpq	$0xb, %r11
               	je	0x400434 <.text+0x214>
               	movl	$0xb, %r11d
               	movq	%r11, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x1, %ebx
               	movl	$0x2, %r12d
               	movl	$0x3, %r14d
               	movl	$0x4, %r10d
               	movq	%r10, 0x58(%rsp)
               	movl	$0x5, %r10d
               	movq	%r10, 0x50(%rsp)
               	movl	$0x6, %r10d
               	movq	%r10, 0x48(%rsp)
               	movl	$0x7, %r10d
               	movq	%r10, 0x40(%rsp)
               	movl	$0x8, %r10d
               	movq	%r10, 0x38(%rsp)
               	movl	$0x9, %r10d
               	movq	%r10, 0x30(%rsp)
               	movl	$0xa, %r10d
               	movq	%r10, 0x28(%rsp)
               	movl	$0xb, %r15d
               	subq	$0x30, %rsp
               	movq	0x70(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x68(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x60(%rsp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x58(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movq	0x88(%rsp), %rcx
               	movq	0x80(%rsp), %r8
               	movq	0x78(%rsp), %r9
               	callq	0x400237 <.text+0x17>
               	addq	$0x30, %rsp
               	movq	%rax, %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x400583 <.text+0x363>
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
               	jae	0x40060a <.text+0x3ea>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400601 <.text+0x3e1>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400605 <.text+0x3e5>
               	andb	%ch, 0x74(%rax)
               	je	0x400615 <.text+0x3f5>
               	jae	0x4005e1 <.text+0x3c1>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x40061d <.text+0x3fd>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x89485500, (%eax,%eax), %esi # imm = 0x89485500
               	inl	$0x48, %eax
               	subl	$0x10, %esp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400687 <exit>
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
               	jbe	0x40063b <.text+0x41b>
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
               	jae	0x4006c2 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4006b9 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4006bd <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x4006cd <exit+0x46>
               	jae	0x400699 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4006d5 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfa33(%rip)           # 0x4100c0
