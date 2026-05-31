
setjmp_longjmp.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40030d <.text+0x6d>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100d0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%esi, %r12
               	movq	%rbx, %r8
               	addq	$0x200, %r8             # imm = 0x200
               	movl	%r12d, (%r8)
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x4005f7 <longjmp>
               	movzbq	%al, %rax
               	movq	%rax, %rdi
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x250, %rsp            # imm = 0x250
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400363 <.text+0xc3>
               	movl	$0xb, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	leaq	-0x208(%rbp), %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x4005fd <setjmp>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movslq	%r14d, %r12
               	cmpq	$0x0, %r12
               	jne	0x4003d2 <.text+0x132>
               	movslq	%ebx, %r12
               	leaq	-0x208(%rbp), %r15
               	movl	$0x7, %r12d
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	callq	0x4002b7 <.text+0x17>
               	movq	%rax, %rsi
               	movl	$0xc, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	movslq	%r14d, %r12
               	cmpq	$0x7, %r12
               	je	0x40040a <.text+0x16a>
               	movl	$0xd, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	movslq	%ebx, %rsi
               	cmpq	$0x1, %rsi
               	je	0x400441 <.text+0x1a1>
               	movl	$0xe, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	leaq	-0x208(%rbp), %r12
               	movq	%r12, %rsi
               	addq	$0x200, %rsi            # imm = 0x200
               	movslq	(%rsi), %r12
               	cmpq	$0x7, %r12
               	je	0x40048a <.text+0x1ea>
               	movl	$0xf, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x4004e7 <.text+0x247>
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
               	jae	0x40056e <.text+0x2ce>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400565 <.text+0x2c5>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400569 <.text+0x2c9>
               	andb	%ch, 0x74(%rax)
               	je	0x400579 <.text+0x2d9>
               	jae	0x400545 <.text+0x2a5>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400581 <.text+0x2e1>
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
               	callq	0x400603 <exit>
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
               	jbe	0x4005ab <.text+0x30b>
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
               	jae	0x400632 <exit+0x2f>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400629 <exit+0x26>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40062d <exit+0x2a>
               	andb	%ch, 0x74(%rax)
               	je	0x40063d <exit+0x3a>
               	jae	0x400609 <exit+0x6>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400645 <exit+0x42>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<longjmp>:
               	jmpq	*0xfac3(%rip)           # 0x4100c0

<setjmp>:
               	jmpq	*0xfac5(%rip)           # 0x4100c8

<exit>:
               	jmpq	*0xfac7(%rip)           # 0x4100d0
