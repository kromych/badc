
unroll_const_trip_index_literal.x64:	file format elf64-x86-64

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

<bank_init>:
               	movq	%rsi, 0x20(%rdi)
               	movq	$0x1, (%rdi)
               	movq	$0x0, 0x28(%rdi)
               	movabsq	$0x100000001, %rcx      # imm = 0x100000001
               	movq	%rsi, 0x50(%rdi)
               	movq	%rcx, 0x30(%rdi)
               	movq	$0x0, 0x58(%rdi)
               	movabsq	$0x200000001, %rax      # imm = 0x200000001
               	movq	%rsi, 0x80(%rdi)
               	movq	%rax, 0x60(%rdi)
               	movq	$0x0, 0x88(%rdi)
               	movabsq	$0x300000001, %rcx      # imm = 0x300000001
               	movq	%rsi, 0xb0(%rdi)
               	movq	%rcx, 0x90(%rdi)
               	movq	$0x0, 0xb8(%rdi)
               	movabsq	$0x400000001, %rcx      # imm = 0x400000001
               	movq	%rsi, 0xe0(%rdi)
               	movq	%rcx, 0xc0(%rdi)
               	movq	$0x0, 0xe8(%rdi)
               	movabsq	$0x500000001, %rcx      # imm = 0x500000001
               	movq	%rsi, 0x110(%rdi)
               	movq	%rcx, 0xf0(%rdi)
               	movq	$0x0, 0x118(%rdi)
               	movabsq	$0x600000001, %rax      # imm = 0x600000001
               	movq	%rsi, 0x140(%rdi)
               	movq	%rax, 0x120(%rdi)
               	movq	$0x0, 0x148(%rdi)
               	movabsq	$0x700000001, %rcx      # imm = 0x700000001
               	movq	%rsi, 0x170(%rdi)
               	movq	%rcx, 0x150(%rdi)
               	movq	$0x0, 0x178(%rdi)
               	movabsq	$0x2000000002, %rcx     # imm = 0x2000000002
               	movq	%rsi, 0x1a0(%rdi)
               	movq	%rcx, 0x180(%rdi)
               	movq	$0x0, 0x1a8(%rdi)
               	movq	$0xb00, 0x190(%rdi)     # imm = 0xB00
               	movabsq	$0x2100000002, %rcx     # imm = 0x2100000002
               	movq	%rsi, 0x1d0(%rdi)
               	movq	%rcx, 0x1b0(%rdi)
               	movq	$0x0, 0x1d8(%rdi)
               	movq	$0x1600, 0x1c0(%rdi)    # imm = 0x1600
               	movabsq	$0x2200000002, %rcx     # imm = 0x2200000002
               	movq	%rsi, 0x200(%rdi)
               	movq	%rcx, 0x1e0(%rdi)
               	movq	$0x0, 0x208(%rdi)
               	movq	$0x2100, 0x1f0(%rdi)    # imm = 0x2100
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	imulq	$0x30, %rax, %rdx
               	addq	%rdx, %rcx
               	movl	(%rcx), %esi
               	cmpl	$0x1, %esi
               	jne	<addr>
               	movq	0x20(%rcx), %rsi
               	leaq	<rip>, %rdi # <addr>
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movl	0x4(%rcx), %ecx
               	cmpl	%eax, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	addq	%rdx, %rcx
               	cmpq	$0x0, 0x28(%rcx)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdx # <addr>
               	leaq	0x180(%rdx), %rsi
               	imulq	$0x30, %rax, %rdx
               	addq	%rdx, %rsi
               	movl	(%rsi), %edi
               	cmpl	$0x2, %edi
               	jne	<addr>
               	movq	0x20(%rsi), %rsi
               	leaq	<rip>, %rdi # <addr>
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	<rip>, %rsi # <addr>
               	addq	$0x180, %rsi            # imm = 0x180
               	addq	%rdx, %rsi
               	movl	0x4(%rsi), %edi
               	leaq	0x20(%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	cmpq	$0x0, 0x28(%rsi)
               	jne	<addr>
               	leaq	<rip>, %rsi # <addr>
               	addq	$0x180, %rsi            # imm = 0x180
               	addq	%rsi, %rdx
               	movq	0x10(%rdx), %rdx
               	leaq	<rip>, %rdi # <addr>
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x8, %rdi
               	cmpq	%rdi, %rdx
               	jne	<addr>
               	imulq	$0x30, %rax, %rdx
               	addq	%rsi, %rdx
               	movq	0x10(%rdx), %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpq	$0x4200, %rcx           # imm = 0x4200
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	movl	<rip>, %esi # <addr>
               	cmpl	%esi, %eax
               	jge	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movslq	(%rsi,%rax,4), %rsi
               	shlq	$0x8, %rsi
               	addq	%rsi, %rdx
               	incq	%rax
               	movl	<rip>, %esi # <addr>
               	cmpl	%esi, %eax
               	jl	<addr>
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
