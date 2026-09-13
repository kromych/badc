
sroa_one_cell_aggregate_promotes.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	xorq	%r8, %r8
               	movl	$0x1, %ecx
               	movl	$0x5, %eax
               	movq	%r8, %rdi
               	jmp	<addr>
               	movl	%eax, %r9d
               	addq	%r9, %rdi
               	cmpl	$0x2, %esi
               	jb	<addr>
               	movq	%r8, %rcx
               	jmp	<addr>
               	movl	%edx, %eax
               	addq	%r9, %rax
               	movl	$0x2, %ecx
               	movl	%ecx, %esi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	0x7(%rdx), %rax
               	movswq	%ax, %rax
               	movsbq	%dl, %rbx
               	movq	%rbx, %rcx
               	xorq	$0x61, %rcx
               	movsbq	%cl, %rcx
               	movq	%rax, %rsi
               	shlq	%rsi
               	addq	%rsi, %rcx
               	addq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	shlq	%rax
               	addq	%rax, %rdi
               	movswq	%dx, %r9
               	leaq	0x1(%rdx), %rax
               	movswq	%ax, %rax
               	movq	%rdx, %rcx
               	shlq	%rcx
               	movswq	%cx, %rcx
               	leaq	-0x3(%rdx), %rsi
               	movswq	%si, %rsi
               	shlq	%rax
               	addq	%r9, %rax
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	leaq	(%rax,%rax,2), %rax
               	leaq	(%rdi,%rax), %r12
               	xorq	%rsi, %rsi
               	movl	$0x1, %ecx
               	movl	$0x5, %eax
               	jmp	<addr>
               	movl	%eax, %r8d
               	addq	%r8, %rsi
               	cmpl	$0x2, %edi
               	jb	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	%edx, %eax
               	addq	%r8, %rax
               	movl	$0x2, %ecx
               	movl	%ecx, %edi
               	testq	%rdi, %rdi
               	jne	<addr>
               	cmpq	$0xd, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	0x7(%rdx), %rax
               	movswq	%ax, %rax
               	movq	%rbx, %rcx
               	xorq	$0x61, %rcx
               	movsbq	%cl, %rcx
               	movq	%rax, %rsi
               	shlq	%rsi
               	addq	%rsi, %rcx
               	addq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x83, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	leaq	0x1(%rdx), %rax
               	movswq	%ax, %rax
               	movq	%rdx, %rcx
               	shlq	%rcx
               	movswq	%cx, %rcx
               	subq	$0x3, %rdx
               	movswq	%dx, %rdx
               	shlq	%rax
               	addq	%r9, %rax
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	cmpl	$0x1d, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	cmpq	$0x16a, %r12            # imm = 0x16A
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
