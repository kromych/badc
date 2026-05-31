
struct_by_value_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003d3 <.text+0x1b3>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %r11
               	movslq	0x20(%rbp), %r9
               	movl	%r9d, (%r11)
               	leaq	-0x8(%rbp), %r8
               	movq	%r8, %r9
               	addq	$0x4, %r9
               	movslq	0x30(%rbp), %r8
               	movl	%r8d, (%r9)
               	movq	0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %r8
               	pushq	%r11
               	movq	(%r8), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	movq	%rax, %r9
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq
               	movslq	%edi, %r11
               	movl	$0xdead, %r9d           # imm = 0xDEAD
               	movl	$0xbeef, %r8d           # imm = 0xBEEF
               	movl	$0xcafe, %edi           # imm = 0xCAFE
               	movl	$0xfacef, %esi          # imm = 0xFACEF
               	movslq	%r9d, %rdx
               	movslq	%r8d, %r9
               	movq	%rdx, %r8
               	addq	%r9, %r8
               	movslq	%r8d, %r8
               	movslq	%edi, %r9
               	movq	%r8, %rdi
               	addq	%r9, %rdi
               	movslq	%edi, %rdi
               	movslq	%esi, %r9
               	movq	%rdi, %rsi
               	addq	%r9, %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, %r9
               	addq	%r11, %r9
               	movslq	%r9d, %rax
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %r11
               	movq	0x20(%rbp), %r9
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	popq	%rax
               	movq	%r11, %r8
               	leaq	-0x10(%rbp), %r8
               	movq	0x30(%rbp), %r9
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r8)
               	popq	%rax
               	movq	%r8, %r11
               	leaq	-0x18(%rbp), %r11
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r8
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %rdi
               	movq	%r8, %r9
               	addq	%rdi, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%r11)
               	leaq	-0x18(%rbp), %rdi
               	movq	%rdi, %r9
               	addq	$0x4, %r9
               	leaq	-0x8(%rbp), %rdi
               	movq	%rdi, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %rdi
               	leaq	-0x10(%rbp), %r11
               	movq	%r11, %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %r11
               	movq	%rdi, %r8
               	addq	%r11, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%r9)
               	movq	0x10(%rbp), %rax
               	leaq	-0x18(%rbp), %r8
               	pushq	%r11
               	movq	(%r8), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	movq	%rax, %r9
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x130, %rsp            # imm = 0x130
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x8(%rbp), %rbx
               	leaq	-0x90(%rbp), %r12
               	movl	$0xb, %r14d
               	movl	$0x16, %r15d
               	movq	%r12, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rsi
               	leaq	-0x90(%rbp), %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rbx)
               	popq	%rax
               	movq	%rbx, %r15
               	movl	$0x7, %r12d
               	movq	%r12, %rdi
               	callq	0x4002b0 <.text+0x90>
               	movq	%rax, %rsi
               	movslq	%esi, %r12
               	cmpq	$0x0, %r12
               	jne	0x400474 <.text+0x254>
               	movl	$0x63, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rsi
               	movslq	(%rsi), %r12
               	cmpq	$0xb, %r12
               	je	0x4004b0 <.text+0x290>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rsi
               	movq	%rsi, %r12
               	addq	$0x4, %r12
               	movslq	(%r12), %rsi
               	cmpq	$0x16, %rsi
               	je	0x4004f6 <.text+0x2d6>
               	movl	$0x2, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r15
               	leaq	-0xa0(%rbp), %r12
               	movl	$0x3, %r14d
               	movl	$0x4, %ebx
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rsi
               	leaq	-0xa0(%rbp), %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%r15)
               	popq	%rax
               	movq	%r15, %rbx
               	leaq	-0x20(%rbp), %rbx
               	movslq	(%rbx), %rsi
               	cmpq	$0x3, %rsi
               	je	0x40056a <.text+0x34a>
               	movl	$0x3, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rbx
               	movq	%rbx, %rsi
               	addq	$0x4, %rsi
               	movslq	(%rsi), %rbx
               	cmpq	$0x4, %rbx
               	je	0x4005af <.text+0x38f>
               	movl	$0x4, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %r12
               	leaq	-0xb0(%rbp), %r14
               	movl	$0x64, %ebx
               	movl	$0xc8, %r15d
               	movq	%r14, %rdi
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rsi
               	leaq	-0xb0(%rbp), %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%r12)
               	popq	%rax
               	movq	%r12, %r15
               	leaq	-0x38(%rbp), %r14
               	leaq	-0xc0(%rbp), %r15
               	movl	$0x12c, %ebx            # imm = 0x12C
               	movl	$0x190, %r12d           # imm = 0x190
               	movq	%r15, %rdi
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rsi
               	leaq	-0xc0(%rbp), %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%r14)
               	popq	%rax
               	movq	%r14, %r12
               	leaq	-0x30(%rbp), %r12
               	movslq	(%r12), %rsi
               	cmpq	$0x64, %rsi
               	je	0x40065e <.text+0x43e>
               	movl	$0x5, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %r12
               	movq	%r12, %rsi
               	addq	$0x4, %rsi
               	movslq	(%rsi), %r12
               	cmpq	$0xc8, %r12
               	je	0x4006a4 <.text+0x484>
               	movl	$0x6, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rsi
               	movslq	(%rsi), %r12
               	cmpq	$0x12c, %r12            # imm = 0x12C
               	je	0x4006e0 <.text+0x4c0>
               	movl	$0x7, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rsi
               	movq	%rsi, %r12
               	addq	$0x4, %r12
               	movslq	(%r12), %rsi
               	cmpq	$0x190, %rsi            # imm = 0x190
               	je	0x400726 <.text+0x506>
               	movl	$0x8, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	-0xd0(%rbp), %r12
               	leaq	-0xe0(%rbp), %rbx
               	movl	$0x1, %r14d
               	movl	$0x2, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rsi
               	leaq	-0xe0(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	leaq	-0xf0(%rbp), %r14
               	movl	$0x3, %r15d
               	movl	$0x4, %ebx
               	movq	%r14, %rdi
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rsi
               	leaq	-0xf0(%rbp), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rdx
               	movq	0x20(%rsp), %rsi
               	callq	0x4002fa <.text+0xda>
               	movq	%rax, %rbx
               	leaq	-0xd0(%rbp), %rbx
               	movq	0x28(%rsp), %r10
               	pushq	%rax
               	movq	(%rbx), %rax
               	movq	%rax, (%r10)
               	popq	%rax
               	movq	%r10, %r14
               	leaq	-0x50(%rbp), %r14
               	movslq	(%r14), %rbx
               	cmpq	$0x4, %rbx
               	je	0x4007f5 <.text+0x5d5>
               	movl	$0x9, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %r14
               	movq	%r14, %rbx
               	addq	$0x4, %rbx
               	movslq	(%rbx), %r14
               	cmpq	$0x6, %r14
               	je	0x40083b <.text+0x61b>
               	movl	$0xa, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
               	orb	(%r9), %cl
               	jbe	0x40089b <.text+0x67b>
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
               	jae	0x400922 <.text+0x702>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400919 <.text+0x6f9>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40091d <.text+0x6fd>
               	andb	%ch, 0x74(%rax)
               	je	0x40092d <.text+0x70d>
               	jae	0x4008f9 <.text+0x6d9>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400935 <.text+0x715>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%dl, 0x48(%rbp)
               	movl	%esp, %ebp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4009a7 <exit>
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
               	jbe	0x40095b <.text+0x73b>
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
               	jae	0x4009e2 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4009d9 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4009dd <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x4009ed <exit+0x46>
               	jae	0x4009b9 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4009f5 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xf713(%rip)           # 0x4100c0
