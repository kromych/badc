
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	xorq	%rsi, %rsi
               	movl	$0x1, %ecx
               	movl	$0x5, %eax
               	jmp	<addr>
               	movl	%eax, %edi
               	addq	%rdi, %rsi
               	movl	%ecx, %ecx
               	cmpq	$0x2, %rcx
               	jb	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdi
               	jmp	<addr>
               	movl	%eax, %eax
               	movl	%edx, %ecx
               	addq	%rcx, %rax
               	movl	$0x2, %ecx
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	movl	%ecx, %edi
               	testq	%rdi, %rdi
               	jne	<addr>
               	leaq	0x7(%rdx), %rax
               	movswq	%ax, %rax
               	movsbq	%dl, %r9
               	movq	%r9, %rcx
               	xorq	$0x61, %rcx
               	movsbq	%cl, %rdi
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rdi, %rcx
               	addq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	shlq	%rax
               	leaq	(%rsi,%rax), %rbx
               	movswq	%dx, %r8
               	leaq	0x1(%rdx), %rax
               	movswq	%ax, %rcx
               	movq	%rdx, %rax
               	shlq	%rax
               	movswq	%ax, %rsi
               	leaq	-0x3(%rdx), %rax
               	movswq	%ax, %rdi
               	shlq	%rcx
               	addq	%r8, %rcx
               	leaq	(%rsi,%rsi,2), %rsi
               	addq	%rsi, %rcx
               	leaq	(%rcx,%rdi), %rax
               	movslq	%eax, %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	%rax, %rbx
               	xorq	%rsi, %rsi
               	movl	$0x1, %ecx
               	movl	$0x5, %eax
               	jmp	<addr>
               	movl	%eax, %edi
               	addq	%rdi, %rsi
               	movl	%ecx, %ecx
               	cmpq	$0x2, %rcx
               	jb	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdi
               	jmp	<addr>
               	movl	%eax, %eax
               	movl	%edx, %ecx
               	addq	%rcx, %rax
               	movl	$0x2, %ecx
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	movl	%ecx, %edi
               	testq	%rdi, %rdi
               	jne	<addr>
               	cmpq	$0xd, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0x7(%rdx), %rax
               	movswq	%ax, %rax
               	movq	%r9, %rcx
               	xorq	$0x61, %rcx
               	movsbq	%cl, %rsi
               	movq	%rax, %rcx
               	shlq	%rcx
               	addq	%rsi, %rcx
               	addq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x83, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0x1(%rdx), %rax
               	movswq	%ax, %rcx
               	movq	%rdx, %rax
               	shlq	%rax
               	movswq	%ax, %rsi
               	leaq	-0x3(%rdx), %rax
               	movswq	%ax, %rdi
               	shlq	%rcx
               	addq	%r8, %rcx
               	leaq	(%rsi,%rsi,2), %rdx
               	addq	%rdx, %rcx
               	leaq	(%rcx,%rdi), %rax
               	movslq	%eax, %rax
               	cmpq	$0x1d, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x16a, %rbx            # imm = 0x16A
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
