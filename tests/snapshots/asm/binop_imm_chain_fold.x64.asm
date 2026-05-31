
binop_imm_chain_fold.x64:	file format elf64-x86-64

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
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	leaq	<rip>, %r9
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
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %r12
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
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movl	$0xa, %r11d
               	movslq	%r11d, %r11
               	movq	%r11, %r9
               	addq	$0x3, %r9
               	movslq	%r9d, %r9
               	addq	$0x7, %r9
               	movslq	%r9d, %r9
               	movq	%r11, %r8
               	addq	$0x8, %r8
               	movslq	%r8d, %r8
               	subq	$0x3, %r8
               	movslq	%r8d, %r8
               	movq	%r11, %rdi
               	subq	$0x4, %rdi
               	movslq	%edi, %rdi
               	addq	$0x9, %rdi
               	movslq	%edi, %rdi
               	movq	%r11, %rsi
               	subq	$0x2, %rsi
               	movslq	%esi, %rsi
               	subq	$0x5, %rsi
               	movslq	%esi, %rsi
               	movq	%r11, %rdx
               	andq	$0x3f, %rdx
               	movq	%r11, %rcx
               	orq	$0x3, %rcx
               	xorq	$0x3, %r11
               	movslq	%r9d, %r9
               	movslq	%r8d, %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	movslq	%edi, %rdi
               	addq	%rdi, %r9
               	movslq	%r9d, %r9
               	movslq	%esi, %rsi
               	addq	%rsi, %r9
               	movslq	%r9d, %r9
               	movslq	%edx, %rdx
               	addq	%rdx, %r9
               	movslq	%r9d, %r9
               	movslq	%ecx, %rcx
               	addq	%rcx, %r9
               	movslq	%r9d, %r9
               	movslq	%r11d, %r11
               	addq	%r11, %r9
               	movslq	%r9d, %rbx
               	leaq	<rip>, %r12
               	movslq	%ebx, %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rbx
               	cmpq	$0x53, %rbx
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x60(%rbp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0x60(%rbp)
               	jmp	<addr>
               	movq	-0x60(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
