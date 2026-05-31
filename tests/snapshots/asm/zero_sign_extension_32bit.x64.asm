
zero_sign_extension_32bit.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400490 <.text+0x150>
               	movq	%rax, %rdi
               	callq	*0xfda9(%rip)           # 0x410100
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfd96(%rip), %r9       # 0x410110
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x4003cb <.text+0x8b>
               	leaq	0xfd72(%rip), %rdi      # 0x410110
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
               	leaq	0xfd4f(%rip), %rdi      # 0x410128
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfd3d(%rip), %rsi      # 0x41012e
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfd2c(%rip), %r9       # 0x410135
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
               	callq	0x401507 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x40045c <.text+0x11c>
               	leaq	0xfccc(%rip), %r14      # 0x410110
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x40045c <.text+0x11c>
               	leaq	0xfcad(%rip), %r12      # 0x410110
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
               	subq	$0x1d0, %rsp            # imm = 0x1D0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movabsq	$-0x1, %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xc8(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0xc0(%rsp)
               	jmp	0x4004d8 <.text+0x198>
               	movq	0xc0(%rsp), %r8
               	cmpq	$-0x1, %r8
               	sete	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x400562 <.text+0x222>
               	jmp	0x400516 <.text+0x1d6>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4004d8 <.text+0x198>
               	jmp	0x400567 <.text+0x227>
               	leaq	0xfc43(%rip), %r8       # 0x410160
               	movl	$0x1, %r14d
               	movl	%r14d, (%r8)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xfc2a(%rip), %r15      # 0x410168
               	movl	$0x1b, %r12d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	jmp	0x400562 <.text+0x222>
               	jmp	0x400501 <.text+0x1c1>
               	movq	0xc8(%rsp), %r8
               	movslq	%r8d, %r8
               	cmpq	$-0x1, %r8
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x400616 <.text+0x2d6>
               	jmp	0x4005cf <.text+0x28f>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400567 <.text+0x227>
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	movq	%r10, 0xb8(%rsp)
               	movq	0xb8(%rsp), %r10
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r10
               	movq	%r10, 0xb0(%rsp)
               	jmp	0x40061b <.text+0x2db>
               	leaq	0xfb8a(%rip), %r12      # 0x410160
               	movl	$0x2, %r14d
               	movl	%r14d, (%r12)
               	movq	%r14, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xfb8c(%rip), %r15      # 0x41017e
               	movl	$0x1c, %r12d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	jmp	0x400616 <.text+0x2d6>
               	jmp	0x400593 <.text+0x253>
               	movq	0xb0(%rsp), %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %r15
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x4006a6 <.text+0x366>
               	jmp	0x40065b <.text+0x31b>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x40061b <.text+0x2db>
               	jmp	0x4006ab <.text+0x36b>
               	leaq	0xfafe(%rip), %r15      # 0x410160
               	movl	$0x3, %r12d
               	movl	%r12d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xfb11(%rip), %r15      # 0x410194
               	movl	$0x20, %ebx
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	jmp	0x4006a6 <.text+0x366>
               	jmp	0x400646 <.text+0x306>
               	movq	0xb8(%rsp), %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%r8, %rbx
               	cmpq	%r11, %r8
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400771 <.text+0x431>
               	jmp	0x400725 <.text+0x3e5>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4006ab <.text+0x36b>
               	movabsq	$-0x7, %r10
               	movq	%r10, 0xa8(%rsp)
               	movq	0xa8(%rsp), %r14
               	movslq	%r14d, %r14
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r14, %r10
               	movq	%r10, 0xa0(%rsp)
               	jmp	0x400776 <.text+0x436>
               	leaq	0xfa34(%rip), %rbx      # 0x410160
               	movl	$0x4, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xfa5d(%rip), %rbx      # 0x4101aa
               	movl	$0x21, %r14d
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	jmp	0x400771 <.text+0x431>
               	jmp	0x4006e2 <.text+0x3a2>
               	movq	0xa0(%rsp), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	movl	$0xfffffff9, %r11d      # imm = 0xFFFFFFF9
               	movq	%r14, %rbx
               	cmpq	%r11, %r14
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400829 <.text+0x4e9>
               	jmp	0x4007de <.text+0x49e>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400776 <.text+0x436>
               	movq	0xa0(%rsp), %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	movslq	%r8d, %r10
               	movq	%r10, 0x98(%rsp)
               	jmp	0x40082e <.text+0x4ee>
               	leaq	0xf97b(%rip), %rbx      # 0x410160
               	movl	$0xa, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf9bb(%rip), %rbx      # 0x4101c0
               	movl	$0x28, %r15d
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	jmp	0x400829 <.text+0x4e9>
               	jmp	0x4007ad <.text+0x46d>
               	movq	0x98(%rsp), %r15
               	movslq	%r15d, %r15
               	cmpq	$-0x7, %r15
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4008d6 <.text+0x596>
               	jmp	0x40088b <.text+0x54b>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x40082e <.text+0x4ee>
               	movq	0xa8(%rsp), %r8
               	movslq	%r8d, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r8, %r10
               	movq	%r10, 0x90(%rsp)
               	jmp	0x4008db <.text+0x59b>
               	leaq	0xf8ce(%rip), %rbx      # 0x410160
               	movl	$0xb, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf924(%rip), %rbx      # 0x4101d6
               	movl	$0x2a, %r14d
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	jmp	0x4008d6 <.text+0x596>
               	jmp	0x40085a <.text+0x51a>
               	movq	0x90(%rsp), %r8
               	movl	$0xfffffff9, %r11d      # imm = 0xFFFFFFF9
               	cmpq	%r11, %r8
               	sete	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x40098a <.text+0x64a>
               	jmp	0x40093f <.text+0x5ff>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x4008db <.text+0x59b>
               	movl	$0xf4240, %r8d          # imm = 0xF4240
               	movl	$0xbb8, %r12d           # imm = 0xBB8
               	movslq	%r8d, %rbx
               	movslq	%r12d, %r8
               	movq	%rbx, %r12
               	imulq	%r8, %r12
               	movslq	%r12d, %r10
               	movq	%r10, 0x88(%rsp)
               	jmp	0x40098f <.text+0x64f>
               	leaq	0xf81a(%rip), %r8       # 0x410160
               	movl	$0xc, %r14d
               	movl	%r14d, (%r8)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf886(%rip), %rbx      # 0x4101ec
               	movl	$0x30, %r12d
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	jmp	0x40098a <.text+0x64a>
               	jmp	0x400906 <.text+0x5c6>
               	movq	0x88(%rsp), %r8
               	movslq	%r8d, %r8
               	cmpq	$-0x4d2fa200, %r8       # imm = 0xB2D05E00
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400a1b <.text+0x6db>
               	jmp	0x4009d0 <.text+0x690>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x40098f <.text+0x64f>
               	jmp	0x400a20 <.text+0x6e0>
               	leaq	0xf789(%rip), %rbx      # 0x410160
               	movl	$0x14, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf80b(%rip), %rbx      # 0x410202
               	movl	$0x3a, %r14d
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	jmp	0x400a1b <.text+0x6db>
               	jmp	0x4009bb <.text+0x67b>
               	movq	0x88(%rsp), %r8
               	movslq	%r8d, %r8
               	cmpq	$-0x4d2fa200, %r8       # imm = 0xB2D05E00
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x400add <.text+0x79d>
               	jmp	0x400a91 <.text+0x751>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400a20 <.text+0x6e0>
               	movl	$0x10000, %r8d          # imm = 0x10000
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r8, %r15
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%r8, %r14
               	movq	%r15, %r8
               	imulq	%r14, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r8, %r10
               	movq	%r10, 0x80(%rsp)
               	jmp	0x400ae2 <.text+0x7a2>
               	leaq	0xf6c8(%rip), %r14      # 0x410160
               	movl	$0x15, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf75f(%rip), %r14      # 0x410218
               	movl	$0x3b, %r15d
               	movq	%rbx, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	jmp	0x400add <.text+0x79d>
               	jmp	0x400a4c <.text+0x70c>
               	movq	0x80(%rsp), %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x400b75 <.text+0x835>
               	jmp	0x400b29 <.text+0x7e9>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400ae2 <.text+0x7a2>
               	jmp	0x400b7a <.text+0x83a>
               	leaq	0xf630(%rip), %r15      # 0x410160
               	movl	$0x16, %r14d
               	movl	%r14d, (%r15)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf6dd(%rip), %r15      # 0x41022e
               	movl	$0x40, %r12d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	jmp	0x400b75 <.text+0x835>
               	jmp	0x400b14 <.text+0x7d4>
               	movq	0x80(%rsp), %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x400c26 <.text+0x8e6>
               	jmp	0x400bdb <.text+0x89b>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400b7a <.text+0x83a>
               	movl	$0x80000000, %r8d       # imm = 0x80000000
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r8, %rbx
               	movq	%rbx, %r10
               	shrq	$0x1, %r10
               	movq	%r10, 0x78(%rsp)
               	jmp	0x400c2b <.text+0x8eb>
               	leaq	0xf57e(%rip), %r12      # 0x410160
               	movl	$0x17, %r14d
               	movl	%r14d, (%r12)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf641(%rip), %r12      # 0x410244
               	movl	$0x41, %ebx
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	jmp	0x400c26 <.text+0x8e6>
               	jmp	0x400bac <.text+0x86c>
               	movq	0x78(%rsp), %rbx
               	cmpq	$0x40000000, %rbx       # imm = 0x40000000
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400cd5 <.text+0x995>
               	jmp	0x400c8a <.text+0x94a>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400c2b <.text+0x8eb>
               	movl	$0x12345678, %r8d       # imm = 0x12345678
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%r8, %r14
               	movq	%r14, %r8
               	shlq	$0x4, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r8, %r10
               	movq	%r10, 0x70(%rsp)
               	jmp	0x400cda <.text+0x99a>
               	leaq	0xf4cf(%rip), %rbx      # 0x410160
               	movl	$0x1e, %r15d
               	movl	%r15d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf5a9(%rip), %rbx      # 0x41025a
               	movl	$0x4a, %r14d
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	jmp	0x400cd5 <.text+0x995>
               	jmp	0x400c51 <.text+0x911>
               	movq	0x70(%rsp), %r8
               	cmpq	$0x23456780, %r8        # imm = 0x23456780
               	sete	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x400d84 <.text+0xa44>
               	jmp	0x400d39 <.text+0x9f9>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400cda <.text+0x99a>
               	xorq	%r8, %r8
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r8, %r15
               	movq	%r15, %r8
               	xorq	$-0x1, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r8, %r10
               	movq	%r10, 0x68(%rsp)
               	jmp	0x400d89 <.text+0xa49>
               	leaq	0xf420(%rip), %r8       # 0x410160
               	movl	$0x1f, %r14d
               	movl	%r14d, (%r8)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf510(%rip), %rbx      # 0x410270
               	movl	$0x4f, %r15d
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	jmp	0x400d84 <.text+0xa44>
               	jmp	0x400d00 <.text+0x9c0>
               	movq	0x68(%rsp), %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %r8
               	sete	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x400e2d <.text+0xaed>
               	jmp	0x400de2 <.text+0xaa2>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400d89 <.text+0xa49>
               	leaq	0xf4d4(%rip), %r15      # 0x41029c
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x401513 <atoi>
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%r10, 0x60(%rsp)
               	jmp	0x400e32 <.text+0xaf2>
               	leaq	0xf377(%rip), %r8       # 0x410160
               	movl	$0x20, %r15d
               	movl	%r15d, (%r8)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf47d(%rip), %rbx      # 0x410286
               	movl	$0x54, %r14d
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	jmp	0x400e2d <.text+0xaed>
               	jmp	0x400db1 <.text+0xa71>
               	movq	0x60(%rsp), %r15
               	movslq	%r15d, %r15
               	cmpq	$-0x7fffffff, %r15      # imm = 0x80000001
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400ebb <.text+0xb7b>
               	jmp	0x400e70 <.text+0xb30>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x400e32 <.text+0xaf2>
               	jmp	0x400ec0 <.text+0xb80>
               	leaq	0xf2e9(%rip), %rbx      # 0x410160
               	movl	$0x28, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf411(%rip), %rbx      # 0x4102a8
               	movl	$0x5d, %r12d
               	movq	%r15, %rdi
               	movq	%r14, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	jmp	0x400ebb <.text+0xb7b>
               	jmp	0x400e5b <.text+0xb1b>
               	movq	0x60(%rsp), %r8
               	movslq	%r8d, %r8
               	cmpq	$-0x7fffffff, %r8       # imm = 0x80000001
               	sete	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x400f8f <.text+0xc4f>
               	jmp	0x400f42 <.text+0xc02>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x400ec0 <.text+0xb80>
               	movabsq	$-0x1, %r10
               	movq	%r10, 0x48(%rsp)
               	movl	$0x1, %r10d
               	movq	%r10, 0x58(%rsp)
               	movq	0x48(%rsp), %r12
               	movslq	%r12d, %r12
               	movq	0x58(%rsp), %r15
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r15
               	movq	%r12, %r8
               	addq	%r15, %r8
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r8, %r10
               	movq	%r10, 0x50(%rsp)
               	jmp	0x400f94 <.text+0xc54>
               	leaq	0xf217(%rip), %r12      # 0x410160
               	movl	$0x29, %r14d
               	movl	%r14d, (%r12)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf353(%rip), %r12      # 0x4102be
               	movl	$0x5e, %r15d
               	movq	%rbx, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	jmp	0x400f8f <.text+0xc4f>
               	jmp	0x400ee9 <.text+0xba9>
               	movq	0x50(%rsp), %r8
               	cmpq	$0x0, %r8
               	sete	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x401044 <.text+0xd04>
               	jmp	0x400ff9 <.text+0xcb9>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x400f94 <.text+0xc54>
               	movq	0x48(%rsp), %rdx
               	movslq	%edx, %rdx
               	movq	0x58(%rsp), %r14
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r14
               	movq	%rdx, %rbx
               	subq	%r14, %rbx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r10
               	movq	%r10, 0x40(%rsp)
               	jmp	0x401049 <.text+0xd09>
               	leaq	0xf160(%rip), %r8       # 0x410160
               	movl	$0x32, %r15d
               	movl	%r15d, (%r8)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf2b4(%rip), %rbx      # 0x4102d4
               	movl	$0x68, %r14d
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	jmp	0x401044 <.text+0xd04>
               	jmp	0x400fba <.text+0xc7a>
               	movq	0x40(%rsp), %rbx
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpq	%r11, %rbx
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4010dc <.text+0xd9c>
               	jmp	0x401091 <.text+0xd51>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x401049 <.text+0xd09>
               	movl	$0x12345678, %r10d      # imm = 0x12345678
               	movq	%r10, 0x38(%rsp)
               	jmp	0x4010e1 <.text+0xda1>
               	leaq	0xf0c8(%rip), %rbx      # 0x410160
               	movl	$0x33, %r14d
               	movl	%r14d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r12
               	leaq	0xf232(%rip), %rbx      # 0x4102ea
               	movl	$0x6c, %r15d
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	jmp	0x4010dc <.text+0xd9c>
               	jmp	0x401071 <.text+0xd31>
               	movq	0x38(%rsp), %r15
               	movslq	%r15d, %r15
               	cmpq	$0x12345678, %r15       # imm = 0x12345678
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401177 <.text+0xe37>
               	jmp	0x40112c <.text+0xdec>
               	xorq	%r14, %r14
               	cmpq	$0x0, %r14
               	jne	0x4010e1 <.text+0xda1>
               	movq	0x38(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x30(%rsp)
               	jmp	0x40117c <.text+0xe3c>
               	leaq	0xf02d(%rip), %rbx      # 0x410160
               	movl	$0x3c, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %ebx
               	movq	%rbx, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf1ad(%rip), %rbx      # 0x410300
               	movl	$0x73, %r14d
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%r14, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	jmp	0x401177 <.text+0xe37>
               	jmp	0x40110a <.text+0xdca>
               	movq	0x30(%rsp), %r14
               	cmpq	$0x12345678, %r14       # imm = 0x12345678
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x40121f <.text+0xedf>
               	jmp	0x4011d3 <.text+0xe93>
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	jne	0x40117c <.text+0xe3c>
               	movabsq	$-0x77359400, %r10      # imm = 0x88CA6C00
               	movq	%r10, 0x28(%rsp)
               	movq	0x28(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x20(%rsp)
               	jmp	0x401224 <.text+0xee4>
               	leaq	0xef86(%rip), %r14      # 0x410160
               	movl	$0x3d, %r15d
               	movl	%r15d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %rbx
               	leaq	0xf11b(%rip), %r14      # 0x410316
               	movl	$0x75, %r12d
               	movq	%rbx, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	jmp	0x40121f <.text+0xedf>
               	jmp	0x4011a2 <.text+0xe62>
               	movq	0x20(%rsp), %r14
               	cmpq	$-0x77359400, %r14      # imm = 0x88CA6C00
               	sete	%r14b
               	movzbq	%r14b, %r14
               	cmpq	$0x0, %r14
               	jne	0x4012aa <.text+0xf6a>
               	jmp	0x40125f <.text+0xf1f>
               	xorq	%rbx, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401224 <.text+0xee4>
               	jmp	0x4012af <.text+0xf6f>
               	leaq	0xeefa(%rip), %r14      # 0x410160
               	movl	$0x3e, %r12d
               	movl	%r12d, (%r14)
               	movl	$0x2, %r14d
               	movq	%r14, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r15
               	leaq	0xf0a5(%rip), %r14      # 0x41032c
               	movl	$0x7a, %ebx
               	movq	%r15, %rdi
               	movq	%r12, %rcx
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	jmp	0x4012aa <.text+0xf6a>
               	jmp	0x40124a <.text+0xf0a>
               	movq	0x28(%rsp), %rdx
               	movslq	%edx, %rdx
               	cmpq	$-0x77359400, %rdx      # imm = 0x88CA6C00
               	sete	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x401350 <.text+0x1010>
               	jmp	0x401304 <.text+0xfc4>
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	jne	0x4012af <.text+0xf6f>
               	leaq	0xee71(%rip), %rdx      # 0x410160
               	movslq	(%rdx), %r15
               	cmpq	$0x0, %r15
               	jne	0x401391 <.text+0x1051>
               	jmp	0x401355 <.text+0x1015>
               	leaq	0xee55(%rip), %rbx      # 0x410160
               	movl	$0x3f, %r12d
               	movl	%r12d, (%rbx)
               	movl	$0x2, %r15d
               	movq	%r15, %rdi
               	callq	0x400357 <.text+0x17>
               	movq	%rax, %r14
               	leaq	0xf016(%rip), %rbx      # 0x410342
               	movl	$0x7b, %r15d
               	movq	%r14, %rdi
               	movq	%r12, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40150d <fprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	jmp	0x401350 <.text+0x1010>
               	jmp	0x4012d8 <.text+0xf98>
               	leaq	0xeffc(%rip), %r12      # 0x410358
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x401519 <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	0xedc8(%rip), %r12      # 0x410160
               	movslq	(%r12), %rdx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
