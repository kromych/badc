
ternary_middle_comma.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400410 <.text+0x150>
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
               	callq	0x400c97 <dlsym>
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x110, %rsp            # imm = 0x110
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	-0x8(%rbp), %r11
               	leaq	0xfd17(%rip), %r9       # 0x410150
               	pushq	%rax
               	movzbq	(%r9), %rax
               	movb	%al, (%r11)
               	movzbq	0x1(%r9), %rax
               	movb	%al, 0x1(%r11)
               	movzbq	0x2(%r9), %rax
               	movb	%al, 0x2(%r11)
               	movzbq	0x3(%r9), %rax
               	movb	%al, 0x3(%r11)
               	popq	%rax
               	movq	%r11, %r8
               	movl	$0x2a, %r10d
               	movq	%r10, 0x28(%rsp)
               	movq	0x28(%rsp), %r9
               	movslq	%r9d, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r9, %r11
               	cmpq	$0x80, %r11
               	jae	0x4004b4 <.text+0x1f4>
               	leaq	-0x8(%rbp), %r11
               	movq	0x28(%rsp), %r9
               	movslq	%r9d, %r9
               	movq	%r9, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r11)
               	movl	$0x1, %r9d
               	movq	%r9, -0x88(%rbp)
               	jmp	0x4004c6 <.text+0x206>
               	movl	$0x63, %r9d
               	movq	%r9, -0x88(%rbp)
               	jmp	0x4004c6 <.text+0x206>
               	movq	-0x88(%rbp), %r9
               	movslq	%r9d, %rdi
               	cmpq	$0x1, %rdi
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x90(%rbp)
               	cmpq	$0x0, %r11
               	jne	0x400529 <.text+0x269>
               	leaq	-0x8(%rbp), %rdi
               	movzbq	(%rdi), %r11
               	movq	%r11, %rdi
               	xorq	$0x2a, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%rdi, %r11
               	cmpq	$0x0, %r11
               	setne	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x90(%rbp)
               	jmp	0x400529 <.text+0x269>
               	movq	-0x90(%rbp), %rdi
               	cmpq	$0x0, %rdi
               	je	0x40058d <.text+0x2cd>
               	leaq	0xfc10(%rip), %r12      # 0x410154
               	movslq	%r9d, %r14
               	leaq	-0x8(%rbp), %r9
               	movzbq	(%r9), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400c9d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	movl	$0x1, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r15
               	leaq	0xfbd2(%rip), %r9       # 0x41016a
               	pushq	%rax
               	movzbq	(%r9), %rax
               	movb	%al, (%r15)
               	movzbq	0x1(%r9), %rax
               	movb	%al, 0x1(%r15)
               	movzbq	0x2(%r9), %rax
               	movb	%al, 0x2(%r15)
               	movzbq	0x3(%r9), %rax
               	movb	%al, 0x3(%r15)
               	popq	%rax
               	movq	%r15, %r14
               	movq	0x28(%rsp), %r14
               	movslq	%r14d, %r14
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r14, %r9
               	cmpq	$0x80, %r9
               	jae	0x400608 <.text+0x348>
               	leaq	-0x20(%rbp), %r9
               	movq	0x28(%rsp), %r14
               	movslq	%r14d, %r14
               	movq	%r14, %r15
               	andq	$0xff, %r15
               	movb	%r15b, (%r9)
               	movl	$0x1, %r14d
               	movq	%r14, -0x98(%rbp)
               	jmp	0x40061a <.text+0x35a>
               	movl	$0x63, %r14d
               	movq	%r14, -0x98(%rbp)
               	jmp	0x40061a <.text+0x35a>
               	movq	-0x98(%rbp), %r14
               	movslq	%r14d, %r15
               	cmpq	$0x1, %r15
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0xa0(%rbp)
               	cmpq	$0x0, %r9
               	jne	0x40067d <.text+0x3bd>
               	leaq	-0x20(%rbp), %r15
               	movzbq	(%r15), %r9
               	movq	%r9, %r15
               	xorq	$0x2a, %r15
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r15, %r9
               	cmpq	$0x0, %r9
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xa0(%rbp)
               	jmp	0x40067d <.text+0x3bd>
               	movq	-0xa0(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x4006e1 <.text+0x421>
               	leaq	0xfad6(%rip), %r12      # 0x41016e
               	movslq	%r14d, %r15
               	leaq	-0x20(%rbp), %r14
               	movzbq	(%r14), %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x400c9d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movl	$0x2, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rbx
               	leaq	0xfa98(%rip), %r14      # 0x410184
               	pushq	%rax
               	movzbq	(%r14), %rax
               	movb	%al, (%rbx)
               	movzbq	0x1(%r14), %rax
               	movb	%al, 0x1(%rbx)
               	movzbq	0x2(%r14), %rax
               	movb	%al, 0x2(%rbx)
               	movzbq	0x3(%r14), %rax
               	movb	%al, 0x3(%rbx)
               	popq	%rax
               	movq	%rbx, %r15
               	movq	0x28(%rsp), %r15
               	movslq	%r15d, %r15
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%r15, %r14
               	cmpq	$0x80, %r14
               	jae	0x40075c <.text+0x49c>
               	leaq	-0x30(%rbp), %r14
               	movq	0x28(%rsp), %r15
               	movslq	%r15d, %r15
               	movq	%r15, %rbx
               	andq	$0xff, %rbx
               	movb	%bl, (%r14)
               	movl	$0x1, %r15d
               	movq	%r15, -0xa8(%rbp)
               	jmp	0x40076e <.text+0x4ae>
               	movl	$0x63, %r15d
               	movq	%r15, -0xa8(%rbp)
               	jmp	0x40076e <.text+0x4ae>
               	movq	-0xa8(%rbp), %r15
               	movslq	%r15d, %rbx
               	cmpq	$0x1, %rbx
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xb0(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x4007d1 <.text+0x511>
               	leaq	-0x30(%rbp), %rbx
               	movzbq	(%rbx), %r14
               	movq	%r14, %rbx
               	xorq	$0x2a, %rbx
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r14
               	cmpq	$0x0, %r14
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xb0(%rbp)
               	jmp	0x4007d1 <.text+0x511>
               	movq	-0xb0(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	0x400835 <.text+0x575>
               	leaq	0xf99c(%rip), %r12      # 0x410188
               	movslq	%r15d, %r14
               	leaq	-0x30(%rbp), %r15
               	movzbq	(%r15), %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400c9d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movl	$0x3, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x40(%rbp)
               	movl	%ebx, -0x48(%rbp)
               	movl	%ebx, -0x50(%rbp)
               	movq	0x28(%rsp), %r15
               	movslq	%r15d, %r15
               	cmpq	$0x0, %r15
               	jle	0x40089c <.text+0x5dc>
               	movl	$0x1, %r15d
               	movl	%r15d, -0x40(%rbp)
               	movl	$0x2, %ebx
               	movl	%ebx, -0x48(%rbp)
               	movl	$0x3, %r15d
               	movl	%r15d, -0x50(%rbp)
               	movslq	-0x40(%rbp), %rbx
               	movslq	-0x48(%rbp), %r15
               	movq	%rbx, %r14
               	addq	%r15, %r14
               	movslq	%r14d, %r14
               	movslq	-0x50(%rbp), %r15
               	movq	%r14, %rbx
               	addq	%r15, %rbx
               	movslq	%ebx, %rbx
               	movq	%rbx, -0xb8(%rbp)
               	jmp	0x4008b2 <.text+0x5f2>
               	movabsq	$-0x1, %rbx
               	movq	%rbx, -0xb8(%rbp)
               	jmp	0x4008b2 <.text+0x5f2>
               	movq	-0xb8(%rbp), %rbx
               	movslq	%ebx, %r15
               	cmpq	$0x6, %r15
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xd0(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x4008fe <.text+0x63e>
               	movslq	-0x40(%rbp), %r15
               	cmpq	$0x1, %r15
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xd0(%rbp)
               	jmp	0x4008fe <.text+0x63e>
               	movq	-0xd0(%rbp), %r14
               	movq	%r14, -0xc8(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x400938 <.text+0x678>
               	movslq	-0x48(%rbp), %r15
               	cmpq	$0x2, %r15
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xc8(%rbp)
               	jmp	0x400938 <.text+0x678>
               	movq	-0xc8(%rbp), %r14
               	movq	%r14, -0xc0(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x400972 <.text+0x6b2>
               	movslq	-0x50(%rbp), %r15
               	cmpq	$0x3, %r15
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xc0(%rbp)
               	jmp	0x400972 <.text+0x6b2>
               	movq	-0xc0(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x4009e7 <.text+0x727>
               	leaq	0xf811(%rip), %r12      # 0x41019e
               	movslq	%ebx, %r15
               	movslq	-0x40(%rbp), %r14
               	movslq	-0x48(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movslq	-0x50(%rbp), %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %r8
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	movq	0x20(%rsp), %rcx
               	movb	$0x0, %al
               	callq	0x400c9d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	movl	$0x4, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rbx
               	leaq	0xf7c9(%rip), %r9       # 0x4101bb
               	pushq	%rax
               	movzbq	(%r9), %rax
               	movb	%al, (%rbx)
               	movzbq	0x1(%r9), %rax
               	movb	%al, 0x1(%rbx)
               	movzbq	0x2(%r9), %rax
               	movb	%al, 0x2(%rbx)
               	movzbq	0x3(%r9), %rax
               	movb	%al, 0x3(%rbx)
               	popq	%rax
               	movq	%rbx, %r14
               	movl	$0xc8, %r14d
               	movslq	%r14d, %r9
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r9, %rbx
               	cmpq	$0x80, %rbx
               	jae	0x400a5d <.text+0x79d>
               	leaq	-0x60(%rbp), %rbx
               	movslq	%r14d, %r9
               	movq	%r9, %r14
               	andq	$0xff, %r14
               	movb	%r14b, (%rbx)
               	movl	$0x1, %r9d
               	movq	%r9, -0xd8(%rbp)
               	jmp	0x400a6f <.text+0x7af>
               	movl	$0x63, %r9d
               	movq	%r9, -0xd8(%rbp)
               	jmp	0x400a6f <.text+0x7af>
               	movq	-0xd8(%rbp), %r9
               	movslq	%r9d, %r14
               	cmpq	$0x63, %r14
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xe0(%rbp)
               	cmpq	$0x0, %rbx
               	jne	0x400ac8 <.text+0x808>
               	leaq	-0x60(%rbp), %r14
               	movzbq	(%r14), %rbx
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r14
               	cmpq	$0x0, %r14
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xe0(%rbp)
               	jmp	0x400ac8 <.text+0x808>
               	movq	-0xe0(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	0x400b2c <.text+0x86c>
               	leaq	0xf6dc(%rip), %r12      # 0x4101bf
               	movslq	%r9d, %r14
               	leaq	-0x60(%rbp), %r9
               	movzbq	(%r9), %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x400c9d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	movl	$0x5, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	orb	(%r9), %cl
               	jbe	0x400b8b <.text+0x8cb>
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
               	jae	0x400c12 <.text+0x952>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400c09 <.text+0x949>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400c0d <.text+0x94d>
               	andb	%ch, 0x74(%rax)
               	je	0x400c1d <.text+0x95d>
               	jae	0x400be9 <.text+0x929>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400c25 <.text+0x965>
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
               	callq	0x400ca3 <exit>
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
               	jbe	0x400c4b <.text+0x98b>
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
               	jae	0x400cd2 <exit+0x2f>
               	<unknown>
               	orb	(%rcx), %cl
               	jb	0x400cc9 <exit+0x26>
               	insl	%dx, %es:(%rdi)
               	outsl	(%rsi), %dx
               	je	0x400ccd <exit+0x2a>
               	andb	%ch, 0x74(%rax)
               	je	0x400cdd <exit+0x3a>
               	jae	0x400ca9 <exit+0x6>
               	<unknown>
               	<unknown>
               	imull	$0x6f632e62, 0x75(%eax,%ebp,2), %esi # imm = 0x6F632E62
               	insl	%dx, %es:(%rdi)
               	<unknown>
               	imull	$0x6d, 0x6f(%rdx), %esi
               	jns	0x400ce5 <exit+0x42>
               	pushq	$0x6461622f             # imm = 0x6461622F
               	movslq	(%rsi), %ebp
               	imull	$0x0, (%eax,%eax), %esi
               	addb	%al, (%rax)
               	addb	%al, (%rax)
               	addb	%bh, %bh

<dlsym>:
               	jmpq	*0xf443(%rip)           # 0x4100e0

<printf>:
               	jmpq	*0xf445(%rip)           # 0x4100e8

<exit>:
               	jmpq	*0xf447(%rip)           # 0x4100f0
