
struct_field_assign_from_call.x64:	file format elf64-x86-64

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
               	movslq	%edx, %rdx
               	movslq	%ecx, %rcx
               	movslq	%r8d, %r8
               	movl	$0x4, %r9d
               	movl	%r9d, (%rsi)
               	movl	$0x1234abcd, %eax       # imm = 0x1234ABCD
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rsi, %r12
               	movq	0x38(%rsp), %r14
               	addq	$0x8, %r14
               	movq	(%r14), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x38(%rsp), %rsi
               	addq	$0x18, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	(%r14), %rdi
               	movq	0x38(%rsp), %rsi
               	addq	$0x14, %rsi
               	movq	0x38(%rsp), %rcx
               	addq	$0x10, %rcx
               	movslq	(%rcx), %rcx
               	addq	$0x1, %rcx
               	movslq	%ecx, %rdx
               	movl	$0x10, %ebx
               	movl	$0x7fff, %r15d          # imm = 0x7FFF
               	movq	%rbx, %rcx
               	movq	%r12, %r9
               	movq	%r15, %r8
               	callq	<addr>
               	movq	%rax, (%r14)
               	movq	0x38(%rsp), %r14
               	addq	$0x18, %r14
               	movq	(%r14), %rdi
               	movq	0x38(%rsp), %rsi
               	addq	$0x24, %rsi
               	movq	0x38(%rsp), %rdx
               	addq	$0x20, %rdx
               	movslq	(%rdx), %rdx
               	addq	$0x1, %rdx
               	movslq	%edx, %rax
               	movq	%rax, %rdx
               	movq	%r12, %r9
               	movq	%r15, %r8
               	movq	%rbx, %rcx
               	callq	<addr>
               	movq	%rax, %rdx
               	movq	%rdx, (%r14)
               	movq	0x38(%rsp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	movq	0x28(%rsp), %rdx
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	0x38(%rsp), %rdx
               	addq	$0x18, %rdx
               	movq	(%rdx), %rdx
               	movq	0x30(%rsp), %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movl	$0x2, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	0x38(%rsp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1234abcd, %rax       # imm = 0x1234ABCD
               	je	<addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	0x38(%rsp), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1234abcd, %rax       # imm = 0x1234ABCD
               	je	<addr>
               	movl	$0x4, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	0x38(%rsp), %rax
               	addq	$0x14, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x5, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	0x38(%rsp), %rax
               	addq	$0x24, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x6, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rbx
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	movq	%rbx, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rdx
               	movq	%rbx, %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rcx
               	movq	%rbx, %rax
               	addq	$0x14, %rax
               	movslq	(%rax), %r8
               	addq	$0x24, %rbx
               	movslq	(%rbx), %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
