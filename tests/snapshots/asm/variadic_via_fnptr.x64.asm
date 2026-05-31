
variadic_via_fnptr.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002e3 <.text+0xc3>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %r11
               	leaq	0x10(%rbp), %r9
               	leaq	0x10(%r9), %r10
               	movq	%r10, (%r11)
               	leaq	-0x8(%rbp), %r8
               	movq	(%r8), %r9
               	leaq	0x10(%r9), %r11
               	movq	%r11, (%r8)
               	movslq	(%r9), %r8
               	leaq	-0x8(%rbp), %r9
               	movq	(%r9), %r11
               	leaq	0x10(%r11), %r10
               	movq	%r10, (%r9)
               	movslq	(%r11), %r9
               	leaq	-0x8(%rbp), %r11
               	movq	(%r11), %rdi
               	leaq	0x10(%rdi), %r10
               	movq	%r10, (%r11)
               	movslq	(%rdi), %r11
               	leaq	-0x8(%rbp), %rdi
               	movslq	0x10(%rbp), %rsi
               	movl	$0x3e8, %edi            # imm = 0x3E8
               	imulq	%rsi, %rdi
               	movslq	%edi, %rdi
               	movslq	%r8d, %rsi
               	movl	$0x64, %r8d
               	imulq	%rsi, %r8
               	movslq	%r8d, %r8
               	movq	%rdi, %rsi
               	addq	%r8, %rsi
               	movslq	%esi, %rsi
               	movslq	%r9d, %r8
               	movl	$0xa, %r9d
               	imulq	%r8, %r9
               	movslq	%r9d, %r9
               	movq	%rsi, %r8
               	addq	%r9, %r8
               	movslq	%r8d, %r8
               	movslq	%r11d, %r9
               	movq	%r8, %r11
               	addq	%r9, %r11
               	movslq	%r11d, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x9, %ebx
               	movl	$0x1, %r12d
               	movl	$0x2, %r14d
               	movl	$0x3, %r15d
               	subq	$0x10, %rsp
               	movq	%r15, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r14, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r12, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	0x400237 <.text+0x17>
               	addq	$0x40, %rsp
               	movq	%rax, %rsi
               	cmpq	$0x23a3, %rsi           # imm = 0x23A3
               	je	0x400387 <.text+0x167>
               	movl	$0xb, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x157(%rip), %rbx      # 0x400237 <.text+0x17>
               	movl	$0x9, %r15d
               	movl	$0x1, %r12d
               	movl	$0x2, %r10d
               	movq	%r10, 0x28(%rsp)
               	movl	$0x3, %r14d
               	movq	%rbx, %r11
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rsi
               	movq	0x28(%rsp), %rdx
               	callq	*%r11
               	movq	%rax, %rsi
               	cmpq	$0x23a3, %rsi           # imm = 0x23A3
               	je	0x4003f6 <.text+0x1d6>
               	movl	$0xc, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	callq	0x4002df <.text+0xbf>
               	movq	%rax, %r14
               	leaq	-0x1ce(%rip), %r15      # 0x400237 <.text+0x17>
               	movl	$0x9, %r14d
               	movl	$0x1, %ebx
               	movl	$0x2, %r10d
               	movq	%r10, 0x20(%rsp)
               	movl	$0x3, %r12d
               	movq	%r15, %r11
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rsi
               	movq	0x20(%rsp), %rdx
               	callq	*%r11
               	movq	%rax, %rsi
               	cmpq	$0x23a3, %rsi           # imm = 0x23A3
               	je	0x40046c <.text+0x24c>
               	movl	$0xd, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	orb	(%r9), %cl
               	jbe	0x4004cb <.text+0x2ab>
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
               	jae	0x400552 <.text+0x332>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400549 <.text+0x329>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40054d <.text+0x32d>
               	andb	%ch, 0x74(%rax)
               	je	0x40055d <.text+0x33d>
               	jae	0x400529 <.text+0x309>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400565 <.text+0x345>
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
               	callq	0x4005d7 <exit>
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
               	jbe	0x40058b <.text+0x36b>
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
               	jae	0x400612 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400609 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x40060d <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x40061d <exit+0x46>
               	jae	0x4005e9 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400625 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xfae3(%rip)           # 0x4100c0
