
ssa_bail_fixup_rollback.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400785 <.text+0x565>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movq	%rdi, %r11
               	movq	%r11, %r9
               	addq	$0x3, %r9
               	movzbq	(%r9), %r8
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r8, %r9
               	movq	%r9, %r8
               	shlq	$0x8, %r8
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r8, %r9
               	movq	%r11, %r8
               	addq	$0x2, %r8
               	movzbq	(%r8), %rdi
               	movq	%r9, %r8
               	orq	%rdi, %r8
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r8, %rdi
               	movq	%rdi, %r8
               	shlq	$0x8, %r8
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r8, %rdi
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r9
               	movq	%rdi, %r8
               	orq	%r9, %r8
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r8, %r9
               	movq	%r9, %r8
               	shlq	$0x8, %r8
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r8, %r9
               	movzbq	(%r11), %r8
               	movq	%r9, %rax
               	orq	%r8, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rsi, %r12
               	movq	%rdx, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	%rcx, %r10
               	movq	%r10, 0x30(%rsp)
               	xorq	%rsi, %rsi
               	movl	%esi, -0x48(%rbp)
               	jmp	0x400308 <.text+0xe8>
               	movslq	-0x48(%rbp), %rsi
               	cmpq	$0x4, %rsi
               	jge	0x400441 <.text+0x221>
               	jmp	0x400336 <.text+0x116>
               	leaq	-0x48(%rbp), %rsi
               	movslq	(%rsi), %rdx
               	movq	%rdx, %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rsi)
               	jmp	0x400308 <.text+0xe8>
               	leaq	-0x40(%rbp), %rcx
               	movslq	-0x48(%rbp), %rdx
               	movl	$0x5, %esi
               	imulq	%rdx, %rsi
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	movq	%rcx, %rbx
               	addq	%rax, %rbx
               	movq	%rdx, %rax
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	movq	0x30(%rsp), %r15
               	addq	%rax, %r15
               	movq	%r15, %rdi
               	callq	0x400237 <.text+0x17>
               	movl	%eax, (%rbx)
               	leaq	-0x40(%rbp), %r15
               	movslq	-0x48(%rbp), %rax
               	movq	%rax, %rbx
               	addq	$0x1, %rbx
               	movslq	%ebx, %rbx
               	movq	%rbx, %rdx
               	shlq	$0x2, %rdx
               	movq	%r15, %rbx
               	addq	%rdx, %rbx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	movslq	%edx, %rdx
               	movq	0x28(%rsp), %r15
               	addq	%rdx, %r15
               	movq	%r15, %rdi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdx
               	movl	%edx, (%rbx)
               	leaq	-0x40(%rbp), %r15
               	movslq	-0x48(%rbp), %rdx
               	movq	%rdx, %rbx
               	addq	$0x6, %rbx
               	movslq	%ebx, %rbx
               	movq	%rbx, %rax
               	shlq	$0x2, %rax
               	movq	%r15, %rbx
               	addq	%rax, %rbx
               	movq	%rdx, %rax
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	movq	%r12, %r15
               	addq	%rax, %r15
               	movq	%r15, %rdi
               	callq	0x400237 <.text+0x17>
               	movl	%eax, (%rbx)
               	leaq	-0x40(%rbp), %r15
               	movslq	-0x48(%rbp), %rax
               	movq	%rax, %rbx
               	addq	$0xb, %rbx
               	movslq	%ebx, %rbx
               	movq	%rbx, %rdx
               	shlq	$0x2, %rdx
               	movq	%r15, %rbx
               	addq	%rdx, %rbx
               	movq	0x28(%rsp), %rdx
               	addq	$0x10, %rdx
               	movq	%rax, %r15
               	shlq	$0x2, %r15
               	movslq	%r15d, %r15
               	movq	%rdx, %r14
               	addq	%r15, %r14
               	movq	%r14, %rdi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r15
               	movl	%r15d, (%rbx)
               	jmp	0x40031e <.text+0xfe>
               	xorq	%r15, %r15
               	leaq	-0x40(%rbp), %r14
               	movl	(%r14), %r12d
               	leaq	-0x40(%rbp), %r14
               	movq	%r14, %rbx
               	addq	$0x14, %rbx
               	movl	(%rbx), %r14d
               	movq	%r12, %rbx
               	xorq	%r14, %rbx
               	leaq	-0x40(%rbp), %r14
               	movq	%r14, %r12
               	addq	$0x28, %r12
               	movl	(%r12), %r14d
               	movq	%rbx, %r12
               	xorq	%r14, %r12
               	leaq	-0x40(%rbp), %r14
               	movq	%r14, %rbx
               	addq	$0x3c, %rbx
               	movl	(%rbx), %r14d
               	movq	%r12, %rbx
               	xorq	%r14, %rbx
               	movq	%rbx, %r14
               	andq	$0xff, %r14
               	movq	0x38(%rsp), %r11
               	movb	%r14b, (%r11)
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, 0x10(%rbp)
               	movq	%rsi, 0x20(%rbp)
               	movq	%rdx, 0x30(%rbp)
               	movq	%r8, %rbx
               	movq	0x30(%rbp), %r8
               	cmpq	$0x0, %r8
               	jne	0x400566 <.text+0x346>
               	xorq	%r8, %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x50, %rsp
               	pushq	%r11
               	retq
               	xorq	%r11, %r11
               	movl	%r11d, -0x58(%rbp)
               	jmp	0x400572 <.text+0x352>
               	movl	-0x58(%rbp), %r11d
               	cmpq	$0x10, %r11
               	jae	0x4005ba <.text+0x39a>
               	jmp	0x4005a1 <.text+0x381>
               	leaq	-0x58(%rbp), %r11
               	movl	(%r11), %r8d
               	movq	%r8, %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	jmp	0x400572 <.text+0x352>
               	leaq	-0x10(%rbp), %r9
               	movl	-0x58(%rbp), %r8d
               	movq	%r9, %r11
               	addq	%r8, %r11
               	xorq	%r8, %r8
               	movb	%r8b, (%r11)
               	jmp	0x400588 <.text+0x368>
               	xorq	%r8, %r8
               	movl	%r8d, -0x58(%rbp)
               	jmp	0x4005c6 <.text+0x3a6>
               	movl	-0x58(%rbp), %r8d
               	cmpq	$0x8, %r8
               	jae	0x400615 <.text+0x3f5>
               	jmp	0x4005f5 <.text+0x3d5>
               	leaq	-0x58(%rbp), %r8
               	movl	(%r8), %r9d
               	movq	%r9, %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r8)
               	jmp	0x4005c6 <.text+0x3a6>
               	leaq	-0x10(%rbp), %r11
               	movl	-0x58(%rbp), %r9d
               	movq	%r11, %r8
               	addq	%r9, %r8
               	movq	%rcx, %r11
               	addq	%r9, %r11
               	movzbq	(%r11), %r9
               	movb	%r9b, (%r8)
               	jmp	0x4005dc <.text+0x3bc>
               	jmp	0x40061a <.text+0x3fa>
               	movq	0x30(%rbp), %r9
               	cmpq	$0x40, %r9
               	jb	0x40065a <.text+0x43a>
               	leaq	-0x50(%rbp), %r12
               	leaq	-0x10(%rbp), %r14
               	leaq	0xfa96(%rip), %r15      # 0x4100d0
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	callq	0x4002c4 <.text+0xa4>
               	movq	%rax, %r8
               	xorq	%r8, %r8
               	movl	%r8d, -0x58(%rbp)
               	jmp	0x40068a <.text+0x46a>
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x50, %rsp
               	pushq	%r11
               	retq
               	movl	-0x58(%rbp), %r8d
               	cmpq	$0x40, %r8
               	jae	0x4006dd <.text+0x4bd>
               	jmp	0x4006b9 <.text+0x499>
               	leaq	-0x58(%rbp), %r8
               	movl	(%r8), %r15d
               	movq	%r15, %r14
               	addq	$0x1, %r14
               	movl	%r14d, (%r8)
               	jmp	0x40068a <.text+0x46a>
               	movq	0x10(%rbp), %r14
               	movl	-0x58(%rbp), %r15d
               	movq	%r14, %r8
               	addq	%r15, %r8
               	movq	0x20(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x400737 <.text+0x517>
               	jmp	0x40071b <.text+0x4fb>
               	leaq	0x30(%rbp), %rdi
               	movq	(%rdi), %r14
               	movq	%r14, %r8
               	subq	$0x40, %r8
               	movq	%r8, (%rdi)
               	leaq	0x10(%rbp), %r14
               	movq	(%r14), %r8
               	movq	%r8, %rdi
               	addq	$0x40, %rdi
               	movq	%rdi, (%r14)
               	movq	0x20(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	0x400780 <.text+0x560>
               	jmp	0x400767 <.text+0x547>
               	movq	0x20(%rbp), %r14
               	movl	-0x58(%rbp), %r15d
               	movq	%r14, %r12
               	addq	%r15, %r12
               	movzbq	(%r12), %r15
               	movq	%r15, -0x80(%rbp)
               	jmp	0x400743 <.text+0x523>
               	xorq	%r15, %r15
               	movq	%r15, -0x80(%rbp)
               	jmp	0x400743 <.text+0x523>
               	movq	-0x80(%rbp), %r15
               	leaq	-0x50(%rbp), %r12
               	movl	-0x58(%rbp), %r14d
               	movq	%r12, %rdi
               	addq	%r14, %rdi
               	movzbq	(%rdi), %r14
               	movq	%r15, %rdi
               	xorq	%r14, %rdi
               	movb	%dil, (%r8)
               	jmp	0x4006a0 <.text+0x480>
               	leaq	0x20(%rbp), %rdi
               	movq	(%rdi), %r8
               	movq	%r8, %r14
               	addq	$0x40, %r14
               	movq	%r14, (%rdi)
               	jmp	0x400780 <.text+0x560>
               	jmp	0x40061a <.text+0x3fa>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x48(%rbp), %r11
               	leaq	0xf942(%rip), %r9       # 0x4100f0
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	popq	%rax
               	movq	%r11, %r8
               	xorq	%r8, %r8
               	movl	%r8d, -0x70(%rbp)
               	jmp	0x4007c5 <.text+0x5a5>
               	movslq	-0x70(%rbp), %r8
               	cmpq	$0x20, %r8
               	jge	0x400814 <.text+0x5f4>
               	jmp	0x4007f4 <.text+0x5d4>
               	leaq	-0x70(%rbp), %r8
               	movslq	(%r8), %r9
               	movq	%r9, %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r8)
               	jmp	0x4007c5 <.text+0x5a5>
               	leaq	-0x68(%rbp), %r11
               	movslq	-0x70(%rbp), %r9
               	movq	%r11, %r8
               	addq	%r9, %r8
               	movq	%r9, %r11
               	andq	$0xff, %r11
               	movb	%r11b, (%r8)
               	jmp	0x4007db <.text+0x5bb>
               	leaq	-0x40(%rbp), %rbx
               	xorq	%r12, %r12
               	movl	$0x40, %r14d
               	leaq	-0x48(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	-0x68(%rbp), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %r8
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movq	0x28(%rsp), %rcx
               	callq	0x4004c5 <.text+0x2a5>
               	movq	%rax, %rsi
               	leaq	-0x40(%rbp), %rsi
               	movzbq	(%rsi), %r15
               	movq	%r15, %rsi
               	xorq	$0x4d, %rsi
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rsi, %r15
               	cmpq	$0x0, %r15
               	jne	0x40087e <.text+0x65e>
               	xorq	%r15, %r15
               	movq	%r15, -0xa0(%rbp)
               	jmp	0x400890 <.text+0x670>
               	movl	$0x1, %r15d
               	movq	%r15, -0xa0(%rbp)
               	jmp	0x400890 <.text+0x670>
               	movq	-0xa0(%rbp), %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	orb	(%r9), %cl
               	jbe	0x4008f3 <.text+0x6d3>
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
               	jae	0x40097a <.text+0x75a>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400971 <.text+0x751>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400975 <.text+0x755>
               	andb	%ch, 0x74(%rax)
               	je	0x400985 <.text+0x765>
               	jae	0x400951 <.text+0x731>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x40098d <.text+0x76d>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x89485500, (%eax,%eax), %esi # imm = 0x89485500
               	inl	$0x48, %eax
               	subl	$0x10, %esp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4009f7 <exit>
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
               	jbe	0x4009ab <.text+0x78b>
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
               	jae	0x400a32 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400a29 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400a2d <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x400a3d <exit+0x46>
               	jae	0x400a09 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400a45 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xf6c3(%rip)           # 0x4100c0
