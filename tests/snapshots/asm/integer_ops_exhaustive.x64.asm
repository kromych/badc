
integer_ops_exhaustive.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003f6 <.text+0x136>
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
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	0x400345 <.text+0x85>
               	leaq	0xfde5(%rip), %r9       # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
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
               	leaq	0xfdc5(%rip), %rdi      # 0x410118
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	0xfdb6(%rip), %rdi      # 0x41011e
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	0xfda8(%rip), %rdi      # 0x410125
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x402307 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x4003c7 <.text+0x107>
               	leaq	0xfd4e(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	0x4003c7 <.text+0x107>
               	leaq	0xfd32(%rip), %r12      # 0x410100
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rbx
               	movq	%rbx, %rcx
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
               	jmp	0x400424 <.text+0x164>
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rbx, %r8
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r12, %rdi
               	cmpq	%rdi, %r8
               	seta	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x4004ac <.text+0x1ec>
               	jmp	0x400467 <.text+0x1a7>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400424 <.text+0x164>
               	jmp	0x4004b1 <.text+0x1f1>
               	leaq	0xfce2(%rip), %r14      # 0x410150
               	leaq	0xfce5(%rip), %r15      # 0x41015a
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400452 <.text+0x192>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r12, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r15
               	cmpq	%r15, %rax
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400539 <.text+0x279>
               	jmp	0x4004f4 <.text+0x234>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4004b1 <.text+0x1f1>
               	jmp	0x40053e <.text+0x27e>
               	leaq	0xfc72(%rip), %r14      # 0x41016d
               	leaq	0xfc75(%rip), %r15      # 0x410177
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4004df <.text+0x21f>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	%r15, %rax
               	setae	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x4005c6 <.text+0x306>
               	jmp	0x400581 <.text+0x2c1>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x40053e <.text+0x27e>
               	jmp	0x4005cb <.text+0x30b>
               	leaq	0xfc02(%rip), %r14      # 0x41018a
               	leaq	0xfc05(%rip), %r15      # 0x410194
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x40056c <.text+0x2ac>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r12, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r15
               	cmpq	%r15, %rax
               	setbe	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400653 <.text+0x393>
               	jmp	0x40060e <.text+0x34e>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4005cb <.text+0x30b>
               	jmp	0x400658 <.text+0x398>
               	leaq	0xfb93(%rip), %r14      # 0x4101a8
               	leaq	0xfb96(%rip), %r15      # 0x4101b2
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4005f9 <.text+0x339>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	%r15, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x4006e0 <.text+0x420>
               	jmp	0x40069b <.text+0x3db>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400658 <.text+0x398>
               	jmp	0x4006e5 <.text+0x425>
               	leaq	0xfb24(%rip), %r14      # 0x4101c6
               	leaq	0xfb27(%rip), %r15      # 0x4101d0
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400686 <.text+0x3c6>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	%r15, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x40078b <.text+0x4cb>
               	jmp	0x400746 <.text+0x486>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4006e5 <.text+0x425>
               	movabsq	$-0x2, %r14
               	movl	$0x1, %ebx
               	jmp	0x400790 <.text+0x4d0>
               	leaq	0xfa97(%rip), %r14      # 0x4101e4
               	leaq	0xfa9a(%rip), %r15      # 0x4101ee
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400722 <.text+0x462>
               	movslq	%r14d, %r12
               	movslq	%ebx, %r15
               	cmpq	%r15, %r12
               	setl	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x40080d <.text+0x54d>
               	jmp	0x4007c8 <.text+0x508>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400790 <.text+0x4d0>
               	jmp	0x400812 <.text+0x552>
               	leaq	0xfa33(%rip), %r15      # 0x410202
               	leaq	0xfa36(%rip), %r12      # 0x41020c
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4007b3 <.text+0x4f3>
               	movslq	%ebx, %rax
               	movslq	%r14d, %r12
               	cmpq	%r12, %rax
               	setg	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x40088f <.text+0x5cf>
               	jmp	0x40084a <.text+0x58a>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400812 <.text+0x552>
               	jmp	0x400894 <.text+0x5d4>
               	leaq	0xf9c6(%rip), %r15      # 0x410217
               	leaq	0xf9c9(%rip), %r12      # 0x410221
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400835 <.text+0x575>
               	movslq	%r14d, %rax
               	movslq	%ebx, %r12
               	cmpq	%r12, %rax
               	setle	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400911 <.text+0x651>
               	jmp	0x4008cc <.text+0x60c>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400894 <.text+0x5d4>
               	jmp	0x400916 <.text+0x656>
               	leaq	0xf959(%rip), %r15      # 0x41022c
               	leaq	0xf95c(%rip), %r12      # 0x410236
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4008b7 <.text+0x5f7>
               	movslq	%ebx, %rax
               	movslq	%r14d, %r12
               	cmpq	%r12, %rax
               	setge	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x4009a3 <.text+0x6e3>
               	jmp	0x40095e <.text+0x69e>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400916 <.text+0x656>
               	movabsq	$-0x2, %r15
               	movl	$0x1, %r14d
               	jmp	0x4009a8 <.text+0x6e8>
               	leaq	0xf8dd(%rip), %r15      # 0x410242
               	leaq	0xf8e0(%rip), %r12      # 0x41024c
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400939 <.text+0x679>
               	cmpq	%r14, %r15
               	seta	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400a1f <.text+0x75f>
               	jmp	0x4009da <.text+0x71a>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4009a8 <.text+0x6e8>
               	jmp	0x400a24 <.text+0x764>
               	leaq	0xf877(%rip), %r12      # 0x410258
               	leaq	0xf87a(%rip), %rbx      # 0x410262
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4009c5 <.text+0x705>
               	cmpq	%r14, %r15
               	setae	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400a9b <.text+0x7db>
               	jmp	0x400a56 <.text+0x796>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400a24 <.text+0x764>
               	jmp	0x400aa0 <.text+0x7e0>
               	leaq	0xf812(%rip), %r12      # 0x41026f
               	leaq	0xf815(%rip), %rbx      # 0x410279
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400a41 <.text+0x781>
               	cmpq	%r15, %r14
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400b27 <.text+0x867>
               	jmp	0x400ae2 <.text+0x822>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400aa0 <.text+0x7e0>
               	movabsq	$-0x2, %r12
               	movl	$0x1, %r15d
               	jmp	0x400b2c <.text+0x86c>
               	leaq	0xf79e(%rip), %r12      # 0x410287
               	leaq	0xf7a1(%rip), %rbx      # 0x410291
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400abd <.text+0x7fd>
               	cmpq	%r12, %r15
               	setg	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x400ba3 <.text+0x8e3>
               	jmp	0x400b5e <.text+0x89e>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400b2c <.text+0x86c>
               	jmp	0x400ba8 <.text+0x8e8>
               	leaq	0xf739(%rip), %rbx      # 0x41029e
               	leaq	0xf73c(%rip), %r14      # 0x4102a8
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400b49 <.text+0x889>
               	cmpq	$0x0, %r12
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400c2e <.text+0x96e>
               	jmp	0x400be9 <.text+0x929>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400ba8 <.text+0x8e8>
               	movl	$0xfe, %r15d
               	movl	$0x1, %ebx
               	jmp	0x400c33 <.text+0x973>
               	leaq	0xf6c3(%rip), %rbx      # 0x4102b3
               	leaq	0xf6c6(%rip), %r14      # 0x4102bd
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400bc9 <.text+0x909>
               	movq	%r15, %r12
               	andq	$0xff, %r12
               	movq	%rbx, %r14
               	andq	$0xff, %r14
               	cmpq	%r14, %r12
               	setg	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x400cbe <.text+0x9fe>
               	jmp	0x400c79 <.text+0x9b9>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400c33 <.text+0x973>
               	jmp	0x400cc3 <.text+0xa03>
               	leaq	0xf648(%rip), %r14      # 0x4102c8
               	leaq	0xf64b(%rip), %r12      # 0x4102d2
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400c64 <.text+0x9a4>
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	movq	%r15, %r12
               	andq	$0xff, %r12
               	cmpq	%r12, %rax
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400d5e <.text+0xa9e>
               	jmp	0x400d19 <.text+0xa59>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400cc3 <.text+0xa03>
               	movabsq	$-0x2, %r14
               	movl	$0x1, %r15d
               	jmp	0x400d63 <.text+0xaa3>
               	leaq	0xf5be(%rip), %r14      # 0x4102de
               	leaq	0xf5c1(%rip), %r12      # 0x4102e8
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400cf4 <.text+0xa34>
               	movsbq	%r14b, %rbx
               	movsbq	%r15b, %r12
               	cmpq	%r12, %rbx
               	setl	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400de2 <.text+0xb22>
               	jmp	0x400d9d <.text+0xadd>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400d63 <.text+0xaa3>
               	jmp	0x400de7 <.text+0xb27>
               	leaq	0xf550(%rip), %r12      # 0x4102f4
               	leaq	0xf553(%rip), %rbx      # 0x4102fe
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400d88 <.text+0xac8>
               	movsbq	%r15b, %rax
               	movsbq	%r14b, %rbx
               	cmpq	%rbx, %rax
               	setg	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400e7d <.text+0xbbd>
               	jmp	0x400e38 <.text+0xb78>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400de7 <.text+0xb27>
               	movl	$0x64, %eax
               	movl	%eax, -0x68(%rbp)
               	leaq	-0x68(%rbp), %rbx
               	movl	(%rbx), %eax
               	addq	$0x5, %rax
               	movl	%eax, (%rbx)
               	jmp	0x400e82 <.text+0xbc2>
               	leaq	0xf4c9(%rip), %r12      # 0x410308
               	leaq	0xf4cc(%rip), %rbx      # 0x410312
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400e0c <.text+0xb4c>
               	movl	-0x68(%rbp), %eax
               	xorq	$0x69, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400f21 <.text+0xc61>
               	jmp	0x400edc <.text+0xc1c>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400e82 <.text+0xbc2>
               	leaq	-0x68(%rbp), %rax
               	movl	(%rax), %r15d
               	subq	$0xa, %r15
               	movl	%r15d, (%rax)
               	jmp	0x400f26 <.text+0xc66>
               	leaq	0xf439(%rip), %r12      # 0x41031c
               	leaq	0xf43c(%rip), %r15      # 0x410326
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400eb6 <.text+0xbf6>
               	movl	-0x68(%rbp), %r15d
               	xorq	$0x5f, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x400fc3 <.text+0xd03>
               	jmp	0x400f7e <.text+0xcbe>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400f26 <.text+0xc66>
               	leaq	-0x68(%rbp), %rax
               	movl	(%rax), %r12d
               	shlq	$0x1, %r12
               	movl	%r12d, (%rax)
               	jmp	0x400fc8 <.text+0xd08>
               	leaq	0xf3aa(%rip), %rbx      # 0x41032f
               	leaq	0xf3ad(%rip), %r12      # 0x410339
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400f5b <.text+0xc9b>
               	movl	-0x68(%rbp), %r12d
               	xorq	$0xbe, %r12
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r12
               	cmpq	$0x0, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x401078 <.text+0xdb8>
               	jmp	0x401033 <.text+0xd73>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400fc8 <.text+0xd08>
               	leaq	-0x68(%rbp), %rax
               	movl	(%rax), %ebx
               	movl	$0x5, %r15d
               	movq	%r15, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%rbx, %rax
               	xorq	%rdx, %rdx
               	divq	%r11
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	movl	%ebx, (%rax)
               	jmp	0x40107d <.text+0xdbd>
               	leaq	0xf309(%rip), %r15      # 0x410343
               	leaq	0xf30c(%rip), %rbx      # 0x41034d
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x400ffd <.text+0xd3d>
               	movl	-0x68(%rbp), %ebx
               	xorq	$0x26, %rbx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x40112e <.text+0xe6e>
               	jmp	0x4010e9 <.text+0xe29>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x40107d <.text+0xdbd>
               	leaq	-0x68(%rbp), %rax
               	movl	(%rax), %r15d
               	movl	$0x7, %r12d
               	movq	%r12, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r15, %rax
               	xorq	%rdx, %rdx
               	divq	%r11
               	movq	%rdx, %r15
               	popq	%rdx
               	popq	%rax
               	movl	%r15d, (%rax)
               	jmp	0x401133 <.text+0xe73>
               	leaq	0xf266(%rip), %r12      # 0x410356
               	leaq	0xf269(%rip), %r15      # 0x410360
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4010b1 <.text+0xdf1>
               	movl	-0x68(%rbp), %r15d
               	xorq	$0x3, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x4011e0 <.text+0xf20>
               	jmp	0x40119b <.text+0xedb>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401133 <.text+0xe73>
               	movl	$0x1, %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	subq	$0x2, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rax, %r15
               	jmp	0x4011e5 <.text+0xf25>
               	leaq	0xf1c7(%rip), %rbx      # 0x410369
               	leaq	0xf1ca(%rip), %r12      # 0x410373
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401168 <.text+0xea8>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r15, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401284 <.text+0xfc4>
               	jmp	0x40123f <.text+0xf7f>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4011e5 <.text+0xf25>
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	movq	%rax, -0x78(%rbp)
               	leaq	-0x78(%rbp), %rbx
               	movq	(%rbx), %rax
               	addq	$0x19f, %rax            # imm = 0x19F
               	movq	%rax, (%rbx)
               	jmp	0x401289 <.text+0xfc9>
               	leaq	0xf136(%rip), %r12      # 0x41037c
               	leaq	0xf139(%rip), %rbx      # 0x410386
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401210 <.text+0xf50>
               	movq	-0x78(%rbp), %rax
               	cmpq	$0x587, %rax            # imm = 0x587
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x40131c <.text+0x105c>
               	jmp	0x4012d7 <.text+0x1017>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401289 <.text+0xfc9>
               	leaq	-0x78(%rbp), %rax
               	movq	(%rax), %r15
               	movl	$0x3, %r11d
               	imulq	%r11, %r15
               	movq	%r15, (%rax)
               	jmp	0x401321 <.text+0x1061>
               	leaq	0xf0b6(%rip), %r14      # 0x410394
               	leaq	0xf0b9(%rip), %r15      # 0x41039e
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4012ae <.text+0xfee>
               	movq	-0x78(%rbp), %r15
               	cmpq	$0x1095, %r15           # imm = 0x1095
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x4013c2 <.text+0x1102>
               	jmp	0x40137d <.text+0x10bd>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x401321 <.text+0x1061>
               	leaq	-0x78(%rbp), %rax
               	movq	(%rax), %r14
               	movl	$0x5, %ebx
               	movq	%rbx, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r14, %rax
               	xorq	%rdx, %rdx
               	divq	%r11
               	movq	%rax, %r14
               	popq	%rdx
               	popq	%rax
               	movq	%r14, (%rax)
               	jmp	0x4013c7 <.text+0x1107>
               	leaq	0xf025(%rip), %rbx      # 0x4103a9
               	leaq	0xf028(%rip), %r14      # 0x4103b3
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401346 <.text+0x1086>
               	movq	-0x78(%rbp), %r14
               	cmpq	$0x351, %r14            # imm = 0x351
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x40148b <.text+0x11cb>
               	jmp	0x401446 <.text+0x1186>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4013c7 <.text+0x1107>
               	movl	$0xff00ff00, %eax       # imm = 0xFF00FF00
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movq	%rax, %r14
               	andq	$0xf0f0f0f, %r14        # imm = 0xF0F0F0F
               	movq	%rax, %rbx
               	orq	$0xff000, %rbx          # imm = 0xFF000
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	xorq	%rax, %r10
               	movq	%r10, 0x20(%rsp)
               	xorq	$-0x1, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	jmp	0x401490 <.text+0x11d0>
               	leaq	0xef6f(%rip), %r15      # 0x4103bc
               	leaq	0xef72(%rip), %rbx      # 0x4103c6
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4013ec <.text+0x112c>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r14, %rax
               	xorq	$0xf000f00, %rax        # imm = 0xF000F00
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401523 <.text+0x1263>
               	jmp	0x4014de <.text+0x121e>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401490 <.text+0x11d0>
               	jmp	0x401528 <.text+0x1268>
               	leaq	0xeeea(%rip), %r12      # 0x4103cf
               	leaq	0xeeed(%rip), %r15      # 0x4103d9
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4014c9 <.text+0x1209>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	movl	$0xff0fff00, %r11d      # imm = 0xFF0FFF00
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x4015ad <.text+0x12ed>
               	jmp	0x401568 <.text+0x12a8>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401528 <.text+0x1268>
               	jmp	0x4015b2 <.text+0x12f2>
               	leaq	0xee70(%rip), %r12      # 0x4103df
               	leaq	0xee73(%rip), %r15      # 0x4103e9
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401553 <.text+0x1293>
               	movq	0x20(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	xorq	$0xff00ff, %rax         # imm = 0xFF00FF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x40164b <.text+0x138b>
               	jmp	0x401606 <.text+0x1346>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4015b2 <.text+0x12f2>
               	jmp	0x401650 <.text+0x1390>
               	leaq	0xede2(%rip), %r14      # 0x4103ef
               	leaq	0xede5(%rip), %r15      # 0x4103f9
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4015f1 <.text+0x1331>
               	movq	0x28(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	xorq	$0xff00ff, %rax         # imm = 0xFF00FF
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401704 <.text+0x1444>
               	jmp	0x4016bf <.text+0x13ff>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401650 <.text+0x1390>
               	movl	$0x12345678, %eax       # imm = 0x12345678
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x4, %rax
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rax, %r14
               	jmp	0x401709 <.text+0x1449>
               	leaq	0xed39(%rip), %rbx      # 0x4103ff
               	leaq	0xed3c(%rip), %r15      # 0x410409
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x40168f <.text+0x13cf>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r14, %rax
               	xorq	$0x23456780, %rax       # imm = 0x23456780
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x4017b7 <.text+0x14f7>
               	jmp	0x401772 <.text+0x14b2>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401709 <.text+0x1449>
               	movl	$0x1, %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x1f, %rax
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rax, %r12
               	jmp	0x4017bc <.text+0x14fc>
               	leaq	0xec96(%rip), %r15      # 0x41040f
               	leaq	0xec99(%rip), %rbx      # 0x410419
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401742 <.text+0x1482>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r12, %rax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401847 <.text+0x1587>
               	jmp	0x401802 <.text+0x1542>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4017bc <.text+0x14fc>
               	movl	$0x1, %r15d
               	jmp	0x40184c <.text+0x158c>
               	leaq	0xec19(%rip), %rbx      # 0x410422
               	leaq	0xec1c(%rip), %r14      # 0x41042c
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4017e7 <.text+0x1527>
               	movq	%r15, %r14
               	shlq	$0x3f, %r14
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x4018e3 <.text+0x1623>
               	jmp	0x40189e <.text+0x15de>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x40184c <.text+0x158c>
               	movabsq	$-0x1, %r14
               	movl	$0x1, %ebx
               	jmp	0x4018e8 <.text+0x1628>
               	leaq	0xeb91(%rip), %rbx      # 0x410436
               	leaq	0xeb94(%rip), %r12      # 0x410440
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x40187a <.text+0x15ba>
               	movslq	%r14d, %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r12
               	cmpq	%r12, %r15
               	seta	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x401974 <.text+0x16b4>
               	jmp	0x40192f <.text+0x166f>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4018e8 <.text+0x1628>
               	jmp	0x401979 <.text+0x16b9>
               	leaq	0xeb14(%rip), %r12      # 0x41044a
               	leaq	0xeb17(%rip), %r15      # 0x410454
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x40191a <.text+0x165a>
               	movslq	%r14d, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r15
               	movslq	%r15d, %r15
               	cmpq	%r15, %rax
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401a1e <.text+0x175e>
               	jmp	0x4019d9 <.text+0x1719>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401979 <.text+0x16b9>
               	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
               	movl	%eax, -0xe0(%rbp)
               	leaq	-0xe0(%rbp), %r15
               	movl	(%r15), %eax
               	addq	$0x1, %rax
               	movl	%eax, (%r15)
               	jmp	0x401a23 <.text+0x1763>
               	leaq	0xea80(%rip), %r12      # 0x410460
               	leaq	0xea83(%rip), %r15      # 0x41046a
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4019a5 <.text+0x16e5>
               	movl	-0xe0(%rbp), %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401ab8 <.text+0x17f8>
               	jmp	0x401a73 <.text+0x17b3>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401a23 <.text+0x1763>
               	leaq	-0xe0(%rbp), %rax
               	movl	(%rax), %ebx
               	addq	$0x1, %rbx
               	movl	%ebx, (%rax)
               	jmp	0x401abd <.text+0x17fd>
               	leaq	0xe9fb(%rip), %r12      # 0x410475
               	leaq	0xe9fe(%rip), %rbx      # 0x41047f
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401a4c <.text+0x178c>
               	movl	-0xe0(%rbp), %ebx
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rbx
               	cmpq	$0x0, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401b6a <.text+0x18aa>
               	jmp	0x401b25 <.text+0x1865>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401abd <.text+0x17fd>
               	movl	$0xfe, %eax
               	movb	%al, -0xe8(%rbp)
               	leaq	-0xe8(%rbp), %r12
               	movzbq	(%r12), %rax
               	addq	$0x1, %rax
               	movb	%al, (%r12)
               	jmp	0x401b6f <.text+0x18af>
               	leaq	0xe962(%rip), %r15      # 0x41048e
               	leaq	0xe965(%rip), %r12      # 0x410498
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401aed <.text+0x182d>
               	movzbq	-0xe8(%rbp), %rax
               	xorq	$0xff, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401c17 <.text+0x1957>
               	jmp	0x401bd2 <.text+0x1912>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401b6f <.text+0x18af>
               	leaq	-0xe8(%rbp), %rax
               	movzbq	(%rax), %r15
               	addq	$0x1, %r15
               	movb	%r15b, (%rax)
               	jmp	0x401c1c <.text+0x195c>
               	leaq	0xe8d1(%rip), %rbx      # 0x4104aa
               	leaq	0xe8d4(%rip), %r15      # 0x4104b4
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401ba8 <.text+0x18e8>
               	movzbq	-0xe8(%rbp), %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	cmpq	$0x0, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x401ccd <.text+0x1a0d>
               	jmp	0x401c88 <.text+0x19c8>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401c1c <.text+0x195c>
               	movabsq	$-0x2, %rax
               	movq	%rax, -0xf0(%rbp)
               	leaq	-0xf0(%rbp), %rbx
               	movq	(%rbx), %rax
               	addq	$0x1, %rax
               	movq	%rax, (%rbx)
               	jmp	0x401cd2 <.text+0x1a12>
               	leaq	0xe838(%rip), %r12      # 0x4104c7
               	leaq	0xe83b(%rip), %rbx      # 0x4104d1
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401c4e <.text+0x198e>
               	movq	-0xf0(%rbp), %rax
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401d68 <.text+0x1aa8>
               	jmp	0x401d23 <.text+0x1a63>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401cd2 <.text+0x1a12>
               	leaq	-0xf0(%rbp), %rax
               	movq	(%rax), %r12
               	addq	$0x1, %r12
               	movq	%r12, (%rax)
               	jmp	0x401d6d <.text+0x1aad>
               	leaq	0xe7b8(%rip), %r15      # 0x4104e2
               	leaq	0xe7bb(%rip), %r12      # 0x4104ec
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401cfa <.text+0x1a3a>
               	movq	-0xf0(%rbp), %r12
               	cmpq	$0x0, %r12
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x401def <.text+0x1b2f>
               	jmp	0x401daa <.text+0x1aea>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401d6d <.text+0x1aad>
               	jmp	0x401df4 <.text+0x1b34>
               	leaq	0xe74a(%rip), %rbx      # 0x4104fb
               	leaq	0xe74d(%rip), %r15      # 0x410505
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401d95 <.text+0x1ad5>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x401e65 <.text+0x1ba5>
               	jmp	0x401e20 <.text+0x1b60>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401df4 <.text+0x1b34>
               	jmp	0x401e6a <.text+0x1baa>
               	leaq	0xe6f0(%rip), %r12      # 0x410517
               	leaq	0xe6f3(%rip), %r15      # 0x410521
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401e0b <.text+0x1b4b>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x401edb <.text+0x1c1b>
               	jmp	0x401e96 <.text+0x1bd6>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401e6a <.text+0x1baa>
               	jmp	0x401ee0 <.text+0x1c20>
               	leaq	0xe68f(%rip), %rbx      # 0x41052c
               	leaq	0xe692(%rip), %r15      # 0x410536
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401e81 <.text+0x1bc1>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x401f51 <.text+0x1c91>
               	jmp	0x401f0c <.text+0x1c4c>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401ee0 <.text+0x1c20>
               	jmp	0x401f56 <.text+0x1c96>
               	leaq	0xe631(%rip), %r12      # 0x410544
               	leaq	0xe634(%rip), %r15      # 0x41054e
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401ef7 <.text+0x1c37>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x401fc7 <.text+0x1d07>
               	jmp	0x401f82 <.text+0x1cc2>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401f56 <.text+0x1c96>
               	jmp	0x401fcc <.text+0x1d0c>
               	leaq	0xe5d1(%rip), %rbx      # 0x41055a
               	leaq	0xe5d4(%rip), %r15      # 0x410564
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401f6d <.text+0x1cad>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x40203d <.text+0x1d7d>
               	jmp	0x401ff8 <.text+0x1d38>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401fcc <.text+0x1d0c>
               	jmp	0x402042 <.text+0x1d82>
               	leaq	0xe571(%rip), %r12      # 0x410570
               	leaq	0xe574(%rip), %r15      # 0x41057a
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x401fe3 <.text+0x1d23>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x4020b3 <.text+0x1df3>
               	jmp	0x40206e <.text+0x1dae>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x402042 <.text+0x1d82>
               	jmp	0x4020b8 <.text+0x1df8>
               	leaq	0xe511(%rip), %rbx      # 0x410586
               	leaq	0xe514(%rip), %r15      # 0x410590
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x402059 <.text+0x1d99>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x402129 <.text+0x1e69>
               	jmp	0x4020e4 <.text+0x1e24>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4020b8 <.text+0x1df8>
               	jmp	0x40212e <.text+0x1e6e>
               	leaq	0xe4b9(%rip), %r12      # 0x4105a4
               	leaq	0xe4bc(%rip), %r15      # 0x4105ae
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x4020cf <.text+0x1e0f>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x4021bf <.text+0x1eff>
               	jmp	0x40217a <.text+0x1eba>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x40212e <.text+0x1e6e>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	0xe439(%rip), %rbx      # 0x4105ba
               	leaq	0xe43c(%rip), %r15      # 0x4105c4
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40230d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	0x402145 <.text+0x1e85>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
