
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
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
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
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %rax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
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
               	movq	-0x10(%rbp), %r11
               	leaq	<rip>, %rsi
               	addq	$0xc, %rsi
               	cmpq	%rsi, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rsi), %r11
               	addq	$0x4, %r11
               	movq	%r11, (%rsi)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r9
               	movq	-0x10(%rbp), %rsi
               	movslq	(%rsi), %rsi
               	addq	%rsi, %r9
               	movl	%r9d, (%r11)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	callq	<addr>
               	cmpq	$0x2d, %rax
               	je	<addr>
               	leaq	<rip>, %rbx
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x32, %rax
               	je	<addr>
               	leaq	<rip>, %r12
               	callq	<addr>
               	movq	%rax, %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2b, %rax
               	je	<addr>
               	leaq	<rip>, %rbx
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	leaq	<rip>, %r12
               	callq	<addr>
               	movq	%rax, %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
