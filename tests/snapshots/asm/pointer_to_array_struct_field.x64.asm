
pointer_to_array_struct_field.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movl	$0x40, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	xorq	%rdx, %rdx
               	cmpl	$0x4, %edx
               	jge	<addr>
               	movslq	%edx, %rcx
               	movq	%rcx, %rdi
               	shlq	$0x4, %rdi
               	leaq	(%rax,%rdi), %r8
               	leaq	(%r8), %r12
               	imulq	$0x64, %rcx, %rsi
               	leaq	(%rsi), %r9
               	movq	%r9, %rbx
               	movw	%bx, (%r12)
               	leaq	0x1(%rsi), %r9
               	movq	%r9, %rbx
               	movw	%bx, 0x2(%r8)
               	addq	%rax, %rdi
               	addq	$0x2, %rsi
               	movq	%rsi, %r8
               	movw	%r8w, 0x4(%rdi)
               	movq	%rcx, %r8
               	shlq	$0x4, %r8
               	leaq	(%rax,%r8), %rdi
               	imulq	$0x64, %rcx, %rsi
               	leaq	0x3(%rsi), %r9
               	movq	%r9, %rbx
               	movw	%bx, 0x6(%rdi)
               	leaq	0x4(%rsi), %r9
               	movq	%r9, %rbx
               	movw	%bx, 0x8(%rdi)
               	leaq	(%rax,%r8), %rdi
               	addq	$0x5, %rsi
               	movq	%rsi, %r8
               	movw	%r8w, 0xa(%rdi)
               	movq	%rcx, %r9
               	shlq	$0x4, %r9
               	leaq	(%rax,%r9), %rdi
               	imulq	$0x64, %rcx, %rsi
               	leaq	0x6(%rsi), %r8
               	movq	%r8, %rbx
               	movw	%bx, 0xc(%rdi)
               	leaq	0x7(%rsi), %rcx
               	movq	%rcx, %rsi
               	movw	%si, 0xe(%rdi)
               	incq	%rdx
               	cmpl	$0x4, %edx
               	jl	<addr>
               	xorq	%rbx, %rbx
               	movq	%rbx, %rdx
               	cmpl	$0x4, %edx
               	jge	<addr>
               	movslq	%edx, %rcx
               	movq	%rcx, %r9
               	shlq	$0x4, %r9
               	leaq	(%rax,%r9), %rdi
               	leaq	(%rdi), %rsi
               	movswq	(%rsi), %r12
               	imulq	$0x64, %rcx, %rsi
               	leaq	(%rsi), %r8
               	movq	%r8, %r13
               	movswq	%r13w, %r8
               	cmpl	%r8d, %r12d
               	jne	<addr>
               	movl	$0x1, %r12d
               	movswq	0x2(%rdi), %rdi
               	incq	%rsi
               	movq	%rsi, %r8
               	movswq	%r8w, %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	movl	$0x2, %r14d
               	movq	%rcx, %r9
               	shlq	$0x4, %r9
               	leaq	(%rax,%r9), %rdi
               	movswq	0x4(%rdi), %r12
               	imulq	$0x64, %rcx, %rsi
               	leaq	0x2(%rsi), %r8
               	movq	%r8, %r13
               	movswq	%r13w, %r8
               	cmpl	%r8d, %r12d
               	jne	<addr>
               	movl	$0x3, %r12d
               	movswq	0x6(%rdi), %rdi
               	addq	$0x3, %rsi
               	movq	%rsi, %r8
               	movswq	%r8w, %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	movl	$0x4, %r14d
               	movq	%rcx, %r9
               	shlq	$0x4, %r9
               	leaq	(%rax,%r9), %rdi
               	movswq	0x8(%rdi), %r12
               	imulq	$0x64, %rcx, %rsi
               	leaq	0x4(%rsi), %r8
               	movq	%r8, %r13
               	movswq	%r13w, %r8
               	cmpl	%r8d, %r12d
               	jne	<addr>
               	movl	$0x5, %r12d
               	movswq	0xa(%rdi), %rdi
               	addq	$0x5, %rsi
               	movq	%rsi, %r8
               	movswq	%r8w, %rsi
               	cmpl	%esi, %edi
               	jne	<addr>
               	movl	$0x6, %r14d
               	movq	%rcx, %r9
               	shlq	$0x4, %r9
               	leaq	(%rax,%r9), %rdi
               	movswq	0xc(%rdi), %r12
               	imulq	$0x64, %rcx, %rsi
               	leaq	0x6(%rsi), %r8
               	movq	%r8, %r13
               	movswq	%r13w, %r8
               	cmpl	%r8d, %r12d
               	jne	<addr>
               	movl	$0x7, %r8d
               	movswq	0xe(%rdi), %rdi
               	leaq	0x7(%rsi), %rcx
               	movq	%rcx, %rsi
               	movswq	%si, %rcx
               	cmpl	%ecx, %edi
               	jne	<addr>
               	incq	%rdx
               	cmpl	$0x4, %edx
               	jl	<addr>
               	movabsq	$-0x1, %rcx
               	movw	%cx, (%rax)
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	%r8, %rbx
               	movq	%rdx, %rax
               	shlq	$0x3, %rax
               	addq	$0xa, %rax
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movq	%r14, %rbx
               	jmp	<addr>
               	movq	%r12, %rbx
               	jmp	<addr>
               	movq	%r14, %rbx
               	jmp	<addr>
               	movq	%r12, %rbx
               	jmp	<addr>
               	movq	%r14, %rbx
               	jmp	<addr>
               	movq	%r12, %rbx
               	jmp	<addr>
