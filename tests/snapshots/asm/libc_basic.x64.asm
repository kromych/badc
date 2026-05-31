
libc_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400810 <.text+0x150>
               	movq	%rax, %rdi
               	callq	*0xfaa1(%rip)           # 0x410178
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfa8e(%rip), %r9       # 0x410188
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40074b <.text+0x8b>
               	leaq	0xfa6a(%rip), %rdi      # 0x410188
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
               	leaq	0xfa47(%rip), %rdi      # 0x4101a0
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfa35(%rip), %rsi      # 0x4101a6
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfa24(%rip), %r9       # 0x4101ad
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
               	callq	0x401157 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x4007dc <.text+0x11c>
               	leaq	0xf9c4(%rip), %r14      # 0x410188
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x4007dc <.text+0x11c>
               	leaq	0xf9a5(%rip), %r12      # 0x410188
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
               	subq	$0xe0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xf9a3(%rip), %rbx      # 0x4101d8
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x40115d <strlen>
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	cmpq	$0x5, %r9
               	je	0x40087a <.text+0x1ba>
               	movl	$0x1, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf95d(%rip), %r12      # 0x4101de
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x40115d <strlen>
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	cmpq	$0x0, %r9
               	je	0x4008c6 <.text+0x206>
               	movl	$0x2, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf912(%rip), %rbx      # 0x4101df
               	leaq	0xf90f(%rip), %r12      # 0x4101e3
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x401163 <strcmp>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	cmpq	$0x0, %r8
               	je	0x40091c <.text+0x25c>
               	movl	$0x3, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf8c4(%rip), %r14      # 0x4101e7
               	leaq	0xf8c4(%rip), %r12      # 0x4101ee
               	movl	$0x3, %r15d
               	movq	%r14, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x401169 <strncmp>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	cmpq	$0x0, %rdi
               	je	0x40097a <.text+0x2ba>
               	movl	$0x4, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf874(%rip), %rbx      # 0x4101f5
               	movl	$0x6c, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x40116f <strchr>
               	movq	%rax, %r12
               	cmpq	$0x0, %r12
               	jne	0x4009cb <.text+0x30b>
               	movl	$0x5, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%r12), %r15
               	movq	%r15, %r12
               	xorq	$0x6c, %r12
               	movl	$0xffffffff, %r15d      # imm = 0xFFFFFFFF
               	andq	%r12, %r15
               	cmpq	$0x0, %r15
               	je	0x400a18 <.text+0x358>
               	movl	$0x6, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r14
               	leaq	0xf7d8(%rip), %r12      # 0x4101fb
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x401175 <strcpy>
               	movq	%rax, %rbx
               	leaq	-0x80(%rbp), %r15
               	leaq	0xf7c1(%rip), %rbx      # 0x4101ff
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	0x40117b <strcat>
               	movq	%rax, %r14
               	leaq	-0x80(%rbp), %r12
               	leaq	0xf7aa(%rip), %r14      # 0x410203
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x401163 <strcmp>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	cmpq	$0x0, %r15
               	je	0x400aa1 <.text+0x3e1>
               	movl	$0x7, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rbx
               	leaq	0xf75e(%rip), %r14      # 0x41020a
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x401175 <strcpy>
               	movq	%rax, %r12
               	leaq	-0x80(%rbp), %r12
               	movq	%r12, %r15
               	addq	$0x2, %r15
               	leaq	-0x80(%rbp), %r14
               	movl	$0x5, %r12d
               	movq	%r15, %rdi
               	movq	%r12, %rdx
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x401181 <memmove>
               	movq	%rax, %rbx
               	leaq	-0x80(%rbp), %rbx
               	movq	%rbx, %r12
               	addq	$0x2, %r12
               	movzbq	(%r12), %rbx
               	movq	%rbx, %r12
               	xorq	$0x30, %r12
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r12, %rbx
               	cmpq	$0x0, %rbx
               	je	0x400b40 <.text+0x480>
               	movl	$0x8, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r12
               	movq	%r12, %rbx
               	addq	$0x6, %rbx
               	movzbq	(%rbx), %r12
               	movq	%r12, %rbx
               	xorq	$0x34, %rbx
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r12
               	cmpq	$0x0, %r12
               	je	0x400b9a <.text+0x4da>
               	movl	$0x9, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r15
               	leaq	0xf670(%rip), %rbx      # 0x410215
               	movl	$0x7, %r12d
               	leaq	0xf66c(%rip), %r10      # 0x41021e
               	movq	%r10, 0x28(%rsp)
               	movl	$0x2a, %r14d
               	movq	%r15, %rdi
               	movq	%r14, %r8
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movq	0x28(%rsp), %rcx
               	movb	$0x0, %al
               	callq	0x401187 <sprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	leaq	-0x80(%rbp), %r15
               	leaq	0xf63b(%rip), %rbx      # 0x410221
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	0x401163 <strcmp>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	cmpq	$0x0, %r12
               	je	0x400c2e <.text+0x56e>
               	movl	$0xa, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %r14
               	movl	$0x10, %ebx
               	leaq	0xf5eb(%rip), %r12      # 0x410229
               	movl	$0x63, %r15d
               	movq	%r14, %rdi
               	movq	%r15, %rcx
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	0x40118d <snprintf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	leaq	-0x80(%rbp), %r14
               	leaq	0xf5c4(%rip), %rbx      # 0x41022c
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	0x401163 <strcmp>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	cmpq	$0x0, %r12
               	je	0x400cb0 <.text+0x5f0>
               	movl	$0xb, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x20, %r15d
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x401193 <isspace>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	cmpq	$0x0, %r12
               	jne	0x400cfb <.text+0x63b>
               	movl	$0xc, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x35, %ebx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x401199 <isdigit>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	cmpq	$0x0, %r12
               	jne	0x400d45 <.text+0x685>
               	movl	$0xd, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x61, %r15d
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x401199 <isdigit>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	cmpq	$0x0, %r12
               	je	0x400d90 <.text+0x6d0>
               	movl	$0xe, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x51, %ebx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x40119f <isalpha>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	cmpq	$0x0, %r15
               	jne	0x400dda <.text+0x71a>
               	movl	$0xf, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7a, %r12d
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x4011a5 <isalnum>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	cmpq	$0x0, %r15
               	jne	0x400e25 <.text+0x765>
               	movl	$0x10, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x61, %ebx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4011ab <toupper>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	cmpq	$0x41, %r15
               	je	0x400e6f <.text+0x7af>
               	movl	$0x11, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5a, %r12d
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x4011b1 <tolower>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	cmpq	$0x7a, %r15
               	je	0x400eba <.text+0x7fa>
               	movl	$0x12, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x66, %ebx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4011b7 <isxdigit>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	cmpq	$0x0, %r15
               	jne	0x400f04 <.text+0x844>
               	movl	$0x13, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf324(%rip), %r12      # 0x41022f
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x4011bd <atoi>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	cmpq	$0x2a, %r15
               	je	0x400f50 <.text+0x890>
               	movl	$0x14, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	0xf2db(%rip), %rbx      # 0x410232
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4011bd <atoi>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	cmpq	$-0x11, %r15
               	je	0x400f9c <.text+0x8dc>
               	movl	$0x15, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x5, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x4011c3 <abs>
               	movslq	%eax, %rax
               	movq	%rax, %r15
               	cmpq	$0x5, %r15
               	je	0x400feb <.text+0x92b>
               	movl	$0x16, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
