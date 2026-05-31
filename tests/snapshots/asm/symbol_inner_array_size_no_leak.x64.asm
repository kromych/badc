
symbol_inner_array_size_no_leak.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002d0 <.text+0xb0>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	xorq	%r8, %r8
               	movl	%r8d, -0x8(%rbp)
               	jmp	0x400254 <.text+0x34>
               	movslq	-0x8(%rbp), %r8
               	cmpq	%r9, %r8
               	jge	0x4002a9 <.text+0x89>
               	jmp	0x40027f <.text+0x5f>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %rdi
               	movq	%rdi, %rsi
               	addq	$0x1, %rsi
               	movl	%esi, (%r8)
               	jmp	0x400254 <.text+0x34>
               	movslq	-0x8(%rbp), %rsi
               	movq	%rsi, %rdi
               	shlq	$0x1, %rdi
               	movq	%r11, %r8
               	addq	%rdi, %r8
               	movl	$0x3, %edi
               	imulq	%rsi, %rdi
               	movslq	%edi, %rdi
               	movswq	%di, %rdi
               	movw	%di, (%r8)
               	jmp	0x400266 <.text+0x46>
               	movq	%r9, %rdi
               	subq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, %r9
               	shlq	$0x1, %r9
               	movq	%r11, %rdi
               	addq	%r9, %rdi
               	movswq	(%rdi), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x10(%rbp), %rbx
               	movl	$0x8, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r8
               	movslq	%r8d, %r12
               	cmpq	$0x15, %r12
               	je	0x40032a <.text+0x10a>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r8
               	movswq	(%r8), %r12
               	cmpq	$0x0, %r12
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x30(%rbp)
               	cmpq	$0x0, %r8
               	jne	0x40037c <.text+0x15c>
               	leaq	-0x10(%rbp), %r12
               	movq	%r12, %r8
               	addq	$0xe, %r8
               	movswq	(%r8), %r12
               	cmpq	$0x15, %r12
               	setne	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x30(%rbp)
               	jmp	0x40037c <.text+0x15c>
               	movq	-0x30(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	0x4003ab <.text+0x18b>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %r8
               	movq	%r8, %r12
               	addq	$0xe, %r12
               	movl	$0x63, %r8d
               	movw	%r8w, (%r12)
               	leaq	-0x28(%rbp), %rbx
               	movq	%rbx, %r8
               	addq	$0xe, %r8
               	movswq	(%r8), %rbx
               	cmpq	$0x63, %rbx
               	je	0x400400 <.text+0x1e0>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x400453 <.text+0x233>
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
               	jae	0x4004da <.text+0x2ba>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4004d1 <.text+0x2b1>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4004d5 <.text+0x2b5>
               	andb	%ch, 0x74(%rax)
               	je	0x4004e5 <.text+0x2c5>
               	jae	0x4004b1 <.text+0x291>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4004ed <.text+0x2cd>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x89485500, (%eax,%eax), %esi # imm = 0x89485500
               	inl	$0x48, %eax
               	subl	$0x10, %esp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400557 <exit>
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
               	jbe	0x40050b <.text+0x2eb>
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
               	jae	0x400592 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400589 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40058d <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x40059d <exit+0x46>
               	jae	0x400569 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4005a5 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfb63(%rip)           # 0x4100c0
