
queens.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400469 <.text+0x249>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	movslq	%edx, %r8
               	xorq	%rdi, %rdi
               	movl	%edi, -0x8(%rbp)
               	jmp	0x400256 <.text+0x36>
               	movslq	-0x8(%rbp), %rdi
               	cmpq	%r9, %rdi
               	jge	0x4002c3 <.text+0xa3>
               	jmp	0x400281 <.text+0x61>
               	movslq	-0x8(%rbp), %rdi
               	movq	%rdi, %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x8(%rbp)
               	jmp	0x400256 <.text+0x36>
               	movslq	-0x8(%rbp), %rsi
               	movq	%r9, %rdi
               	subq	%rsi, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x10(%rbp)
               	movq	%rsi, %rdx
               	shlq	$0x2, %rdx
               	movq	%r11, %rsi
               	addq	%rdx, %rsi
               	movslq	(%rsi), %rdx
               	movq	%r8, %rsi
               	subq	%rdx, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x18(%rbp)
               	movslq	-0x18(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	jge	0x4002ec <.text+0xcc>
               	jmp	0x4002d2 <.text+0xb2>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x18(%rbp), %rdx
               	movabsq	$-0x1, %rsi
               	imulq	%rdx, %rsi
               	movl	%esi, -0x18(%rbp)
               	jmp	0x4002ec <.text+0xcc>
               	movslq	-0x8(%rbp), %rsi
               	movq	%rsi, %rdx
               	shlq	$0x2, %rdx
               	movq	%r11, %rsi
               	addq	%rdx, %rsi
               	movslq	(%rsi), %rdx
               	cmpq	%r8, %rdx
               	jne	0x400317 <.text+0xf7>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x10(%rbp), %rsi
               	movslq	-0x18(%rbp), %rax
               	cmpq	%rax, %rsi
               	jne	0x400336 <.text+0x116>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	0x400268 <.text+0x48>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movslq	%esi, %r12
               	cmpq	$0x8, %r12
               	jne	0x400393 <.text+0x173>
               	movl	$0x1, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movl	%r8d, -0x8(%rbp)
               	movl	%r8d, -0x10(%rbp)
               	jmp	0x4003a3 <.text+0x183>
               	movslq	-0x10(%rbp), %r8
               	cmpq	$0x8, %r8
               	jge	0x4003f9 <.text+0x1d9>
               	jmp	0x4003d2 <.text+0x1b2>
               	movslq	-0x10(%rbp), %r8
               	movq	%r8, %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x10(%rbp)
               	jmp	0x4003a3 <.text+0x183>
               	movslq	-0x10(%rbp), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r8
               	cmpq	$0x0, %r8
               	je	0x400424 <.text+0x204>
               	jmp	0x40041f <.text+0x1ff>
               	movslq	-0x8(%rbp), %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	0x4003b9 <.text+0x199>
               	movq	%r12, %r14
               	shlq	$0x2, %r14
               	movq	%rbx, %r8
               	addq	%r14, %r8
               	movslq	-0x10(%rbp), %r14
               	movl	%r14d, (%r8)
               	movslq	-0x8(%rbp), %r15
               	movq	%r12, %r14
               	addq	$0x1, %r14
               	movslq	%r14d, %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	0x40033b <.text+0x11b>
               	movq	%rax, %r8
               	movq	%r15, %r14
               	addq	%r8, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x8(%rbp)
               	jmp	0x4003b9 <.text+0x199>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x20(%rbp), %rbx
               	xorq	%r12, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x40033b <.text+0x11b>
               	movq	%rax, %r8
               	movslq	%r8d, %r12
               	cmpq	$0x5c, %r12
               	je	0x4004c0 <.text+0x2a0>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x400513 <.text+0x2f3>
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
               	jae	0x40059a <.text+0x37a>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400591 <.text+0x371>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400595 <.text+0x375>
               	andb	%ch, 0x74(%rax)
               	je	0x4005a5 <.text+0x385>
               	jae	0x400571 <.text+0x351>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4005ad <.text+0x38d>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x89485500, (%eax,%eax), %esi # imm = 0x89485500
               	inl	$0x48, %eax
               	subl	$0x10, %esp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400617 <exit>
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
               	jbe	0x4005cb <.text+0x3ab>
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
               	jae	0x400652 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400649 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40064d <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x40065d <exit+0x46>
               	jae	0x400629 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400665 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfaa3(%rip)           # 0x4100c0
