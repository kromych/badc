
compound_literal_file_scope.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4003d0 <.text+0x150>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100e8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe3e(%rip), %r9       # 0x4100f8
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40030b <.text+0x8b>
               	leaq	0xfe1a(%rip), %rdi      # 0x4100f8
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
               	leaq	0xfdf7(%rip), %rdi      # 0x410110
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfde5(%rip), %rsi      # 0x410116
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfdd4(%rip), %r9       # 0x41011d
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
               	je	0x40039c <.text+0x11c>
               	leaq	0xfd74(%rip), %r14      # 0x4100f8
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x40039c <.text+0x11c>
               	leaq	0xfd55(%rip), %r12      # 0x4100f8
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
               	subq	$0x40, %rsp
               	leaq	0xfd66(%rip), %r11      # 0x410148
               	movq	(%r11), %r9
               	movslq	(%r9), %r11
               	cmpq	$0x1, %r11
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x10(%rbp)
               	cmpq	$0x0, %r9
               	jne	0x400437 <.text+0x1b7>
               	leaq	0xfd39(%rip), %r11      # 0x410148
               	movq	(%r11), %r9
               	movq	%r9, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r9
               	cmpq	$0x4, %r9
               	setne	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x10(%rbp)
               	jmp	0x400437 <.text+0x1b7>
               	movq	-0x10(%rbp), %r11
               	movq	%r11, -0x8(%rbp)
               	cmpq	$0x0, %r11
               	jne	0x40047b <.text+0x1fb>
               	leaq	0xfcf5(%rip), %r9       # 0x410148
               	movq	(%r9), %r11
               	movq	%r11, %r9
               	addq	$0x8, %r9
               	movslq	(%r9), %r11
               	cmpq	$0x4, %r11
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x8(%rbp)
               	jmp	0x40047b <.text+0x1fb>
               	movq	-0x8(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	0x40049a <.text+0x21a>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfcbf(%rip), %r9       # 0x410160
               	movq	(%r9), %rax
               	movslq	(%rax), %r9
               	cmpq	$0x2, %r9
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x20(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4004f6 <.text+0x276>
               	leaq	0xfc92(%rip), %r9       # 0x410160
               	movq	(%r9), %rax
               	movq	%rax, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x8, %rax
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x20(%rbp)
               	jmp	0x4004f6 <.text+0x276>
               	movq	-0x20(%rbp), %r9
               	movq	%r9, -0x18(%rbp)
               	cmpq	$0x0, %r9
               	jne	0x40053a <.text+0x2ba>
               	leaq	0xfc4e(%rip), %rax      # 0x410160
               	movq	(%rax), %r9
               	movq	%r9, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x8, %r9
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x18(%rbp)
               	jmp	0x40053a <.text+0x2ba>
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x40055d <.text+0x2dd>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc14(%rip), %rax      # 0x410178
               	movq	(%rax), %r9
               	movslq	(%r9), %rax
               	cmpq	$0x0, %rax
               	je	0x400585 <.text+0x305>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfbec(%rip), %r9       # 0x410178
               	movq	(%r9), %rax
               	movq	%rax, %r9
               	addq	$0x8, %r9
               	movq	(%r9), %rax
               	movzbq	(%rax), %r9
               	movq	%r9, %rax
               	xorq	$0x72, %rax
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%rax, %r9
               	cmpq	$0x0, %r9
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x28(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x400622 <.text+0x3a2>
               	leaq	0xfb9e(%rip), %r9       # 0x410178
               	movq	(%r9), %rax
               	movq	%rax, %r9
               	addq	$0x8, %r9
               	movq	(%r9), %rax
               	movq	%rax, %r9
               	addq	$0x1, %r9
               	movzbq	(%r9), %rax
               	movq	%rax, %r9
               	xorq	$0x6f, %r9
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r9, %rax
               	cmpq	$0x0, %rax
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x28(%rbp)
               	jmp	0x400622 <.text+0x3a2>
               	movq	-0x28(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	0x400641 <.text+0x3c1>
               	movl	$0x4, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb30(%rip), %r9       # 0x410178
               	movq	(%r9), %rax
               	movq	%rax, %r9
               	addq	$0x10, %r9
               	movq	(%r9), %rax
               	cmpq	$0x0, %rax
               	je	0x400673 <.text+0x3f3>
               	movl	$0x5, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb26(%rip), %r9       # 0x4101a0
               	movq	(%r9), %rax
               	movslq	(%rax), %r9
               	cmpq	$0x0, %r9
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x38(%rbp)
               	cmpq	$0x0, %rax
               	jne	0x4006cf <.text+0x44f>
               	leaq	0xfaf9(%rip), %r9       # 0x4101a0
               	movq	(%r9), %rax
               	movq	%rax, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x0, %rax
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x38(%rbp)
               	jmp	0x4006cf <.text+0x44f>
               	movq	-0x38(%rbp), %r9
               	movq	%r9, -0x30(%rbp)
               	cmpq	$0x0, %r9
               	jne	0x400713 <.text+0x493>
               	leaq	0xfab5(%rip), %rax      # 0x4101a0
               	movq	(%rax), %r9
               	movq	%r9, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x0, %r9
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x30(%rbp)
               	jmp	0x400713 <.text+0x493>
               	movq	-0x30(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	0x400736 <.text+0x4b6>
               	movl	$0x6, %r9d
               	movq	%r9, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
