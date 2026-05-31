
c4.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x404c0c <.text+0x47ac>
               	movq	%rax, %rdi
               	callq	*0xfc81(%rip)           # 0x4100f8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfc9e(%rip), %r9       # 0x410138
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x4004eb <.text+0x8b>
               	leaq	0xfc7a(%rip), %rdi      # 0x410138
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
               	leaq	0xfc57(%rip), %rdi      # 0x410150
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfc45(%rip), %rsi      # 0x410156
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfc34(%rip), %r9       # 0x41015d
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
               	callq	0x407037 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x400579 <.text+0x119>
               	leaq	0xfbd7(%rip), %r14      # 0x410138
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x400579 <.text+0x119>
               	leaq	0xfbb8(%rip), %r12      # 0x410138
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	movq	%r12, %rbx
               	addq	%rax, %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x170, %rsp            # imm = 0x170
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	jmp	0x4005d0 <.text+0x170>
               	leaq	0xfbe9(%rip), %r11      # 0x4101c0
               	leaq	0xfbaa(%rip), %r9       # 0x410188
               	movq	(%r9), %r8
               	movzbq	(%r8), %r9
               	movq	%r9, (%r11)
               	cmpq	$0x0, %r9
               	je	0x400628 <.text+0x1c8>
               	leaq	0xfb8c(%rip), %r8       # 0x410188
               	movq	(%r8), %r9
               	movq	%r9, %r11
               	addq	$0x1, %r11
               	movq	%r11, (%r8)
               	leaq	0xfbad(%rip), %r9       # 0x4101c0
               	movq	(%r9), %r11
               	cmpq	$0xa, %r11
               	jne	0x40066e <.text+0x20e>
               	jmp	0x40064d <.text+0x1ed>
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xfb94(%rip), %r11      # 0x4101e8
               	movq	(%r11), %r9
               	cmpq	$0x0, %r9
               	je	0x4006fc <.text+0x29c>
               	jmp	0x40068a <.text+0x22a>
               	jmp	0x4005d0 <.text+0x170>
               	leaq	0xfb4b(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x23, %rax
               	jne	0x4007fa <.text+0x39a>
               	jmp	0x4007f0 <.text+0x390>
               	leaq	0xfb67(%rip), %rbx      # 0x4101f8
               	leaq	0xfb48(%rip), %r9       # 0x4101e0
               	movq	(%r9), %r12
               	leaq	0xfae6(%rip), %r10      # 0x410188
               	movq	%r10, 0x20(%rsp)
               	movq	0x20(%rsp), %r10
               	movq	(%r10), %rdi
               	leaq	0xfada(%rip), %r10      # 0x410190
               	movq	%r10, 0x28(%rsp)
               	movq	0x28(%rsp), %r10
               	movq	(%r10), %rdx
               	movq	%rdi, %r15
               	subq	%rdx, %r15
               	movq	0x28(%rsp), %r10
               	movq	(%r10), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movq	0x20(%rsp), %r10
               	movq	(%r10), %rax
               	movq	0x28(%rsp), %r11
               	movq	%rax, (%r11)
               	jmp	0x40071a <.text+0x2ba>
               	leaq	0xfadd(%rip), %r12      # 0x4101e0
               	movq	(%r12), %rax
               	movq	%rax, %r14
               	addq	$0x1, %r14
               	movq	%r14, (%r12)
               	jmp	0x400669 <.text+0x209>
               	leaq	0xfa87(%rip), %rax      # 0x4101a8
               	movq	(%rax), %r14
               	leaq	0xfa75(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r15
               	cmpq	%r15, %r14
               	jge	0x400797 <.text+0x337>
               	leaq	0xfac3(%rip), %rbx      # 0x410201
               	leaq	0xfac2(%rip), %rax      # 0x410207
               	leaq	0xfa5c(%rip), %r15      # 0x4101a8
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movq	(%r14), %r12
               	movl	$0x5, %r14d
               	imulq	%r12, %r14
               	movq	%rax, %r12
               	addq	%r14, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movq	(%r15), %rax
               	movq	(%rax), %r15
               	cmpq	$0x7, %r15
               	jg	0x4007d7 <.text+0x377>
               	jmp	0x40079c <.text+0x33c>
               	jmp	0x4006fc <.text+0x29c>
               	leaq	0xfb28(%rip), %r14      # 0x4102cb
               	leaq	0xf9fe(%rip), %rax      # 0x4101a8
               	movq	(%rax), %r12
               	movq	%r12, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%rax)
               	movq	(%rbx), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	jmp	0x4007d2 <.text+0x372>
               	jmp	0x40071a <.text+0x2ba>
               	leaq	0xfaf2(%rip), %r12      # 0x4102d0
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	jmp	0x4007d2 <.text+0x372>
               	jmp	0x40082a <.text+0x3ca>
               	jmp	0x400669 <.text+0x209>
               	leaq	0xf9bf(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x61, %rax
               	setge	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	cmpq	$0x0, %r12
               	je	0x4008f8 <.text+0x498>
               	jmp	0x4008d6 <.text+0x476>
               	leaq	0xf957(%rip), %rax      # 0x410188
               	movq	(%rax), %r14
               	movzbq	(%r14), %rax
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rax, %r14
               	cmpq	$0x0, %r14
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x30(%rbp)
               	cmpq	$0x0, %rax
               	je	0x4008c0 <.text+0x460>
               	jmp	0x400887 <.text+0x427>
               	leaq	0xf91b(%rip), %r14      # 0x410188
               	movq	(%r14), %rax
               	movq	%rax, %r12
               	addq	$0x1, %r12
               	movq	%r12, (%r14)
               	jmp	0x40082a <.text+0x3ca>
               	jmp	0x4007f5 <.text+0x395>
               	leaq	0xf8fa(%rip), %r14      # 0x410188
               	movq	(%r14), %rax
               	movzbq	(%rax), %r14
               	movq	%r14, %rax
               	xorq	$0xa, %rax
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rax, %r14
               	cmpq	$0x0, %r14
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x30(%rbp)
               	jmp	0x4008c0 <.text+0x460>
               	movq	-0x30(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x400882 <.text+0x422>
               	jmp	0x400866 <.text+0x406>
               	leaq	0xf8e3(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x7a, %r12
               	setle	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	0x4008f8 <.text+0x498>
               	movq	-0x48(%rbp), %rax
               	movq	%rax, -0x40(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x40093d <.text+0x4dd>
               	leaq	0xf8ac(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x41, %rax
               	setge	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x50(%rbp)
               	cmpq	$0x0, %r12
               	je	0x400979 <.text+0x519>
               	jmp	0x400957 <.text+0x4f7>
               	movq	-0x40(%rbp), %rax
               	movq	%rax, -0x38(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4009a9 <.text+0x549>
               	jmp	0x400986 <.text+0x526>
               	leaq	0xf862(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x5a, %r12
               	setle	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x50(%rbp)
               	jmp	0x400979 <.text+0x519>
               	movq	-0x50(%rbp), %rax
               	movq	%rax, -0x40(%rbp)
               	jmp	0x40093d <.text+0x4dd>
               	leaq	0xf833(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x5f, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x38(%rbp)
               	jmp	0x4009a9 <.text+0x549>
               	movq	-0x38(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x4009d8 <.text+0x578>
               	leaq	0xf7c7(%rip), %rax      # 0x410188
               	movq	(%rax), %r12
               	movq	%r12, %r15
               	subq	$0x1, %r15
               	jmp	0x400a0a <.text+0x5aa>
               	jmp	0x4007f5 <.text+0x395>
               	leaq	0xf7e1(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r12
               	cmpq	$0x30, %r12
               	setge	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x90(%rbp)
               	cmpq	$0x0, %r14
               	je	0x400dfd <.text+0x99d>
               	jmp	0x400dd7 <.text+0x977>
               	leaq	0xf777(%rip), %r12      # 0x410188
               	movq	(%r12), %r14
               	movzbq	(%r14), %r12
               	cmpq	$0x61, %r12
               	setge	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x70(%rbp)
               	cmpq	$0x0, %r14
               	je	0x400ae6 <.text+0x686>
               	jmp	0x400abf <.text+0x65f>
               	leaq	0xf77b(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	movl	$0x93, %ebx
               	imulq	%r14, %rbx
               	leaq	0xf72f(%rip), %r14      # 0x410188
               	movq	(%r14), %rax
               	movq	%rax, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%r14)
               	movzbq	(%rax), %rcx
               	movq	%rbx, %rax
               	addq	%rcx, %rax
               	movq	%rax, (%r12)
               	jmp	0x400a0a <.text+0x5aa>
               	leaq	0xf73d(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rcx
               	movq	%rcx, %r12
               	shlq	$0x6, %r12
               	leaq	0xf6f4(%rip), %rcx      # 0x410188
               	movq	(%rcx), %rbx
               	movq	%rbx, %rcx
               	subq	%r15, %rcx
               	movq	%r12, %rbx
               	addq	%rcx, %rbx
               	movq	%rbx, (%rax)
               	leaq	0xf703(%rip), %rcx      # 0x4101b0
               	leaq	0xf704(%rip), %rbx      # 0x4101b8
               	movq	(%rbx), %rax
               	movq	%rax, (%rcx)
               	jmp	0x400c4f <.text+0x7ef>
               	leaq	0xf6c2(%rip), %r12      # 0x410188
               	movq	(%r12), %r14
               	movzbq	(%r14), %r12
               	cmpq	$0x7a, %r12
               	setle	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x70(%rbp)
               	jmp	0x400ae6 <.text+0x686>
               	movq	-0x70(%rbp), %r14
               	movq	%r14, -0x68(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x400b2f <.text+0x6cf>
               	leaq	0xf686(%rip), %r12      # 0x410188
               	movq	(%r12), %r14
               	movzbq	(%r14), %r12
               	cmpq	$0x41, %r12
               	setge	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x78(%rbp)
               	cmpq	$0x0, %r14
               	je	0x400b70 <.text+0x710>
               	jmp	0x400b49 <.text+0x6e9>
               	movq	-0x68(%rbp), %r14
               	movq	%r14, -0x60(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x400bb1 <.text+0x751>
               	jmp	0x400b7d <.text+0x71d>
               	leaq	0xf638(%rip), %r12      # 0x410188
               	movq	(%r12), %r14
               	movzbq	(%r14), %r12
               	cmpq	$0x5a, %r12
               	setle	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x78(%rbp)
               	jmp	0x400b70 <.text+0x710>
               	movq	-0x78(%rbp), %r14
               	movq	%r14, -0x68(%rbp)
               	jmp	0x400b2f <.text+0x6cf>
               	leaq	0xf604(%rip), %r12      # 0x410188
               	movq	(%r12), %r14
               	movzbq	(%r14), %r12
               	cmpq	$0x30, %r12
               	setge	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x80(%rbp)
               	cmpq	$0x0, %r14
               	je	0x400bf2 <.text+0x792>
               	jmp	0x400bcb <.text+0x76b>
               	movq	-0x60(%rbp), %r14
               	movq	%r14, -0x58(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x400c39 <.text+0x7d9>
               	jmp	0x400bff <.text+0x79f>
               	leaq	0xf5b6(%rip), %r12      # 0x410188
               	movq	(%r12), %r14
               	movzbq	(%r14), %r12
               	cmpq	$0x39, %r12
               	setle	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x80(%rbp)
               	jmp	0x400bf2 <.text+0x792>
               	movq	-0x80(%rbp), %r14
               	movq	%r14, -0x60(%rbp)
               	jmp	0x400bb1 <.text+0x751>
               	leaq	0xf582(%rip), %r12      # 0x410188
               	movq	(%r12), %r14
               	movzbq	(%r14), %r12
               	movq	%r12, %r14
               	xorq	$0x5f, %r14
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r14, %r12
               	cmpq	$0x0, %r12
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x58(%rbp)
               	jmp	0x400c39 <.text+0x7d9>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x400a7c <.text+0x61c>
               	jmp	0x400a3e <.text+0x5de>
               	leaq	0xf55a(%rip), %rax      # 0x4101b0
               	movq	(%rax), %rbx
               	movq	(%rbx), %rax
               	cmpq	$0x0, %rax
               	je	0x400cae <.text+0x84e>
               	leaq	0xf550(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %rax
               	leaq	0xf536(%rip), %rbx      # 0x4101b0
               	movq	(%rbx), %rcx
               	movq	%rcx, %rbx
               	addq	$0x8, %rbx
               	movq	(%rbx), %rcx
               	cmpq	%rcx, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x88(%rbp)
               	cmpq	$0x0, %rbx
               	je	0x400d6b <.text+0x90b>
               	jmp	0x400d16 <.text+0x8b6>
               	leaq	0xf4fb(%rip), %r12      # 0x4101b0
               	movq	(%r12), %rbx
               	movq	%rbx, %r14
               	addq	$0x10, %r14
               	movq	%r15, (%r14)
               	movq	(%r12), %rbx
               	movq	%rbx, %r14
               	addq	$0x8, %r14
               	leaq	0xf4e5(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	movq	%r15, (%r14)
               	movq	(%r12), %rax
               	xorq	%r12, %r12
               	movl	$0x85, %r15d
               	movq	%r15, (%rax)
               	movq	%r15, (%rbx)
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xf493(%rip), %rcx      # 0x4101b0
               	movq	(%rcx), %rbx
               	movq	%rbx, %rcx
               	addq	$0x10, %rcx
               	movq	(%rcx), %r14
               	leaq	0xf454(%rip), %rcx      # 0x410188
               	movq	(%rcx), %rax
               	movq	%rax, %rbx
               	subq	%r15, %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x407043 <memcmp>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x88(%rbp)
               	jmp	0x400d6b <.text+0x90b>
               	movq	-0x88(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	0x400dbb <.text+0x95b>
               	leaq	0xf43a(%rip), %rax      # 0x4101c0
               	leaq	0xf423(%rip), %rbx      # 0x4101b0
               	movq	(%rbx), %r14
               	xorq	%rbx, %rbx
               	movq	(%r14), %r12
               	movq	%r12, (%rax)
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xf3ee(%rip), %r14      # 0x4101b0
               	movq	(%r14), %rbx
               	movq	%rbx, %r12
               	addq	$0x48, %r12
               	movq	%r12, (%r14)
               	jmp	0x400c4f <.text+0x7ef>
               	leaq	0xf3e2(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	cmpq	$0x39, %r14
               	setle	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x90(%rbp)
               	jmp	0x400dfd <.text+0x99d>
               	movq	-0x90(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x400e47 <.text+0x9e7>
               	leaq	0xf3b0(%rip), %r14      # 0x4101c8
               	leaq	0xf3a1(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	movq	%r15, %r12
               	subq	$0x30, %r12
               	movq	%r12, (%r14)
               	cmpq	$0x0, %r12
               	je	0x400e9d <.text+0xa3d>
               	jmp	0x400e63 <.text+0xa03>
               	jmp	0x4009d3 <.text+0x573>
               	leaq	0xf372(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x2f, %r15
               	jne	0x40134e <.text+0xeee>
               	jmp	0x401316 <.text+0xeb6>
               	jmp	0x400ee5 <.text+0xa85>
               	leaq	0xf351(%rip), %r12      # 0x4101c0
               	movl	$0x80, %ebx
               	movq	%rbx, (%r12)
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xf2e4(%rip), %rdi      # 0x410188
               	movq	(%rdi), %rbx
               	movzbq	(%rbx), %rdi
               	movq	%rdi, %rbx
               	xorq	$0x78, %rbx
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%rbx, %rdi
               	cmpq	$0x0, %rdi
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xa0(%rbp)
               	cmpq	$0x0, %rbx
               	jne	0x400fe8 <.text+0xb88>
               	jmp	0x400fad <.text+0xb4d>
               	leaq	0xf29c(%rip), %r15      # 0x410188
               	movq	(%r15), %r12
               	movzbq	(%r12), %r15
               	cmpq	$0x30, %r15
               	setge	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x98(%rbp)
               	cmpq	$0x0, %r12
               	je	0x400f94 <.text+0xb34>
               	jmp	0x400f6a <.text+0xb0a>
               	leaq	0xf2a5(%rip), %r15      # 0x4101c8
               	movq	(%r15), %r12
               	movl	$0xa, %r14d
               	imulq	%r12, %r14
               	leaq	0xf251(%rip), %r12      # 0x410188
               	movq	(%r12), %rbx
               	movq	%rbx, %rax
               	addq	$0x1, %rax
               	movq	%rax, (%r12)
               	movzbq	(%rbx), %rdi
               	movq	%r14, %rbx
               	addq	%rdi, %rbx
               	movq	%rbx, %rdi
               	subq	$0x30, %rdi
               	movq	%rdi, (%r15)
               	jmp	0x400ee5 <.text+0xa85>
               	jmp	0x400e68 <.text+0xa08>
               	leaq	0xf217(%rip), %r15      # 0x410188
               	movq	(%r15), %r12
               	movzbq	(%r12), %r15
               	cmpq	$0x39, %r15
               	setle	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x98(%rbp)
               	jmp	0x400f94 <.text+0xb34>
               	movq	-0x98(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x400f65 <.text+0xb05>
               	jmp	0x400f1c <.text+0xabc>
               	leaq	0xf1d4(%rip), %rdi      # 0x410188
               	movq	(%rdi), %rbx
               	movzbq	(%rbx), %rdi
               	movq	%rdi, %rbx
               	xorq	$0x58, %rbx
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%rbx, %rdi
               	cmpq	$0x0, %rdi
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xa0(%rbp)
               	jmp	0x400fe8 <.text+0xb88>
               	movq	-0xa0(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	0x401006 <.text+0xba6>
               	jmp	0x40100b <.text+0xbab>
               	jmp	0x400e68 <.text+0xa08>
               	jmp	0x401255 <.text+0xdf5>
               	leaq	0xf1ae(%rip), %rdi      # 0x4101c0
               	leaq	0xf16f(%rip), %rbx      # 0x410188
               	movq	(%rbx), %r15
               	movq	%r15, %r14
               	addq	$0x1, %r14
               	movq	%r14, (%rbx)
               	movzbq	(%r14), %r15
               	movq	%r15, (%rdi)
               	movq	%r15, -0xa8(%rbp)
               	cmpq	$0x0, %r15
               	je	0x4010c0 <.text+0xc60>
               	jmp	0x40108e <.text+0xc2e>
               	leaq	0xf178(%rip), %r14      # 0x4101c8
               	movq	(%r14), %r15
               	movq	%r15, %rdi
               	shlq	$0x4, %rdi
               	leaq	0xf15f(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rbx
               	movq	%rbx, %rax
               	andq	$0xf, %rax
               	movq	%rdi, %rbx
               	addq	%rax, %rbx
               	movq	(%r15), %rax
               	cmpq	$0x41, %rax
               	jl	0x401231 <.text+0xdd1>
               	jmp	0x401220 <.text+0xdc0>
               	jmp	0x401001 <.text+0xba1>
               	leaq	0xf12b(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x30, %r15
               	setge	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xc0(%rbp)
               	cmpq	$0x0, %r14
               	je	0x4010fe <.text+0xc9e>
               	jmp	0x4010d9 <.text+0xc79>
               	movq	-0xa8(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x401089 <.text+0xc29>
               	jmp	0x401049 <.text+0xbe9>
               	leaq	0xf0e0(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r14
               	cmpq	$0x39, %r14
               	setle	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xc0(%rbp)
               	jmp	0x4010fe <.text+0xc9e>
               	movq	-0xc0(%rbp), %r15
               	movq	%r15, -0xb8(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x40114b <.text+0xceb>
               	leaq	0xf0a0(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x61, %r15
               	setge	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xc8(%rbp)
               	cmpq	$0x0, %r14
               	je	0x401190 <.text+0xd30>
               	jmp	0x40116b <.text+0xd0b>
               	movq	-0xb8(%rbp), %r15
               	movq	%r15, -0xb0(%rbp)
               	cmpq	$0x0, %r15
               	jne	0x4011d5 <.text+0xd75>
               	jmp	0x4011a3 <.text+0xd43>
               	leaq	0xf04e(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r14
               	cmpq	$0x66, %r14
               	setle	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xc8(%rbp)
               	jmp	0x401190 <.text+0xd30>
               	movq	-0xc8(%rbp), %r15
               	movq	%r15, -0xb8(%rbp)
               	jmp	0x40114b <.text+0xceb>
               	leaq	0xf016(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x41, %r15
               	setge	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xd0(%rbp)
               	cmpq	$0x0, %r14
               	je	0x40120d <.text+0xdad>
               	jmp	0x4011e8 <.text+0xd88>
               	movq	-0xb0(%rbp), %r15
               	movq	%r15, -0xa8(%rbp)
               	jmp	0x4010c0 <.text+0xc60>
               	leaq	0xefd1(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r14
               	cmpq	$0x46, %r14
               	setle	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0xd0(%rbp)
               	jmp	0x40120d <.text+0xdad>
               	movq	-0xd0(%rbp), %r15
               	movq	%r15, -0xb0(%rbp)
               	jmp	0x4011d5 <.text+0xd75>
               	movl	$0x9, %eax
               	movq	%rax, -0xd8(%rbp)
               	jmp	0x401240 <.text+0xde0>
               	xorq	%rax, %rax
               	movq	%rax, -0xd8(%rbp)
               	jmp	0x401240 <.text+0xde0>
               	movq	-0xd8(%rbp), %rax
               	movq	%rbx, %r15
               	addq	%rax, %r15
               	movq	%r15, (%r14)
               	jmp	0x40100b <.text+0xbab>
               	leaq	0xef2c(%rip), %r15      # 0x410188
               	movq	(%r15), %rax
               	movzbq	(%rax), %r15
               	cmpq	$0x30, %r15
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xe0(%rbp)
               	cmpq	$0x0, %rax
               	je	0x4012fd <.text+0xe9d>
               	jmp	0x4012d4 <.text+0xe74>
               	leaq	0xef36(%rip), %r15      # 0x4101c8
               	movq	(%r15), %rax
               	movq	%rax, %r14
               	shlq	$0x3, %r14
               	leaq	0xeee5(%rip), %rax      # 0x410188
               	movq	(%rax), %rbx
               	movq	%rbx, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%rax)
               	movzbq	(%rbx), %r12
               	movq	%r14, %rbx
               	addq	%r12, %rbx
               	movq	%rbx, %r12
               	subq	$0x30, %r12
               	movq	%r12, (%r15)
               	jmp	0x401255 <.text+0xdf5>
               	jmp	0x401001 <.text+0xba1>
               	leaq	0xeead(%rip), %r15      # 0x410188
               	movq	(%r15), %rax
               	movzbq	(%rax), %r15
               	cmpq	$0x37, %r15
               	setle	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xe0(%rbp)
               	jmp	0x4012fd <.text+0xe9d>
               	movq	-0xe0(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x4012cf <.text+0xe6f>
               	jmp	0x40128b <.text+0xe2b>
               	leaq	0xee6b(%rip), %r15      # 0x410188
               	movq	(%r15), %rbx
               	movzbq	(%rbx), %r15
               	movq	%r15, %rbx
               	xorq	$0x2f, %rbx
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r15
               	cmpq	$0x0, %r15
               	jne	0x4013a2 <.text+0xf42>
               	jmp	0x401381 <.text+0xf21>
               	jmp	0x400e42 <.text+0x9e2>
               	leaq	0xee6b(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rbx
               	cmpq	$0x27, %rbx
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xf0(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x4014b1 <.text+0x1051>
               	jmp	0x40148c <.text+0x102c>
               	leaq	0xee00(%rip), %r15      # 0x410188
               	movq	(%r15), %rbx
               	movq	%rbx, %r12
               	addq	$0x1, %r12
               	movq	%r12, (%r15)
               	jmp	0x4013d7 <.text+0xf77>
               	jmp	0x401349 <.text+0xee9>
               	leaq	0xee17(%rip), %r15      # 0x4101c0
               	movl	$0xa0, %r12d
               	movq	%r12, (%r15)
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xedaa(%rip), %r12      # 0x410188
               	movq	(%r12), %rbx
               	movzbq	(%rbx), %r12
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r12, %rbx
               	cmpq	$0x0, %rbx
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xe8(%rbp)
               	cmpq	$0x0, %r12
               	je	0x401473 <.text+0x1013>
               	jmp	0x401437 <.text+0xfd7>
               	leaq	0xed6b(%rip), %rbx      # 0x410188
               	movq	(%rbx), %r12
               	movq	%r12, %r15
               	addq	$0x1, %r15
               	movq	%r15, (%rbx)
               	jmp	0x4013d7 <.text+0xf77>
               	jmp	0x40139d <.text+0xf3d>
               	leaq	0xed4a(%rip), %rbx      # 0x410188
               	movq	(%rbx), %r12
               	movzbq	(%r12), %rbx
               	movq	%rbx, %r12
               	xorq	$0xa, %r12
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r12, %rbx
               	cmpq	$0x0, %rbx
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xe8(%rbp)
               	jmp	0x401473 <.text+0x1013>
               	movq	-0xe8(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x401432 <.text+0xfd2>
               	jmp	0x401416 <.text+0xfb6>
               	leaq	0xed2d(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r12
               	cmpq	$0x22, %r12
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0xf0(%rbp)
               	jmp	0x4014b1 <.text+0x1051>
               	movq	-0xf0(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	0x4014da <.text+0x107a>
               	leaq	0xeccc(%rip), %r12      # 0x410198
               	movq	(%r12), %rbx
               	jmp	0x4014f6 <.text+0x1096>
               	jmp	0x401349 <.text+0xee9>
               	leaq	0xecdf(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %rdi
               	cmpq	$0x3d, %rdi
               	jne	0x401709 <.text+0x12a9>
               	jmp	0x4016d2 <.text+0x1272>
               	leaq	0xec8b(%rip), %r12      # 0x410188
               	movq	(%r12), %r15
               	movzbq	(%r15), %r12
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	$0x0, %r15
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xf8(%rbp)
               	cmpq	$0x0, %r12
               	je	0x4015d5 <.text+0x1175>
               	jmp	0x4015a4 <.text+0x1144>
               	leaq	0xec8b(%rip), %r14      # 0x4101c8
               	leaq	0xec44(%rip), %r12      # 0x410188
               	movq	(%r12), %r15
               	movq	%r15, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%r12)
               	movzbq	(%r15), %rax
               	movq	%rax, (%r14)
               	cmpq	$0x5c, %rax
               	jne	0x401625 <.text+0x11c5>
               	jmp	0x4015ee <.text+0x118e>
               	leaq	0xec12(%rip), %r12      # 0x410188
               	movq	(%r12), %rdi
               	movq	%rdi, %r14
               	addq	$0x1, %r14
               	movq	%r14, (%r12)
               	leaq	0xec31(%rip), %rdi      # 0x4101c0
               	movq	(%rdi), %r14
               	cmpq	$0x22, %r14
               	jne	0x4016be <.text+0x125e>
               	jmp	0x40168a <.text+0x122a>
               	leaq	0xebdd(%rip), %r15      # 0x410188
               	movq	(%r15), %r12
               	movzbq	(%r12), %r15
               	leaq	0xec06(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	cmpq	%r14, %r15
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xf8(%rbp)
               	jmp	0x4015d5 <.text+0x1175>
               	movq	-0xf8(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x40156f <.text+0x110f>
               	jmp	0x401536 <.text+0x10d6>
               	leaq	0xebd3(%rip), %rax      # 0x4101c8
               	leaq	0xeb8c(%rip), %r15      # 0x410188
               	movq	(%r15), %r14
               	movq	%r14, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%r15)
               	movzbq	(%r14), %r12
               	movq	%r12, (%rax)
               	cmpq	$0x6e, %r12
               	jne	0x401657 <.text+0x11f7>
               	jmp	0x401641 <.text+0x11e1>
               	leaq	0xeb94(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x22, %rax
               	jne	0x401685 <.text+0x1225>
               	jmp	0x40165c <.text+0x11fc>
               	leaq	0xeb80(%rip), %r12      # 0x4101c8
               	movl	$0xa, %r14d
               	movq	%r14, (%r12)
               	jmp	0x401657 <.text+0x11f7>
               	jmp	0x401625 <.text+0x11c5>
               	leaq	0xeb35(%rip), %rax      # 0x410198
               	movq	(%rax), %r14
               	movq	%r14, %r12
               	addq	$0x1, %r12
               	movq	%r12, (%rax)
               	leaq	0xeb4e(%rip), %rdi      # 0x4101c8
               	movq	(%rdi), %r12
               	movb	%r12b, (%r14)
               	jmp	0x401685 <.text+0x1225>
               	jmp	0x4014f6 <.text+0x1096>
               	leaq	0xeb37(%rip), %r14      # 0x4101c8
               	movq	%rbx, (%r14)
               	jmp	0x401699 <.text+0x1239>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xeafb(%rip), %r14      # 0x4101c0
               	movl	$0x80, %edi
               	movq	%rdi, (%r14)
               	jmp	0x401699 <.text+0x1239>
               	leaq	0xeaaf(%rip), %rdi      # 0x410188
               	movq	(%rdi), %rbx
               	movzbq	(%rbx), %rdi
               	movq	%rdi, %rbx
               	xorq	$0x3d, %rbx
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%rbx, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x401776 <.text+0x1316>
               	jmp	0x401725 <.text+0x12c5>
               	jmp	0x4014d5 <.text+0x1075>
               	leaq	0xeab0(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %rdi
               	cmpq	$0x2b, %rdi
               	jne	0x4017c1 <.text+0x1361>
               	jmp	0x40178a <.text+0x132a>
               	leaq	0xea5c(%rip), %rdi      # 0x410188
               	movq	(%rdi), %rbx
               	movq	%rbx, %r14
               	addq	$0x1, %r14
               	movq	%r14, (%rdi)
               	leaq	0xea7d(%rip), %rbx      # 0x4101c0
               	movl	$0x95, %r14d
               	movq	%r14, (%rbx)
               	jmp	0x401751 <.text+0x12f1>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xea43(%rip), %r14      # 0x4101c0
               	movl	$0x8e, %edi
               	movq	%rdi, (%r14)
               	jmp	0x401751 <.text+0x12f1>
               	leaq	0xe9f7(%rip), %rdi      # 0x410188
               	movq	(%rdi), %rbx
               	movzbq	(%rbx), %rdi
               	movq	%rdi, %rbx
               	xorq	$0x2b, %rbx
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%rbx, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x40182e <.text+0x13ce>
               	jmp	0x4017dd <.text+0x137d>
               	jmp	0x401704 <.text+0x12a4>
               	leaq	0xe9f8(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %rdi
               	cmpq	$0x2d, %rdi
               	jne	0x401879 <.text+0x1419>
               	jmp	0x401842 <.text+0x13e2>
               	leaq	0xe9a4(%rip), %rdi      # 0x410188
               	movq	(%rdi), %rbx
               	movq	%rbx, %r14
               	addq	$0x1, %r14
               	movq	%r14, (%rdi)
               	leaq	0xe9c5(%rip), %rbx      # 0x4101c0
               	movl	$0xa2, %r14d
               	movq	%r14, (%rbx)
               	jmp	0x401809 <.text+0x13a9>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xe98b(%rip), %r14      # 0x4101c0
               	movl	$0x9d, %edi
               	movq	%rdi, (%r14)
               	jmp	0x401809 <.text+0x13a9>
               	leaq	0xe93f(%rip), %rdi      # 0x410188
               	movq	(%rdi), %rbx
               	movzbq	(%rbx), %rdi
               	movq	%rdi, %rbx
               	xorq	$0x2d, %rbx
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%rbx, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x4018e6 <.text+0x1486>
               	jmp	0x401895 <.text+0x1435>
               	jmp	0x4017bc <.text+0x135c>
               	leaq	0xe940(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %rdi
               	cmpq	$0x21, %rdi
               	jne	0x401931 <.text+0x14d1>
               	jmp	0x4018fa <.text+0x149a>
               	leaq	0xe8ec(%rip), %rdi      # 0x410188
               	movq	(%rdi), %rbx
               	movq	%rbx, %r14
               	addq	$0x1, %r14
               	movq	%r14, (%rdi)
               	leaq	0xe90d(%rip), %rbx      # 0x4101c0
               	movl	$0xa3, %r14d
               	movq	%r14, (%rbx)
               	jmp	0x4018c1 <.text+0x1461>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xe8d3(%rip), %r14      # 0x4101c0
               	movl	$0x9e, %edi
               	movq	%rdi, (%r14)
               	jmp	0x4018c1 <.text+0x1461>
               	leaq	0xe887(%rip), %rdi      # 0x410188
               	movq	(%rdi), %rbx
               	movzbq	(%rbx), %rdi
               	movq	%rdi, %rbx
               	xorq	$0x3d, %rbx
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%rbx, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x401979 <.text+0x1519>
               	jmp	0x40194d <.text+0x14ed>
               	jmp	0x401874 <.text+0x1414>
               	leaq	0xe888(%rip), %rdi      # 0x4101c0
               	movq	(%rdi), %r14
               	cmpq	$0x3c, %r14
               	jne	0x4019d6 <.text+0x1576>
               	jmp	0x40199e <.text+0x153e>
               	leaq	0xe834(%rip), %rdi      # 0x410188
               	movq	(%rdi), %rbx
               	movq	%rbx, %r14
               	addq	$0x1, %r14
               	movq	%r14, (%rdi)
               	leaq	0xe855(%rip), %rbx      # 0x4101c0
               	movl	$0x96, %r14d
               	movq	%r14, (%rbx)
               	jmp	0x401979 <.text+0x1519>
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xe7e3(%rip), %r14      # 0x410188
               	movq	(%r14), %rdi
               	movzbq	(%rdi), %r14
               	movq	%r14, %rdi
               	xorq	$0x3d, %rdi
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rdi, %r14
               	cmpq	$0x0, %r14
               	jne	0x401a42 <.text+0x15e2>
               	jmp	0x4019f2 <.text+0x1592>
               	jmp	0x40192c <.text+0x14cc>
               	leaq	0xe7e3(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rbx
               	cmpq	$0x3e, %rbx
               	jne	0x401aea <.text+0x168a>
               	jmp	0x401ab3 <.text+0x1653>
               	leaq	0xe78f(%rip), %r14      # 0x410188
               	movq	(%r14), %rdi
               	movq	%rdi, %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%r14)
               	leaq	0xe7b0(%rip), %rdi      # 0x4101c0
               	movl	$0x99, %ebx
               	movq	%rbx, (%rdi)
               	jmp	0x401a1d <.text+0x15bd>
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xe73f(%rip), %rbx      # 0x410188
               	movq	(%rbx), %r14
               	movzbq	(%r14), %rbx
               	movq	%rbx, %r14
               	xorq	$0x3c, %r14
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r14, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401a9f <.text+0x163f>
               	leaq	0xe712(%rip), %rbx      # 0x410188
               	movq	(%rbx), %r14
               	movq	%r14, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%rbx)
               	leaq	0xe733(%rip), %r14      # 0x4101c0
               	movl	$0x9b, %edi
               	movq	%rdi, (%r14)
               	jmp	0x401a9a <.text+0x163a>
               	jmp	0x401a1d <.text+0x15bd>
               	leaq	0xe71a(%rip), %rdi      # 0x4101c0
               	movl	$0x97, %ebx
               	movq	%rbx, (%rdi)
               	jmp	0x401a9a <.text+0x163a>
               	leaq	0xe6ce(%rip), %rbx      # 0x410188
               	movq	(%rbx), %r14
               	movzbq	(%r14), %rbx
               	movq	%rbx, %r14
               	xorq	$0x3d, %r14
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r14, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401b56 <.text+0x16f6>
               	jmp	0x401b06 <.text+0x16a6>
               	jmp	0x4019d1 <.text+0x1571>
               	leaq	0xe6cf(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %rdi
               	cmpq	$0x7c, %rdi
               	jne	0x401bff <.text+0x179f>
               	jmp	0x401bc8 <.text+0x1768>
               	leaq	0xe67b(%rip), %rbx      # 0x410188
               	movq	(%rbx), %r14
               	movq	%r14, %rdi
               	addq	$0x1, %rdi
               	movq	%rdi, (%rbx)
               	leaq	0xe69c(%rip), %r14      # 0x4101c0
               	movl	$0x9a, %edi
               	movq	%rdi, (%r14)
               	jmp	0x401b31 <.text+0x16d1>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xe62b(%rip), %rdi      # 0x410188
               	movq	(%rdi), %rbx
               	movzbq	(%rbx), %rdi
               	movq	%rdi, %rbx
               	xorq	$0x3e, %rbx
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%rbx, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x401bb4 <.text+0x1754>
               	leaq	0xe5fe(%rip), %rdi      # 0x410188
               	movq	(%rdi), %rbx
               	movq	%rbx, %r14
               	addq	$0x1, %r14
               	movq	%r14, (%rdi)
               	leaq	0xe61f(%rip), %rbx      # 0x4101c0
               	movl	$0x9c, %r14d
               	movq	%r14, (%rbx)
               	jmp	0x401baf <.text+0x174f>
               	jmp	0x401b31 <.text+0x16d1>
               	leaq	0xe605(%rip), %r14      # 0x4101c0
               	movl	$0x98, %edi
               	movq	%rdi, (%r14)
               	jmp	0x401baf <.text+0x174f>
               	leaq	0xe5b9(%rip), %rdi      # 0x410188
               	movq	(%rdi), %rbx
               	movzbq	(%rbx), %rdi
               	movq	%rdi, %rbx
               	xorq	$0x7c, %rbx
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%rbx, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x401c6c <.text+0x180c>
               	jmp	0x401c1b <.text+0x17bb>
               	jmp	0x401ae5 <.text+0x1685>
               	leaq	0xe5ba(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %rdi
               	cmpq	$0x26, %rdi
               	jne	0x401cb7 <.text+0x1857>
               	jmp	0x401c80 <.text+0x1820>
               	leaq	0xe566(%rip), %rdi      # 0x410188
               	movq	(%rdi), %rbx
               	movq	%rbx, %r14
               	addq	$0x1, %r14
               	movq	%r14, (%rdi)
               	leaq	0xe587(%rip), %rbx      # 0x4101c0
               	movl	$0x90, %r14d
               	movq	%r14, (%rbx)
               	jmp	0x401c47 <.text+0x17e7>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xe54d(%rip), %r14      # 0x4101c0
               	movl	$0x92, %edi
               	movq	%rdi, (%r14)
               	jmp	0x401c47 <.text+0x17e7>
               	leaq	0xe501(%rip), %rdi      # 0x410188
               	movq	(%rdi), %rbx
               	movzbq	(%rbx), %rdi
               	movq	%rdi, %rbx
               	xorq	$0x26, %rbx
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%rbx, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x401d24 <.text+0x18c4>
               	jmp	0x401cd3 <.text+0x1873>
               	jmp	0x401bfa <.text+0x179a>
               	leaq	0xe502(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %rdi
               	cmpq	$0x5e, %rdi
               	jne	0x401d71 <.text+0x1911>
               	jmp	0x401d38 <.text+0x18d8>
               	leaq	0xe4ae(%rip), %rdi      # 0x410188
               	movq	(%rdi), %rbx
               	movq	%rbx, %r14
               	addq	$0x1, %r14
               	movq	%r14, (%rdi)
               	leaq	0xe4cf(%rip), %rbx      # 0x4101c0
               	movl	$0x91, %r14d
               	movq	%r14, (%rbx)
               	jmp	0x401cff <.text+0x189f>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0xe495(%rip), %r14      # 0x4101c0
               	movl	$0x94, %edi
               	movq	%rdi, (%r14)
               	jmp	0x401cff <.text+0x189f>
               	leaq	0xe481(%rip), %rdi      # 0x4101c0
               	movl	$0x93, %ebx
               	movq	%rbx, (%rdi)
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	0x401cb2 <.text+0x1852>
               	leaq	0xe448(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r14
               	cmpq	$0x25, %r14
               	jne	0x401dc1 <.text+0x1961>
               	leaq	0xe431(%rip), %r14      # 0x4101c0
               	movl	$0xa1, %ebx
               	movq	%rbx, (%r14)
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	0x401d6c <.text+0x190c>
               	leaq	0xe3f8(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %rdi
               	cmpq	$0x2a, %rdi
               	jne	0x401e11 <.text+0x19b1>
               	leaq	0xe3e1(%rip), %rdi      # 0x4101c0
               	movl	$0x9f, %ebx
               	movq	%rbx, (%rdi)
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	0x401dbc <.text+0x195c>
               	leaq	0xe3a8(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r14
               	cmpq	$0x5b, %r14
               	jne	0x401e61 <.text+0x1a01>
               	leaq	0xe391(%rip), %r14      # 0x4101c0
               	movl	$0xa4, %ebx
               	movq	%rbx, (%r14)
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	0x401e0c <.text+0x19ac>
               	leaq	0xe358(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %rdi
               	cmpq	$0x3f, %rdi
               	jne	0x401eb1 <.text+0x1a51>
               	leaq	0xe341(%rip), %rdi      # 0x4101c0
               	movl	$0x8f, %ebx
               	movq	%rbx, (%rdi)
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	0x401e5c <.text+0x19fc>
               	leaq	0xe308(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r14
               	cmpq	$0x7e, %r14
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x138(%rbp)
               	cmpq	$0x0, %rbx
               	jne	0x401f03 <.text+0x1aa3>
               	leaq	0xe2db(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rbx
               	cmpq	$0x3b, %rbx
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x138(%rbp)
               	jmp	0x401f03 <.text+0x1aa3>
               	movq	-0x138(%rbp), %r14
               	movq	%r14, -0x130(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x401f43 <.text+0x1ae3>
               	leaq	0xe29b(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r14
               	cmpq	$0x7b, %r14
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x130(%rbp)
               	jmp	0x401f43 <.text+0x1ae3>
               	movq	-0x130(%rbp), %rbx
               	movq	%rbx, -0x128(%rbp)
               	cmpq	$0x0, %rbx
               	jne	0x401f83 <.text+0x1b23>
               	leaq	0xe25b(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rbx
               	cmpq	$0x7d, %rbx
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x128(%rbp)
               	jmp	0x401f83 <.text+0x1b23>
               	movq	-0x128(%rbp), %r14
               	movq	%r14, -0x120(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x401fc3 <.text+0x1b63>
               	leaq	0xe21b(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r14
               	cmpq	$0x28, %r14
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x120(%rbp)
               	jmp	0x401fc3 <.text+0x1b63>
               	movq	-0x120(%rbp), %rbx
               	movq	%rbx, -0x118(%rbp)
               	cmpq	$0x0, %rbx
               	jne	0x402003 <.text+0x1ba3>
               	leaq	0xe1db(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rbx
               	cmpq	$0x29, %rbx
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x118(%rbp)
               	jmp	0x402003 <.text+0x1ba3>
               	movq	-0x118(%rbp), %r14
               	movq	%r14, -0x110(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x402043 <.text+0x1be3>
               	leaq	0xe19b(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r14
               	cmpq	$0x5d, %r14
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x110(%rbp)
               	jmp	0x402043 <.text+0x1be3>
               	movq	-0x110(%rbp), %rbx
               	movq	%rbx, -0x108(%rbp)
               	cmpq	$0x0, %rbx
               	jne	0x402083 <.text+0x1c23>
               	leaq	0xe15b(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rbx
               	cmpq	$0x2c, %rbx
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x108(%rbp)
               	jmp	0x402083 <.text+0x1c23>
               	movq	-0x108(%rbp), %r14
               	movq	%r14, -0x100(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x4020c3 <.text+0x1c63>
               	leaq	0xe11b(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r14
               	cmpq	$0x3a, %r14
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x100(%rbp)
               	jmp	0x4020c3 <.text+0x1c63>
               	movq	-0x100(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	0x4020fc <.text+0x1c9c>
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	jmp	0x401eac <.text+0x1a4c>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	0xe092(%rip), %r9       # 0x4101c0
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	jne	0x402180 <.text+0x1d20>
               	leaq	0xe18d(%rip), %r12      # 0x4102d2
               	leaq	0xe094(%rip), %r9       # 0x4101e0
               	movq	(%r9), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x40217b <.text+0x1d1b>
               	jmp	0x4032d4 <.text+0x2e74>
               	leaq	0xe039(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0x80, %rax
               	jne	0x4021ef <.text+0x1d8f>
               	leaq	0xe002(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r15
               	movq	%r15, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	movq	(%rax), %rsi
               	movq	%rsi, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	leaq	0xdff9(%rip), %rsi      # 0x4101c8
               	movq	(%rsi), %rax
               	movq	%rax, (%r12)
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xdfee(%rip), %rax      # 0x4101d0
               	movq	%r14, (%rax)
               	jmp	0x4021ea <.text+0x1d8a>
               	jmp	0x40217b <.text+0x1d1b>
               	leaq	0xdfca(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rsi
               	cmpq	$0x22, %rsi
               	jne	0x402252 <.text+0x1df2>
               	leaq	0xdf93(%rip), %rsi      # 0x4101a0
               	movq	(%rsi), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rsi)
               	movl	$0x1, %eax
               	movq	%rax, (%r14)
               	movq	(%rsi), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rsi)
               	leaq	0xdf8c(%rip), %r12      # 0x4101c8
               	movq	(%r12), %rsi
               	movq	%rsi, (%rax)
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x40226e <.text+0x1e0e>
               	jmp	0x4021ea <.text+0x1d8a>
               	leaq	0xdf67(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0x8c, %r15
               	jne	0x4022eb <.text+0x1e8b>
               	jmp	0x4022c5 <.text+0x1e65>
               	leaq	0xdf4b(%rip), %rsi      # 0x4101c0
               	movq	(%rsi), %rax
               	cmpq	$0x22, %rax
               	jne	0x40228f <.text+0x1e2f>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x40226e <.text+0x1e0e>
               	leaq	0xdf02(%rip), %r15      # 0x410198
               	movq	(%r15), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	%r12, %rax
               	andq	$-0x8, %rax
               	movq	%rax, (%r15)
               	leaq	0xdf19(%rip), %r12      # 0x4101d0
               	movl	$0x2, %eax
               	movq	%rax, (%r12)
               	jmp	0x40224d <.text+0x1ded>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xdeef(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x28, %r14
               	jne	0x40233d <.text+0x1edd>
               	jmp	0x402307 <.text+0x1ea7>
               	jmp	0x40224d <.text+0x1ded>
               	leaq	0xdece(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0x85, %rax
               	jne	0x40250d <.text+0x20ad>
               	jmp	0x4024d9 <.text+0x2079>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x402311 <.text+0x1eb1>
               	leaq	0xdeb8(%rip), %r12      # 0x4101d0
               	movl	$0x1, %eax
               	movq	%rax, (%r12)
               	leaq	0xde98(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x8a, %rax
               	jne	0x402389 <.text+0x1f29>
               	jmp	0x40237a <.text+0x1f1a>
               	leaq	0xdfb0(%rip), %r14      # 0x4102f4
               	leaq	0xde95(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x402311 <.text+0x1eb1>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x402384 <.text+0x1f24>
               	jmp	0x4023bc <.text+0x1f5c>
               	leaq	0xde30(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0x86, %rax
               	jne	0x4023b7 <.text+0x1f57>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xde24(%rip), %rax      # 0x4101d0
               	xorq	%r14, %r14
               	movq	%r14, (%rax)
               	jmp	0x4023b7 <.text+0x1f57>
               	jmp	0x402384 <.text+0x1f24>
               	leaq	0xddfd(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r12
               	cmpq	$0x9f, %r12
               	jne	0x4023f4 <.text+0x1f94>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xddf1(%rip), %rax      # 0x4101d0
               	movq	(%rax), %r15
               	movq	%r15, %r12
               	addq	$0x2, %r12
               	movq	%r12, (%rax)
               	jmp	0x4023bc <.text+0x1f5c>
               	leaq	0xddc5(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x29, %r15
               	jne	0x402462 <.text+0x2002>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x402416 <.text+0x1fb6>
               	leaq	0xdd83(%rip), %r15      # 0x4101a0
               	movq	(%r15), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0x1, %eax
               	movq	%rax, (%r12)
               	movq	(%r15), %r14
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	leaq	0xdd83(%rip), %r14      # 0x4101d0
               	movq	(%r14), %r15
               	cmpq	$0x0, %r15
               	jne	0x4024ae <.text+0x204e>
               	jmp	0x40249f <.text+0x203f>
               	leaq	0xdeae(%rip), %r12      # 0x410317
               	leaq	0xdd70(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x402416 <.text+0x1fb6>
               	movl	$0x1, %r15d
               	movq	%r15, -0x30(%rbp)
               	jmp	0x4024bd <.text+0x205d>
               	movl	$0x8, %r15d
               	movq	%r15, -0x30(%rbp)
               	jmp	0x4024bd <.text+0x205d>
               	movq	-0x30(%rbp), %r15
               	movq	%r15, (%rax)
               	leaq	0xdd05(%rip), %r14      # 0x4101d0
               	movl	$0x1, %r15d
               	movq	%r15, (%r14)
               	jmp	0x4022e6 <.text+0x1e86>
               	leaq	0xdcd0(%rip), %rax      # 0x4101b0
               	movq	(%rax), %r15
               	movq	%r15, -0x10(%rbp)
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xdccd(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0x28, %r15
               	jne	0x40253f <.text+0x20df>
               	jmp	0x402529 <.text+0x20c9>
               	jmp	0x4022e6 <.text+0x1e86>
               	leaq	0xdcac(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r14
               	cmpq	$0x28, %r14
               	jne	0x40297e <.text+0x251e>
               	jmp	0x402945 <.text+0x24e5>
               	callq	0x4005ad <.text+0x14d>
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	jmp	0x402562 <.text+0x2102>
               	jmp	0x402508 <.text+0x20a8>
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %r15
               	addq	$0x18, %r15
               	movq	(%r15), %rax
               	cmpq	$0x80, %rax
               	jne	0x4027b6 <.text+0x2356>
               	jmp	0x40275e <.text+0x22fe>
               	leaq	0xdc57(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x29, %r12
               	je	0x4025d7 <.text+0x2177>
               	movl	$0x8e, %r15d
               	movq	%r15, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	leaq	0xdc12(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0xd, %r15d
               	movq	%r15, (%r14)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %r15
               	movq	%r15, %r14
               	addq	$0x1, %r14
               	movq	%r14, (%rax)
               	leaq	0xdbfe(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r14
               	cmpq	$0x2c, %r14
               	jne	0x40260c <.text+0x21ac>
               	jmp	0x4025ff <.text+0x219f>
               	callq	0x4005ad <.text+0x14d>
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %r15
               	addq	$0x18, %r15
               	movq	(%r15), %rax
               	cmpq	$0x82, %rax
               	jne	0x402658 <.text+0x21f8>
               	jmp	0x402611 <.text+0x21b1>
               	callq	0x4005ad <.text+0x14d>
               	movq	%rax, %r15
               	jmp	0x40260c <.text+0x21ac>
               	jmp	0x402562 <.text+0x2102>
               	leaq	0xdb88(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r15
               	movq	%r15, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movq	-0x10(%rbp), %r15
               	movq	%r15, %rax
               	addq	$0x28, %rax
               	movq	(%rax), %r15
               	movq	%r15, (%r12)
               	jmp	0x402642 <.text+0x21e2>
               	movq	-0x8(%rbp), %r15
               	cmpq	$0x0, %r15
               	je	0x40273e <.text+0x22de>
               	jmp	0x402701 <.text+0x22a1>
               	movq	-0x10(%rbp), %r15
               	movq	%r15, %rax
               	addq	$0x18, %rax
               	movq	(%rax), %r15
               	cmpq	$0x81, %r15
               	jne	0x4026c4 <.text+0x2264>
               	leaq	0xdb23(%rip), %r15      # 0x4101a0
               	movq	(%r15), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0x3, %eax
               	movq	%rax, (%r12)
               	movq	(%r15), %r14
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movq	-0x10(%rbp), %r14
               	movq	%r14, %r15
               	addq	$0x28, %r15
               	movq	(%r15), %r14
               	movq	%r14, (%rax)
               	jmp	0x4026bf <.text+0x225f>
               	jmp	0x402642 <.text+0x21e2>
               	leaq	0xdc70(%rip), %r12      # 0x41033b
               	leaq	0xdb0e(%rip), %r15      # 0x4101e0
               	movq	(%r15), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x4026bf <.text+0x225f>
               	leaq	0xda98(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r15
               	movq	%r15, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0x7, %r15d
               	movq	%r15, (%r12)
               	movq	(%rax), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movq	-0x8(%rbp), %r14
               	movq	%r14, (%r15)
               	jmp	0x40273e <.text+0x22de>
               	leaq	0xda8b(%rip), %r14      # 0x4101d0
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %r15
               	addq	$0x20, %r15
               	movq	(%r15), %rax
               	movq	%rax, (%r14)
               	jmp	0x40253a <.text+0x20da>
               	leaq	0xda3b(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0x1, %r15d
               	movq	%r15, (%r14)
               	movq	(%rax), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movq	-0x10(%rbp), %r12
               	movq	%r12, %rax
               	addq	$0x28, %rax
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	leaq	0xda27(%rip), %rax      # 0x4101d0
               	movq	%r15, (%rax)
               	jmp	0x4027b1 <.text+0x2351>
               	jmp	0x40253a <.text+0x20da>
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %r12
               	addq	$0x18, %r12
               	movq	(%r12), %rax
               	cmpq	$0x84, %rax
               	jne	0x402870 <.text+0x2410>
               	leaq	0xd9c4(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	xorq	%r12, %r12
               	movq	%r12, (%r15)
               	movq	(%rax), %r14
               	movq	%r14, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	leaq	0xd9cf(%rip), %r14      # 0x4101d8
               	movq	(%r14), %rax
               	movq	-0x10(%rbp), %r14
               	movq	%r14, %r15
               	addq	$0x28, %r15
               	movq	(%r15), %r14
               	movq	%rax, %r15
               	subq	%r14, %r15
               	movq	%r15, (%r12)
               	jmp	0x40282c <.text+0x23cc>
               	leaq	0xd96d(%rip), %r15      # 0x4101a0
               	movq	(%r15), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	leaq	0xd986(%rip), %rax      # 0x4101d0
               	movq	-0x10(%rbp), %r15
               	movq	%r15, %r14
               	addq	$0x20, %r14
               	movq	(%r14), %r15
               	movq	%r15, (%rax)
               	cmpq	$0x0, %r15
               	jne	0x402929 <.text+0x24c9>
               	jmp	0x40291a <.text+0x24ba>
               	movq	-0x10(%rbp), %r15
               	movq	%r15, %r14
               	addq	$0x18, %r14
               	movq	(%r14), %r15
               	cmpq	$0x83, %r15
               	jne	0x4028dd <.text+0x247d>
               	leaq	0xd90b(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r14
               	movq	%r14, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0x1, %r14d
               	movq	%r14, (%r12)
               	movq	(%r15), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %r15
               	addq	$0x28, %r15
               	movq	(%r15), %rax
               	movq	%rax, (%r14)
               	jmp	0x4028d8 <.text+0x2478>
               	jmp	0x40282c <.text+0x23cc>
               	leaq	0xda6e(%rip), %r12      # 0x410352
               	leaq	0xd8f5(%rip), %r15      # 0x4101e0
               	movq	(%r15), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x4028d8 <.text+0x2478>
               	movl	$0xa, %r15d
               	movq	%r15, -0x38(%rbp)
               	jmp	0x402938 <.text+0x24d8>
               	movl	$0x9, %r15d
               	movq	%r15, -0x38(%rbp)
               	jmp	0x402938 <.text+0x24d8>
               	movq	-0x38(%rbp), %r15
               	movq	%r15, (%r12)
               	jmp	0x4027b1 <.text+0x2351>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xd86f(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x8a, %r12
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x40(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4029bd <.text+0x255d>
               	jmp	0x40299a <.text+0x253a>
               	jmp	0x402508 <.text+0x20a8>
               	leaq	0xd83b(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x9f, %rax
               	jne	0x402b79 <.text+0x2719>
               	jmp	0x402b45 <.text+0x26e5>
               	leaq	0xd81f(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x86, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x40(%rbp)
               	jmp	0x4029bd <.text+0x255d>
               	movq	-0x40(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x4029ef <.text+0x258f>
               	leaq	0xd7eb(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x8a, %r12
               	jne	0x402a28 <.text+0x25c8>
               	jmp	0x402a19 <.text+0x25b9>
               	jmp	0x402979 <.text+0x2519>
               	movl	$0x8e, %r15d
               	movq	%r15, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	leaq	0xd7bc(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0x29, %r15
               	jne	0x402b08 <.text+0x26a8>
               	jmp	0x402af9 <.text+0x2699>
               	movl	$0x1, %r12d
               	movq	%r12, -0x48(%rbp)
               	jmp	0x402a34 <.text+0x25d4>
               	xorq	%r12, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	0x402a34 <.text+0x25d4>
               	movq	-0x48(%rbp), %r12
               	movq	%r12, -0x8(%rbp)
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x402a46 <.text+0x25e6>
               	leaq	0xd773(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x9f, %rax
               	jne	0x402a7a <.text+0x261a>
               	callq	0x4005ad <.text+0x14d>
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %r14
               	addq	$0x2, %r14
               	movq	%r14, -0x8(%rbp)
               	jmp	0x402a46 <.text+0x25e6>
               	leaq	0xd73f(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x29, %rax
               	jne	0x402abc <.text+0x265c>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x402a9b <.text+0x263b>
               	movl	$0xa2, %r12d
               	movq	%r12, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	leaq	0xd720(%rip), %rax      # 0x4101d0
               	movq	-0x8(%rbp), %r12
               	movq	%r12, (%rax)
               	jmp	0x4029ea <.text+0x258a>
               	leaq	0xd8a7(%rip), %r14      # 0x41036a
               	leaq	0xd716(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x402a9b <.text+0x263b>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x402b03 <.text+0x26a3>
               	jmp	0x4029ea <.text+0x258a>
               	leaq	0xd869(%rip), %r15      # 0x410378
               	leaq	0xd6ca(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x402b03 <.text+0x26a3>
               	callq	0x4005ad <.text+0x14d>
               	movl	$0xa2, %r14d
               	movq	%r14, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	leaq	0xd671(%rip), %rax      # 0x4101d0
               	movq	(%rax), %r14
               	cmpq	$0x1, %r14
               	jle	0x402be4 <.text+0x2784>
               	jmp	0x402b95 <.text+0x2735>
               	jmp	0x402979 <.text+0x2519>
               	leaq	0xd640(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x94, %rax
               	jne	0x402c96 <.text+0x2836>
               	jmp	0x402c4c <.text+0x27ec>
               	leaq	0xd634(%rip), %r14      # 0x4101d0
               	movq	(%r14), %rax
               	movq	%rax, %r15
               	subq	$0x2, %r15
               	movq	%r15, (%r14)
               	jmp	0x402bb1 <.text+0x2751>
               	leaq	0xd5e8(%rip), %r14      # 0x4101a0
               	movq	(%r14), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	leaq	0xd601(%rip), %rax      # 0x4101d0
               	movq	(%rax), %r14
               	cmpq	$0x0, %r14
               	jne	0x402c30 <.text+0x27d0>
               	jmp	0x402c21 <.text+0x27c1>
               	leaq	0xd7a7(%rip), %r12      # 0x410392
               	leaq	0xd5ee(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x402bb1 <.text+0x2751>
               	movl	$0xa, %r14d
               	movq	%r14, -0x50(%rbp)
               	jmp	0x402c3f <.text+0x27df>
               	movl	$0x9, %r14d
               	movq	%r14, -0x50(%rbp)
               	jmp	0x402c3f <.text+0x27df>
               	movq	-0x50(%rbp), %r14
               	movq	%r14, (%r12)
               	jmp	0x402b74 <.text+0x2714>
               	callq	0x4005ad <.text+0x14d>
               	movl	$0xa2, %r14d
               	movq	%r14, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	leaq	0xd53a(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r14
               	movq	(%r14), %rax
               	cmpq	$0xa, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x58(%rbp)
               	cmpq	$0x0, %r14
               	jne	0x402cd7 <.text+0x2877>
               	jmp	0x402cb2 <.text+0x2852>
               	jmp	0x402b74 <.text+0x2714>
               	leaq	0xd523(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0x21, %rax
               	jne	0x402deb <.text+0x298b>
               	jmp	0x402d5d <.text+0x28fd>
               	leaq	0xd4e7(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r14
               	movq	(%r14), %rax
               	cmpq	$0x9, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x58(%rbp)
               	jmp	0x402cd7 <.text+0x2877>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x402d20 <.text+0x28c0>
               	leaq	0xd4b1(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r14
               	movq	%r14, %r12
               	addq	$-0x8, %r12
               	movq	%r12, (%rax)
               	jmp	0x402d04 <.text+0x28a4>
               	leaq	0xd4c5(%rip), %r14      # 0x4101d0
               	movq	(%r14), %rax
               	movq	%rax, %r15
               	addq	$0x2, %r15
               	movq	%r15, (%r14)
               	jmp	0x402c91 <.text+0x2831>
               	leaq	0xd680(%rip), %r15      # 0x4103a7
               	leaq	0xd4b2(%rip), %r14      # 0x4101e0
               	movq	(%r14), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x402d04 <.text+0x28a4>
               	callq	0x4005ad <.text+0x14d>
               	movl	$0xa2, %r15d
               	movq	%r15, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	leaq	0xd429(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0xd, %r15d
               	movq	%r15, (%r14)
               	movq	(%rax), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0x1, %r12d
               	movq	%r12, (%r15)
               	movq	(%rax), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	xorq	%r14, %r14
               	movq	%r14, (%r15)
               	movq	(%rax), %rdx
               	movq	%rdx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0x11, %edx
               	movq	%rdx, (%r14)
               	leaq	0xd3f2(%rip), %rax      # 0x4101d0
               	movq	%r12, (%rax)
               	jmp	0x402de6 <.text+0x2986>
               	jmp	0x402c91 <.text+0x2831>
               	leaq	0xd3ce(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rdx
               	cmpq	$0x7e, %rdx
               	jne	0x402e99 <.text+0x2a39>
               	callq	0x4005ad <.text+0x14d>
               	movl	$0xa2, %r14d
               	movq	%r14, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	leaq	0xd384(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r14
               	movq	%r14, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0xd, %r14d
               	movq	%r14, (%r12)
               	movq	(%rax), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0x1, %r15d
               	movq	%r15, (%r14)
               	movq	(%rax), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movabsq	$-0x1, %r12
               	movq	%r12, (%r14)
               	movq	(%rax), %rdx
               	movq	%rdx, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0xf, %edx
               	movq	%rdx, (%r12)
               	leaq	0xd344(%rip), %rax      # 0x4101d0
               	movq	%r15, (%rax)
               	jmp	0x402e94 <.text+0x2a34>
               	jmp	0x402de6 <.text+0x2986>
               	leaq	0xd320(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rdx
               	cmpq	$0x9d, %rdx
               	jne	0x402edd <.text+0x2a7d>
               	callq	0x4005ad <.text+0x14d>
               	movl	$0xa2, %r12d
               	movq	%r12, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	leaq	0xd306(%rip), %rax      # 0x4101d0
               	movl	$0x1, %r12d
               	movq	%r12, (%rax)
               	jmp	0x402ed8 <.text+0x2a78>
               	jmp	0x402e94 <.text+0x2a34>
               	leaq	0xd2dc(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0x9e, %r15
               	jne	0x402f3b <.text+0x2adb>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xd29f(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0x1, %r14d
               	movq	%r14, (%r15)
               	leaq	0xd29f(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x80, %r14
               	jne	0x402fbc <.text+0x2b5c>
               	jmp	0x402f6b <.text+0x2b0b>
               	jmp	0x402ed8 <.text+0x2a78>
               	leaq	0xd27e(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	cmpq	$0xa2, %r14
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x60(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x40304c <.text+0x2bec>
               	jmp	0x40302a <.text+0x2bca>
               	leaq	0xd22e(%rip), %r14      # 0x4101a0
               	movq	(%r14), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	leaq	0xd23f(%rip), %rax      # 0x4101c8
               	movq	(%rax), %r14
               	movabsq	$-0x1, %rax
               	imulq	%r14, %rax
               	movq	%rax, (%r15)
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x402fa7 <.text+0x2b47>
               	leaq	0xd222(%rip), %rax      # 0x4101d0
               	movl	$0x1, %r12d
               	movq	%r12, (%rax)
               	jmp	0x402f36 <.text+0x2ad6>
               	leaq	0xd1dd(%rip), %r12      # 0x4101a0
               	movq	(%r12), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movabsq	$-0x1, %rax
               	movq	%rax, (%r15)
               	movq	(%r12), %r14
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0xd, %r14d
               	movq	%r14, (%rax)
               	movl	$0xa2, %r14d
               	movq	%r14, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	movq	(%r12), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movl	$0x1b, %eax
               	movq	%rax, (%r14)
               	jmp	0x402fa7 <.text+0x2b47>
               	leaq	0xd18f(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r12
               	cmpq	$0xa3, %r12
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x60(%rbp)
               	jmp	0x40304c <.text+0x2bec>
               	movq	-0x60(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x4030a3 <.text+0x2c43>
               	leaq	0xd15c(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r14
               	movq	%r14, -0x8(%rbp)
               	callq	0x4005ad <.text+0x14d>
               	movl	$0xa2, %r15d
               	movq	%r15, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	leaq	0xd11a(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r15
               	movq	(%r15), %rax
               	cmpq	$0xa, %rax
               	jne	0x403178 <.text+0x2d18>
               	jmp	0x4030e0 <.text+0x2c80>
               	jmp	0x402f36 <.text+0x2ad6>
               	leaq	0xd332(%rip), %r15      # 0x4103dc
               	leaq	0xd12f(%rip), %r14      # 0x4101e0
               	movq	(%r14), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x40309e <.text+0x2c3e>
               	leaq	0xd0b9(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r15
               	movl	$0xd, %r12d
               	movq	%r12, (%r15)
               	movq	(%rax), %r14
               	movq	%r14, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0xa, %r14d
               	movq	%r14, (%r12)
               	jmp	0x403112 <.text+0x2cb2>
               	leaq	0xd087(%rip), %r14      # 0x4101a0
               	movq	(%r14), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0xd, %eax
               	movq	%rax, (%r12)
               	movq	(%r14), %r15
               	movq	%r15, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x1, %r15d
               	movq	%r15, (%rax)
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	leaq	0xd06e(%rip), %r12      # 0x4101d0
               	movq	(%r12), %r14
               	cmpq	$0x2, %r14
               	jle	0x403215 <.text+0x2db5>
               	jmp	0x403206 <.text+0x2da6>
               	leaq	0xd021(%rip), %r14      # 0x4101a0
               	movq	(%r14), %rax
               	movq	(%rax), %r14
               	cmpq	$0x9, %r14
               	jne	0x4031c9 <.text+0x2d69>
               	leaq	0xd007(%rip), %r14      # 0x4101a0
               	movq	(%r14), %rax
               	movl	$0xd, %r12d
               	movq	%r12, (%rax)
               	movq	(%r14), %r15
               	movq	%r15, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0x9, %r15d
               	movq	%r15, (%r12)
               	jmp	0x4031c4 <.text+0x2d64>
               	jmp	0x403112 <.text+0x2cb2>
               	leaq	0xd1eb(%rip), %r12      # 0x4103bb
               	leaq	0xd009(%rip), %r14      # 0x4101e0
               	movq	(%r14), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x4031c4 <.text+0x2d64>
               	movl	$0x8, %r14d
               	movq	%r14, -0x68(%rbp)
               	jmp	0x403224 <.text+0x2dc4>
               	movl	$0x1, %r14d
               	movq	%r14, -0x68(%rbp)
               	jmp	0x403224 <.text+0x2dc4>
               	movq	-0x68(%rbp), %r14
               	movq	%r14, (%r15)
               	leaq	0xcf6e(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movq	-0x8(%rbp), %r14
               	cmpq	$0xa2, %r14
               	jne	0x403264 <.text+0x2e04>
               	movl	$0x19, %r14d
               	movq	%r14, -0x70(%rbp)
               	jmp	0x403273 <.text+0x2e13>
               	movl	$0x1a, %r14d
               	movq	%r14, -0x70(%rbp)
               	jmp	0x403273 <.text+0x2e13>
               	movq	-0x70(%rbp), %r14
               	movq	%r14, (%r15)
               	leaq	0xcf1f(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	leaq	0xcf36(%rip), %r14      # 0x4101d0
               	movq	(%r14), %r12
               	cmpq	$0x0, %r12
               	jne	0x4032b9 <.text+0x2e59>
               	movl	$0xc, %r12d
               	movq	%r12, -0x78(%rbp)
               	jmp	0x4032c8 <.text+0x2e68>
               	movl	$0xb, %r12d
               	movq	%r12, -0x78(%rbp)
               	jmp	0x4032c8 <.text+0x2e68>
               	movq	-0x78(%rbp), %r12
               	movq	%r12, (%r15)
               	jmp	0x40309e <.text+0x2c3e>
               	leaq	0xcee5(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	movq	0x28(%rsp), %r10
               	cmpq	%r10, %rax
               	jl	0x403316 <.text+0x2eb6>
               	leaq	0xcedd(%rip), %rax      # 0x4101d0
               	movq	(%rax), %r14
               	movq	%r14, -0x8(%rbp)
               	leaq	0xcebf(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x8e, %r14
               	jne	0x403378 <.text+0x2f18>
               	jmp	0x40333b <.text+0x2edb>
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xce59(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r12
               	movq	(%r12), %rax
               	cmpq	$0xa, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x80(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x4033ba <.text+0x2f5a>
               	jmp	0x403394 <.text+0x2f34>
               	jmp	0x4032d4 <.text+0x2e74>
               	leaq	0xce41(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0x8f, %r15
               	jne	0x4034ff <.text+0x309f>
               	jmp	0x403497 <.text+0x3037>
               	leaq	0xce05(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r12
               	movq	(%r12), %rax
               	cmpq	$0x9, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x80(%rbp)
               	jmp	0x4033ba <.text+0x2f5a>
               	movq	-0x80(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	0x403429 <.text+0x2fc9>
               	leaq	0xcdce(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r12
               	movl	$0xd, %eax
               	movq	%rax, (%r12)
               	jmp	0x4033e3 <.text+0x2f83>
               	movl	$0x8e, %r12d
               	movq	%r12, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	leaq	0xcda8(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	leaq	0xcdc1(%rip), %r12      # 0x4101d0
               	movq	-0x8(%rbp), %rax
               	movq	%rax, (%r12)
               	cmpq	$0x0, %rax
               	jne	0x403477 <.text+0x3017>
               	jmp	0x403466 <.text+0x3006>
               	leaq	0xcfc0(%rip), %r14      # 0x4103f0
               	leaq	0xcda9(%rip), %r15      # 0x4101e0
               	movq	(%r15), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x4033e3 <.text+0x2f83>
               	movl	$0xc, %eax
               	movq	%rax, -0x88(%rbp)
               	jmp	0x403488 <.text+0x3028>
               	movl	$0xb, %eax
               	movq	%rax, -0x88(%rbp)
               	jmp	0x403488 <.text+0x3028>
               	movq	-0x88(%rbp), %rax
               	movq	%rax, (%r14)
               	jmp	0x403373 <.text+0x2f13>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xccfd(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0x4, %r12d
               	movq	%r12, (%r14)
               	movq	(%rax), %r15
               	movq	%r15, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movq	%r12, -0x10(%rbp)
               	movl	$0x8e, %r14d
               	movq	%r14, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	leaq	0xccdb(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x3a, %r14
               	jne	0x403595 <.text+0x3135>
               	jmp	0x40351b <.text+0x30bb>
               	jmp	0x403373 <.text+0x2f13>
               	leaq	0xccba(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r14
               	cmpq	$0x90, %r14
               	jne	0x403647 <.text+0x31e7>
               	jmp	0x4035d2 <.text+0x3172>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x403525 <.text+0x30c5>
               	movq	-0x10(%rbp), %r12
               	leaq	0xcc70(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r14
               	movq	%r14, %rax
               	addq	$0x18, %rax
               	movq	%rax, (%r12)
               	movq	(%r15), %r14
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x2, %r14d
               	movq	%r14, (%rax)
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movq	%r14, -0x10(%rbp)
               	movl	$0x8f, %r14d
               	movq	%r14, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	movq	-0x10(%rbp), %rax
               	movq	(%r15), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	jmp	0x4034fa <.text+0x309a>
               	leaq	0xce72(%rip), %r14      # 0x41040e
               	leaq	0xcc3d(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x403525 <.text+0x30c5>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xcbc2(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0x5, %r12d
               	movq	%r12, (%r14)
               	movq	(%r15), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movq	%r12, -0x10(%rbp)
               	movl	$0x91, %r14d
               	movq	%r14, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	movq	-0x10(%rbp), %rax
               	movq	(%r15), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	leaq	0xcb9c(%rip), %r14      # 0x4101d0
               	movl	$0x1, %r15d
               	movq	%r15, (%r14)
               	jmp	0x403642 <.text+0x31e2>
               	jmp	0x4034fa <.text+0x309a>
               	leaq	0xcb72(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0x91, %rax
               	jne	0x4036d3 <.text+0x3273>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xcb36(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0x4, %r12d
               	movq	%r12, (%r14)
               	movq	(%r15), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movq	%r12, -0x10(%rbp)
               	movl	$0x92, %r14d
               	movq	%r14, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	movq	-0x10(%rbp), %rax
               	movq	(%r15), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	leaq	0xcb10(%rip), %r14      # 0x4101d0
               	movl	$0x1, %r15d
               	movq	%r15, (%r14)
               	jmp	0x4036ce <.text+0x326e>
               	jmp	0x403642 <.text+0x31e2>
               	leaq	0xcae6(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0x92, %rax
               	jne	0x40374e <.text+0x32ee>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xcaaa(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0x93, %r14d
               	movq	%r14, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	movq	(%r15), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xe, %eax
               	movq	%rax, (%r14)
               	leaq	0xca94(%rip), %r15      # 0x4101d0
               	movl	$0x1, %eax
               	movq	%rax, (%r15)
               	jmp	0x403749 <.text+0x32e9>
               	jmp	0x4036ce <.text+0x326e>
               	leaq	0xca6b(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x93, %r14
               	jne	0x4037c9 <.text+0x3369>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xca2f(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0xd, %r12d
               	movq	%r12, (%r15)
               	movl	$0x94, %r15d
               	movq	%r15, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	movq	(%r14), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0xf, %eax
               	movq	%rax, (%r15)
               	leaq	0xca19(%rip), %r14      # 0x4101d0
               	movl	$0x1, %eax
               	movq	%rax, (%r14)
               	jmp	0x4037c4 <.text+0x3364>
               	jmp	0x403749 <.text+0x32e9>
               	leaq	0xc9f0(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0x94, %r15
               	jne	0x403844 <.text+0x33e4>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xc9b4(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0x95, %r14d
               	movq	%r14, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	movq	(%r15), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0x10, %eax
               	movq	%rax, (%r14)
               	leaq	0xc99e(%rip), %r15      # 0x4101d0
               	movl	$0x1, %eax
               	movq	%rax, (%r15)
               	jmp	0x40383f <.text+0x33df>
               	jmp	0x4037c4 <.text+0x3364>
               	leaq	0xc975(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x95, %r14
               	jne	0x4038bf <.text+0x345f>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xc939(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0xd, %r12d
               	movq	%r12, (%r15)
               	movl	$0x97, %r15d
               	movq	%r15, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	movq	(%r14), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0x11, %eax
               	movq	%rax, (%r15)
               	leaq	0xc923(%rip), %r14      # 0x4101d0
               	movl	$0x1, %eax
               	movq	%rax, (%r14)
               	jmp	0x4038ba <.text+0x345a>
               	jmp	0x40383f <.text+0x33df>
               	leaq	0xc8fa(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0x96, %r15
               	jne	0x40393a <.text+0x34da>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xc8be(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0x97, %r14d
               	movq	%r14, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	movq	(%r15), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0x12, %eax
               	movq	%rax, (%r14)
               	leaq	0xc8a8(%rip), %r15      # 0x4101d0
               	movl	$0x1, %eax
               	movq	%rax, (%r15)
               	jmp	0x403935 <.text+0x34d5>
               	jmp	0x4038ba <.text+0x345a>
               	leaq	0xc87f(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x97, %r14
               	jne	0x4039b5 <.text+0x3555>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xc843(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0xd, %r12d
               	movq	%r12, (%r15)
               	movl	$0x9b, %r15d
               	movq	%r15, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	movq	(%r14), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0x13, %eax
               	movq	%rax, (%r15)
               	leaq	0xc82d(%rip), %r14      # 0x4101d0
               	movl	$0x1, %eax
               	movq	%rax, (%r14)
               	jmp	0x4039b0 <.text+0x3550>
               	jmp	0x403935 <.text+0x34d5>
               	leaq	0xc804(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0x98, %r15
               	jne	0x403a30 <.text+0x35d0>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xc7c8(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0x9b, %r14d
               	movq	%r14, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	movq	(%r15), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0x14, %eax
               	movq	%rax, (%r14)
               	leaq	0xc7b2(%rip), %r15      # 0x4101d0
               	movl	$0x1, %eax
               	movq	%rax, (%r15)
               	jmp	0x403a2b <.text+0x35cb>
               	jmp	0x4039b0 <.text+0x3550>
               	leaq	0xc789(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x99, %r14
               	jne	0x403aab <.text+0x364b>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xc74d(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0xd, %r12d
               	movq	%r12, (%r15)
               	movl	$0x9b, %r15d
               	movq	%r15, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	movq	(%r14), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0x15, %eax
               	movq	%rax, (%r15)
               	leaq	0xc737(%rip), %r14      # 0x4101d0
               	movl	$0x1, %eax
               	movq	%rax, (%r14)
               	jmp	0x403aa6 <.text+0x3646>
               	jmp	0x403a2b <.text+0x35cb>
               	leaq	0xc70e(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0x9a, %r15
               	jne	0x403b26 <.text+0x36c6>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xc6d2(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0x9b, %r14d
               	movq	%r14, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	movq	(%r15), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0x16, %eax
               	movq	%rax, (%r14)
               	leaq	0xc6bc(%rip), %r15      # 0x4101d0
               	movl	$0x1, %eax
               	movq	%rax, (%r15)
               	jmp	0x403b21 <.text+0x36c1>
               	jmp	0x403aa6 <.text+0x3646>
               	leaq	0xc693(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x9b, %r14
               	jne	0x403ba1 <.text+0x3741>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xc657(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0xd, %r12d
               	movq	%r12, (%r15)
               	movl	$0x9d, %r15d
               	movq	%r15, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	movq	(%r14), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0x17, %eax
               	movq	%rax, (%r15)
               	leaq	0xc641(%rip), %r14      # 0x4101d0
               	movl	$0x1, %eax
               	movq	%rax, (%r14)
               	jmp	0x403b9c <.text+0x373c>
               	jmp	0x403b21 <.text+0x36c1>
               	leaq	0xc618(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0x9c, %r15
               	jne	0x403c1c <.text+0x37bc>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xc5dc(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0x9d, %r14d
               	movq	%r14, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	movq	(%r15), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0x18, %eax
               	movq	%rax, (%r14)
               	leaq	0xc5c6(%rip), %r15      # 0x4101d0
               	movl	$0x1, %eax
               	movq	%rax, (%r15)
               	jmp	0x403c17 <.text+0x37b7>
               	jmp	0x403b9c <.text+0x373c>
               	leaq	0xc59d(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x9d, %r14
               	jne	0x403c8b <.text+0x382b>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xc561(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0xd, %r12d
               	movq	%r12, (%r15)
               	movl	$0x9f, %r14d
               	movq	%r14, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	leaq	0xc563(%rip), %rax      # 0x4101d0
               	movq	-0x8(%rbp), %r14
               	movq	%r14, (%rax)
               	cmpq	$0x2, %r14
               	jle	0x403d17 <.text+0x38b7>
               	jmp	0x403ca7 <.text+0x3847>
               	jmp	0x403c17 <.text+0x37b7>
               	leaq	0xc52e(%rip), %r14      # 0x4101c0
               	movq	(%r14), %r15
               	cmpq	$0x9e, %r15
               	jne	0x403da0 <.text+0x3940>
               	jmp	0x403d3c <.text+0x38dc>
               	leaq	0xc4f2(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r15
               	movq	%r15, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %r15d
               	movq	%r15, (%rax)
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0x1, %r12d
               	movq	%r12, (%r15)
               	movq	(%r14), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	movl	$0x8, %eax
               	movq	%rax, (%r12)
               	movq	(%r14), %r15
               	movq	%r15, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x1b, %r15d
               	movq	%r15, (%rax)
               	jmp	0x403d17 <.text+0x38b7>
               	leaq	0xc482(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r14
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x19, %r14d
               	movq	%r14, (%rax)
               	jmp	0x403c86 <.text+0x3826>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xc458(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0xd, %r12d
               	movq	%r12, (%r15)
               	movl	$0x9f, %r14d
               	movq	%r14, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2, %rax
               	setg	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x90(%rbp)
               	cmpq	$0x0, %r14
               	je	0x403de1 <.text+0x3981>
               	jmp	0x403dbc <.text+0x395c>
               	jmp	0x403c86 <.text+0x3826>
               	leaq	0xc419(%rip), %rdx      # 0x4101c0
               	movq	(%rdx), %r14
               	cmpq	$0x9f, %r14
               	jne	0x403fbc <.text+0x3b5c>
               	jmp	0x403f58 <.text+0x3af8>
               	movq	-0x8(%rbp), %rax
               	leaq	0xc409(%rip), %r14      # 0x4101d0
               	movq	(%r14), %r15
               	cmpq	%r15, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x90(%rbp)
               	jmp	0x403de1 <.text+0x3981>
               	movq	-0x90(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x403e8d <.text+0x3a2d>
               	leaq	0xc3a4(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r14
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x1a, %r14d
               	movq	%r14, (%rax)
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movq	(%r15), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0x1, %eax
               	movq	%rax, (%r12)
               	movq	(%r15), %r14
               	movq	%r14, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0x8, %r14d
               	movq	%r14, (%r12)
               	movq	(%r15), %rdx
               	movq	%rdx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0x1c, %edx
               	movq	%rdx, (%r14)
               	leaq	0xc350(%rip), %r15      # 0x4101d0
               	movq	%rax, (%r15)
               	jmp	0x403e88 <.text+0x3a28>
               	jmp	0x403d9b <.text+0x393b>
               	leaq	0xc33c(%rip), %r15      # 0x4101d0
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, (%r15)
               	cmpq	$0x2, %rdx
               	jle	0x403f34 <.text+0x3ad4>
               	leaq	0xc2f1(%rip), %rdx      # 0x4101a0
               	movq	(%rdx), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rdx)
               	movl	$0xd, %eax
               	movq	%rax, (%r15)
               	movq	(%rdx), %r14
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdx)
               	movl	$0x1, %r14d
               	movq	%r14, (%rax)
               	movq	(%rdx), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rdx)
               	movl	$0x8, %r15d
               	movq	%r15, (%r14)
               	movq	(%rdx), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rdx)
               	movl	$0x1b, %eax
               	movq	%rax, (%r15)
               	movq	(%rdx), %r14
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rdx)
               	movl	$0x1a, %r14d
               	movq	%r14, (%rax)
               	jmp	0x403f2f <.text+0x3acf>
               	jmp	0x403e88 <.text+0x3a28>
               	leaq	0xc265(%rip), %r14      # 0x4101a0
               	movq	(%r14), %rdx
               	movq	%rdx, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x1a, %edx
               	movq	%rdx, (%rax)
               	jmp	0x403f2f <.text+0x3acf>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xc23c(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0xa2, %r14d
               	movq	%r14, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	movq	(%r15), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0x1b, %eax
               	movq	%rax, (%r14)
               	leaq	0xc226(%rip), %r15      # 0x4101d0
               	movl	$0x1, %eax
               	movq	%rax, (%r15)
               	jmp	0x403fb7 <.text+0x3b57>
               	jmp	0x403d9b <.text+0x393b>
               	leaq	0xc1fd(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0xa0, %r14
               	jne	0x404037 <.text+0x3bd7>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xc1c1(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0xd, %r12d
               	movq	%r12, (%r15)
               	movl	$0xa2, %r15d
               	movq	%r15, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	movq	(%r14), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0x1c, %eax
               	movq	%rax, (%r15)
               	leaq	0xc1ab(%rip), %r14      # 0x4101d0
               	movl	$0x1, %eax
               	movq	%rax, (%r14)
               	jmp	0x404032 <.text+0x3bd2>
               	jmp	0x403fb7 <.text+0x3b57>
               	leaq	0xc182(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0xa1, %r15
               	jne	0x4040b2 <.text+0x3c52>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xc146(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movl	$0xa2, %r14d
               	movq	%r14, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	movq	(%r15), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0x1d, %eax
               	movq	%rax, (%r14)
               	leaq	0xc130(%rip), %r15      # 0x4101d0
               	movl	$0x1, %eax
               	movq	%rax, (%r15)
               	jmp	0x4040ad <.text+0x3c4d>
               	jmp	0x404032 <.text+0x3bd2>
               	leaq	0xc107(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0xa2, %r14
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x98(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x404104 <.text+0x3ca4>
               	leaq	0xc0da(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0xa3, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x98(%rbp)
               	jmp	0x404104 <.text+0x3ca4>
               	movq	-0x98(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x40413c <.text+0x3cdc>
               	leaq	0xc081(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r14
               	movq	(%r14), %rax
               	cmpq	$0xa, %rax
               	jne	0x4041f3 <.text+0x3d93>
               	jmp	0x404158 <.text+0x3cf8>
               	jmp	0x4040ad <.text+0x3c4d>
               	leaq	0xc07d(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0xa4, %rax
               	jne	0x4044b6 <.text+0x4056>
               	jmp	0x404462 <.text+0x4002>
               	leaq	0xc041(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r14
               	movl	$0xd, %r15d
               	movq	%r15, (%r14)
               	movq	(%rax), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0xa, %r12d
               	movq	%r12, (%r15)
               	jmp	0x404189 <.text+0x3d29>
               	leaq	0xc010(%rip), %r12      # 0x4101a0
               	movq	(%r12), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0xd, %eax
               	movq	%rax, (%r15)
               	movq	(%r12), %r14
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	movl	$0x1, %r14d
               	movq	%r14, (%rax)
               	movq	(%r12), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	leaq	0xbff2(%rip), %r15      # 0x4101d0
               	movq	(%r15), %r12
               	cmpq	$0x2, %r12
               	jle	0x404297 <.text+0x3e37>
               	jmp	0x404285 <.text+0x3e25>
               	leaq	0xbfa6(%rip), %r12      # 0x4101a0
               	movq	(%r12), %rax
               	movq	(%rax), %r12
               	cmpq	$0x9, %r12
               	jne	0x404247 <.text+0x3de7>
               	leaq	0xbf8b(%rip), %r12      # 0x4101a0
               	movq	(%r12), %rax
               	movl	$0xd, %r15d
               	movq	%r15, (%rax)
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movl	$0x9, %r14d
               	movq	%r14, (%r15)
               	jmp	0x404242 <.text+0x3de2>
               	jmp	0x404189 <.text+0x3d29>
               	leaq	0xc1df(%rip), %r15      # 0x41042d
               	leaq	0xbf8b(%rip), %r12      # 0x4101e0
               	movq	(%r12), %r14
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x404242 <.text+0x3de2>
               	movl	$0x8, %r12d
               	movq	%r12, -0xa0(%rbp)
               	jmp	0x4042a9 <.text+0x3e49>
               	movl	$0x1, %r12d
               	movq	%r12, -0xa0(%rbp)
               	jmp	0x4042a9 <.text+0x3e49>
               	movq	-0xa0(%rbp), %r12
               	movq	%r12, (%r14)
               	leaq	0xbee6(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	leaq	0xbeef(%rip), %r12      # 0x4101c0
               	movq	(%r12), %r15
               	cmpq	$0xa2, %r15
               	jne	0x4042f4 <.text+0x3e94>
               	movl	$0x19, %r15d
               	movq	%r15, -0xa8(%rbp)
               	jmp	0x404306 <.text+0x3ea6>
               	movl	$0x1a, %r15d
               	movq	%r15, -0xa8(%rbp)
               	jmp	0x404306 <.text+0x3ea6>
               	movq	-0xa8(%rbp), %r15
               	movq	%r15, (%r14)
               	leaq	0xbe89(%rip), %r12      # 0x4101a0
               	movq	(%r12), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	leaq	0xbea0(%rip), %r15      # 0x4101d0
               	movq	(%r15), %r12
               	cmpq	$0x0, %r12
               	jne	0x404352 <.text+0x3ef2>
               	movl	$0xc, %r12d
               	movq	%r12, -0xb0(%rbp)
               	jmp	0x404364 <.text+0x3f04>
               	movl	$0xb, %r12d
               	movq	%r12, -0xb0(%rbp)
               	jmp	0x404364 <.text+0x3f04>
               	movq	-0xb0(%rbp), %r12
               	movq	%r12, (%r14)
               	leaq	0xbe2b(%rip), %r15      # 0x4101a0
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %r12d
               	movq	%r12, (%r14)
               	movq	(%r15), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0x1, %eax
               	movq	%rax, (%r12)
               	movq	(%r15), %r14
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	leaq	0xbe12(%rip), %r14      # 0x4101d0
               	movq	(%r14), %r15
               	cmpq	$0x2, %r15
               	jle	0x4043e0 <.text+0x3f80>
               	movl	$0x8, %r15d
               	movq	%r15, -0xb8(%rbp)
               	jmp	0x4043f2 <.text+0x3f92>
               	movl	$0x1, %r15d
               	movq	%r15, -0xb8(%rbp)
               	jmp	0x4043f2 <.text+0x3f92>
               	movq	-0xb8(%rbp), %r15
               	movq	%r15, (%rax)
               	leaq	0xbd9d(%rip), %r14      # 0x4101a0
               	movq	(%r14), %r15
               	movq	%r15, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	leaq	0xbda6(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r14
               	cmpq	$0xa2, %r14
               	jne	0x40443c <.text+0x3fdc>
               	movl	$0x1a, %r14d
               	movq	%r14, -0xc0(%rbp)
               	jmp	0x40444e <.text+0x3fee>
               	movl	$0x19, %r14d
               	movq	%r14, -0xc0(%rbp)
               	jmp	0x40444e <.text+0x3fee>
               	movq	-0xc0(%rbp), %r14
               	movq	%r14, (%rax)
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x404137 <.text+0x3cd7>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xbd32(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	movl	$0xd, %r12d
               	movq	%r12, (%r15)
               	movl	$0x8e, %r14d
               	movq	%r14, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	leaq	0xbd24(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x5d, %r14
               	jne	0x404520 <.text+0x40c0>
               	jmp	0x404500 <.text+0x40a0>
               	jmp	0x404137 <.text+0x3cd7>
               	leaq	0xbfc9(%rip), %r14      # 0x410486
               	leaq	0xbd1c(%rip), %r15      # 0x4101e0
               	movq	(%r15), %r12
               	leaq	0xbcf2(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x4044b1 <.text+0x4051>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x40450a <.text+0x40aa>
               	movq	-0x8(%rbp), %r15
               	cmpq	$0x2, %r15
               	jle	0x404626 <.text+0x41c6>
               	jmp	0x40455d <.text+0x40fd>
               	leaq	0xbf28(%rip), %r14      # 0x41044f
               	leaq	0xbcb2(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x40450a <.text+0x40aa>
               	leaq	0xbc3c(%rip), %r15      # 0x4101a0
               	movq	(%r15), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0xd, %eax
               	movq	%rax, (%r14)
               	movq	(%r15), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x1, %r12d
               	movq	%r12, (%rax)
               	movq	(%r15), %r14
               	movq	%r14, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0x8, %r14d
               	movq	%r14, (%r12)
               	movq	(%r15), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0x1b, %eax
               	movq	%rax, (%r14)
               	jmp	0x4045cc <.text+0x416c>
               	leaq	0xbbcd(%rip), %r15      # 0x4101a0
               	movq	(%r15), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movl	$0x19, %eax
               	movq	%rax, (%r12)
               	movq	(%r15), %r14
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	leaq	0xbbcd(%rip), %r14      # 0x4101d0
               	movq	-0x8(%rbp), %r15
               	movq	%r15, %r12
               	subq	$0x2, %r12
               	movq	%r12, (%r14)
               	cmpq	$0x0, %r12
               	jne	0x40468b <.text+0x422b>
               	jmp	0x404679 <.text+0x4219>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2, %rax
               	jge	0x404674 <.text+0x4214>
               	leaq	0xbe2d(%rip), %r12      # 0x41046b
               	leaq	0xbb9b(%rip), %r15      # 0x4101e0
               	movq	(%r15), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x404674 <.text+0x4214>
               	jmp	0x4045cc <.text+0x416c>
               	movl	$0xa, %r12d
               	movq	%r12, -0xc8(%rbp)
               	jmp	0x40469d <.text+0x423d>
               	movl	$0x9, %r12d
               	movq	%r12, -0xc8(%rbp)
               	jmp	0x40469d <.text+0x423d>
               	movq	-0xc8(%rbp), %r12
               	movq	%r12, (%rax)
               	jmp	0x4044b1 <.text+0x4051>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xbaef(%rip), %r11      # 0x4101c0
               	movq	(%r11), %r9
               	cmpq	$0x89, %r9
               	jne	0x404727 <.text+0x42c7>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xbad3(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rbx
               	cmpq	$0x28, %rbx
               	jne	0x404777 <.text+0x4317>
               	jmp	0x404743 <.text+0x42e3>
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xba92(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rdi
               	cmpq	$0x8d, %rdi
               	jne	0x404905 <.text+0x44a5>
               	jmp	0x4048c7 <.text+0x4467>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x40474d <.text+0x42ed>
               	movl	$0x8e, %r12d
               	movq	%r12, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	leaq	0xba5e(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x29, %r12
               	jne	0x404813 <.text+0x43b3>
               	jmp	0x4047b4 <.text+0x4354>
               	leaq	0xbd22(%rip), %rbx      # 0x4104a0
               	leaq	0xba5b(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x40474d <.text+0x42ed>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x4047be <.text+0x435e>
               	leaq	0xb9db(%rip), %rbx      # 0x4101a0
               	movq	(%rbx), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rbx)
               	movl	$0x4, %eax
               	movq	%rax, (%r12)
               	movq	(%rbx), %rdi
               	movq	%rdi, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	%rax, -0x10(%rbp)
               	callq	0x4046ac <.text+0x424c>
               	leaq	0xb9c2(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rdi
               	cmpq	$0x87, %rdi
               	jne	0x4048a7 <.text+0x4447>
               	jmp	0x404850 <.text+0x43f0>
               	leaq	0xbc9f(%rip), %r12      # 0x4104b9
               	leaq	0xb9bf(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x4047be <.text+0x435e>
               	movq	-0x10(%rbp), %rdi
               	leaq	0xb945(%rip), %rax      # 0x4101a0
               	movq	(%rax), %rbx
               	movq	%rbx, %r12
               	addq	$0x18, %r12
               	movq	%r12, (%rdi)
               	movq	(%rax), %rbx
               	movq	%rbx, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	movl	$0x2, %ebx
               	movq	%rbx, (%r12)
               	movq	(%rax), %rdi
               	movq	%rdi, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%rax)
               	movq	%rbx, -0x10(%rbp)
               	callq	0x4005ad <.text+0x14d>
               	callq	0x4046ac <.text+0x424c>
               	jmp	0x4048a7 <.text+0x4447>
               	movq	-0x10(%rbp), %rbx
               	leaq	0xb8ee(%rip), %rax      # 0x4101a0
               	movq	(%rax), %rdi
               	movq	%rdi, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	jmp	0x404702 <.text+0x42a2>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xb8cd(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r14
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	0xb8d5(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x28, %rax
               	jne	0x404955 <.text+0x44f5>
               	jmp	0x404921 <.text+0x44c1>
               	jmp	0x404702 <.text+0x42a2>
               	leaq	0xb8b4(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x8b, %r15
               	jne	0x404a81 <.text+0x4621>
               	jmp	0x404a5b <.text+0x45fb>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x40492b <.text+0x44cb>
               	movl	$0x8e, %r15d
               	movq	%r15, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	leaq	0xb880(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0x29, %r15
               	jne	0x404a1e <.text+0x45be>
               	jmp	0x404992 <.text+0x4532>
               	leaq	0xbb77(%rip), %r14      # 0x4104d3
               	leaq	0xb87d(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x40492b <.text+0x44cb>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x40499c <.text+0x453c>
               	leaq	0xb7fd(%rip), %rbx      # 0x4101a0
               	movq	(%rbx), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rbx)
               	movl	$0x4, %eax
               	movq	%rax, (%r15)
               	movq	(%rbx), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	%rax, -0x10(%rbp)
               	callq	0x4046ac <.text+0x424c>
               	movq	(%rbx), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rbx)
               	movl	$0x2, %eax
               	movq	%rax, (%r12)
               	movq	(%rbx), %r15
               	movq	%r15, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	-0x8(%rbp), %r15
               	movq	%r15, (%rax)
               	movq	-0x10(%rbp), %r12
               	movq	(%rbx), %r15
               	movq	%r15, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r12)
               	jmp	0x404900 <.text+0x44a0>
               	leaq	0xbac7(%rip), %r15      # 0x4104ec
               	leaq	0xb7b4(%rip), %rax      # 0x4101e0
               	movq	(%rax), %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x40499c <.text+0x453c>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xb759(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x3b, %r14
               	je	0x404ab0 <.text+0x4650>
               	jmp	0x404a9e <.text+0x463e>
               	jmp	0x404900 <.text+0x44a0>
               	leaq	0xb738(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x7b, %rax
               	jne	0x404b42 <.text+0x46e2>
               	jmp	0x404b33 <.text+0x46d3>
               	movl	$0x8e, %ebx
               	movq	%rbx, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	jmp	0x404ab0 <.text+0x4650>
               	leaq	0xb6e9(%rip), %rbx      # 0x4101a0
               	movq	(%rbx), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rbx)
               	movl	$0x8, %eax
               	movq	%rax, (%r12)
               	leaq	0xb6e9(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %rax
               	cmpq	$0x3b, %rax
               	jne	0x404af6 <.text+0x4696>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x404af1 <.text+0x4691>
               	jmp	0x404a7c <.text+0x461c>
               	leaq	0xba09(%rip), %rbx      # 0x410506
               	leaq	0xb6dc(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x404af1 <.text+0x4691>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x404b5e <.text+0x46fe>
               	jmp	0x404a7c <.text+0x461c>
               	leaq	0xb677(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x3b, %rax
               	jne	0x404b9b <.text+0x473b>
               	jmp	0x404b8c <.text+0x472c>
               	leaq	0xb65b(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x7d, %rax
               	je	0x404b82 <.text+0x4722>
               	callq	0x4046ac <.text+0x424c>
               	movq	%rax, %r14
               	jmp	0x404b5e <.text+0x46fe>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x404b3d <.text+0x46dd>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x404b96 <.text+0x4736>
               	jmp	0x404b3d <.text+0x46dd>
               	movl	$0x8e, %r14d
               	movq	%r14, %rdi
               	callq	0x402101 <.text+0x1ca1>
               	leaq	0xb610(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x3b, %r14
               	jne	0x404bcf <.text+0x476f>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x404bca <.text+0x476a>
               	jmp	0x404b96 <.text+0x4736>
               	leaq	0xb948(%rip), %r14      # 0x41051e
               	leaq	0xb603(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r12
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x407049 <exit>
               	movslq	%eax, %rax
               	jmp	0x404bca <.text+0x476a>
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x130, %rsp            # imm = 0x130
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %r11
               	movq	%r11, 0x10(%rbp)
               	movq	%rsi, %r9
               	movq	%r9, 0x20(%rbp)
               	leaq	0x10(%rbp), %r11
               	movq	(%r11), %r9
               	movq	%r9, %r8
               	addq	$-0x1, %r8
               	movq	%r8, (%r11)
               	leaq	0x20(%rbp), %r9
               	movq	(%r9), %r8
               	movq	%r8, %r11
               	addq	$0x8, %r11
               	movq	%r11, (%r9)
               	movq	0x10(%rbp), %r8
               	cmpq	$0x0, %r8
               	setg	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xa0(%rbp)
               	cmpq	$0x0, %r11
               	je	0x404cda <.text+0x487a>
               	movq	0x20(%rbp), %r8
               	movq	(%r8), %r11
               	movzbq	(%r11), %r8
               	movq	%r8, %r11
               	xorq	$0x2d, %r11
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	sete	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xa0(%rbp)
               	jmp	0x404cda <.text+0x487a>
               	movq	-0xa0(%rbp), %r11
               	movq	%r11, -0x98(%rbp)
               	cmpq	$0x0, %r11
               	je	0x404d38 <.text+0x48d8>
               	movq	0x20(%rbp), %r8
               	movq	(%r8), %r11
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r11
               	movq	%r11, %r8
               	xorq	$0x73, %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r8, %r11
               	cmpq	$0x0, %r11
               	sete	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x98(%rbp)
               	jmp	0x404d38 <.text+0x48d8>
               	movq	-0x98(%rbp), %r8
               	cmpq	$0x0, %r8
               	je	0x404d89 <.text+0x4929>
               	leaq	0xb495(%rip), %r11      # 0x4101e8
               	movl	$0x1, %r8d
               	movq	%r8, (%r11)
               	leaq	0x10(%rbp), %r9
               	movq	(%r9), %r8
               	movq	%r8, %r11
               	addq	$-0x1, %r11
               	movq	%r11, (%r9)
               	leaq	0x20(%rbp), %r8
               	movq	(%r8), %r11
               	movq	%r11, %r9
               	addq	$0x8, %r9
               	movq	%r9, (%r8)
               	jmp	0x404d89 <.text+0x4929>
               	movq	0x10(%rbp), %r9
               	cmpq	$0x0, %r9
               	setg	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xb0(%rbp)
               	cmpq	$0x0, %r11
               	je	0x404de9 <.text+0x4989>
               	movq	0x20(%rbp), %r9
               	movq	(%r9), %r11
               	movzbq	(%r11), %r9
               	movq	%r9, %r11
               	xorq	$0x2d, %r11
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	sete	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0xb0(%rbp)
               	jmp	0x404de9 <.text+0x4989>
               	movq	-0xb0(%rbp), %r11
               	movq	%r11, -0xa8(%rbp)
               	cmpq	$0x0, %r11
               	je	0x404e47 <.text+0x49e7>
               	movq	0x20(%rbp), %r9
               	movq	(%r9), %r11
               	movq	%r11, %r9
               	addq	$0x1, %r9
               	movzbq	(%r9), %r11
               	movq	%r11, %r9
               	xorq	$0x64, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r9, %r11
               	cmpq	$0x0, %r11
               	sete	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0xa8(%rbp)
               	jmp	0x404e47 <.text+0x49e7>
               	movq	-0xa8(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	0x404e98 <.text+0x4a38>
               	leaq	0xb38e(%rip), %r11      # 0x4101f0
               	movl	$0x1, %r9d
               	movq	%r9, (%r11)
               	leaq	0x10(%rbp), %r8
               	movq	(%r8), %r9
               	movq	%r9, %r11
               	addq	$-0x1, %r11
               	movq	%r11, (%r8)
               	leaq	0x20(%rbp), %r9
               	movq	(%r9), %r11
               	movq	%r11, %r8
               	addq	$0x8, %r8
               	movq	%r8, (%r9)
               	jmp	0x404e98 <.text+0x4a38>
               	movq	0x10(%rbp), %r8
               	cmpq	$0x1, %r8
               	jge	0x404ef4 <.text+0x4a94>
               	leaq	0xb686(%rip), %rbx      # 0x410536
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movq	0x20(%rbp), %rbx
               	movq	(%rbx), %r12
               	xorq	%r14, %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40704f <open>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	cmpq	$0x0, %rbx
               	jge	0x404f73 <.text+0x4b13>
               	leaq	0xb62f(%rip), %r15      # 0x410554
               	movq	0x20(%rbp), %r14
               	movq	(%r14), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movl	$0x40000, %r12d         # imm = 0x40000
               	movslq	%r12d, %r10
               	movq	%r10, 0x48(%rsp)
               	leaq	0xb230(%rip), %r12      # 0x4101b8
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x407055 <malloc>
               	movq	%rax, (%r12)
               	cmpq	$0x0, %rax
               	jne	0x404ff5 <.text+0x4b95>
               	leaq	0xb5bc(%rip), %r15      # 0x410568
               	movq	%r15, %rdi
               	movq	0x48(%rsp), %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xb1ac(%rip), %r12      # 0x4101a8
               	leaq	0xb19d(%rip), %r15      # 0x4101a0
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x407055 <malloc>
               	movq	%rax, (%r15)
               	movq	%rax, (%r12)
               	cmpq	$0x0, %rax
               	jne	0x405073 <.text+0x4c13>
               	leaq	0xb560(%rip), %r15      # 0x41058a
               	movq	%r15, %rdi
               	movq	0x48(%rsp), %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xb11e(%rip), %r12      # 0x410198
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x407055 <malloc>
               	movq	%rax, (%r12)
               	cmpq	$0x0, %rax
               	jne	0x4050e7 <.text+0x4c87>
               	leaq	0xb50c(%rip), %r12      # 0x4105aa
               	movq	%r12, %rdi
               	movq	0x48(%rsp), %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x407055 <malloc>
               	movq	%rax, -0x38(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x405154 <.text+0x4cf4>
               	leaq	0xb4bf(%rip), %r15      # 0x4105ca
               	movq	%r15, %rdi
               	movq	0x48(%rsp), %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xb05d(%rip), %r15      # 0x4101b8
               	movq	(%r15), %r12
               	xorq	%r15, %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movq	0x48(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	0x40705b <memset>
               	leaq	0xb026(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r12
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movq	0x48(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	0x40705b <memset>
               	leaq	0xb002(%rip), %rax      # 0x410198
               	movq	(%rax), %r12
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movq	0x48(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	0x40705b <memset>
               	leaq	0xafd6(%rip), %rax      # 0x410188
               	leaq	0xb432(%rip), %r12      # 0x4105eb
               	movq	%r12, (%rax)
               	movl	$0x86, %r15d
               	movq	%r15, -0x58(%rbp)
               	jmp	0x4051cb <.text+0x4d6b>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x8d, %r15
               	jg	0x405208 <.text+0x4da8>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xafc8(%rip), %rax      # 0x4101b0
               	movq	(%rax), %r12
               	leaq	-0x58(%rbp), %rax
               	movq	(%rax), %r15
               	movq	%r15, %rdx
               	addq	$0x1, %rdx
               	movq	%rdx, (%rax)
               	movq	%r15, (%r12)
               	jmp	0x4051cb <.text+0x4d6b>
               	movl	$0x1e, %r15d
               	movq	%r15, -0x58(%rbp)
               	jmp	0x405217 <.text+0x4db7>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x26, %r15
               	jg	0x405289 <.text+0x4e29>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xaf7c(%rip), %rax      # 0x4101b0
               	movq	(%rax), %r12
               	movq	%r12, %rcx
               	addq	$0x18, %rcx
               	movl	$0x82, %r12d
               	movq	%r12, (%rcx)
               	movq	(%rax), %rdx
               	movq	%rdx, %r12
               	addq	$0x20, %r12
               	movl	$0x1, %edx
               	movq	%rdx, (%r12)
               	movq	(%rax), %rcx
               	movq	%rcx, %rax
               	addq	$0x28, %rax
               	leaq	-0x58(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movq	%rdx, %r12
               	addq	$0x1, %r12
               	movq	%r12, (%rcx)
               	movq	%rdx, (%rax)
               	jmp	0x405217 <.text+0x4db7>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xaf1b(%rip), %r15      # 0x4101b0
               	movq	(%r15), %r12
               	movl	$0x86, %edx
               	movq	%rdx, (%r12)
               	callq	0x4005ad <.text+0x14d>
               	movq	(%r15), %r10
               	movq	%r10, 0x40(%rsp)
               	leaq	0xaedb(%rip), %r15      # 0x410190
               	leaq	0xaecc(%rip), %r14      # 0x410188
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x407055 <malloc>
               	movq	%rax, (%r14)
               	movq	%rax, (%r15)
               	cmpq	$0x0, %rax
               	jne	0x40532b <.text+0x4ecb>
               	leaq	0xb373(%rip), %r14      # 0x410655
               	movq	%r14, %rdi
               	movq	0x48(%rsp), %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xae56(%rip), %r14      # 0x410188
               	movq	(%r14), %r15
               	movq	0x48(%rsp), %r14
               	subq	$0x1, %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x407061 <read>
               	movslq	%eax, %rax
               	movq	%rax, -0x58(%rbp)
               	cmpq	$0x0, %rax
               	jg	0x4053b7 <.text+0x4f57>
               	leaq	0xb30b(%rip), %r15      # 0x410677
               	movq	-0x58(%rbp), %r14
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xadca(%rip), %r14      # 0x410188
               	movq	(%r14), %rax
               	movq	-0x58(%rbp), %r14
               	movq	%rax, %r15
               	addq	%r14, %r15
               	xorq	%r14, %r14
               	movb	%r14b, (%r15)
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x407067 <close>
               	movslq	%eax, %rax
               	leaq	0xadfb(%rip), %rax      # 0x4101e0
               	movl	$0x1, %ebx
               	movq	%rbx, (%rax)
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x4053f7 <.text+0x4f97>
               	leaq	0xadc2(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %rax
               	cmpq	$0x0, %rax
               	je	0x405433 <.text+0x4fd3>
               	movl	$0x1, %ebx
               	movq	%rbx, -0x10(%rbp)
               	leaq	0xada2(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rbx
               	cmpq	$0x8a, %rbx
               	jne	0x405467 <.text+0x5007>
               	jmp	0x405458 <.text+0x4ff8>
               	movq	0x40(%rsp), %rbx
               	addq	$0x28, %rbx
               	movq	(%rbx), %rax
               	movq	%rax, -0x30(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x40615c <.text+0x5cfc>
               	jmp	0x406111 <.text+0x5cb1>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x405462 <.text+0x5002>
               	jmp	0x4056df <.text+0x527f>
               	leaq	0xad52(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0x86, %rax
               	jne	0x405494 <.text+0x5034>
               	callq	0x4005ad <.text+0x14d>
               	xorq	%rax, %rax
               	movq	%rax, -0x10(%rbp)
               	jmp	0x40548f <.text+0x502f>
               	jmp	0x405462 <.text+0x5002>
               	leaq	0xad25(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rbx
               	cmpq	$0x88, %rbx
               	jne	0x4054cc <.text+0x506c>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xad09(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0x7b, %r15
               	je	0x4054db <.text+0x507b>
               	jmp	0x4054d1 <.text+0x5071>
               	jmp	0x40548f <.text+0x502f>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x4054db <.text+0x507b>
               	leaq	0xacde(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %rax
               	cmpq	$0x7b, %rax
               	jne	0x405503 <.text+0x50a3>
               	callq	0x4005ad <.text+0x14d>
               	xorq	%rax, %rax
               	movq	%rax, -0x58(%rbp)
               	jmp	0x405508 <.text+0x50a8>
               	jmp	0x4054cc <.text+0x506c>
               	leaq	0xacb1(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0x7d, %r15
               	je	0x40553b <.text+0x50db>
               	leaq	0xac9a(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0x85, %rax
               	je	0x4055aa <.text+0x514a>
               	jmp	0x405545 <.text+0x50e5>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x405503 <.text+0x50a3>
               	leaq	0xb13f(%rip), %rbx      # 0x41068b
               	leaq	0xac8d(%rip), %r15      # 0x4101e0
               	movq	(%r15), %r14
               	leaq	0xac63(%rip), %r15      # 0x4101c0
               	movq	(%r15), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xac0a(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r15
               	cmpq	$0x8e, %r15
               	jne	0x4055e7 <.text+0x5187>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xabee(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x80, %r12
               	je	0x4056b4 <.text+0x5254>
               	jmp	0x40565c <.text+0x51fc>
               	leaq	0xabc2(%rip), %r12      # 0x4101b0
               	movq	(%r12), %rax
               	movq	%rax, %r15
               	addq	$0x18, %r15
               	movl	$0x80, %eax
               	movq	%rax, (%r15)
               	movq	(%r12), %rbx
               	movq	%rbx, %rax
               	addq	$0x20, %rax
               	movl	$0x1, %ebx
               	movq	%rbx, (%rax)
               	movq	(%r12), %r15
               	movq	%r15, %r12
               	addq	$0x28, %r12
               	leaq	-0x58(%rbp), %r15
               	movq	(%r15), %rbx
               	movq	%rbx, %rax
               	addq	$0x1, %rax
               	movq	%rax, (%r15)
               	movq	%rbx, (%r12)
               	leaq	0xab79(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rbx
               	cmpq	$0x2c, %rbx
               	jne	0x4056da <.text+0x527a>
               	jmp	0x4056cd <.text+0x526d>
               	leaq	0xb044(%rip), %r15      # 0x4106a7
               	leaq	0xab76(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r12
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xab0d(%rip), %r12      # 0x4101c8
               	movq	(%r12), %rax
               	movq	%rax, -0x58(%rbp)
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x4055e7 <.text+0x5187>
               	callq	0x4005ad <.text+0x14d>
               	movq	%rax, %r14
               	jmp	0x4056da <.text+0x527a>
               	jmp	0x405508 <.text+0x50a8>
               	leaq	0xaada(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x3b, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0xb8(%rbp)
               	cmpq	$0x0, %r14
               	je	0x40574d <.text+0x52ed>
               	jmp	0x405728 <.text+0x52c8>
               	movq	-0x10(%rbp), %r14
               	movq	%r14, -0x18(%rbp)
               	jmp	0x405766 <.text+0x5306>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x4053f7 <.text+0x4f97>
               	leaq	0xaa91(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r14
               	cmpq	$0x7d, %r14
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xb8(%rbp)
               	jmp	0x40574d <.text+0x52ed>
               	movq	-0xb8(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x40571e <.text+0x52be>
               	jmp	0x405711 <.text+0x52b1>
               	leaq	0xaa53(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x9f, %rax
               	jne	0x405799 <.text+0x5339>
               	callq	0x4005ad <.text+0x14d>
               	movq	-0x18(%rbp), %rax
               	movq	%rax, %rbx
               	addq	$0x2, %rbx
               	movq	%rbx, -0x18(%rbp)
               	jmp	0x405766 <.text+0x5306>
               	leaq	0xaa20(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %rax
               	cmpq	$0x85, %rax
               	je	0x405808 <.text+0x53a8>
               	leaq	0xaf0a(%rip), %r14      # 0x4106c1
               	leaq	0xaa22(%rip), %rbx      # 0x4101e0
               	movq	(%rbx), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xa9a1(%rip), %r15      # 0x4101b0
               	movq	(%r15), %rax
               	movq	%rax, %r15
               	addq	$0x18, %r15
               	movq	(%r15), %rax
               	cmpq	$0x0, %rax
               	je	0x405884 <.text+0x5424>
               	leaq	0xaeaa(%rip), %rbx      # 0x4106dd
               	leaq	0xa9a6(%rip), %rax      # 0x4101e0
               	movq	(%rax), %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xa920(%rip), %rax      # 0x4101b0
               	movq	(%rax), %r14
               	movq	%r14, %rax
               	addq	$0x20, %rax
               	movq	-0x18(%rbp), %r14
               	movq	%r14, (%rax)
               	leaq	0xa915(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r14
               	cmpq	$0x28, %r14
               	jne	0x405929 <.text+0x54c9>
               	leaq	0xa8ee(%rip), %r14      # 0x4101b0
               	movq	(%r14), %rbx
               	movq	%rbx, %rax
               	addq	$0x18, %rax
               	movl	$0x81, %ebx
               	movq	%rbx, (%rax)
               	movq	(%r14), %r12
               	movq	%r12, %r14
               	addq	$0x28, %r14
               	leaq	0xa8b5(%rip), %r12      # 0x4101a0
               	movq	(%r12), %rbx
               	movq	%rbx, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r14)
               	callq	0x4005ad <.text+0x14d>
               	xorq	%rax, %rax
               	movq	%rax, -0x58(%rbp)
               	jmp	0x405977 <.text+0x5517>
               	leaq	0xa8ac(%rip), %rbx      # 0x4101c0
               	movq	(%rbx), %r15
               	cmpq	$0x2c, %r15
               	jne	0x40610c <.text+0x5cac>
               	jmp	0x4060ff <.text+0x5c9f>
               	leaq	0xa880(%rip), %r12      # 0x4101b0
               	movq	(%r12), %rbx
               	movq	%rbx, %r15
               	addq	$0x18, %r15
               	movl	$0x83, %ebx
               	movq	%rbx, (%r15)
               	movq	(%r12), %rax
               	movq	%rax, %r12
               	addq	$0x28, %r12
               	leaq	0xa83d(%rip), %rax      # 0x410198
               	movq	(%rax), %rbx
               	movq	%rbx, (%r12)
               	movq	(%rax), %r15
               	movq	%r15, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%rax)
               	jmp	0x40590d <.text+0x54ad>
               	leaq	0xa842(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x29, %r12
               	je	0x4059b4 <.text+0x5554>
               	movl	$0x1, %r12d
               	movq	%r12, -0x18(%rbp)
               	leaq	0xa821(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x8a, %r12
               	jne	0x4059e4 <.text+0x5584>
               	jmp	0x4059d5 <.text+0x5575>
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xa800(%rip), %rax      # 0x4101c0
               	movq	(%rax), %rbx
               	cmpq	$0x7b, %rbx
               	je	0x405c6c <.text+0x580c>
               	jmp	0x405c14 <.text+0x57b4>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x4059df <.text+0x557f>
               	jmp	0x405a11 <.text+0x55b1>
               	leaq	0xa7d5(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0x86, %rax
               	jne	0x405a0c <.text+0x55ac>
               	callq	0x4005ad <.text+0x14d>
               	xorq	%rax, %rax
               	movq	%rax, -0x18(%rbp)
               	jmp	0x405a0c <.text+0x55ac>
               	jmp	0x4059df <.text+0x557f>
               	leaq	0xa7a8(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x9f, %r12
               	jne	0x405a44 <.text+0x55e4>
               	callq	0x4005ad <.text+0x14d>
               	movq	-0x18(%rbp), %rax
               	movq	%rax, %r15
               	addq	$0x2, %r15
               	movq	%r15, -0x18(%rbp)
               	jmp	0x405a11 <.text+0x55b1>
               	leaq	0xa775(%rip), %r15      # 0x4101c0
               	movq	(%r15), %rax
               	cmpq	$0x85, %rax
               	je	0x405ab3 <.text+0x5653>
               	leaq	0xac9c(%rip), %r12      # 0x4106fe
               	leaq	0xa777(%rip), %r15      # 0x4101e0
               	movq	(%r15), %rbx
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xa6f6(%rip), %rbx      # 0x4101b0
               	movq	(%rbx), %rax
               	movq	%rax, %rbx
               	addq	$0x18, %rbx
               	movq	(%rbx), %rax
               	cmpq	$0x84, %rax
               	jne	0x405b2f <.text+0x56cf>
               	leaq	0xac3f(%rip), %r15      # 0x41071d
               	leaq	0xa6fb(%rip), %rbx      # 0x4101e0
               	movq	(%rbx), %r14
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xa67a(%rip), %r14      # 0x4101b0
               	movq	(%r14), %rax
               	movq	%rax, %r15
               	addq	$0x30, %r15
               	movq	(%r14), %rax
               	movq	%rax, %r12
               	addq	$0x18, %r12
               	movq	(%r12), %rax
               	movq	%rax, (%r15)
               	movq	(%r14), %r12
               	movq	%r12, %rax
               	addq	$0x18, %rax
               	movl	$0x84, %r12d
               	movq	%r12, (%rax)
               	movq	(%r14), %r15
               	movq	%r15, %r12
               	addq	$0x38, %r12
               	movq	(%r14), %r15
               	movq	%r15, %rax
               	addq	$0x20, %rax
               	movq	(%rax), %r15
               	movq	%r15, (%r12)
               	movq	(%r14), %rax
               	movq	%rax, %r15
               	addq	$0x20, %r15
               	movq	-0x18(%rbp), %rax
               	movq	%rax, (%r15)
               	movq	(%r14), %r12
               	movq	%r12, %rax
               	addq	$0x40, %rax
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x28, %r15
               	movq	(%r15), %r12
               	movq	%r12, (%rax)
               	movq	(%r14), %r15
               	movq	%r15, %r14
               	addq	$0x28, %r14
               	leaq	-0x58(%rbp), %r15
               	movq	(%r15), %r12
               	movq	%r12, %rax
               	addq	$0x1, %rax
               	movq	%rax, (%r15)
               	movq	%r12, (%r14)
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xa5ce(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x2c, %r12
               	jne	0x405c0f <.text+0x57af>
               	callq	0x4005ad <.text+0x14d>
               	movq	%rax, %rbx
               	jmp	0x405c0f <.text+0x57af>
               	jmp	0x405977 <.text+0x5517>
               	leaq	0xab26(%rip), %r15      # 0x410741
               	leaq	0xa5be(%rip), %rax      # 0x4101e0
               	movq	(%rax), %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xa565(%rip), %rbx      # 0x4101d8
               	leaq	-0x58(%rbp), %rax
               	movq	(%rax), %r15
               	movq	%r15, %r12
               	addq	$0x1, %r12
               	movq	%r12, (%rax)
               	movq	%r12, (%rbx)
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x405c94 <.text+0x5834>
               	leaq	0xa525(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x8a, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0xc0(%rbp)
               	cmpq	$0x0, %r12
               	jne	0x405d54 <.text+0x58f4>
               	jmp	0x405d2f <.text+0x58cf>
               	leaq	0xa4f2(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x8a, %rax
               	jne	0x405d7e <.text+0x591e>
               	jmp	0x405d6d <.text+0x590d>
               	leaq	0xa4b5(%rip), %r14      # 0x4101a0
               	movq	(%r14), %rax
               	movq	%rax, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r14)
               	movl	$0x6, %eax
               	movq	%rax, (%rbx)
               	movq	(%r14), %r12
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movq	-0x58(%rbp), %r12
               	leaq	0xa4ba(%rip), %r14      # 0x4101d8
               	movq	(%r14), %rbx
               	movq	%r12, %r14
               	subq	%rbx, %r14
               	movq	%r14, (%rax)
               	jmp	0x405fd4 <.text+0x5b74>
               	leaq	0xa48a(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x86, %r12
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0xc0(%rbp)
               	jmp	0x405d54 <.text+0x58f4>
               	movq	-0xc0(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x405ce4 <.text+0x5884>
               	jmp	0x405cc7 <.text+0x5867>
               	movl	$0x1, %eax
               	movq	%rax, -0xc8(%rbp)
               	jmp	0x405d8d <.text+0x592d>
               	xorq	%rax, %rax
               	movq	%rax, -0xc8(%rbp)
               	jmp	0x405d8d <.text+0x592d>
               	movq	-0xc8(%rbp), %rax
               	movq	%rax, -0x10(%rbp)
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x405da2 <.text+0x5942>
               	leaq	0xa417(%rip), %r12      # 0x4101c0
               	movq	(%r12), %rax
               	cmpq	$0x3b, %rax
               	je	0x405dc7 <.text+0x5967>
               	movq	-0x10(%rbp), %rax
               	movq	%rax, -0x18(%rbp)
               	jmp	0x405dd1 <.text+0x5971>
               	callq	0x4005ad <.text+0x14d>
               	jmp	0x405c94 <.text+0x5834>
               	leaq	0xa3e8(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x9f, %r12
               	jne	0x405e04 <.text+0x59a4>
               	callq	0x4005ad <.text+0x14d>
               	movq	-0x18(%rbp), %rax
               	movq	%rax, %r14
               	addq	$0x2, %r14
               	movq	%r14, -0x18(%rbp)
               	jmp	0x405dd1 <.text+0x5971>
               	leaq	0xa3b5(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rax
               	cmpq	$0x85, %rax
               	je	0x405e73 <.text+0x5a13>
               	leaq	0xa93c(%rip), %r12      # 0x41075e
               	leaq	0xa3b7(%rip), %r14      # 0x4101e0
               	movq	(%r14), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xa336(%rip), %r15      # 0x4101b0
               	movq	(%r15), %rax
               	movq	%rax, %r15
               	addq	$0x18, %r15
               	movq	(%r15), %rax
               	cmpq	$0x84, %rax
               	jne	0x405eef <.text+0x5a8f>
               	leaq	0xa8db(%rip), %r14      # 0x410779
               	leaq	0xa33b(%rip), %r15      # 0x4101e0
               	movq	(%r15), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xa2ba(%rip), %rbx      # 0x4101b0
               	movq	(%rbx), %rax
               	movq	%rax, %r14
               	addq	$0x30, %r14
               	movq	(%rbx), %rax
               	movq	%rax, %r12
               	addq	$0x18, %r12
               	movq	(%r12), %rax
               	movq	%rax, (%r14)
               	movq	(%rbx), %r12
               	movq	%r12, %rax
               	addq	$0x18, %rax
               	movl	$0x84, %r12d
               	movq	%r12, (%rax)
               	movq	(%rbx), %r14
               	movq	%r14, %r12
               	addq	$0x38, %r12
               	movq	(%rbx), %r14
               	movq	%r14, %rax
               	addq	$0x20, %rax
               	movq	(%rax), %r14
               	movq	%r14, (%r12)
               	movq	(%rbx), %rax
               	movq	%rax, %r14
               	addq	$0x20, %r14
               	movq	-0x18(%rbp), %rax
               	movq	%rax, (%r14)
               	movq	(%rbx), %r12
               	movq	%r12, %rax
               	addq	$0x40, %rax
               	movq	(%rbx), %r12
               	movq	%r12, %r14
               	addq	$0x28, %r14
               	movq	(%r14), %r12
               	movq	%r12, (%rax)
               	movq	(%rbx), %r14
               	movq	%r14, %rbx
               	addq	$0x28, %rbx
               	leaq	-0x58(%rbp), %r14
               	movq	(%r14), %r12
               	movq	%r12, %rax
               	addq	$0x1, %rax
               	movq	%rax, (%r14)
               	movq	%rax, (%rbx)
               	callq	0x4005ad <.text+0x14d>
               	leaq	0xa20e(%rip), %rax      # 0x4101c0
               	movq	(%rax), %r12
               	cmpq	$0x2c, %r12
               	jne	0x405fcf <.text+0x5b6f>
               	callq	0x4005ad <.text+0x14d>
               	movq	%rax, %r14
               	jmp	0x405fcf <.text+0x5b6f>
               	jmp	0x405da2 <.text+0x5942>
               	leaq	0xa1e5(%rip), %r14      # 0x4101c0
               	movq	(%r14), %rbx
               	cmpq	$0x7d, %rbx
               	je	0x405ff5 <.text+0x5b95>
               	callq	0x4046ac <.text+0x424c>
               	jmp	0x405fd4 <.text+0x5b74>
               	leaq	0xa1a4(%rip), %r15      # 0x4101a0
               	movq	(%r15), %rax
               	movq	%rax, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r15)
               	movl	$0x8, %eax
               	movq	%rax, (%rbx)
               	leaq	0xa195(%rip), %r15      # 0x4101b0
               	leaq	0xa196(%rip), %rax      # 0x4101b8
               	movq	(%rax), %rbx
               	movq	%rbx, (%r15)
               	jmp	0x40602d <.text+0x5bcd>
               	leaq	0xa17c(%rip), %rbx      # 0x4101b0
               	movq	(%rbx), %rax
               	movq	(%rax), %rbx
               	cmpq	$0x0, %rbx
               	je	0x406070 <.text+0x5c10>
               	leaq	0xa162(%rip), %rax      # 0x4101b0
               	movq	(%rax), %rbx
               	movq	%rbx, %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rbx
               	cmpq	$0x84, %rbx
               	jne	0x4060e3 <.text+0x5c83>
               	jmp	0x406075 <.text+0x5c15>
               	jmp	0x40590d <.text+0x54ad>
               	leaq	0xa134(%rip), %rbx      # 0x4101b0
               	movq	(%rbx), %rax
               	movq	%rax, %r15
               	addq	$0x18, %r15
               	movq	(%rbx), %rax
               	movq	%rax, %r12
               	addq	$0x30, %r12
               	movq	(%r12), %rax
               	movq	%rax, (%r15)
               	movq	(%rbx), %r12
               	movq	%r12, %rax
               	addq	$0x20, %rax
               	movq	(%rbx), %r12
               	movq	%r12, %r15
               	addq	$0x38, %r15
               	movq	(%r15), %r12
               	movq	%r12, (%rax)
               	movq	(%rbx), %r15
               	movq	%r15, %r12
               	addq	$0x28, %r12
               	movq	(%rbx), %r15
               	movq	%r15, %rbx
               	addq	$0x40, %rbx
               	movq	(%rbx), %r15
               	movq	%r15, (%r12)
               	jmp	0x4060e3 <.text+0x5c83>
               	leaq	0xa0c6(%rip), %r15      # 0x4101b0
               	movq	(%r15), %rbx
               	movq	%rbx, %r12
               	addq	$0x48, %r12
               	movq	%r12, (%r15)
               	jmp	0x40602d <.text+0x5bcd>
               	callq	0x4005ad <.text+0x14d>
               	movq	%rax, %rbx
               	jmp	0x40610c <.text+0x5cac>
               	jmp	0x4056df <.text+0x527f>
               	leaq	0xa681(%rip), %r15      # 0x410799
               	movq	%r15, %rdi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xa085(%rip), %r15      # 0x4101e8
               	movq	(%r15), %rax
               	cmpq	$0x0, %rax
               	je	0x4061a3 <.text+0x5d43>
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movq	-0x38(%rbp), %rax
               	movq	0x48(%rsp), %r10
               	movq	%rax, %r15
               	addq	%r10, %r15
               	movq	%r15, -0x38(%rbp)
               	movq	%r15, -0x40(%rbp)
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %r15
               	movq	%r15, %r14
               	addq	$-0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0x26, %r15d
               	movq	%r15, (%r14)
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %r15
               	movq	%r15, %r14
               	addq	$-0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0xd, %r15d
               	movq	%r15, (%r14)
               	movq	-0x38(%rbp), %rax
               	movq	%rax, -0x60(%rbp)
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %rax
               	movq	%rax, %r14
               	addq	$-0x8, %r14
               	movq	%r14, (%r15)
               	movq	0x10(%rbp), %rax
               	movq	%rax, (%r14)
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %rax
               	movq	%rax, %r14
               	addq	$-0x8, %r14
               	movq	%r14, (%r15)
               	movq	0x20(%rbp), %rax
               	movq	%rax, (%r14)
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %rax
               	movq	%rax, %r14
               	addq	$-0x8, %r14
               	movq	%r14, (%r15)
               	movq	-0x60(%rbp), %rax
               	movq	%rax, (%r14)
               	xorq	%r15, %r15
               	movq	%r15, -0x50(%rbp)
               	jmp	0x406259 <.text+0x5df9>
               	movl	$0x1, %r15d
               	cmpq	$0x0, %r15
               	je	0x4062b8 <.text+0x5e58>
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %r15
               	movq	%r15, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movq	(%r15), %r12
               	movq	%r12, -0x58(%rbp)
               	leaq	-0x50(%rbp), %r15
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x1, %r14
               	movq	%r14, (%r15)
               	leaq	0x9f4e(%rip), %r12      # 0x4101f0
               	movq	(%r12), %r14
               	cmpq	$0x0, %r14
               	je	0x40633e <.text+0x5ede>
               	jmp	0x4062e8 <.text+0x5e88>
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	leaq	0xa4be(%rip), %rbx      # 0x4107ad
               	movq	-0x50(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	0xa4b7(%rip), %r15      # 0x4107b6
               	movq	-0x58(%rbp), %rax
               	movl	$0x5, %r14d
               	imulq	%rax, %r14
               	movq	%r15, %r12
               	addq	%r14, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	0x38(%rsp), %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x7, %rax
               	jg	0x40637d <.text+0x5f1d>
               	jmp	0x406354 <.text+0x5ef4>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x0, %r12
               	jne	0x4063cc <.text+0x5f6c>
               	jmp	0x406396 <.text+0x5f36>
               	leaq	0xa51f(%rip), %r14      # 0x41087a
               	movq	-0x30(%rbp), %r12
               	movq	(%r12), %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	jmp	0x406378 <.text+0x5f18>
               	jmp	0x40633e <.text+0x5ede>
               	leaq	0xa4fb(%rip), %r12      # 0x41087f
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	jmp	0x406378 <.text+0x5f18>
               	movq	-0x40(%rbp), %r12
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %r14
               	movq	%r14, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%rax)
               	movq	(%r14), %r15
               	movq	%r15, %r14
               	shlq	$0x3, %r14
               	movq	%r12, %r15
               	addq	%r14, %r15
               	movq	%r15, -0x48(%rbp)
               	jmp	0x4063c7 <.text+0x5f67>
               	jmp	0x406259 <.text+0x5df9>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x1, %r15
               	jne	0x406402 <.text+0x5fa2>
               	leaq	-0x30(%rbp), %r15
               	movq	(%r15), %r14
               	movq	%r14, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%r15)
               	movq	(%r14), %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x4063fd <.text+0x5f9d>
               	jmp	0x4063c7 <.text+0x5f67>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x2, %rbx
               	jne	0x406428 <.text+0x5fc8>
               	movq	-0x30(%rbp), %rbx
               	movq	(%rbx), %r14
               	movq	%r14, -0x30(%rbp)
               	jmp	0x406423 <.text+0x5fc3>
               	jmp	0x4063fd <.text+0x5f9d>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x3, %r14
               	jne	0x406474 <.text+0x6014>
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %rbx
               	movq	%rbx, %r12
               	addq	$-0x8, %r12
               	movq	%r12, (%r14)
               	movq	-0x30(%rbp), %rbx
               	movq	%rbx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r12)
               	movq	-0x30(%rbp), %rbx
               	movq	(%rbx), %r14
               	movq	%r14, -0x30(%rbp)
               	jmp	0x40646f <.text+0x600f>
               	jmp	0x406423 <.text+0x5fc3>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x4, %r14
               	jne	0x4064a0 <.text+0x6040>
               	movq	-0x48(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	0x4064d0 <.text+0x6070>
               	jmp	0x4064b6 <.text+0x6056>
               	jmp	0x40646f <.text+0x600f>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x5, %rbx
               	jne	0x40650e <.text+0x60ae>
               	jmp	0x4064f3 <.text+0x6093>
               	movq	-0x30(%rbp), %rbx
               	movq	%rbx, %r14
               	addq	$0x8, %r14
               	movq	%r14, -0xd0(%rbp)
               	jmp	0x4064e3 <.text+0x6083>
               	movq	-0x30(%rbp), %r14
               	movq	(%r14), %rbx
               	movq	%rbx, -0xd0(%rbp)
               	jmp	0x4064e3 <.text+0x6083>
               	movq	-0xd0(%rbp), %rbx
               	movq	%rbx, -0x30(%rbp)
               	jmp	0x40649b <.text+0x603b>
               	movq	-0x48(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	je	0x406537 <.text+0x60d7>
               	jmp	0x406524 <.text+0x60c4>
               	jmp	0x40649b <.text+0x603b>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x6, %r14
               	jne	0x4065b8 <.text+0x6158>
               	jmp	0x406561 <.text+0x6101>
               	movq	-0x30(%rbp), %r14
               	movq	(%r14), %rbx
               	movq	%rbx, -0xd8(%rbp)
               	jmp	0x406551 <.text+0x60f1>
               	movq	-0x30(%rbp), %rbx
               	movq	%rbx, %r14
               	addq	$0x8, %r14
               	movq	%r14, -0xd8(%rbp)
               	jmp	0x406551 <.text+0x60f1>
               	movq	-0xd8(%rbp), %r14
               	movq	%r14, -0x30(%rbp)
               	jmp	0x406509 <.text+0x60a9>
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %rbx
               	movq	%rbx, %r12
               	addq	$-0x8, %r12
               	movq	%r12, (%r14)
               	movq	-0x40(%rbp), %rbx
               	movq	%rbx, (%r12)
               	movq	-0x38(%rbp), %r14
               	movq	%r14, -0x40(%rbp)
               	leaq	-0x30(%rbp), %rbx
               	movq	(%rbx), %r12
               	movq	%r12, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rbx)
               	movq	(%r12), %rax
               	movq	%rax, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rax
               	subq	%r12, %rax
               	movq	%rax, -0x38(%rbp)
               	jmp	0x4065b3 <.text+0x6153>
               	jmp	0x406509 <.text+0x60a9>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x7, %rax
               	jne	0x406601 <.text+0x61a1>
               	movq	-0x38(%rbp), %rax
               	leaq	-0x30(%rbp), %r12
               	movq	(%r12), %r14
               	movq	%r14, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r12)
               	movq	(%r14), %rbx
               	movq	%rbx, %r14
               	shlq	$0x3, %r14
               	movq	%rax, %rbx
               	addq	%r14, %rbx
               	movq	%rbx, -0x38(%rbp)
               	jmp	0x4065fc <.text+0x619c>
               	jmp	0x4065b3 <.text+0x6153>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x8, %rbx
               	jne	0x40665a <.text+0x61fa>
               	movq	-0x40(%rbp), %rbx
               	movq	%rbx, -0x38(%rbp)
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %rbx
               	movq	%rbx, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movq	(%rbx), %r15
               	movq	%r15, -0x40(%rbp)
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %r15
               	movq	%r15, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	(%r15), %r14
               	movq	%r14, -0x30(%rbp)
               	jmp	0x406655 <.text+0x61f5>
               	jmp	0x4065fc <.text+0x619c>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x9, %r14
               	jne	0x406680 <.text+0x6220>
               	movq	-0x48(%rbp), %r14
               	movq	(%r14), %r15
               	movq	%r15, -0x48(%rbp)
               	jmp	0x40667b <.text+0x621b>
               	jmp	0x406655 <.text+0x61f5>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0xa, %r15
               	jne	0x4066a7 <.text+0x6247>
               	movq	-0x48(%rbp), %r15
               	movzbq	(%r15), %r14
               	movq	%r14, -0x48(%rbp)
               	jmp	0x4066a2 <.text+0x6242>
               	jmp	0x40667b <.text+0x621b>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0xb, %r14
               	jne	0x4066e0 <.text+0x6280>
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %r15
               	movq	%r15, %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movq	(%r15), %rbx
               	movq	-0x48(%rbp), %r15
               	movq	%r15, (%rbx)
               	jmp	0x4066db <.text+0x627b>
               	jmp	0x4066a2 <.text+0x6242>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0xc, %r15
               	jne	0x40671d <.text+0x62bd>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %rax
               	movq	%rax, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r15)
               	movq	(%rax), %r14
               	movq	-0x48(%rbp), %rax
               	movb	%al, (%r14)
               	movq	%rax, -0x48(%rbp)
               	jmp	0x406718 <.text+0x62b8>
               	jmp	0x4066db <.text+0x627b>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0xd, %rax
               	jne	0x406753 <.text+0x62f3>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rbx
               	movq	%rbx, %r14
               	addq	$-0x8, %r14
               	movq	%r14, (%rax)
               	movq	-0x48(%rbp), %rbx
               	movq	%rbx, (%r14)
               	jmp	0x40674e <.text+0x62ee>
               	jmp	0x406718 <.text+0x62b8>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0xe, %rbx
               	jne	0x406793 <.text+0x6333>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	movq	(%rax), %r15
               	movq	-0x48(%rbp), %rax
               	movq	%r15, %r14
               	orq	%rax, %r14
               	movq	%r14, -0x48(%rbp)
               	jmp	0x40678e <.text+0x632e>
               	jmp	0x40674e <.text+0x62ee>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0xf, %r14
               	jne	0x4067d3 <.text+0x6373>
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movq	(%rax), %rbx
               	movq	-0x48(%rbp), %rax
               	movq	%rbx, %r15
               	xorq	%rax, %r15
               	movq	%r15, -0x48(%rbp)
               	jmp	0x4067ce <.text+0x636e>
               	jmp	0x40678e <.text+0x632e>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x10, %r15
               	jne	0x406813 <.text+0x63b3>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %rax
               	movq	%rax, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r15)
               	movq	(%rax), %r14
               	movq	-0x48(%rbp), %rax
               	movq	%r14, %rbx
               	andq	%rax, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x40680e <.text+0x63ae>
               	jmp	0x4067ce <.text+0x636e>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x11, %rbx
               	jne	0x406858 <.text+0x63f8>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	movq	(%rax), %r15
               	movq	-0x48(%rbp), %rax
               	cmpq	%rax, %r15
               	sete	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x48(%rbp)
               	jmp	0x406853 <.text+0x63f3>
               	jmp	0x40680e <.text+0x63ae>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x12, %r14
               	jne	0x40689d <.text+0x643d>
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movq	(%rax), %rbx
               	movq	-0x48(%rbp), %rax
               	cmpq	%rax, %rbx
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x48(%rbp)
               	jmp	0x406898 <.text+0x6438>
               	jmp	0x406853 <.text+0x63f3>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x13, %r15
               	jne	0x4068e2 <.text+0x6482>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %rax
               	movq	%rax, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r15)
               	movq	(%rax), %r14
               	movq	-0x48(%rbp), %rax
               	cmpq	%rax, %r14
               	setl	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x4068dd <.text+0x647d>
               	jmp	0x406898 <.text+0x6438>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x14, %rbx
               	jne	0x406927 <.text+0x64c7>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	movq	(%rax), %r15
               	movq	-0x48(%rbp), %rax
               	cmpq	%rax, %r15
               	setg	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x48(%rbp)
               	jmp	0x406922 <.text+0x64c2>
               	jmp	0x4068dd <.text+0x647d>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x15, %r14
               	jne	0x40696c <.text+0x650c>
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movq	(%rax), %rbx
               	movq	-0x48(%rbp), %rax
               	cmpq	%rax, %rbx
               	setle	%r15b
               	movzbq	%r15b, %r15
               	movq	%r15, -0x48(%rbp)
               	jmp	0x406967 <.text+0x6507>
               	jmp	0x406922 <.text+0x64c2>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x16, %r15
               	jne	0x4069b1 <.text+0x6551>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %rax
               	movq	%rax, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r15)
               	movq	(%rax), %r14
               	movq	-0x48(%rbp), %rax
               	cmpq	%rax, %r14
               	setge	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x4069ac <.text+0x654c>
               	jmp	0x406967 <.text+0x6507>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x17, %rbx
               	jne	0x4069f4 <.text+0x6594>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	movq	(%rax), %r15
               	movq	-0x48(%rbp), %rax
               	movq	%r15, %r14
               	movq	%rax, %rcx
               	shlq	%cl, %r14
               	movq	%r14, -0x48(%rbp)
               	jmp	0x4069ef <.text+0x658f>
               	jmp	0x4069ac <.text+0x654c>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x18, %r14
               	jne	0x406a37 <.text+0x65d7>
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movq	(%rax), %rbx
               	movq	-0x48(%rbp), %rax
               	movq	%rbx, %r15
               	movq	%rax, %rcx
               	sarq	%cl, %r15
               	movq	%r15, -0x48(%rbp)
               	jmp	0x406a32 <.text+0x65d2>
               	jmp	0x4069ef <.text+0x658f>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x19, %r15
               	jne	0x406a77 <.text+0x6617>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %rax
               	movq	%rax, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r15)
               	movq	(%rax), %r14
               	movq	-0x48(%rbp), %rax
               	movq	%r14, %rbx
               	addq	%rax, %rbx
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x406a72 <.text+0x6612>
               	jmp	0x406a32 <.text+0x65d2>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x1a, %rbx
               	jne	0x406ab7 <.text+0x6657>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	movq	(%rax), %r15
               	movq	-0x48(%rbp), %rax
               	movq	%r15, %r14
               	subq	%rax, %r14
               	movq	%r14, -0x48(%rbp)
               	jmp	0x406ab2 <.text+0x6652>
               	jmp	0x406a72 <.text+0x6612>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x1b, %r14
               	jne	0x406af8 <.text+0x6698>
               	leaq	-0x38(%rbp), %r14
               	movq	(%r14), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movq	(%rax), %rbx
               	movq	-0x48(%rbp), %rax
               	movq	%rbx, %r15
               	imulq	%rax, %r15
               	movq	%r15, -0x48(%rbp)
               	jmp	0x406af3 <.text+0x6693>
               	jmp	0x406ab2 <.text+0x6652>
               	movq	-0x58(%rbp), %r15
               	cmpq	$0x1c, %r15
               	jne	0x406b44 <.text+0x66e4>
               	leaq	-0x38(%rbp), %r15
               	movq	(%r15), %rax
               	movq	%rax, %rbx
               	addq	$0x8, %rbx
               	movq	%rbx, (%r15)
               	movq	(%rax), %r14
               	movq	-0x48(%rbp), %rax
               	movq	%rax, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r14, %rax
               	cqto
               	idivq	%r11
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	movq	%rbx, -0x48(%rbp)
               	jmp	0x406b3f <.text+0x66df>
               	jmp	0x406af3 <.text+0x6693>
               	movq	-0x58(%rbp), %rbx
               	cmpq	$0x1d, %rbx
               	jne	0x406b90 <.text+0x6730>
               	leaq	-0x38(%rbp), %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	movq	(%rax), %r15
               	movq	-0x48(%rbp), %rax
               	movq	%rax, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r15, %rax
               	cqto
               	idivq	%r11
               	movq	%rdx, %r14
               	popq	%rdx
               	popq	%rax
               	movq	%r14, -0x48(%rbp)
               	jmp	0x406b8b <.text+0x672b>
               	jmp	0x406b3f <.text+0x66df>
               	movq	-0x58(%rbp), %r14
               	cmpq	$0x1e, %r14
               	jne	0x406bd3 <.text+0x6773>
               	movq	-0x38(%rbp), %r14
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r12
               	movq	(%r14), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40704f <open>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	0x406bce <.text+0x676e>
               	jmp	0x406b8b <.text+0x672b>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x1f, %rax
               	jne	0x406c26 <.text+0x67c6>
               	movq	-0x38(%rbp), %rax
               	movq	%rax, %r15
               	addq	$0x10, %r15
               	movq	(%r15), %r14
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	(%r15), %r12
               	movq	(%rax), %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x407061 <read>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	0x406c21 <.text+0x67c1>
               	jmp	0x406bce <.text+0x676e>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x20, %rax
               	jne	0x406c59 <.text+0x67f9>
               	movq	-0x38(%rbp), %rax
               	movq	(%rax), %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x407067 <close>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	0x406c54 <.text+0x67f4>
               	jmp	0x406c21 <.text+0x67c1>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x21, %rax
               	jne	0x406d22 <.text+0x68c2>
               	movq	-0x38(%rbp), %rax
               	movq	-0x30(%rbp), %r15
               	movq	%r15, %r12
               	addq	$0x8, %r12
               	movq	(%r12), %r15
               	movq	%r15, %r12
               	shlq	$0x3, %r12
               	movq	%rax, %r15
               	addq	%r12, %r15
               	movq	%r15, -0x60(%rbp)
               	movq	-0x60(%rbp), %r12
               	movq	%r12, %r15
               	addq	$-0x8, %r15
               	movq	(%r15), %rbx
               	movq	%r12, %r15
               	addq	$-0x10, %r15
               	movq	(%r15), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	%r12, %r15
               	addq	$-0x18, %r15
               	movq	(%r15), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	%r12, %r15
               	addq	$-0x20, %r15
               	movq	(%r15), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	%r12, %r15
               	addq	$-0x28, %r15
               	movq	(%r15), %r14
               	movq	%r12, %r15
               	addq	$-0x30, %r15
               	movq	(%r15), %r12
               	movq	%rbx, %rdi
               	movq	%r12, %r9
               	movq	%r14, %r8
               	movq	0x30(%rsp), %rsi
               	movq	0x28(%rsp), %rdx
               	movq	0x20(%rsp), %rcx
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	0x406d1d <.text+0x68bd>
               	jmp	0x406c54 <.text+0x67f4>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x22, %rax
               	jne	0x406d52 <.text+0x68f2>
               	movq	-0x38(%rbp), %rax
               	movq	(%rax), %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x407055 <malloc>
               	movq	%rax, -0x48(%rbp)
               	jmp	0x406d4d <.text+0x68ed>
               	jmp	0x406d1d <.text+0x68bd>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x23, %rax
               	jne	0x406d81 <.text+0x6921>
               	movq	-0x38(%rbp), %rax
               	movq	(%rax), %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x40706d <free>
               	movslq	%eax, %rax
               	jmp	0x406d7c <.text+0x691c>
               	jmp	0x406d4d <.text+0x68ed>
               	movq	-0x58(%rbp), %r12
               	cmpq	$0x24, %r12
               	jne	0x406dd2 <.text+0x6972>
               	movq	-0x38(%rbp), %r12
               	movq	%r12, %rax
               	addq	$0x10, %rax
               	movq	(%rax), %r15
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r14
               	movq	(%r12), %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x40705b <memset>
               	movq	%rax, -0x48(%rbp)
               	jmp	0x406dcd <.text+0x696d>
               	jmp	0x406d7c <.text+0x691c>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x25, %rax
               	jne	0x406e25 <.text+0x69c5>
               	movq	-0x38(%rbp), %rax
               	movq	%rax, %rbx
               	addq	$0x10, %rbx
               	movq	(%rbx), %r12
               	movq	%rax, %rbx
               	addq	$0x8, %rbx
               	movq	(%rbx), %r14
               	movq	(%rax), %r15
               	movq	%r12, %rdi
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x407043 <memcmp>
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	jmp	0x406e20 <.text+0x69c0>
               	jmp	0x406dcd <.text+0x696d>
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x26, %rax
               	jne	0x406e94 <.text+0x6a34>
               	leaq	0x9a44(%rip), %rbx      # 0x410881
               	movq	-0x38(%rbp), %r15
               	movq	(%r15), %r12
               	movq	-0x50(%rbp), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movq	-0x38(%rbp), %rax
               	movq	(%rax), %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	jmp	0x406e20 <.text+0x69c0>
               	leaq	0x99fb(%rip), %r15      # 0x410896
               	movq	-0x58(%rbp), %rbx
               	movq	-0x50(%rbp), %r14
               	movq	%r15, %rdi
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40703d <printf>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	addb	%al, (%rax)
