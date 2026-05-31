
binary_integer_literal.x64:	file format elf64-x86-64

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
               	callq	0x400657 <dlsym>
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
               	subq	$0x30, %rsp
               	movl	$0xa, %r11d
               	movslq	%r11d, %r9
               	cmpq	$0xa, %r9
               	je	0x4003ff <.text+0x17f>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %r11d
               	movslq	%r11d, %rax
               	cmpq	$0x3, %rax
               	je	0x400423 <.text+0x1a3>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0xc0, %r11d
               	movq	%r11, %rax
               	andq	$0xff, %rax
               	movq	%rax, %r11
               	xorq	$0xc0, %r11
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400460 <.text+0x1e0>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3f, %r11d
               	movq	%r11, %rax
               	andq	$0xff, %rax
               	movq	%rax, %r11
               	xorq	$0x3f, %r11
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40049d <.text+0x21d>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %r11
               	cmpq	$-0x1, %r11
               	je	0x4004c6 <.text+0x246>
               	movl	$0x5, %r11d
               	movq	%r11, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%rax, %r11
               	movq	%r11, %rax
               	xorq	$0x1, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%rax, %r11
               	cmpq	$0x0, %r11
               	je	0x400506 <.text+0x286>
               	movl	$0x6, %r11d
               	movq	%r11, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
