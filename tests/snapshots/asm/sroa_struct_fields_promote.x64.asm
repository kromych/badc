
sroa_struct_fields_promote.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<t_mixed>:
               	leaq	(%rdi,%rdi,4), %rax
               	leaq	0x1(%rdi), %rcx
               	movq	%rdi, %rdx
               	shlq	%rdx
               	leaq	(%rax,%rdx), %r8
               	leaq	0x7(%rdi), %rax
               	movswq	%ax, %rdx
               	movsbq	%dil, %rax
               	xorq	$0x7a, %rax
               	movsbq	%al, %rsi
               	leaq	0x1(%rdi), %rax
               	addq	%rax, %rcx
               	movq	%rax, %rdi
               	shlq	%rdi
               	addq	%r8, %rdi
               	addq	%rax, %rdx
               	movswq	%dx, %rdx
               	movsbq	%al, %rax
               	xorq	%rsi, %rax
               	movsbq	%al, %rax
               	movslq	%ecx, %rcx
               	addq	%rdi, %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	retq

<t_deep>:
               	movq	%rdi, %rax
               	sarq	%rax
               	shlq	$0x4, %rax
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	addq	%rdi, %rax
               	retq

<t_tmpl>:
               	imulq	$0x7, %rdi, %rax
               	addq	$0x9, %rax
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
               	movq	%rax, %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	shlq	%rax
               	addq	%rax, %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	(%rax,%rax,2), %rax
               	leaq	(%r12,%rax), %r8
               	xorq	%rdx, %rdx
               	movl	$0x1, %eax
               	movl	$0x5, %ecx
               	jmp	<addr>
               	addq	%rcx, %rdx
               	movl	%eax, %esi
               	cmpq	$0x2, %rsi
               	jb	<addr>
               	cmpq	$0x2, %rsi
               	je	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	addq	%rbx, %rcx
               	movl	$0x2, %eax
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	movl	%eax, %esi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	(%rdx,%rdx,4), %rax
               	leaq	(%r8,%rax), %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0xb0, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	movl	$0x1, %eax
               	movl	$0x5, %ecx
               	jmp	<addr>
               	addq	%rcx, %rdx
               	movl	%eax, %esi
               	cmpq	$0x2, %rsi
               	jb	<addr>
               	cmpq	$0x2, %rsi
               	je	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	addq	%rbx, %rcx
               	movl	$0x2, %eax
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	movl	%eax, %esi
               	testq	%rsi, %rsi
               	jne	<addr>
               	cmpq	$0xd, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x177, %r12            # imm = 0x177
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
