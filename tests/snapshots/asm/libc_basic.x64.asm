
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
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%rdi, %rdi
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %r8
               	movq	%r8, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rsi
               	movq	(%rsi), %r8
               	movq	%r8, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdi
               	movq	(%rax), %rax
               	movq	%rax, (%rdi)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
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
               	movl	$0x1, %r9d
               	movq	%r9, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
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
               	movl	$0x3, %edi
               	movq	%rdi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %esi
               	movq	%rsi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x6c, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x5, %edx
               	movq	%rdx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%rax), %rax
               	xorq	$0x6c, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x6, %edi
               	movq	%rdi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	leaq	<rip>, %rsi
               	movq	%rax, %rdi
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
               	movl	$0x7, %edi
               	movq	%rdi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	leaq	<rip>, %rsi
               	movq	%rax, %rdi
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
               	movl	$0x8, %esi
               	movq	%rsi, %rax
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
               	movl	$0x9, %esi
               	movq	%rsi, %rax
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
               	movl	$0xa, %edi
               	movq	%rdi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movl	$0x10, %esi
               	leaq	<rip>, %rdx
               	movl	$0x63, %ecx
               	movq	%rax, %rdi
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
               	movl	$0xb, %edi
               	movq	%rdi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x20, %eax
               	movq	%rax, %rdi
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
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0xd, %edi
               	movq	%rdi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x61, %eax
               	movq	%rax, %rdi
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
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0xf, %edi
               	movq	%rdi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7a, %eax
               	movq	%rax, %rdi
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
               	cmpq	$0x41, %rax
               	je	<addr>
               	movl	$0x11, %edi
               	movq	%rdi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5a, %eax
               	movq	%rax, %rdi
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
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x13, %edi
               	movq	%rdi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	%rax, %rdi
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
               	cmpq	$-0x11, %rax
               	je	<addr>
               	movl	$0x15, %edi
               	movq	%rdi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x5, %rax
               	movq	%rax, %rdi
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
