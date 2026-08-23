
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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x40, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rsi
               	shlq	$0x4, %rsi
               	leaq	(%rdi,%rsi), %r8
               	leaq	(%r8), %r12
               	imulq	$0x64, %rax, %rdx
               	leaq	(%rdx), %r9
               	movslq	%r9d, %rbx
               	movw	%bx, (%r12)
               	leaq	0x1(%rdx), %r9
               	movslq	%r9d, %rbx
               	movw	%bx, 0x2(%r8)
               	addq	%rdi, %rsi
               	addq	$0x2, %rdx
               	movslq	%edx, %r8
               	movw	%r8w, 0x4(%rsi)
               	movq	%rax, %r8
               	shlq	$0x4, %r8
               	leaq	(%rdi,%r8), %rsi
               	imulq	$0x64, %rax, %rdx
               	leaq	0x3(%rdx), %r9
               	movslq	%r9d, %rbx
               	movw	%bx, 0x6(%rsi)
               	leaq	0x4(%rdx), %r9
               	movslq	%r9d, %rbx
               	movw	%bx, 0x8(%rsi)
               	leaq	(%rdi,%r8), %rsi
               	addq	$0x5, %rdx
               	movslq	%edx, %r8
               	movw	%r8w, 0xa(%rsi)
               	movq	%rax, %r9
               	shlq	$0x4, %r9
               	leaq	(%rdi,%r9), %rsi
               	imulq	$0x64, %rax, %rdx
               	leaq	0x6(%rdx), %r8
               	movslq	%r8d, %rbx
               	movw	%bx, 0xc(%rsi)
               	addq	$0x7, %rdx
               	movslq	%edx, %r8
               	movw	%r8w, 0xe(%rsi)
               	leaq	0x1(%rax), %rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorq	%r8, %r8
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%r8d, %rdx
               	movq	%rdx, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdi,%rcx), %rsi
               	movslq	%eax, %rcx
               	movswq	(%rsi,%rcx,2), %rsi
               	imulq	$0x64, %rdx, %rdx
               	addq	%rcx, %rdx
               	movslq	%edx, %r9
               	movswq	%r9w, %rdx
               	cmpl	%edx, %esi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movslq	%r8d, %rax
               	leaq	0x1(%rax), %r8
               	cmpl	$0x4, %r8d
               	jl	<addr>
               	movabsq	$-0x1, %rax
               	movw	%ax, (%rdi)
               	movswq	%ax, %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x63, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movzbq	%al, %rax
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%r8, %rcx
               	shlq	$0x3, %rcx
               	addq	$0xa, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
