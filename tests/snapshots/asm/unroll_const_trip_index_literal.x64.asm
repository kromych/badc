
unroll_const_trip_index_literal.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	movabsq	$0x200000001, %rcx      # imm = 0x200000001
               	movq	%rsi, 0x80(%rdi)
               	movq	%rcx, 0x60(%rdi)
               	movq	$0x0, 0x88(%rdi)
               	movabsq	$0x300000001, %rax      # imm = 0x300000001
               	movq	%rsi, 0xb0(%rdi)
               	movq	%rax, 0x90(%rdi)
               	movq	$0x0, 0xb8(%rdi)
               	movabsq	$0x400000001, %rcx      # imm = 0x400000001
               	movq	%rsi, 0xe0(%rdi)
               	movq	%rcx, 0xc0(%rdi)
               	movq	$0x0, 0xe8(%rdi)
               	movabsq	$0x500000001, %rcx      # imm = 0x500000001
               	movq	%rsi, 0x110(%rdi)
               	movq	%rcx, 0xf0(%rdi)
               	movq	$0x0, 0x118(%rdi)
               	movabsq	$0x600000001, %rcx      # imm = 0x600000001
               	movq	%rsi, 0x140(%rdi)
               	movq	%rcx, 0x120(%rdi)
               	movq	$0x0, 0x148(%rdi)
               	movabsq	$0x700000001, %rcx      # imm = 0x700000001
               	movq	%rsi, 0x170(%rdi)
               	movq	%rcx, 0x150(%rdi)
               	movq	$0x0, 0x178(%rdi)
               	movabsq	$0x2000000002, %rax     # imm = 0x2000000002
               	movq	%rsi, 0x1a0(%rdi)
               	movq	%rax, 0x180(%rdi)
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
               	pushq	%rax
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rdi # <addr>
               	imulq	$0x30, %rax, %rsi
               	leaq	(%rdx,%rsi), %rcx
               	movl	(%rcx), %r8d
               	cmpl	$0x1, %r8d
               	jne	<addr>
               	movq	0x20(%rcx), %r8
               	cmpq	%rdi, %r8
               	jne	<addr>
               	movl	0x4(%rcx), %ecx
               	cmpl	%eax, %ecx
               	jne	<addr>
               	leaq	(%rdx,%rsi), %rcx
               	nopl	(%rax,%rax)
               	cmpq	$0x0, 0x28(%rcx)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r9 # <addr>
               	leaq	0x180(%rcx), %rdx
               	xorl	%ecx, %ecx
               	imulq	$0x30, %rax, %rdi
               	leaq	(%rdx,%rdi), %rsi
               	movl	(%rsi), %r10d
               	cmpl	$0x2, %r10d
               	jne	<addr>
               	movq	0x20(%rsi), %r10
               	cmpq	%r9, %r10
               	jne	<addr>
               	movl	0x4(%rsi), %esi
               	leaq	0x20(%rax), %r10
               	nop
               	cmpl	%r10d, %esi
               	jne	<addr>
               	leaq	(%rdx,%rdi), %rsi
               	cmpq	$0x0, 0x28(%rsi)
               	jne	<addr>
               	imulq	$0x30, %rax, %rsi
               	addq	%rdx, %rsi
               	movq	0x10(%rsi), %rsi
               	movslq	(%r8,%rax,4), %rdi
               	shlq	$0x8, %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	addq	%rsi, %rcx
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpq	$0x4200, %rcx           # imm = 0x4200
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	<rip>, %r8d # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%r8d, %eax
               	jge	<addr>
               	movslq	(%rdi,%rax,4), %rsi
               	shlq	$0x8, %rsi
               	addq	%rsi, %rdx
               	incq	%rax
               	cmpl	%r8d, %eax
               	jl	<addr>
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movl	$0x1, %eax
               	popq	%r11
               	retq
