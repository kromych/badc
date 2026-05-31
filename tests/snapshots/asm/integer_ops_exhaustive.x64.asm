
integer_ops_exhaustive.x64:	file format elf64-x86-64

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
               	callq	0x402467 <dlsym>
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
               	subq	$0x130, %rsp            # imm = 0x130
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0xfffffffe, %ebx       # imm = 0xFFFFFFFE
               	movl	$0x1, %r12d
               	jmp	0x40043e <.text+0x17e>
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rbx, %r8
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r12, %rdi
               	cmpq	%rdi, %r8
               	seta	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x0, %rsi
               	jne	0x4004ca <.text+0x20a>
               	jmp	0x400481 <.text+0x1c1>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x40043e <.text+0x17e>
               	jmp	0x4004cf <.text+0x20f>
               	leaq	0xfcc8(%rip), %r14      # 0x410150
               	leaq	0xfccb(%rip), %r15      # 0x41015a
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x40046c <.text+0x1ac>
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%r12, %r8
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r15
               	cmpq	%r15, %r8
               	setb	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x40055c <.text+0x29c>
               	jmp	0x400513 <.text+0x253>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4004cf <.text+0x20f>
               	jmp	0x400561 <.text+0x2a1>
               	leaq	0xfc53(%rip), %r14      # 0x41016d
               	leaq	0xfc56(%rip), %r15      # 0x410177
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4004fe <.text+0x23e>
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rbx, %r8
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	%r15, %r8
               	setae	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x4005ee <.text+0x32e>
               	jmp	0x4005a5 <.text+0x2e5>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400561 <.text+0x2a1>
               	jmp	0x4005f3 <.text+0x333>
               	leaq	0xfbde(%rip), %r14      # 0x41018a
               	leaq	0xfbe1(%rip), %r15      # 0x410194
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400590 <.text+0x2d0>
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%r12, %r8
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r15
               	cmpq	%r15, %r8
               	setbe	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x400680 <.text+0x3c0>
               	jmp	0x400637 <.text+0x377>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4005f3 <.text+0x333>
               	jmp	0x400685 <.text+0x3c5>
               	leaq	0xfb6a(%rip), %r14      # 0x4101a8
               	leaq	0xfb6d(%rip), %r15      # 0x4101b2
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400622 <.text+0x362>
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rbx, %r8
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	%r15, %r8
               	setne	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x400712 <.text+0x452>
               	jmp	0x4006c9 <.text+0x409>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400685 <.text+0x3c5>
               	jmp	0x400717 <.text+0x457>
               	leaq	0xfaf6(%rip), %r14      # 0x4101c6
               	leaq	0xfaf9(%rip), %r15      # 0x4101d0
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4006b4 <.text+0x3f4>
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rbx, %r8
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	%r15, %r8
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x4007c2 <.text+0x502>
               	jmp	0x400779 <.text+0x4b9>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400717 <.text+0x457>
               	movabsq	$-0x2, %r15
               	movl	$0x1, %ebx
               	jmp	0x4007c7 <.text+0x507>
               	leaq	0xfa64(%rip), %r15      # 0x4101e4
               	leaq	0xfa67(%rip), %r14      # 0x4101ee
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400755 <.text+0x495>
               	movslq	%r15d, %r12
               	movslq	%ebx, %r14
               	cmpq	%r14, %r12
               	setl	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x400848 <.text+0x588>
               	jmp	0x4007ff <.text+0x53f>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4007c7 <.text+0x507>
               	jmp	0x40084d <.text+0x58d>
               	leaq	0xf9fc(%rip), %r12      # 0x410202
               	leaq	0xf9ff(%rip), %r14      # 0x41020c
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4007ea <.text+0x52a>
               	movslq	%ebx, %r8
               	movslq	%r15d, %r14
               	cmpq	%r14, %r8
               	setg	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x4008ce <.text+0x60e>
               	jmp	0x400885 <.text+0x5c5>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x40084d <.text+0x58d>
               	jmp	0x4008d3 <.text+0x613>
               	leaq	0xf98b(%rip), %r12      # 0x410217
               	leaq	0xf98e(%rip), %r14      # 0x410221
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400870 <.text+0x5b0>
               	movslq	%r15d, %r8
               	movslq	%ebx, %r14
               	cmpq	%r14, %r8
               	setle	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x400954 <.text+0x694>
               	jmp	0x40090b <.text+0x64b>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4008d3 <.text+0x613>
               	jmp	0x400959 <.text+0x699>
               	leaq	0xf91a(%rip), %r12      # 0x41022c
               	leaq	0xf91d(%rip), %r14      # 0x410236
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4008f6 <.text+0x636>
               	movslq	%ebx, %r8
               	movslq	%r15d, %r14
               	cmpq	%r14, %r8
               	setge	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x4009ea <.text+0x72a>
               	jmp	0x4009a1 <.text+0x6e1>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400959 <.text+0x699>
               	movabsq	$-0x2, %r12
               	movl	$0x1, %r15d
               	jmp	0x4009ef <.text+0x72f>
               	leaq	0xf89a(%rip), %r12      # 0x410242
               	leaq	0xf89d(%rip), %r14      # 0x41024c
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x40097c <.text+0x6bc>
               	cmpq	%r15, %r12
               	seta	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400a6a <.text+0x7aa>
               	jmp	0x400a21 <.text+0x761>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4009ef <.text+0x72f>
               	jmp	0x400a6f <.text+0x7af>
               	leaq	0xf830(%rip), %rbx      # 0x410258
               	leaq	0xf833(%rip), %r14      # 0x410262
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400a0c <.text+0x74c>
               	cmpq	%r15, %r12
               	setae	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x400aea <.text+0x82a>
               	jmp	0x400aa1 <.text+0x7e1>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400a6f <.text+0x7af>
               	jmp	0x400aef <.text+0x82f>
               	leaq	0xf7c7(%rip), %rbx      # 0x41026f
               	leaq	0xf7ca(%rip), %r14      # 0x410279
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400a8c <.text+0x7cc>
               	cmpq	%r12, %r15
               	setb	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x400b7a <.text+0x8ba>
               	jmp	0x400b31 <.text+0x871>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400aef <.text+0x82f>
               	movabsq	$-0x2, %rbx
               	movl	$0x1, %r12d
               	jmp	0x400b7f <.text+0x8bf>
               	leaq	0xf74f(%rip), %rbx      # 0x410287
               	leaq	0xf752(%rip), %r14      # 0x410291
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400b0c <.text+0x84c>
               	cmpq	%rbx, %r12
               	setg	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x400bfa <.text+0x93a>
               	jmp	0x400bb1 <.text+0x8f1>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400b7f <.text+0x8bf>
               	jmp	0x400bff <.text+0x93f>
               	leaq	0xf6e6(%rip), %r15      # 0x41029e
               	leaq	0xf6e9(%rip), %r14      # 0x4102a8
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400b9c <.text+0x8dc>
               	cmpq	$0x0, %rbx
               	setl	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x400c8a <.text+0x9ca>
               	jmp	0x400c41 <.text+0x981>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400bff <.text+0x93f>
               	movl	$0xfe, %r15d
               	movl	$0x1, %r14d
               	jmp	0x400c8f <.text+0x9cf>
               	leaq	0xf66b(%rip), %r15      # 0x4102b3
               	leaq	0xf66e(%rip), %r12      # 0x4102bd
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400c20 <.text+0x960>
               	movq	%r15, %rbx
               	andq	$0xff, %rbx
               	movq	%r14, %r12
               	andq	$0xff, %r12
               	cmpq	%r12, %rbx
               	setg	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x400d1e <.text+0xa5e>
               	jmp	0x400cd5 <.text+0xa15>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400c8f <.text+0x9cf>
               	jmp	0x400d23 <.text+0xa63>
               	leaq	0xf5ec(%rip), %rbx      # 0x4102c8
               	leaq	0xf5ef(%rip), %r12      # 0x4102d2
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400cc0 <.text+0xa00>
               	movq	%r14, %r8
               	andq	$0xff, %r8
               	movq	%r15, %r12
               	andq	$0xff, %r12
               	cmpq	%r12, %r8
               	setl	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400dc2 <.text+0xb02>
               	jmp	0x400d79 <.text+0xab9>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400d23 <.text+0xa63>
               	movabsq	$-0x2, %rbx
               	movl	$0x1, %r15d
               	jmp	0x400dc7 <.text+0xb07>
               	leaq	0xf55e(%rip), %rbx      # 0x4102de
               	leaq	0xf561(%rip), %r12      # 0x4102e8
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400d54 <.text+0xa94>
               	movsbq	%bl, %r14
               	movsbq	%r15b, %r12
               	cmpq	%r12, %r14
               	setl	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x400e4a <.text+0xb8a>
               	jmp	0x400e01 <.text+0xb41>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400dc7 <.text+0xb07>
               	jmp	0x400e4f <.text+0xb8f>
               	leaq	0xf4ec(%rip), %r14      # 0x4102f4
               	leaq	0xf4ef(%rip), %r12      # 0x4102fe
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400dec <.text+0xb2c>
               	movsbq	%r15b, %r8
               	movsbq	%bl, %r12
               	cmpq	%r12, %r8
               	setg	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x400ef2 <.text+0xc32>
               	jmp	0x400ea9 <.text+0xbe9>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400e4f <.text+0xb8f>
               	movl	$0x64, %r8d
               	movl	%r8d, -0x68(%rbp)
               	leaq	-0x68(%rbp), %r12
               	movl	(%r12), %r8d
               	movq	%r8, %r15
               	addq	$0x5, %r15
               	movl	%r15d, (%r12)
               	jmp	0x400ef7 <.text+0xc37>
               	leaq	0xf458(%rip), %r14      # 0x410308
               	leaq	0xf45b(%rip), %r12      # 0x410312
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400e74 <.text+0xbb4>
               	movl	-0x68(%rbp), %r15d
               	movq	%r15, %r8
               	xorq	$0x69, %r8
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r8, %r15
               	cmpq	$0x0, %r15
               	sete	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x400fa3 <.text+0xce3>
               	jmp	0x400f5a <.text+0xc9a>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400ef7 <.text+0xc37>
               	leaq	-0x68(%rbp), %r12
               	movl	(%r12), %ebx
               	movq	%rbx, %r14
               	subq	$0xa, %r14
               	movl	%r14d, (%r12)
               	jmp	0x400fa8 <.text+0xce8>
               	leaq	0xf3bb(%rip), %r14      # 0x41031c
               	leaq	0xf3be(%rip), %rbx      # 0x410326
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
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
               	jmp	0x400f2f <.text+0xc6f>
               	movl	-0x68(%rbp), %r14d
               	movq	%r14, %rbx
               	xorq	$0x5f, %rbx
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r14
               	cmpq	$0x0, %r14
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401051 <.text+0xd91>
               	jmp	0x401008 <.text+0xd48>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400fa8 <.text+0xce8>
               	leaq	-0x68(%rbp), %r12
               	movl	(%r12), %ebx
               	movq	%rbx, %r15
               	shlq	$0x1, %r15
               	movl	%r15d, (%r12)
               	jmp	0x401056 <.text+0xd96>
               	leaq	0xf320(%rip), %r15      # 0x41032f
               	leaq	0xf323(%rip), %rbx      # 0x410339
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
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
               	jmp	0x400fe0 <.text+0xd20>
               	movl	-0x68(%rbp), %r15d
               	movq	%r15, %rbx
               	xorq	$0xbe, %rbx
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r15
               	cmpq	$0x0, %r15
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401111 <.text+0xe51>
               	jmp	0x4010c8 <.text+0xe08>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401056 <.text+0xd96>
               	leaq	-0x68(%rbp), %r12
               	movl	(%r12), %ebx
               	movl	$0x5, %r14d
               	movq	%r14, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%rbx, %rax
               	xorq	%rdx, %rdx
               	divq	%r11
               	movq	%rax, %r15
               	popq	%rdx
               	popq	%rax
               	movl	%r15d, (%r12)
               	jmp	0x401116 <.text+0xe56>
               	leaq	0xf274(%rip), %r14      # 0x410343
               	leaq	0xf277(%rip), %rbx      # 0x41034d
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
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
               	jmp	0x40108e <.text+0xdce>
               	movl	-0x68(%rbp), %r15d
               	movq	%r15, %r14
               	xorq	$0x26, %r14
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r14, %r15
               	cmpq	$0x0, %r15
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x4011d0 <.text+0xf10>
               	jmp	0x401187 <.text+0xec7>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x401116 <.text+0xe56>
               	leaq	-0x68(%rbp), %r12
               	movl	(%r12), %r14d
               	movl	$0x7, %ebx
               	movq	%rbx, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r14, %rax
               	xorq	%rdx, %rdx
               	divq	%r11
               	movq	%rdx, %r15
               	popq	%rdx
               	popq	%rax
               	movl	%r15d, (%r12)
               	jmp	0x4011d5 <.text+0xf15>
               	leaq	0xf1c8(%rip), %rbx      # 0x410356
               	leaq	0xf1cb(%rip), %r14      # 0x410360
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
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
               	jmp	0x40114e <.text+0xe8e>
               	movl	-0x68(%rbp), %r15d
               	movq	%r15, %rbx
               	xorq	$0x3, %rbx
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r15
               	cmpq	$0x0, %r15
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x40128c <.text+0xfcc>
               	jmp	0x401243 <.text+0xf83>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4011d5 <.text+0xf15>
               	movl	$0x1, %r12d
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r12, %rbx
               	movq	%rbx, %r12
               	subq	$0x2, %r12
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	jmp	0x401291 <.text+0xfd1>
               	leaq	0xf11f(%rip), %r14      # 0x410369
               	leaq	0xf122(%rip), %rbx      # 0x410373
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
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
               	jmp	0x40120d <.text+0xf4d>
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r15, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%r12, %r14
               	cmpq	%r11, %r12
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x40133c <.text+0x107c>
               	jmp	0x4012f3 <.text+0x1033>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x401291 <.text+0xfd1>
               	movl	$0x3e8, %r12d           # imm = 0x3E8
               	movq	%r12, -0x78(%rbp)
               	leaq	-0x78(%rbp), %r14
               	movq	(%r14), %r12
               	movq	%r12, %r15
               	addq	$0x19f, %r15            # imm = 0x19F
               	movq	%r15, (%r14)
               	jmp	0x401341 <.text+0x1081>
               	leaq	0xf082(%rip), %rbx      # 0x41037c
               	leaq	0xf085(%rip), %r14      # 0x410386
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
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
               	jmp	0x4012c0 <.text+0x1000>
               	movq	-0x78(%rbp), %r15
               	cmpq	$0x587, %r15            # imm = 0x587
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x4013d7 <.text+0x1117>
               	jmp	0x40138e <.text+0x10ce>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401341 <.text+0x1081>
               	leaq	-0x78(%rbp), %r14
               	movq	(%r14), %r12
               	movl	$0x3, %ebx
               	imulq	%r12, %rbx
               	movq	%rbx, (%r14)
               	jmp	0x4013dc <.text+0x111c>
               	leaq	0xefff(%rip), %rbx      # 0x410394
               	leaq	0xf002(%rip), %r12      # 0x41039e
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401366 <.text+0x10a6>
               	movq	-0x78(%rbp), %rbx
               	cmpq	$0x1095, %rbx           # imm = 0x1095
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x401482 <.text+0x11c2>
               	jmp	0x401439 <.text+0x1179>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4013dc <.text+0x111c>
               	leaq	-0x78(%rbp), %r14
               	movq	(%r14), %r12
               	movl	$0x5, %r15d
               	movq	%r15, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r12, %rax
               	xorq	%rdx, %rdx
               	divq	%r11
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	movq	%rbx, (%r14)
               	jmp	0x401487 <.text+0x11c7>
               	leaq	0xef69(%rip), %r15      # 0x4103a9
               	leaq	0xef6c(%rip), %r12      # 0x4103b3
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401401 <.text+0x1141>
               	movq	-0x78(%rbp), %rbx
               	cmpq	$0x351, %rbx            # imm = 0x351
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x401553 <.text+0x1293>
               	jmp	0x40150a <.text+0x124a>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401487 <.text+0x11c7>
               	movl	$0xff00ff00, %r14d      # imm = 0xFF00FF00
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r14, %r15
               	movq	%r15, %rbx
               	andq	$0xf0f0f0f, %rbx        # imm = 0xF0F0F0F
               	movq	%r15, %r14
               	orq	$0xff000, %r14          # imm = 0xFF000
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	xorq	%r15, %r10
               	movq	%r10, 0x20(%rsp)
               	movq	%r15, %r8
               	xorq	$-0x1, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r8, %r10
               	movq	%r10, 0x28(%rsp)
               	jmp	0x401558 <.text+0x1298>
               	leaq	0xeeab(%rip), %r12      # 0x4103bc
               	leaq	0xeeae(%rip), %r15      # 0x4103c6
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4014ac <.text+0x11ec>
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rbx, %r8
               	movq	%r8, %rdx
               	xorq	$0xf000f00, %rdx        # imm = 0xF000F00
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rdx, %r8
               	cmpq	$0x0, %r8
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	0x4015f3 <.text+0x1333>
               	jmp	0x4015aa <.text+0x12ea>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401558 <.text+0x1298>
               	jmp	0x4015f8 <.text+0x1338>
               	leaq	0xee1e(%rip), %r15      # 0x4103cf
               	leaq	0xee21(%rip), %r12      # 0x4103d9
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401595 <.text+0x12d5>
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%r14, %r8
               	movl	$0xff0fff00, %r11d      # imm = 0xFF0FFF00
               	movq	%r8, %r12
               	cmpq	%r11, %r8
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x401684 <.text+0x13c4>
               	jmp	0x40163c <.text+0x137c>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4015f8 <.text+0x1338>
               	jmp	0x401689 <.text+0x13c9>
               	leaq	0xed9c(%rip), %r15      # 0x4103df
               	leaq	0xed9f(%rip), %r12      # 0x4103e9
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401627 <.text+0x1367>
               	movq	0x20(%rsp), %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	movq	%rbx, %r12
               	xorq	$0xff00ff, %r12         # imm = 0xFF00FF
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r12, %rbx
               	cmpq	$0x0, %rbx
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x401728 <.text+0x1468>
               	jmp	0x4016df <.text+0x141f>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401689 <.text+0x13c9>
               	jmp	0x40172d <.text+0x146d>
               	leaq	0xed09(%rip), %r15      # 0x4103ef
               	leaq	0xed0c(%rip), %r12      # 0x4103f9
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4016ca <.text+0x140a>
               	movq	0x28(%rsp), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	movq	%r14, %r12
               	xorq	$0xff00ff, %r12         # imm = 0xFF00FF
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%r12, %r14
               	cmpq	$0x0, %r14
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x4017ec <.text+0x152c>
               	jmp	0x4017a3 <.text+0x14e3>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x40172d <.text+0x146d>
               	movl	$0x12345678, %r15d      # imm = 0x12345678
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r15, %r12
               	movq	%r12, %r15
               	shlq	$0x4, %r15
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%r15, %r14
               	jmp	0x4017f1 <.text+0x1531>
               	leaq	0xec55(%rip), %rbx      # 0x4103ff
               	leaq	0xec58(%rip), %r12      # 0x410409
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x40176f <.text+0x14af>
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r14, %r15
               	movq	%r15, %rbx
               	xorq	$0x23456780, %rbx       # imm = 0x23456780
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r15
               	cmpq	$0x0, %r15
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4018aa <.text+0x15ea>
               	jmp	0x401861 <.text+0x15a1>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4017f1 <.text+0x1531>
               	movl	$0x1, %r15d
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r15, %rbx
               	movq	%rbx, %r15
               	shlq	$0x1f, %r15
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r15, %r12
               	jmp	0x4018af <.text+0x15ef>
               	leaq	0xeba7(%rip), %r12      # 0x41040f
               	leaq	0xebaa(%rip), %rbx      # 0x410419
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x40182e <.text+0x156e>
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	movq	%r15, %r14
               	cmpq	%r11, %r15
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x401941 <.text+0x1681>
               	jmp	0x4018f8 <.text+0x1638>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4018af <.text+0x15ef>
               	movl	$0x1, %ebx
               	jmp	0x401946 <.text+0x1686>
               	leaq	0xeb23(%rip), %rbx      # 0x410422
               	leaq	0xeb26(%rip), %r14      # 0x41042c
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4018de <.text+0x161e>
               	movq	%rbx, %r14
               	shlq	$0x3f, %r14
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r14, %r12
               	cmpq	%r11, %r14
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x4019e5 <.text+0x1725>
               	jmp	0x40199c <.text+0x16dc>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401946 <.text+0x1686>
               	movabsq	$-0x1, %r15
               	movl	$0x1, %r14d
               	jmp	0x4019ea <.text+0x172a>
               	leaq	0xea93(%rip), %r15      # 0x410436
               	leaq	0xea96(%rip), %r12      # 0x410440
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401977 <.text+0x16b7>
               	movslq	%r15d, %rbx
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r12
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r14, %rbx
               	cmpq	%rbx, %r12
               	seta	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x401a79 <.text+0x17b9>
               	jmp	0x401a30 <.text+0x1770>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4019ea <.text+0x172a>
               	jmp	0x401a7e <.text+0x17be>
               	leaq	0xea13(%rip), %r12      # 0x41044a
               	leaq	0xea16(%rip), %rbx      # 0x410454
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401a1b <.text+0x175b>
               	movslq	%r15d, %r8
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r14, %rbx
               	movslq	%ebx, %rbx
               	cmpq	%rbx, %r8
               	setl	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x401b2b <.text+0x186b>
               	jmp	0x401ae2 <.text+0x1822>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401a7e <.text+0x17be>
               	movl	$0xfffffffe, %r8d       # imm = 0xFFFFFFFE
               	movl	%r8d, -0xe0(%rbp)
               	leaq	-0xe0(%rbp), %rbx
               	movl	(%rbx), %r8d
               	movq	%r8, %r14
               	addq	$0x1, %r14
               	movl	%r14d, (%rbx)
               	jmp	0x401b30 <.text+0x1870>
               	leaq	0xe977(%rip), %r12      # 0x410460
               	leaq	0xe97a(%rip), %rbx      # 0x41046a
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401aa9 <.text+0x17e9>
               	movl	-0xe0(%rbp), %r14d
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%r14, %r8
               	cmpq	%r11, %r14
               	sete	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x401bd1 <.text+0x1911>
               	jmp	0x401b89 <.text+0x18c9>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401b30 <.text+0x1870>
               	leaq	-0xe0(%rbp), %rbx
               	movl	(%rbx), %r15d
               	movq	%r15, %r12
               	addq	$0x1, %r12
               	movl	%r12d, (%rbx)
               	jmp	0x401bd6 <.text+0x1916>
               	leaq	0xe8e5(%rip), %r12      # 0x410475
               	leaq	0xe8e8(%rip), %r15      # 0x41047f
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401b5d <.text+0x189d>
               	movl	-0xe0(%rbp), %r12d
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	$0x0, %r15
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x401c8a <.text+0x19ca>
               	jmp	0x401c42 <.text+0x1982>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401bd6 <.text+0x1916>
               	movl	$0xfe, %ebx
               	movb	%bl, -0xe8(%rbp)
               	leaq	-0xe8(%rbp), %r12
               	movzbq	(%r12), %rbx
               	movq	%rbx, %r14
               	addq	$0x1, %r14
               	movb	%r14b, (%r12)
               	jmp	0x401c8f <.text+0x19cf>
               	leaq	0xe845(%rip), %r14      # 0x41048e
               	leaq	0xe848(%rip), %r12      # 0x410498
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401c07 <.text+0x1947>
               	movzbq	-0xe8(%rbp), %r14
               	movq	%r14, %rbx
               	xorq	$0xff, %rbx
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r14
               	cmpq	$0x0, %r14
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401d43 <.text+0x1a83>
               	jmp	0x401cfa <.text+0x1a3a>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401c8f <.text+0x19cf>
               	leaq	-0xe8(%rbp), %r12
               	movzbq	(%r12), %rbx
               	movq	%rbx, %r15
               	addq	$0x1, %r15
               	movb	%r15b, (%r12)
               	jmp	0x401d48 <.text+0x1a88>
               	leaq	0xe7a9(%rip), %r15      # 0x4104aa
               	leaq	0xe7ac(%rip), %rbx      # 0x4104b4
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
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
               	jmp	0x401ccb <.text+0x1a0b>
               	movzbq	-0xe8(%rbp), %r15
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r15, %rbx
               	cmpq	$0x0, %rbx
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x401dff <.text+0x1b3f>
               	jmp	0x401db6 <.text+0x1af6>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401d48 <.text+0x1a88>
               	movabsq	$-0x2, %r12
               	movq	%r12, -0xf0(%rbp)
               	leaq	-0xf0(%rbp), %r15
               	movq	(%r15), %r12
               	movq	%r12, %r14
               	addq	$0x1, %r14
               	movq	%r14, (%r15)
               	jmp	0x401e04 <.text+0x1b44>
               	leaq	0xe70a(%rip), %r14      # 0x4104c7
               	leaq	0xe70d(%rip), %r15      # 0x4104d1
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
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
               	jmp	0x401d79 <.text+0x1ab9>
               	movq	-0xf0(%rbp), %r14
               	cmpq	$-0x1, %r14
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x401ea1 <.text+0x1be1>
               	jmp	0x401e58 <.text+0x1b98>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401e04 <.text+0x1b44>
               	leaq	-0xf0(%rbp), %r15
               	movq	(%r15), %r12
               	movq	%r12, %rbx
               	addq	$0x1, %rbx
               	movq	%rbx, (%r15)
               	jmp	0x401ea6 <.text+0x1be6>
               	leaq	0xe683(%rip), %rbx      # 0x4104e2
               	leaq	0xe686(%rip), %r12      # 0x4104ec
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401e2c <.text+0x1b6c>
               	movq	-0xf0(%rbp), %rbx
               	cmpq	$0x0, %rbx
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x401f2c <.text+0x1c6c>
               	jmp	0x401ee3 <.text+0x1c23>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401ea6 <.text+0x1be6>
               	jmp	0x401f31 <.text+0x1c71>
               	leaq	0xe611(%rip), %r14      # 0x4104fb
               	leaq	0xe614(%rip), %r12      # 0x410505
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401ece <.text+0x1c0e>
               	movl	$0x1, %r15d
               	cmpq	$0x0, %r15
               	jne	0x401fa7 <.text+0x1ce7>
               	jmp	0x401f5e <.text+0x1c9e>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401f31 <.text+0x1c71>
               	jmp	0x401fac <.text+0x1cec>
               	leaq	0xe5b2(%rip), %rbx      # 0x410517
               	leaq	0xe5b5(%rip), %r15      # 0x410521
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401f49 <.text+0x1c89>
               	movl	$0x1, %r14d
               	cmpq	$0x0, %r14
               	jne	0x402021 <.text+0x1d61>
               	jmp	0x401fd9 <.text+0x1d19>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x401fac <.text+0x1cec>
               	jmp	0x402026 <.text+0x1d66>
               	leaq	0xe54c(%rip), %r12      # 0x41052c
               	leaq	0xe54f(%rip), %r14      # 0x410536
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401fc4 <.text+0x1d04>
               	movl	$0x1, %ebx
               	cmpq	$0x0, %rbx
               	jne	0x40209b <.text+0x1ddb>
               	jmp	0x402052 <.text+0x1d92>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x402026 <.text+0x1d66>
               	jmp	0x4020a0 <.text+0x1de0>
               	leaq	0xe4eb(%rip), %r15      # 0x410544
               	leaq	0xe4ee(%rip), %rbx      # 0x41054e
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
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
               	jmp	0x40203d <.text+0x1d7d>
               	movl	$0x1, %r12d
               	cmpq	$0x0, %r12
               	jne	0x402116 <.text+0x1e56>
               	jmp	0x4020cd <.text+0x1e0d>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4020a0 <.text+0x1de0>
               	jmp	0x40211b <.text+0x1e5b>
               	leaq	0xe486(%rip), %r14      # 0x41055a
               	leaq	0xe489(%rip), %r12      # 0x410564
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4020b8 <.text+0x1df8>
               	movl	$0x1, %r15d
               	cmpq	$0x0, %r15
               	jne	0x402191 <.text+0x1ed1>
               	jmp	0x402148 <.text+0x1e88>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x40211b <.text+0x1e5b>
               	jmp	0x402196 <.text+0x1ed6>
               	leaq	0xe421(%rip), %rbx      # 0x410570
               	leaq	0xe424(%rip), %r15      # 0x41057a
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x402133 <.text+0x1e73>
               	movl	$0x1, %r14d
               	cmpq	$0x0, %r14
               	jne	0x40220b <.text+0x1f4b>
               	jmp	0x4021c3 <.text+0x1f03>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x402196 <.text+0x1ed6>
               	jmp	0x402210 <.text+0x1f50>
               	leaq	0xe3bc(%rip), %r12      # 0x410586
               	leaq	0xe3bf(%rip), %r14      # 0x410590
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4021ae <.text+0x1eee>
               	movl	$0x1, %ebx
               	cmpq	$0x0, %rbx
               	jne	0x402285 <.text+0x1fc5>
               	jmp	0x40223c <.text+0x1f7c>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x402210 <.text+0x1f50>
               	jmp	0x40228a <.text+0x1fca>
               	leaq	0xe361(%rip), %r15      # 0x4105a4
               	leaq	0xe364(%rip), %rbx      # 0x4105ae
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
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
               	jmp	0x402227 <.text+0x1f67>
               	movl	$0x1, %r12d
               	cmpq	$0x0, %r12
               	jne	0x402320 <.text+0x2060>
               	jmp	0x4022d7 <.text+0x2017>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x40228a <.text+0x1fca>
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	0xe2dc(%rip), %r14      # 0x4105ba
               	leaq	0xe2df(%rip), %r12      # 0x4105c4
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40246d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4022a2 <.text+0x1fe2>
               	addb	%al, (%rax)
