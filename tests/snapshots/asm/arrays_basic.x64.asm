
arrays_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002ab <.text+0x8b>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	xorq	%r8, %r8
               	movl	%r8d, -0x8(%rbp)
               	movl	%r8d, -0x10(%rbp)
               	jmp	0x400258 <.text+0x38>
               	movslq	-0x10(%rbp), %r8
               	cmpq	%r9, %r8
               	jge	0x40029e <.text+0x7e>
               	movslq	-0x8(%rbp), %r8
               	movslq	-0x10(%rbp), %rdi
               	movq	%rdi, %rsi
               	shlq	$0x2, %rsi
               	movq	%r11, %rdx
               	addq	%rsi, %rdx
               	movslq	(%rdx), %rsi
               	movq	%r8, %rdx
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	movl	%edx, -0x8(%rbp)
               	movq	%rdi, %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x10(%rbp)
               	jmp	0x400258 <.text+0x38>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x20(%rbp)
               	jmp	0x4002cb <.text+0xab>
               	movslq	-0x20(%rbp), %r11
               	cmpq	$0x5, %r11
               	jge	0x40031b <.text+0xfb>
               	leaq	-0x18(%rbp), %r11
               	movslq	-0x20(%rbp), %r9
               	movq	%r9, %r8
               	shlq	$0x2, %r8
               	movq	%r11, %rdi
               	addq	%r8, %rdi
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%rdi)
               	movslq	-0x20(%rbp), %r9
               	movq	%r9, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x20(%rbp)
               	jmp	0x4002cb <.text+0xab>
               	leaq	-0x18(%rbp), %rbx
               	movl	$0x5, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	cmpq	$0xf, %rdi
               	je	0x40035d <.text+0x13d>
               	movl	$0x1, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	je	0x40038a <.text+0x16a>
               	movl	$0x2, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movl	%r12d, -0x20(%rbp)
               	jmp	0x400396 <.text+0x176>
               	movslq	-0x20(%rbp), %r12
               	cmpq	$0x5, %r12
               	jge	0x4003e7 <.text+0x1c7>
               	leaq	0xfd22(%rip), %r12      # 0x4100d0
               	movslq	-0x20(%rbp), %rdi
               	movq	%rdi, %rbx
               	shlq	$0x2, %rbx
               	movq	%r12, %r11
               	addq	%rbx, %r11
               	movl	$0xa, %ebx
               	imulq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	movl	%ebx, (%r11)
               	movslq	-0x20(%rbp), %rdi
               	movq	%rdi, %rbx
               	addq	$0x1, %rbx
               	movslq	%ebx, %rbx
               	movl	%ebx, -0x20(%rbp)
               	jmp	0x400396 <.text+0x176>
               	leaq	0xfce2(%rip), %rbx      # 0x4100d0
               	movslq	(%rbx), %rdi
               	movq	%rbx, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r12
               	movq	%rdi, %r11
               	addq	%r12, %r11
               	movslq	%r11d, %r11
               	movq	%rbx, %r12
               	addq	$0x8, %r12
               	movslq	(%r12), %rdi
               	movq	%r11, %r12
               	addq	%rdi, %r12
               	movslq	%r12d, %r12
               	movq	%rbx, %rdi
               	addq	$0xc, %rdi
               	movslq	(%rdi), %r11
               	movq	%r12, %rdi
               	addq	%r11, %rdi
               	movslq	%edi, %rdi
               	movq	%rbx, %r11
               	addq	$0x10, %r11
               	movslq	(%r11), %rbx
               	movq	%rdi, %r11
               	addq	%rbx, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x64, %r11
               	je	0x400475 <.text+0x255>
               	movl	$0x3, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	je	0x4004a3 <.text+0x283>
               	movl	$0x4, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	je	0x4004d1 <.text+0x2b1>
               	movl	$0x5, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc10(%rip), %rbx      # 0x4100e8
               	xorq	%r11, %r11
               	movl	$0x68, %edi
               	movb	%dil, (%rbx)
               	movq	%rbx, %r12
               	addq	$0x1, %r12
               	movl	$0x69, %edi
               	movb	%dil, (%r12)
               	movq	%rbx, %rsi
               	addq	$0x2, %rsi
               	movb	%r11b, (%rsi)
               	movzbq	(%rbx), %rdi
               	movq	%rdi, %rbx
               	xorq	$0x68, %rbx
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%rbx, %rdi
               	cmpq	$0x0, %rdi
               	je	0x400543 <.text+0x323>
               	movl	$0x6, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb9e(%rip), %rbx      # 0x4100e8
               	movq	%rbx, %rdi
               	addq	$0x1, %rdi
               	movzbq	(%rdi), %rbx
               	movq	%rbx, %rdi
               	xorq	$0x69, %rdi
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%rdi, %rbx
               	cmpq	$0x0, %rbx
               	je	0x400594 <.text+0x374>
               	movl	$0x7, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb4d(%rip), %rdi      # 0x4100e8
               	movq	%rdi, %rbx
               	addq	$0x2, %rbx
               	movzbq	(%rbx), %rdi
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%rdi, %rbx
               	cmpq	$0x0, %rbx
               	je	0x4005db <.text+0x3bb>
               	movl	$0x8, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movl	%edi, -0x20(%rbp)
               	jmp	0x4005e6 <.text+0x3c6>
               	movslq	-0x20(%rbp), %rdi
               	cmpq	$0x3, %rdi
               	jge	0x400655 <.text+0x435>
               	leaq	-0x40(%rbp), %rdi
               	movslq	-0x20(%rbp), %rbx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movq	%rdi, %r11
               	addq	%rsi, %r11
               	movl	%ebx, (%r11)
               	leaq	-0x40(%rbp), %rsi
               	movslq	-0x20(%rbp), %r11
               	movq	%r11, %rbx
               	shlq	$0x3, %rbx
               	movq	%rsi, %rdi
               	addq	%rbx, %rdi
               	movq	%rdi, %rbx
               	addq	$0x4, %rbx
               	movl	$0x64, %edi
               	imulq	%r11, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, (%rbx)
               	movslq	-0x20(%rbp), %r11
               	movq	%r11, %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x20(%rbp)
               	jmp	0x4005e6 <.text+0x3c6>
               	leaq	-0x40(%rbp), %rdi
               	movslq	(%rdi), %r11
               	cmpq	$0x0, %r11
               	je	0x400687 <.text+0x467>
               	movl	$0x9, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rdi
               	movq	%rdi, %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %rdi
               	cmpq	$0x1, %rdi
               	je	0x4006c2 <.text+0x4a2>
               	movl	$0xa, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %r11
               	movq	%r11, %rdi
               	addq	$0x14, %rdi
               	movslq	(%rdi), %r11
               	cmpq	$0xc8, %r11
               	je	0x4006fe <.text+0x4de>
               	movl	$0xb, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	cmpq	$0x0, %rdi
               	je	0x40072c <.text+0x50c>
               	movl	$0xc, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rdi
               	movq	%rdi, %r11
               	addq	$0x20, %r11
               	xorq	%rdi, %rdi
               	movl	%edi, (%r11)
               	movl	%edi, -0x20(%rbp)
               	jmp	0x400748 <.text+0x528>
               	movslq	-0x20(%rbp), %rdi
               	cmpq	$0x8, %rdi
               	jge	0x4007da <.text+0x5ba>
               	leaq	-0x68(%rbp), %rdi
               	movslq	-0x20(%rbp), %rbx
               	movq	%rbx, %r11
               	shlq	$0x2, %r11
               	movq	%rdi, %rsi
               	addq	%r11, %rsi
               	movq	%rbx, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, (%rsi)
               	leaq	-0x68(%rbp), %rbx
               	movq	%rbx, %r11
               	addq	$0x20, %r11
               	leaq	-0x68(%rbp), %rbx
               	movq	%rbx, %rsi
               	addq	$0x20, %rsi
               	movslq	(%rsi), %rbx
               	leaq	-0x68(%rbp), %rsi
               	movslq	-0x20(%rbp), %rdi
               	movq	%rdi, %r12
               	shlq	$0x2, %r12
               	movq	%rsi, %rdi
               	addq	%r12, %rdi
               	movslq	(%rdi), %r12
               	movq	%rbx, %rdi
               	addq	%r12, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, (%r11)
               	movslq	-0x20(%rbp), %r12
               	movq	%r12, %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x20(%rbp)
               	jmp	0x400748 <.text+0x528>
               	leaq	-0x68(%rbp), %rdi
               	movq	%rdi, %r12
               	addq	$0x20, %r12
               	movslq	(%r12), %rdi
               	cmpq	$0x24, %rdi
               	je	0x400816 <.text+0x5f6>
               	movl	$0xd, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movl	%r12d, -0x20(%rbp)
               	jmp	0x400822 <.text+0x602>
               	movslq	-0x20(%rbp), %r12
               	cmpq	$0x8, %r12
               	jge	0x40086b <.text+0x64b>
               	leaq	-0x70(%rbp), %r12
               	movslq	-0x20(%rbp), %rdi
               	movq	%r12, %r11
               	addq	%rdi, %r11
               	movq	%rdi, %r12
               	addq	$0x41, %r12
               	movslq	%r12d, %r12
               	movb	%r12b, (%r11)
               	movslq	-0x20(%rbp), %rdi
               	movq	%rdi, %r12
               	addq	$0x1, %r12
               	movslq	%r12d, %r12
               	movl	%r12d, -0x20(%rbp)
               	jmp	0x400822 <.text+0x602>
               	leaq	-0x70(%rbp), %r12
               	movzbq	(%r12), %rdi
               	movq	%rdi, %r12
               	xorq	$0x41, %r12
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r12, %rdi
               	cmpq	$0x0, %rdi
               	je	0x4008b0 <.text+0x690>
               	movl	$0xe, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x70(%rbp), %r12
               	movq	%r12, %rdi
               	addq	$0x7, %rdi
               	movzbq	(%rdi), %r12
               	movq	%r12, %rdi
               	xorq	$0x48, %rdi
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rdi, %r12
               	cmpq	$0x0, %r12
               	je	0x400900 <.text+0x6e0>
               	movl	$0xf, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rdi
               	movq	%rdi, %r12
               	addq	$0x8, %r12
               	movslq	(%r12), %rdi
               	movq	%r12, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %rbx
               	movq	%rdi, %r11
               	addq	%rbx, %r11
               	movslq	%r11d, %r11
               	movq	%r12, %rbx
               	addq	$0x8, %rbx
               	movslq	(%rbx), %r12
               	movq	%r11, %rbx
               	addq	%r12, %rbx
               	movslq	%ebx, %rbx
               	movslq	%ebx, %r12
               	cmpq	$0xc, %r12
               	je	0x40096c <.text+0x74c>
               	movl	$0x10, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x4009bf <.text+0x79f>
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
               	jae	0x400a46 <.text+0x826>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400a3d <.text+0x81d>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400a41 <.text+0x821>
               	andb	%ch, 0x74(%rax)
               	je	0x400a51 <.text+0x831>
               	jae	0x400a1d <.text+0x7fd>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400a59 <.text+0x839>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%dl, 0x48(%rbp)
               	movl	%esp, %ebp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400ac7 <exit>
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
               	jbe	0x400a7b <.text+0x85b>
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
               	jae	0x400b02 <exit+0x3b>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400af9 <exit+0x32>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400afd <exit+0x36>
               	andb	%ch, 0x74(%rax)
               	je	0x400b0d <exit+0x46>
               	jae	0x400ad9 <exit+0x12>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400b15 <exit+0x4e>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<exit>:
               	jmpq	*0xf5f3(%rip)           # 0x4100c0
