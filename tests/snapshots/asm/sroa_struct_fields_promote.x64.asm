
sroa_struct_fields_promote.x64:	file format elf64-x86-64

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

<t_mixed>:
               	leaq	(%rdi,%rdi,4), %rcx
               	leaq	0x1(%rdi), %rax
               	movq	%rdi, %rdx
               	shlq	%rdx
               	leaq	(%rcx,%rdx), %rsi
               	leaq	0x7(%rdi), %rcx
               	movswq	%cx, %rcx
               	movsbq	%dil, %rdx
               	xorq	$0x7a, %rdx
               	movsbq	%dl, %rdx
               	leaq	(%rax,%rax), %rdi
               	movq	%rax, %r8
               	shlq	%r8
               	addq	%r8, %rsi
               	addq	%rax, %rcx
               	movswq	%cx, %rcx
               	movsbq	%al, %rax
               	xorq	%rdx, %rax
               	movsbq	%al, %rax
               	movslq	%edi, %rdx
               	addq	%rsi, %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%rbx, %rax
               	sarq	%rax
               	shlq	$0x4, %rax
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	addq	%rbx, %rax
               	shlq	%rax
               	addq	%rcx, %rax
               	imulq	$0x7, %rbx, %rcx
               	addq	$0x9, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	leaq	(%rax,%rcx), %r8
               	xorq	%rdi, %rdi
               	movl	$0x1, %eax
               	movl	$0x5, %ecx
               	movq	%rdi, %rsi
               	jmp	<addr>
               	addq	%rcx, %rsi
               	cmpl	$0x2, %edx
               	jb	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	addq	%rbx, %rcx
               	movl	$0x2, %eax
               	movq	%rdi, %rdx
               	jmp	<addr>
               	movl	%eax, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	(%rsi,%rsi,4), %rax
               	leaq	(%r8,%rax), %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0xb0, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movq	%rbx, %rax
               	sarq	%rax
               	shlq	$0x4, %rax
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	addq	%rbx, %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	imulq	$0x7, %rbx, %rax
               	addq	$0x9, %rax
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	xorq	%rdi, %rdi
               	movl	$0x1, %eax
               	movl	$0x5, %ecx
               	movq	%rdi, %rsi
               	jmp	<addr>
               	addq	%rcx, %rsi
               	cmpl	$0x2, %edx
               	jb	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	addq	%rbx, %rcx
               	movl	$0x2, %eax
               	movq	%rdi, %rdx
               	jmp	<addr>
               	movl	%eax, %edx
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpq	$0xd, %rsi
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	cmpq	$0x177, %r12            # imm = 0x177
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
