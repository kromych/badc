
integer_ops_exhaustive.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40040d <.text+0x14d>
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
               	callq	0x402377 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x4003d9 <.text+0x119>
               	leaq	0xfd3f(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x4003d9 <.text+0x119>
               	leaq	0xfd20(%rip), %r12      # 0x410100
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
               	subq	$0x130, %rsp            # imm = 0x130
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0xfffffffe, %ebx       # imm = 0xFFFFFFFE
               	movl	$0x1, %r12d
               	jmp	0x40043b <.text+0x17b>
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rbx, %r8
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r12, %rdi
               	cmpq	%rdi, %r8
               	seta	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x0, %rsi
               	jne	0x4004c3 <.text+0x203>
               	jmp	0x40047e <.text+0x1be>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x40043b <.text+0x17b>
               	jmp	0x4004c8 <.text+0x208>
               	leaq	0xfccb(%rip), %r14      # 0x410150
               	leaq	0xfcce(%rip), %r15      # 0x41015a
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x400469 <.text+0x1a9>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r12, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r15
               	cmpq	%r15, %rax
               	setb	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x400550 <.text+0x290>
               	jmp	0x40050b <.text+0x24b>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4004c8 <.text+0x208>
               	jmp	0x400555 <.text+0x295>
               	leaq	0xfc5b(%rip), %r14      # 0x41016d
               	leaq	0xfc5e(%rip), %r15      # 0x410177
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x4004f6 <.text+0x236>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	%r15, %rax
               	setae	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x4005dd <.text+0x31d>
               	jmp	0x400598 <.text+0x2d8>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400555 <.text+0x295>
               	jmp	0x4005e2 <.text+0x322>
               	leaq	0xfbeb(%rip), %r14      # 0x41018a
               	leaq	0xfbee(%rip), %r15      # 0x410194
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x400583 <.text+0x2c3>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r12, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r15
               	cmpq	%r15, %rax
               	setbe	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x40066a <.text+0x3aa>
               	jmp	0x400625 <.text+0x365>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4005e2 <.text+0x322>
               	jmp	0x40066f <.text+0x3af>
               	leaq	0xfb7c(%rip), %r14      # 0x4101a8
               	leaq	0xfb7f(%rip), %r15      # 0x4101b2
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x400610 <.text+0x350>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	%r15, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x4006f7 <.text+0x437>
               	jmp	0x4006b2 <.text+0x3f2>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x40066f <.text+0x3af>
               	jmp	0x4006fc <.text+0x43c>
               	leaq	0xfb0d(%rip), %r14      # 0x4101c6
               	leaq	0xfb10(%rip), %r15      # 0x4101d0
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x40069d <.text+0x3dd>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	%r15, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x4007a2 <.text+0x4e2>
               	jmp	0x40075d <.text+0x49d>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4006fc <.text+0x43c>
               	movabsq	$-0x2, %r15
               	movl	$0x1, %ebx
               	jmp	0x4007a7 <.text+0x4e7>
               	leaq	0xfa80(%rip), %r15      # 0x4101e4
               	leaq	0xfa83(%rip), %r14      # 0x4101ee
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x400739 <.text+0x479>
               	movslq	%r15d, %r12
               	movslq	%ebx, %r14
               	cmpq	%r14, %r12
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400824 <.text+0x564>
               	jmp	0x4007df <.text+0x51f>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4007a7 <.text+0x4e7>
               	jmp	0x400829 <.text+0x569>
               	leaq	0xfa1c(%rip), %r12      # 0x410202
               	leaq	0xfa1f(%rip), %r14      # 0x41020c
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x4007ca <.text+0x50a>
               	movslq	%ebx, %rax
               	movslq	%r15d, %r14
               	cmpq	%r14, %rax
               	setg	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x4008a6 <.text+0x5e6>
               	jmp	0x400861 <.text+0x5a1>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400829 <.text+0x569>
               	jmp	0x4008ab <.text+0x5eb>
               	leaq	0xf9af(%rip), %r12      # 0x410217
               	leaq	0xf9b2(%rip), %r14      # 0x410221
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x40084c <.text+0x58c>
               	movslq	%r15d, %rax
               	movslq	%ebx, %r14
               	cmpq	%r14, %rax
               	setle	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x400928 <.text+0x668>
               	jmp	0x4008e3 <.text+0x623>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4008ab <.text+0x5eb>
               	jmp	0x40092d <.text+0x66d>
               	leaq	0xf942(%rip), %r12      # 0x41022c
               	leaq	0xf945(%rip), %r14      # 0x410236
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x4008ce <.text+0x60e>
               	movslq	%ebx, %rax
               	movslq	%r15d, %r14
               	cmpq	%r14, %rax
               	setge	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x4009ba <.text+0x6fa>
               	jmp	0x400975 <.text+0x6b5>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x40092d <.text+0x66d>
               	movabsq	$-0x2, %r12
               	movl	$0x1, %r15d
               	jmp	0x4009bf <.text+0x6ff>
               	leaq	0xf8c6(%rip), %r12      # 0x410242
               	leaq	0xf8c9(%rip), %r14      # 0x41024c
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x400950 <.text+0x690>
               	cmpq	%r15, %r12
               	seta	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400a36 <.text+0x776>
               	jmp	0x4009f1 <.text+0x731>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4009bf <.text+0x6ff>
               	jmp	0x400a3b <.text+0x77b>
               	leaq	0xf860(%rip), %rbx      # 0x410258
               	leaq	0xf863(%rip), %r14      # 0x410262
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x4009dc <.text+0x71c>
               	cmpq	%r15, %r12
               	setae	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400ab2 <.text+0x7f2>
               	jmp	0x400a6d <.text+0x7ad>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400a3b <.text+0x77b>
               	jmp	0x400ab7 <.text+0x7f7>
               	leaq	0xf7fb(%rip), %rbx      # 0x41026f
               	leaq	0xf7fe(%rip), %r14      # 0x410279
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x400a58 <.text+0x798>
               	cmpq	%r12, %r15
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400b3e <.text+0x87e>
               	jmp	0x400af9 <.text+0x839>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400ab7 <.text+0x7f7>
               	movabsq	$-0x2, %rbx
               	movl	$0x1, %r12d
               	jmp	0x400b43 <.text+0x883>
               	leaq	0xf787(%rip), %rbx      # 0x410287
               	leaq	0xf78a(%rip), %r14      # 0x410291
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x400ad4 <.text+0x814>
               	cmpq	%rbx, %r12
               	setg	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x400bba <.text+0x8fa>
               	jmp	0x400b75 <.text+0x8b5>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400b43 <.text+0x883>
               	jmp	0x400bbf <.text+0x8ff>
               	leaq	0xf722(%rip), %r15      # 0x41029e
               	leaq	0xf725(%rip), %r14      # 0x4102a8
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x400b60 <.text+0x8a0>
               	cmpq	$0x0, %rbx
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400c46 <.text+0x986>
               	jmp	0x400c01 <.text+0x941>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400bbf <.text+0x8ff>
               	movl	$0xfe, %r14d
               	movl	$0x1, %r15d
               	jmp	0x400c4b <.text+0x98b>
               	leaq	0xf6ab(%rip), %r15      # 0x4102b3
               	leaq	0xf6ae(%rip), %r12      # 0x4102bd
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x400be0 <.text+0x920>
               	movq	%r14, %rbx
               	andq	$0xff, %rbx
               	movq	%r15, %r12
               	andq	$0xff, %r12
               	cmpq	%r12, %rbx
               	setg	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400cd6 <.text+0xa16>
               	jmp	0x400c91 <.text+0x9d1>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400c4b <.text+0x98b>
               	jmp	0x400cdb <.text+0xa1b>
               	leaq	0xf630(%rip), %rbx      # 0x4102c8
               	leaq	0xf633(%rip), %r12      # 0x4102d2
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x400c7c <.text+0x9bc>
               	movq	%r15, %rax
               	andq	$0xff, %rax
               	movq	%r14, %r12
               	andq	$0xff, %r12
               	cmpq	%r12, %rax
               	setl	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400d76 <.text+0xab6>
               	jmp	0x400d31 <.text+0xa71>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400cdb <.text+0xa1b>
               	movabsq	$-0x2, %rbx
               	movl	$0x1, %r14d
               	jmp	0x400d7b <.text+0xabb>
               	leaq	0xf5a6(%rip), %rbx      # 0x4102de
               	leaq	0xf5a9(%rip), %r12      # 0x4102e8
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x400d0c <.text+0xa4c>
               	movsbq	%bl, %r15
               	movsbq	%r14b, %r12
               	cmpq	%r12, %r15
               	setl	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400dfa <.text+0xb3a>
               	jmp	0x400db5 <.text+0xaf5>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400d7b <.text+0xabb>
               	jmp	0x400dff <.text+0xb3f>
               	leaq	0xf538(%rip), %r15      # 0x4102f4
               	leaq	0xf53b(%rip), %r12      # 0x4102fe
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x400da0 <.text+0xae0>
               	movsbq	%r14b, %rax
               	movsbq	%bl, %r12
               	cmpq	%r12, %rax
               	setg	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x400e9c <.text+0xbdc>
               	jmp	0x400e57 <.text+0xb97>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400dff <.text+0xb3f>
               	movl	$0x64, %eax
               	movl	%eax, -0x68(%rbp)
               	leaq	-0x68(%rbp), %r12
               	movl	(%r12), %eax
               	movq	%rax, %r14
               	addq	$0x5, %r14
               	movl	%r14d, (%r12)
               	jmp	0x400ea1 <.text+0xbe1>
               	leaq	0xf4aa(%rip), %r15      # 0x410308
               	leaq	0xf4ad(%rip), %r12      # 0x410312
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x400e24 <.text+0xb64>
               	movl	-0x68(%rbp), %r14d
               	movq	%r14, %rax
               	xorq	$0x69, %rax
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rax, %r14
               	cmpq	$0x0, %r14
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x400f46 <.text+0xc86>
               	jmp	0x400f01 <.text+0xc41>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400ea1 <.text+0xbe1>
               	leaq	-0x68(%rbp), %rax
               	movl	(%rax), %ebx
               	movq	%rbx, %r15
               	subq	$0xa, %r15
               	movl	%r15d, (%rax)
               	jmp	0x400f4b <.text+0xc8b>
               	leaq	0xf414(%rip), %r15      # 0x41031c
               	leaq	0xf417(%rip), %rbx      # 0x410326
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x400ed9 <.text+0xc19>
               	movl	-0x68(%rbp), %r15d
               	movq	%r15, %rbx
               	xorq	$0x5f, %rbx
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r15
               	cmpq	$0x0, %r15
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400fed <.text+0xd2d>
               	jmp	0x400fa8 <.text+0xce8>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400f4b <.text+0xc8b>
               	leaq	-0x68(%rbp), %rax
               	movl	(%rax), %ebx
               	movq	%rbx, %r12
               	shlq	$0x1, %r12
               	movl	%r12d, (%rax)
               	jmp	0x400ff2 <.text+0xd32>
               	leaq	0xf380(%rip), %r12      # 0x41032f
               	leaq	0xf383(%rip), %rbx      # 0x410339
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x400f83 <.text+0xcc3>
               	movl	-0x68(%rbp), %r12d
               	movq	%r12, %rbx
               	xorq	$0xbe, %rbx
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r12
               	cmpq	$0x0, %r12
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4010a6 <.text+0xde6>
               	jmp	0x401061 <.text+0xda1>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400ff2 <.text+0xd32>
               	leaq	-0x68(%rbp), %rax
               	movl	(%rax), %ebx
               	movl	$0x5, %r15d
               	movq	%r15, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%rbx, %rax
               	xorq	%rdx, %rdx
               	divq	%r11
               	movq	%rax, %r14
               	popq	%rdx
               	popq	%rax
               	movl	%r14d, (%rax)
               	jmp	0x4010ab <.text+0xdeb>
               	leaq	0xf2db(%rip), %r15      # 0x410343
               	leaq	0xf2de(%rip), %rbx      # 0x41034d
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x40102a <.text+0xd6a>
               	movl	-0x68(%rbp), %r14d
               	movq	%r14, %r15
               	xorq	$0x26, %r15
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%r15, %r14
               	cmpq	$0x0, %r14
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x40115f <.text+0xe9f>
               	jmp	0x40111a <.text+0xe5a>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4010ab <.text+0xdeb>
               	leaq	-0x68(%rbp), %rax
               	movl	(%rax), %r15d
               	movl	$0x7, %r12d
               	movq	%r12, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r15, %rax
               	xorq	%rdx, %rdx
               	divq	%r11
               	movq	%rdx, %rbx
               	popq	%rdx
               	popq	%rax
               	movl	%ebx, (%rax)
               	jmp	0x401164 <.text+0xea4>
               	leaq	0xf235(%rip), %r12      # 0x410356
               	leaq	0xf238(%rip), %r15      # 0x410360
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x4010e3 <.text+0xe23>
               	movl	-0x68(%rbp), %ebx
               	movq	%rbx, %r12
               	xorq	$0x3, %r12
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r12, %rbx
               	cmpq	$0x0, %rbx
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x401214 <.text+0xf54>
               	jmp	0x4011cf <.text+0xf0f>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401164 <.text+0xea4>
               	movl	$0x1, %eax
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rax, %r12
               	movq	%r12, %rax
               	subq	$0x2, %rax
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%rax, %rbx
               	jmp	0x401219 <.text+0xf59>
               	leaq	0xf193(%rip), %r14      # 0x410369
               	leaq	0xf196(%rip), %r12      # 0x410373
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x40119a <.text+0xeda>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rax, %r14
               	cmpq	%r11, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x4012be <.text+0xffe>
               	jmp	0x401279 <.text+0xfb9>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x401219 <.text+0xf59>
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	movq	%rax, -0x78(%rbp)
               	leaq	-0x78(%rbp), %r14
               	movq	(%r14), %rax
               	movq	%rax, %rbx
               	addq	$0x19f, %rbx            # imm = 0x19F
               	movq	%rbx, (%r14)
               	jmp	0x4012c3 <.text+0x1003>
               	leaq	0xf0fc(%rip), %r12      # 0x41037c
               	leaq	0xf0ff(%rip), %r14      # 0x410386
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x401247 <.text+0xf87>
               	movq	-0x78(%rbp), %rbx
               	cmpq	$0x587, %rbx            # imm = 0x587
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401356 <.text+0x1096>
               	jmp	0x401311 <.text+0x1051>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4012c3 <.text+0x1003>
               	leaq	-0x78(%rbp), %rax
               	movq	(%rax), %r12
               	movl	$0x3, %r15d
               	imulq	%r12, %r15
               	movq	%r15, (%rax)
               	jmp	0x40135b <.text+0x109b>
               	leaq	0xf07c(%rip), %r15      # 0x410394
               	leaq	0xf07f(%rip), %r12      # 0x41039e
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x4012e8 <.text+0x1028>
               	movq	-0x78(%rbp), %r15
               	cmpq	$0x1095, %r15           # imm = 0x1095
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x4013fd <.text+0x113d>
               	jmp	0x4013b8 <.text+0x10f8>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x40135b <.text+0x109b>
               	leaq	-0x78(%rbp), %rax
               	movq	(%rax), %r12
               	movl	$0x5, %r14d
               	movq	%r14, %r11
               	pushq	%rax
               	pushq	%rdx
               	movq	%r12, %rax
               	xorq	%rdx, %rdx
               	divq	%r11
               	movq	%rax, %rbx
               	popq	%rdx
               	popq	%rax
               	movq	%rbx, (%rax)
               	jmp	0x401402 <.text+0x1142>
               	leaq	0xefea(%rip), %r14      # 0x4103a9
               	leaq	0xefed(%rip), %r12      # 0x4103b3
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x401380 <.text+0x10c0>
               	movq	-0x78(%rbp), %rbx
               	cmpq	$0x351, %rbx            # imm = 0x351
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x4014c9 <.text+0x1209>
               	jmp	0x401484 <.text+0x11c4>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x401402 <.text+0x1142>
               	movl	$0xff00ff00, %eax       # imm = 0xFF00FF00
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rax, %r14
               	movq	%r14, %rbx
               	andq	$0xf0f0f0f, %rbx        # imm = 0xF0F0F0F
               	movq	%r14, %r12
               	orq	$0xff000, %r12          # imm = 0xFF000
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	xorq	%r14, %r10
               	movq	%r10, 0x20(%rsp)
               	movq	%r14, %rax
               	xorq	$-0x1, %rax
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	jmp	0x4014ce <.text+0x120e>
               	leaq	0xef31(%rip), %r15      # 0x4103bc
               	leaq	0xef34(%rip), %r14      # 0x4103c6
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x401427 <.text+0x1167>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	movq	%rax, %rdx
               	xorq	$0xf000f00, %rdx        # imm = 0xF000F00
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rdx, %rax
               	cmpq	$0x0, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	0x401563 <.text+0x12a3>
               	jmp	0x40151e <.text+0x125e>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4014ce <.text+0x120e>
               	jmp	0x401568 <.text+0x12a8>
               	leaq	0xeeaa(%rip), %r14      # 0x4103cf
               	leaq	0xeead(%rip), %r15      # 0x4103d9
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x401509 <.text+0x1249>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r12, %rax
               	movl	$0xff0fff00, %r11d      # imm = 0xFF0FFF00
               	movq	%rax, %r15
               	cmpq	%r11, %rax
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x4015f0 <.text+0x1330>
               	jmp	0x4015ab <.text+0x12eb>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401568 <.text+0x12a8>
               	jmp	0x4015f5 <.text+0x1335>
               	leaq	0xee2d(%rip), %r14      # 0x4103df
               	leaq	0xee30(%rip), %r15      # 0x4103e9
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x401596 <.text+0x12d6>
               	movq	0x20(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movq	%rax, %r15
               	xorq	$0xff00ff, %r15         # imm = 0xFF00FF
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r15, %rax
               	cmpq	$0x0, %rax
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x401690 <.text+0x13d0>
               	jmp	0x40164b <.text+0x138b>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4015f5 <.text+0x1335>
               	jmp	0x401695 <.text+0x13d5>
               	leaq	0xed9d(%rip), %rbx      # 0x4103ef
               	leaq	0xeda0(%rip), %r15      # 0x4103f9
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x401636 <.text+0x1376>
               	movq	0x28(%rsp), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	movq	%rax, %r15
               	xorq	$0xff00ff, %r15         # imm = 0xFF00FF
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r15, %rax
               	cmpq	$0x0, %rax
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x40174d <.text+0x148d>
               	jmp	0x401708 <.text+0x1448>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401695 <.text+0x13d5>
               	movl	$0x12345678, %eax       # imm = 0x12345678
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rax, %r15
               	movq	%r15, %rax
               	shlq	$0x4, %rax
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%rax, %rbx
               	jmp	0x401752 <.text+0x1492>
               	leaq	0xecf0(%rip), %r12      # 0x4103ff
               	leaq	0xecf3(%rip), %r15      # 0x410409
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x4016d6 <.text+0x1416>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	movq	%rax, %r12
               	xorq	$0x23456780, %r12       # imm = 0x23456780
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r12, %rax
               	cmpq	$0x0, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x401805 <.text+0x1545>
               	jmp	0x4017c0 <.text+0x1500>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401752 <.text+0x1492>
               	movl	$0x1, %eax
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rax, %r12
               	movq	%r12, %rax
               	shlq	$0x1f, %rax
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rax, %r14
               	jmp	0x40180a <.text+0x154a>
               	leaq	0xec48(%rip), %r15      # 0x41040f
               	leaq	0xec4b(%rip), %r12      # 0x410419
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x40178d <.text+0x14cd>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r14, %rax
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	movq	%rax, %rbx
               	cmpq	%r11, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401898 <.text+0x15d8>
               	jmp	0x401853 <.text+0x1593>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x40180a <.text+0x154a>
               	movl	$0x1, %r15d
               	jmp	0x40189d <.text+0x15dd>
               	leaq	0xebc8(%rip), %r12      # 0x410422
               	leaq	0xebcb(%rip), %rbx      # 0x41042c
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x401838 <.text+0x1578>
               	movq	%r15, %rbx
               	shlq	$0x3f, %rbx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rbx, %r14
               	cmpq	%r11, %rbx
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x401938 <.text+0x1678>
               	jmp	0x4018f3 <.text+0x1633>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x40189d <.text+0x15dd>
               	movabsq	$-0x1, %rbx
               	movl	$0x1, %r12d
               	jmp	0x40193d <.text+0x167d>
               	leaq	0xeb3c(%rip), %r12      # 0x410436
               	leaq	0xeb3f(%rip), %r14      # 0x410440
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x4018ce <.text+0x160e>
               	movslq	%ebx, %r15
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%r15, %r14
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	%r15, %r14
               	seta	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x4019c9 <.text+0x1709>
               	jmp	0x401984 <.text+0x16c4>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x40193d <.text+0x167d>
               	jmp	0x4019ce <.text+0x170e>
               	leaq	0xeabf(%rip), %r14      # 0x41044a
               	leaq	0xeac2(%rip), %r15      # 0x410454
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x40196f <.text+0x16af>
               	movslq	%ebx, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	movslq	%r15d, %r15
               	cmpq	%r15, %rax
               	setl	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x401a76 <.text+0x17b6>
               	jmp	0x401a31 <.text+0x1771>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4019ce <.text+0x170e>
               	movl	$0xfffffffe, %eax       # imm = 0xFFFFFFFE
               	movl	%eax, -0xe0(%rbp)
               	leaq	-0xe0(%rbp), %r15
               	movl	(%r15), %eax
               	movq	%rax, %r12
               	addq	$0x1, %r12
               	movl	%r12d, (%r15)
               	jmp	0x401a7b <.text+0x17bb>
               	leaq	0xea28(%rip), %r14      # 0x410460
               	leaq	0xea2b(%rip), %r15      # 0x41046a
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x4019fa <.text+0x173a>
               	movl	-0xe0(%rbp), %r12d
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%r12, %rax
               	cmpq	%r11, %r12
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401b18 <.text+0x1858>
               	jmp	0x401ad3 <.text+0x1813>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401a7b <.text+0x17bb>
               	leaq	-0xe0(%rbp), %rax
               	movl	(%rax), %ebx
               	movq	%rbx, %r14
               	addq	$0x1, %r14
               	movl	%r14d, (%rax)
               	jmp	0x401b1d <.text+0x185d>
               	leaq	0xe99b(%rip), %r14      # 0x410475
               	leaq	0xe99e(%rip), %rbx      # 0x41047f
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x401aa8 <.text+0x17e8>
               	movl	-0xe0(%rbp), %r14d
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r14, %rbx
               	cmpq	$0x0, %rbx
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x401bcb <.text+0x190b>
               	jmp	0x401b86 <.text+0x18c6>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x401b1d <.text+0x185d>
               	movl	$0xfe, %eax
               	movb	%al, -0xe8(%rbp)
               	leaq	-0xe8(%rbp), %r14
               	movzbq	(%r14), %rax
               	movq	%rax, %r15
               	addq	$0x1, %r15
               	movb	%r15b, (%r14)
               	jmp	0x401bd0 <.text+0x1910>
               	leaq	0xe901(%rip), %r15      # 0x41048e
               	leaq	0xe904(%rip), %r14      # 0x410498
               	movq	%r15, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x401b4d <.text+0x188d>
               	movzbq	-0xe8(%rbp), %r15
               	movq	%r15, %rax
               	xorq	$0xff, %rax
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%rax, %r15
               	cmpq	$0x0, %r15
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401c7e <.text+0x19be>
               	jmp	0x401c39 <.text+0x1979>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x401bd0 <.text+0x1910>
               	leaq	-0xe8(%rbp), %rax
               	movzbq	(%rax), %r12
               	movq	%r12, %rbx
               	addq	$0x1, %rbx
               	movb	%bl, (%rax)
               	jmp	0x401c83 <.text+0x19c3>
               	leaq	0xe86a(%rip), %rbx      # 0x4104aa
               	leaq	0xe86d(%rip), %r12      # 0x4104b4
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x401c0c <.text+0x194c>
               	movzbq	-0xe8(%rbp), %rbx
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r12
               	cmpq	$0x0, %r12
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401d37 <.text+0x1a77>
               	jmp	0x401cf2 <.text+0x1a32>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401c83 <.text+0x19c3>
               	movabsq	$-0x2, %rax
               	movq	%rax, -0xf0(%rbp)
               	leaq	-0xf0(%rbp), %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %r14
               	addq	$0x1, %r14
               	movq	%r14, (%rbx)
               	jmp	0x401d3c <.text+0x1a7c>
               	leaq	0xe7ce(%rip), %r14      # 0x4104c7
               	leaq	0xe7d1(%rip), %rbx      # 0x4104d1
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x401cb5 <.text+0x19f5>
               	movq	-0xf0(%rbp), %r14
               	cmpq	$-0x1, %r14
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x401dd5 <.text+0x1b15>
               	jmp	0x401d90 <.text+0x1ad0>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401d3c <.text+0x1a7c>
               	leaq	-0xf0(%rbp), %rax
               	movq	(%rax), %r15
               	movq	%r15, %r12
               	addq	$0x1, %r12
               	movq	%r12, (%rax)
               	jmp	0x401dda <.text+0x1b1a>
               	leaq	0xe74b(%rip), %r12      # 0x4104e2
               	leaq	0xe74e(%rip), %r15      # 0x4104ec
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x401d64 <.text+0x1aa4>
               	movq	-0xf0(%rbp), %r12
               	cmpq	$0x0, %r12
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x401e5c <.text+0x1b9c>
               	jmp	0x401e17 <.text+0x1b57>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401dda <.text+0x1b1a>
               	jmp	0x401e61 <.text+0x1ba1>
               	leaq	0xe6dd(%rip), %rbx      # 0x4104fb
               	leaq	0xe6e0(%rip), %r15      # 0x410505
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x401e02 <.text+0x1b42>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x401ed2 <.text+0x1c12>
               	jmp	0x401e8d <.text+0x1bcd>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x401e61 <.text+0x1ba1>
               	jmp	0x401ed7 <.text+0x1c17>
               	leaq	0xe683(%rip), %r12      # 0x410517
               	leaq	0xe686(%rip), %r14      # 0x410521
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x401e78 <.text+0x1bb8>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x401f48 <.text+0x1c88>
               	jmp	0x401f03 <.text+0x1c43>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401ed7 <.text+0x1c17>
               	jmp	0x401f4d <.text+0x1c8d>
               	leaq	0xe622(%rip), %rbx      # 0x41052c
               	leaq	0xe625(%rip), %r15      # 0x410536
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x401eee <.text+0x1c2e>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x401fbe <.text+0x1cfe>
               	jmp	0x401f79 <.text+0x1cb9>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x401f4d <.text+0x1c8d>
               	jmp	0x401fc3 <.text+0x1d03>
               	leaq	0xe5c4(%rip), %r12      # 0x410544
               	leaq	0xe5c7(%rip), %r14      # 0x41054e
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x401f64 <.text+0x1ca4>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x402034 <.text+0x1d74>
               	jmp	0x401fef <.text+0x1d2f>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401fc3 <.text+0x1d03>
               	jmp	0x402039 <.text+0x1d79>
               	leaq	0xe564(%rip), %rbx      # 0x41055a
               	leaq	0xe567(%rip), %r15      # 0x410564
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x401fda <.text+0x1d1a>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x4020aa <.text+0x1dea>
               	jmp	0x402065 <.text+0x1da5>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x402039 <.text+0x1d79>
               	jmp	0x4020af <.text+0x1def>
               	leaq	0xe504(%rip), %r12      # 0x410570
               	leaq	0xe507(%rip), %r14      # 0x41057a
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x402050 <.text+0x1d90>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x402120 <.text+0x1e60>
               	jmp	0x4020db <.text+0x1e1b>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4020af <.text+0x1def>
               	jmp	0x402125 <.text+0x1e65>
               	leaq	0xe4a4(%rip), %rbx      # 0x410586
               	leaq	0xe4a7(%rip), %r15      # 0x410590
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x4020c6 <.text+0x1e06>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x402196 <.text+0x1ed6>
               	jmp	0x402151 <.text+0x1e91>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x402125 <.text+0x1e65>
               	jmp	0x40219b <.text+0x1edb>
               	leaq	0xe44c(%rip), %r12      # 0x4105a4
               	leaq	0xe44f(%rip), %r14      # 0x4105ae
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x40213c <.text+0x1e7c>
               	movl	$0x1, %eax
               	cmpq	$0x0, %rax
               	jne	0x40222c <.text+0x1f6c>
               	jmp	0x4021e7 <.text+0x1f27>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x40219b <.text+0x1edb>
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
               	leaq	0xe3cc(%rip), %rbx      # 0x4105ba
               	leaq	0xe3cf(%rip), %r15      # 0x4105c4
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40237d <printf>
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
               	jmp	0x4021b2 <.text+0x1ef2>
               	addb	%al, (%rax)
