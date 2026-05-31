
three_dim_array_indexing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40045d <.text+0x19d>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100f0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe06(%rip), %r9       # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40034b <.text+0x8b>
               	leaq	0xfde2(%rip), %rdi      # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%rdi, %r9
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	0xfdbf(%rip), %rdi      # 0x410118
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfdad(%rip), %rsi      # 0x41011e
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfd9c(%rip), %r9       # 0x410125
               	movq	%r9, (%rsi)
               	leaq	-0x18(%rbp), %rdi
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	movq	%rdi, %rsi
               	addq	%r9, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400887 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x4003dc <.text+0x11c>
               	leaq	0xfd3c(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x4003dc <.text+0x11c>
               	leaq	0xfd1d(%rip), %r12      # 0x410100
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movq	%r12, %rbx
               	addq	%rsi, %rbx
               	movq	(%rbx), %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %r11
               	movzbq	(%r11), %r9
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %rdi
               	movq	%r9, %r8
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	movq	%r11, %rdi
               	addq	$0x2, %rdi
               	movzbq	(%rdi), %r9
               	movq	%r8, %rdi
               	addq	%r9, %rdi
               	movslq	%edi, %rdi
               	movq	%r11, %r9
               	addq	$0x3, %r9
               	movzbq	(%r9), %r11
               	movq	%rdi, %r9
               	addq	%r11, %r9
               	movslq	%r9d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	0xfcd8(%rip), %rbx      # 0x410150
               	movq	%rbx, %rdi
               	callq	0x400410 <.text+0x150>
               	movq	%rax, %r9
               	movl	$0x3, %ebx
               	movslq	%ebx, %rbx
               	movq	%rbx, %r8
               	addq	$0x3, %r8
               	movslq	%r8d, %r8
               	movq	%r8, %rbx
               	addq	$0x4, %rbx
               	movslq	%ebx, %rbx
               	cmpq	%rbx, %r9
               	je	0x4004cb <.text+0x20b>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc7e(%rip), %r8       # 0x410150
               	movq	%r8, %r12
               	addq	$0x8, %r12
               	movq	%r12, %rdi
               	callq	0x400410 <.text+0x150>
               	movq	%rax, %r8
               	movl	$0x13, %r12d
               	movslq	%r12d, %r12
               	movq	%r12, %r9
               	addq	$0xb, %r9
               	movslq	%r9d, %r9
               	movq	%r9, %r12
               	addq	$0xc, %r12
               	movslq	%r12d, %r12
               	cmpq	%r12, %r8
               	je	0x400531 <.text+0x271>
               	movl	$0x2, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc18(%rip), %r9       # 0x410150
               	movq	%r9, %rbx
               	addq	$0x10, %rbx
               	movq	%rbx, %rdi
               	callq	0x400410 <.text+0x150>
               	movq	%rax, %r9
               	movl	$0x23, %ebx
               	movslq	%ebx, %rbx
               	movq	%rbx, %r8
               	addq	$0x13, %r8
               	movslq	%r8d, %r8
               	movq	%r8, %rbx
               	addq	$0x14, %rbx
               	movslq	%ebx, %rbx
               	cmpq	%rbx, %r9
               	je	0x400595 <.text+0x2d5>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfbb4(%rip), %r8       # 0x410150
               	movzbq	(%r8), %rbx
               	movq	%rbx, %r8
               	xorq	$0x1, %r8
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r8, %rbx
               	cmpq	$0x0, %rbx
               	je	0x4005dc <.text+0x31c>
               	movl	$0x4, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb6d(%rip), %r8       # 0x410150
               	movq	%r8, %rbx
               	addq	$0xb, %rbx
               	movzbq	(%rbx), %r8
               	movq	%r8, %rbx
               	xorq	$0xc, %rbx
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rbx, %r8
               	cmpq	$0x0, %r8
               	je	0x40062f <.text+0x36f>
               	movl	$0x5, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb1a(%rip), %rbx      # 0x410150
               	movq	%rbx, %r8
               	addq	$0x17, %r8
               	movzbq	(%r8), %rbx
               	movq	%rbx, %r8
               	xorq	$0x18, %r8
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r8, %rbx
               	cmpq	$0x0, %rbx
               	je	0x400680 <.text+0x3c0>
               	movl	$0x6, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfac9(%rip), %r8       # 0x410150
               	movq	%r8, %rbx
               	addq	$0xc, %rbx
               	movzbq	(%rbx), %r9
               	movzbq	(%r8), %rbx
               	movq	%r9, %r8
               	subq	%rbx, %r8
               	movslq	%r8d, %r8
               	cmpq	$0xc, %r8
               	je	0x4006cd <.text+0x40d>
               	movl	$0x7, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfa7c(%rip), %rbx      # 0x410150
               	movq	%rbx, %r8
               	addq	$0x4, %r8
               	movzbq	(%r8), %r9
               	movzbq	(%rbx), %r8
               	movq	%r9, %rbx
               	subq	%r8, %rbx
               	movslq	%ebx, %rbx
               	cmpq	$0x4, %rbx
               	je	0x400719 <.text+0x459>
               	movl	$0x8, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfa48(%rip), %r12      # 0x410168
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x40088d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	orb	(%r9), %cl
               	jbe	0x400783 <.text+0x4c3>
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
               	jae	0x40080a <.text+0x54a>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400801 <.text+0x541>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400805 <.text+0x545>
               	andb	%ch, 0x74(%rax)
               	je	0x400815 <.text+0x555>
               	jae	0x4007e1 <.text+0x521>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x40081d <.text+0x55d>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x89485500, (%eax,%eax), %esi # imm = 0x89485500
               	inl	$0x48, %eax
               	subl	$0x10, %esp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400893 <exit>
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
               	jbe	0x40083b <.text+0x57b>
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
               	jae	0x4008c2 <exit+0x2f>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x4008b9 <exit+0x26>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x4008bd <exit+0x2a>
               	andb	%ch, 0x74(%rax)
               	je	0x4008cd <exit+0x3a>
               	jae	0x400899 <exit+0x6>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x4008d5 <exit+0x42>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<dlsym>:
               	jmpq	*0xf853(%rip)           # 0x4100e0

<printf>:
               	jmpq	*0xf855(%rip)           # 0x4100e8

<exit>:
               	jmpq	*0xf857(%rip)           # 0x4100f0
