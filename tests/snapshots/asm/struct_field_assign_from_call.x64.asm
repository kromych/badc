
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
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%r12, %rcx
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	%edx, %rdx
               	movslq	%ecx, %rcx
               	movslq	%r8d, %r8
               	movl	$0x4, %eax
               	movl	%eax, (%rsi)
               	movl	$0x1234abcd, %eax       # imm = 0x1234ABCD
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movq	%rbx, %r14
               	addq	$0x8, %r14
               	movq	(%r14), %r15
               	movq	%rbx, %rax
               	addq	$0x18, %rax
               	movq	(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	(%r14), %rdi
               	movq	%rbx, %rsi
               	addq	$0x14, %rsi
               	movq	%rbx, %rax
               	addq	$0x10, %rax
               	movslq	(%rax), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rdx
               	movl	$0x10, %r10d
               	movq	%r10, 0x30(%rsp)
               	movl	$0x7fff, %r10d          # imm = 0x7FFF
               	movq	%r10, 0x28(%rsp)
               	movq	%r12, %r9
               	movq	0x30(%rsp), %rcx
               	movq	0x28(%rsp), %r8
               	callq	<addr>
               	movq	%rax, (%r14)
               	movq	%rbx, %r14
               	addq	$0x18, %r14
               	movq	(%r14), %rdi
               	movq	%rbx, %rsi
               	addq	$0x24, %rsi
               	movq	%rbx, %rax
               	addq	$0x20, %rax
               	movslq	(%rax), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rdx
               	movq	%r12, %r9
               	movq	0x30(%rsp), %rcx
               	movq	0x28(%rsp), %r8
               	callq	<addr>
               	movq	%rax, (%r14)
               	movq	%rbx, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	cmpq	%rax, %r15
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
               	movq	%rbx, %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	movq	%rax, %r10
               	movq	0x38(%rsp), %rax
               	cmpq	%r10, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1234abcd, %rax       # imm = 0x1234ABCD
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1234abcd, %rax       # imm = 0x1234ABCD
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	addq	$0x14, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	addq	$0x24, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
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
               	movslq	%eax, %rcx
               	cmpq	$0x0, %rcx
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
               	movq	%rbx, %rax
               	addq	$0x24, %rax
               	movslq	(%rax), %r9
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
