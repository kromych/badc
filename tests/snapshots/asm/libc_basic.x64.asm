
libc_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r12, %r8
               	movq	(%r8), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%r12, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x8, %rdx
               	leaq	<rip>, %rsi
               	movq	%rsi, (%rdx)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x10, %r8
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%r12, %rsi
               	movq	(%rax), %rax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x3, %esi
               	movq	%rsi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %edx
               	movq	%rdx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x6c, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x5, %edi
               	movq	%rdi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%rax), %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x6, %esi
               	movq	%rsi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x7, %esi
               	movq	%rsi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x80(%rbp), %rax
               	movq	%rax, %rdi
               	addq	$0x2, %rdi
               	leaq	-0x80(%rbp), %rsi
               	movl	$0x5, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x80(%rbp), %rax
               	addq	$0x2, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x30, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x8, %edx
               	movq	%rdx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	addq	$0x6, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x34, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x9, %edx
               	movq	%rdx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x7, %edx
               	leaq	<rip>, %rcx
               	movl	$0x2a, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0x80(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xa, %esi
               	movq	%rsi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x10, %esi
               	leaq	<rip>, %rdx
               	movl	$0x63, %ecx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0x80(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xb, %esi
               	movq	%rsi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x20, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0xc, %edi
               	movq	%rdi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x35, %eax
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	movl	$0xd, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x61, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xe, %edi
               	movq	%rdi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x51, %eax
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	movl	$0xf, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7a, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x10, %edi
               	movq	%rdi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x61, %eax
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	cmpq	$0x41, %rdi
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5a, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x7a, %rax
               	je	<addr>
               	movl	$0x12, %edi
               	movq	%rdi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x66, %eax
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	movl	$0x13, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x14, %edi
               	movq	%rdi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	cmpq	$-0x11, %rdi
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x5, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x16, %edi
               	movq	%rdi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
