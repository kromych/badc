
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
               	movslq	%edx, %rdx
               	movslq	%ecx, %rcx
               	movslq	%r8d, %r8
               	movl	$0x4, %r9d
               	movl	%r9d, (%rsi)
               	movl	$0x1234abcd, %eax       # imm = 0x1234ABCD
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %r10
               	movq	%r10, 0x58(%rsp)
               	movq	%rsi, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x58(%rsp), %r10
               	addq	$0x8, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	(%r10), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x58(%rsp), %rsi
               	addq	$0x18, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	(%r10), %rbx
               	movq	0x58(%rsp), %r15
               	addq	$0x14, %r15
               	movq	0x58(%rsp), %rsi
               	addq	$0x10, %rsi
               	movslq	(%rsi), %rdx
               	addq	$0x1, %rdx
               	movslq	%edx, %r12
               	movl	$0x10, %r10d
               	movq	%r10, 0x30(%rsp)
               	movl	$0x7fff, %r14d          # imm = 0x7FFF
               	movq	%rbx, %rdi
               	movq	%r14, %r8
               	movq	%r12, %rdx
               	movq	%r15, %rsi
               	movq	0x30(%rsp), %rcx
               	movq	0x40(%rsp), %r9
               	callq	<addr>
               	movq	0x38(%rsp), %r11
               	movq	%rax, (%r11)
               	movq	0x58(%rsp), %r10
               	addq	$0x18, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x28(%rsp), %r10
               	movq	(%r10), %r12
               	movq	0x58(%rsp), %r15
               	addq	$0x24, %r15
               	movq	0x58(%rsp), %rax
               	addq	$0x20, %rax
               	movslq	(%rax), %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rbx
               	movq	%r12, %rdi
               	movq	%r14, %r8
               	movq	%rbx, %rdx
               	movq	%r15, %rsi
               	movq	0x30(%rsp), %rcx
               	movq	0x40(%rsp), %r9
               	callq	<addr>
               	movq	0x28(%rsp), %r11
               	movq	%rax, (%r11)
               	movq	0x58(%rsp), %rbx
               	addq	$0x8, %rbx
               	movq	(%rbx), %rax
               	movq	0x48(%rsp), %rbx
               	cmpq	%rax, %rbx
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movq	0x58(%rsp), %rbx
               	addq	$0x18, %rbx
               	movq	(%rbx), %rax
               	movq	0x50(%rsp), %rbx
               	cmpq	%rax, %rbx
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movq	0x58(%rsp), %rbx
               	addq	$0x8, %rbx
               	movq	(%rbx), %rax
               	cmpq	$0x1234abcd, %rax       # imm = 0x1234ABCD
               	je	<addr>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movq	0x58(%rsp), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rbx
               	cmpq	$0x1234abcd, %rbx       # imm = 0x1234ABCD
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movq	0x58(%rsp), %rbx
               	addq	$0x14, %rbx
               	movslq	(%rbx), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x5, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movq	0x58(%rsp), %rax
               	addq	$0x24, %rax
               	movslq	(%rax), %rbx
               	cmpq	$0x4, %rbx
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movslq	%eax, %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	leaq	<rip>, %r14
               	movslq	%eax, %rbx
               	leaq	<rip>, %rax
               	movq	%rax, %rdi
               	addq	$0x8, %rdi
               	movq	(%rdi), %r12
               	movq	%rax, %rdi
               	addq	$0x18, %rdi
               	movq	(%rdi), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	%rax, %rdi
               	addq	$0x14, %rdi
               	movslq	(%rdi), %r10
               	movq	%r10, 0x20(%rsp)
               	addq	$0x24, %rax
               	movslq	(%rax), %r15
               	movq	%r14, %rdi
               	movq	%r15, %r9
               	movq	%r12, %rdx
               	movq	%rbx, %rsi
               	movq	0x28(%rsp), %rcx
               	movq	0x20(%rsp), %r8
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r14
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
