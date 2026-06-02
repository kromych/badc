
for_init_declaration.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	%r11d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r11
               	cmpq	$0xa, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r8
               	movslq	-0x10(%rbp), %r9
               	addq	%r9, %r8
               	movl	%r8d, (%r11)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	$0xa, %r9d
               	movl	%r9d, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r9
               	movslq	-0x18(%rbp), %r11
               	cmpq	%r11, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	leaq	-0x18(%rbp), %r8
               	movslq	(%r8), %r9
               	addq	$-0x1, %r9
               	movl	%r9d, (%r8)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r11
               	movslq	-0x10(%rbp), %r8
               	movslq	-0x18(%rbp), %rdi
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	addq	%r8, %r11
               	movl	%r11d, (%r9)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x2a, %eax
               	xorq	%r9, %r9
               	movl	%r9d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r9
               	cmpq	$0x3, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %r8
               	movslq	(%r8), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r8)
               	jmp	<addr>
               	jmp	<addr>
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	%r11d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r11
               	cmpq	$0x5, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r8
               	movslq	-0x10(%rbp), %r9
               	addq	%r9, %r8
               	movl	%r8d, (%r11)
               	jmp	<addr>
               	movl	$0xa, %r9d
               	movl	%r9d, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %r9
               	cmpq	$0xd, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x18(%rbp), %r11
               	movslq	(%r11), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r11)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r8
               	movslq	-0x18(%rbp), %r11
               	addq	%r11, %r8
               	movl	%r8d, (%r9)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %r11
               	xorq	%r9, %r9
               	movl	$0x1, %r8d
               	movl	%r8d, (%r11)
               	movl	$0x4, %edi
               	movq	%r11, %r8
               	addq	$0x4, %r8
               	movl	$0x2, %esi
               	movl	%esi, (%r8)
               	movq	%r11, %rdx
               	addq	$0x8, %rdx
               	movl	%edi, (%rdx)
               	movl	%r9d, -0x8(%rbp)
               	movq	%r11, -0x10(%rbp)
               	jmp	<addr>
               	movq	-0x10(%rbp), %r9
               	movq	%r11, %rsi
               	addq	$0xc, %rsi
               	cmpq	%rsi, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rsi), %r9
               	addq	$0x4, %r9
               	movq	%r9, (%rsi)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %rdx
               	movq	-0x10(%rbp), %rsi
               	movslq	(%rsi), %rsi
               	addq	%rsi, %rdx
               	movl	%edx, (%r9)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	callq	<addr>
               	cmpq	$0x2d, %rax
               	je	<addr>
               	leaq	<rip>, %rbx
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	movq	%rax, %rsi
               	cmpq	$0x32, %rsi
               	je	<addr>
               	leaq	<rip>, %r12
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	movq	%rax, %rsi
               	cmpq	$0x2a, %rsi
               	je	<addr>
               	leaq	<rip>, %rbx
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	movq	%rax, %rsi
               	cmpq	$0x2b, %rsi
               	je	<addr>
               	leaq	<rip>, %r12
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	movq	%rax, %rsi
               	cmpq	$0x7, %rsi
               	je	<addr>
               	leaq	<rip>, %rbx
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
